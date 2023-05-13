local blob_color = require 'plugins.configs.lualine.lib'.blob_color

local function template(name)
  return {
    lualine_a = { { function() return name end, color = blob_color } },
    lualine_y = { { '%2l/%L' } },
    lualine_z = { { 'progress', color = blob_color } },
  }
end

local M = {}

M.man = {
  filetypes = { 'man' },
  sections = vim.tbl_extend('force', template 'Manpage', {
    lualine_b = { { 'filename', file_status = false } },
  }),
}

M.nvim_tree = {
  filetypes = { 'NvimTree' },
  sections = template 'NvimTree',
}

M.telescope = {
  filetypes = { 'TelescopePrompt' },
  sections = {
    lualine_a = { { function() return 'Telescope' end, color = blob_color } },
  },
}

return M
