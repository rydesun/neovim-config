require 'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  playground = { enable = true },
  textobjects = {
    select = {
      enable = true,
      -- 如果不在文本对象中，自动往下查找
      lookahead = true,
      keymaps = {
        ['if'] = '@function.inner',
        ['af'] = '@function.outer',
        ['ic'] = '@class.inner',
        ['ac'] = '@class.outer',
        ['il'] = '@loop.inner',
        ['al'] = '@loop.outer',
        ['aC'] = "@comment.outer",
        ['id'] = "@conditional.inner",
        ['ad'] = "@conditional.outer",
      },
    },
  },
}
