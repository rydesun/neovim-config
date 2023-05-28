local components = require 'plugins.configs.lualine.components'
local blob_color = require 'plugins.configs.lualine.lib'.blob_color

local function template_onlyname(filetype, name)
  return {
    filetypes = { filetype },
    sections = {
      lualine_a = { { function() return name end, color = blob_color } },
    },
  }
end

local function template(name)
  return {
    lualine_a = { { function() return name end, color = blob_color } },
    lualine_y = { { '%2l/%L' } },
    lualine_z = { { 'progress', color = blob_color } },
  }
end

local M = {}

M.aerial = {
  filetypes = { 'aerial' },
  sections = template 'aerial',
}

M.diffview_files = template_onlyname('DiffviewFiles', 'Diffview Files')

M.diffview_file_history = template_onlyname(
  'DiffviewFileHistory', 'Diffview File History')

M.man = {
  filetypes = { 'man' },
  sections = vim.tbl_extend('force', template ' Man', {
    lualine_b = { { 'filename', file_status = false } },
  }),
}

M.nvim_tree = {
  filetypes = { 'NvimTree' },
  sections = vim.tbl_extend('force', template 'NvimTree', {
    lualine_b = { { components.cwd } },
  }),
}

M.quickfix = require 'lualine.extensions.quickfix'
local quickfix_color = M.quickfix.sections.lualine_a[1].color
local quickfix_func = M.quickfix.sections.lualine_a[1][1]
M.quickfix.sections.lualine_a[1][1] = function()
  return quickfix_func() == 'Location List' and 'Location' or 'Quickfix'
end
M.quickfix.sections.lualine_y = { { '%2l/%L' } }
M.quickfix.sections.lualine_z = { { 'progress', color = quickfix_color } }

M.telescope = {
  filetypes = { 'TelescopePrompt' },
  sections = {
    lualine_a = { { function() return 'Telescope' end, color = blob_color } },
    lualine_b = { { components.cwd } },
  },
}

M.termcat = {
  filetypes = { 'termcat' },
  sections = template ' TermCat',
}

return M
