local cond = vim.g.plug_cmd
return require 'libs.lazy-helper' { cond = cond, very_lazy = true, spec = {
  -- 异步执行
  { 'skywind3000/asyncrun.vim' },

  -- 构建
  { 'skywind3000/asynctasks.vim', config_file = true },

  -- 粘贴图片
  { 'HakonHarnes/img-clip.nvim', config = true, cmd = 'PasteImage' },

  -- 终端窗口
  { 'akinsho/toggleterm.nvim', version = '*', opts_file = true },

  -- 集成Git
  { 'lewis6991/gitsigns.nvim', opts_file = true },
  { 'sindrets/diffview.nvim', opts_file = true },
  { 'NeogitOrg/neogit', opts_file = true },

  -- 切换输入法
  { 'lilydjwg/fcitx.vim',
    enabled = vim.fn.executable 'fcitx5' > 0,
    -- 不用dbus-python
    init = function() vim.g.fcitx5_remote = 'fcitx5-remote' end,
  },

  -- Obsidian
  { 'obsidian-nvim/obsidian.nvim', opts_file = true },

  -- GitHub
  { 'pwntester/octo.nvim', opts_file = true,
    cmd = 'Octo', enabled = vim.fn.executable 'gh' > 0,
  },

  -- 数据库
  { 'kndndrj/nvim-dbee', config = true,
    build = function() require 'dbee'.install() end,
    dependencies = 'MunifTanjim/nui.nvim',
    cmd = 'Dbee',
  },
} }
