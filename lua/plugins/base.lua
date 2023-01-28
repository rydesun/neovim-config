return {
  -- 补充lua API
  {'nvim-lua/plenary.nvim', lazy = true},

  -- 自动设置工作目录
  { dir = vim.fn.stdpath('config') .. '/pack/local/opt/rooter',
    opts = { '.git', 'Makefile', 'package.json' } },
}
