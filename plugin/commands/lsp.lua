local function fixall()
  vim.lsp.buf.code_action { apply = true, context = {
    diagnostics = {}, only = { 'source.fixAll' } } }
end

local function fixall_js()
  vim.cmd 'TSToolsFixAll'
end

local function format()
  local ok, conform = pcall(require, 'conform')
  if ok then
    conform.format({}, function(err)
      if err then
        vim.notify(err, vim.log.levels.WARN)
        return
      end
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), 'v') then
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
      end
    end)
  else
    vim.lsp.buf.format {}
  end
end

local function sortimports_and_format()
  -- FIXME: 必须提供sync版本
  vim.lsp.buf.code_action { apply = true, context = {
    diagnostics = {}, only = { 'source.organizeImports' } } }
  format()
end

local function format_js()
  vim.cmd 'TSToolsOrganizeImports'
  format()
end

-- 不同语言封装成统一的命令LspFixAll和LspFormat
vim.api.nvim_create_autocmd('filetype', {
  pattern = { 'python' },
  callback = function()
    vim.api.nvim_buf_create_user_command(0, 'LspFixAll', fixall, {})
    vim.api.nvim_buf_create_user_command(0, 'LspFormat',
      sortimports_and_format, {})
  end,
})
vim.api.nvim_create_autocmd('filetype', {
  pattern = { 'go' },
  callback = function()
    -- TODO: 使用sync版本的sortimports
    vim.api.nvim_buf_create_user_command(0, 'LspFormat', format, {})
  end,
})
vim.api.nvim_create_autocmd('filetype', {
  pattern = { 'javascript', 'typescript' },
  callback = function()
    vim.api.nvim_buf_create_user_command(0, 'LspFixAll', fixall_js, {})
    vim.api.nvim_buf_create_user_command(0, 'LspFormat', format_js, {})
  end,
})
-- 默认行为
vim.api.nvim_create_user_command('LspFixAll', function()
  vim.notify('[LSP] FixAll not configured', vim.log.levels.INFO)
end, {})
vim.api.nvim_create_user_command('LspFormat', format, {})

-- 特定语言按需手动开启
vim.api.nvim_create_user_command('FormatOnSaveEnable', function()
  local ext = vim.fn.expand '%:e'
  if ext == '' then
    vim.notify('FormatOnSave: Invalid ext', vim.log.levels.ERROR)
    return
  end
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.' .. ext,
    group = vim.api.nvim_create_augroup('format_on_save_' .. ext,
      { clear = true }),
    callback = function() vim.cmd 'LspFormat' end,
  })
  vim.notify('FormatOnSave enabled: ' .. ext, vim.log.levels.INFO)
end, {})
vim.api.nvim_create_user_command('FormatOnSaveDisable', function()
  local ext = vim.fn.expand '%:e'
  if ext == '' then return end
  vim.api.nvim_clear_autocmds { group = 'format_on_save_' .. ext }
  vim.notify('FormatOnSave disabled: ' .. ext, vim.log.levels.INFO)
end, {})

-- go强制自动格式化
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.go' },
  group = vim.api.nvim_create_augroup('format_on_save_go',
    { clear = true }),
  callback = function() vim.cmd 'LspFormat' end,
})

vim.api.nvim_create_user_command('CodelensEnable', function()
  vim.lsp.codelens.refresh()

  local augroup = vim.api.nvim_create_augroup('Codelens', {})
  vim.api.nvim_create_autocmd({ 'BufReadPost', 'InsertLeave' }, {
    pattern = '*',
    group = augroup,
    callback = vim.lsp.codelens.refresh,
  })
  local timer = assert(vim.uv.new_timer())
  vim.api.nvim_create_autocmd('TextChanged', {
    pattern = '*',
    group = augroup,
    callback = function()
      timer:stop()
      timer:start(500, 0, vim.schedule_wrap(function()
        vim.lsp.codelens.refresh()
      end))
    end,
  })
end, {})

vim.api.nvim_create_user_command('CodelensDisable', function()
  vim.api.nvim_clear_autocmds { group = 'Codelens' }
  vim.lsp.codelens.clear()
end, {})
