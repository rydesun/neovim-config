local M = {}

M.man = {
  filetypes = { 'man' },
  sections = {
    lualine_a = { function() return 'MAN' end },
    lualine_b = {
      { 'filename', file_status = false }
    },
    lualine_y = { { '%2l/%L' } },
    lualine_z = { { 'progress' } },
  },
}

return M
