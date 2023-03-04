require 'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  playground = { enable = true },
  textobjects = {
    select = {
      enable = true,
      -- 如果不在文本对象中，自动往下查找
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['ik'] = '@assignment.lhs',
        ['iv'] = '@assignment.rhs',
      },
    },
  },
}
