local M = {}

M.man = {
  filetypes = { 'man' },
  sections = {
    lualine_a = { function() return 'MAN' end },
    lualine_b = {
      { 'filename', file_status = false, padding = { left = 1, right = 0 } }
    },
    lualine_z = { { '%L/%-2l' } },
  },
}

return M
