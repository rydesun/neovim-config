return {
  { 'nvim-lua/plenary.nvim', lazy = true },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = { highlight = { enable = true } },
    event = { 'VeryLazy', 'BufReadPost' },
  },
}
