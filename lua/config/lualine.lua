local function git_branch()
  local head = vim.b.gitsigns_head
  if head == nil or head == '' then
    return ''
  elseif head == 'master' or head == 'main' then
    return ''
  else
    return ' '..head
  end
end

local function git_diff()
  local status = vim.b.gitsigns_status
  if status == nil or status == '' then
    return ''
  else
    return ''
  end
end

local function encoding()
  local fenc = vim.o.fenc
  return fenc == 'utf-8' and '' or fenc
end

require'lualine'.setup {
  options = {
    theme = 'everforest',
    section_separators = {left = '', right = ''},
    component_separators = '',
  },
  sections = {
    lualine_a = {
      {'%L/%-2l', padding = {left = 1, right = 0}},
    },
    lualine_b = {
      {git_branch, padding = {left = 1, right = 0}},
      git_diff,
    },
    lualine_c = {
      {'fileformat', symbols = {unix = ''}, padding = {left = 1, right = 0}},
      {'filename',
        path = 3, symbols = {modified = '  ', readonly = ' ', unnamed = ''}},
    },
    lualine_x = {encoding},
    lualine_y = {'diagnostics'},
    lualine_z = {
      {'filetype', icons_enabled = false},
    },
  },
  extensions = {'aerial', 'nvim-tree', 'quickfix'},
}
