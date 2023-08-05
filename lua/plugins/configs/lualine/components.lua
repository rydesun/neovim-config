local M = {}

function M.git_branch()
  local head = vim.b.gitsigns_head
  return head == nil and ''
      or (head == 'master' or head == 'main') and '⋆'
      or (head == '') and '⋆init'
      or ' ' .. head
end

function M.encoding()
  local fenc = vim.o.fenc
  return (fenc == 'utf-8' or fenc == '') and '' or '(' .. fenc .. ')'
end

function M.cwd()
  return vim.fn.fnamemodify(vim.fn.getcwd() .. '/', ':~')
end

M.filetype = require 'lualine.components.filetype':extend()

function M.filetype:init(options)
  local defaults = {
    terminal = ' ',
    unset = '󰈙 -',
    fallback_icon = '󰈙',
  }
  M.filetype.super:init(options)
  self.options = vim.tbl_deep_extend('keep', self.options or {}, defaults)
end

function M.filetype:update_status()
  local filetype = self.super:update_status()
  return filetype ~= '' and filetype or '-'
end

function M.filetype:apply_icon()
  local ok, devicons = pcall(require, 'nvim-web-devicons')
  if not ok then return nil end

  if self.status == '-' then
    if vim.bo.buftype == 'terminal' then
      self.status = self.options.terminal
    else
      self.status = self.options.unset
    end
    return
  end

  local icon = devicons.get_icon_color_by_filetype(
    vim.bo.filetype, { default = false })
  if icon == nil then
    icon = vim.bo.buftype == 'nofile' and '' or self.options.fallback_icon
  end
  if icon ~= '' then
    self.status = icon .. ' ' .. self.status
  end
end

M.filename = require 'lualine.components.filename':extend()

function M.filename:init(options)
  local defaults = {
    hl = {
      cwd = '%#StatusLineNC#',
      file = '%#StatusLineTermNC#',
    }
  }
  M.filename.super:init(options)
  self.options.path = 3 -- 固定选项
  self.options = vim.tbl_deep_extend('keep', self.options or {}, defaults)
end

function M.filename:update_status()
  -- 可能只有标志没有文件名
  local compact_path = M.filename.super:update_status()
  local full_path = vim.fn.expand('%:p:~')
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd() .. '/', ':~')

  -- 只有家目录时不显示
  if full_path == '' and cwd == '~/' then return compact_path end

  -- 没有文件名没有标志时只显示cwd
  if compact_path == '' then return self.options.hl.cwd .. cwd end

  -- 没有文件名但有标志时显示cwd和标志
  if full_path == '' then
    return self.options.hl.cwd .. cwd .. self.options.hl.file .. compact_path
  end

  -- 如果是URL
  local protocol = full_path:match '^[%w-]+://'
  if protocol then
    local rest = compact_path:match '^[^/]+//(.*)'
    return self.options.hl.cwd .. protocol .. self.options.hl.file .. rest
  end

  -- cwd不匹配时直接显示文件路径
  if full_path:find(cwd, 1, true) ~= 1 then
    return self.options.hl.file .. compact_path
  end

  -- 通过计算cwd的slash个数来划分compact_path
  local count_slash = 0
  for _ in cwd:gmatch('/') do count_slash = count_slash + 1 end
  local split_idx
  for i = 1, #compact_path do
    local c = compact_path:sub(i, i)
    if c == '/' then count_slash = count_slash - 1 end
    if count_slash == 0 then
      split_idx = i; break
    end
  end
  local compact_path_left = compact_path:sub(1, split_idx)
  local compact_path_right = compact_path:sub(split_idx + 1)
  return self.options.hl.cwd .. compact_path_left
      .. self.options.hl.file .. compact_path_right
end

return M
