local components = require 'plugins.configs.lualine.components'
local blob_color = require 'plugins.configs.lualine.lib'.blob_color

local M = {}

M.man = {
  filetypes = { 'man' },
  winbar = {
    lualine_a = { { function() return ' Man' end, color = blob_color } },
    lualine_b = { { 'filename', file_status = false } },
    lualine_x = { '%2l/%L' },
    lualine_y = { 'progress' },
  },
}

M.nvim_tree = {
  filetypes = { 'NvimTree' },
  sections = {
    lualine_b = { components.cwd },
  },
}

M.quickfix = require 'lualine.extensions.quickfix'
local quickfix_func = M.quickfix.sections.lualine_a[1]
local quickfix_scope = M.quickfix.sections.lualine_b[1]
M.quickfix.sections = nil
M.quickfix.winbar = {
  lualine_a = {
    function()
      return quickfix_func() == 'Location List' and 'Location' or 'Quickfix'
    end
  },
  lualine_b = { quickfix_scope },
  lualine_c = { '%2l/%L' },
}

M.termcat = {
  filetypes = { 'termcat' },
  winbar = {
    lualine_a = { function() return ' term' end },
    lualine_x = { '%2l/%L' },
    lualine_y = { 'progress' },
  },
}

M.toggleterm = {
  filetypes = { 'toggleterm' },
  winbar = {
    lualine_a = { function() return ' #' .. vim.b.toggle_number end },
    lualine_x = { '%2l/%L' },
    lualine_y = { 'progress' },
  }
}

return M
