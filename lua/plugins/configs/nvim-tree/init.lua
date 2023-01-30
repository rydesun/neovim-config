local lib = require 'plugins.configs.nvim-tree.lib'

return {
  -- 让位dirbuf.nvim接管
  hijack_directories = { enable = false },

  -- 使用buffer的工作目录
  respect_buf_cwd = true,

  -- 与dressing.nvim集成
  select_prompts = true,

  -- 已经打开的目录不显示git符号
  git = { show_on_open_dirs = false },

  view = {
    -- 浮动窗口
    float = {
      enable = true,
      open_win_config = lib.center_floating,
      quit_on_focus_loss = false,
    },

    -- 开启相对行号
    relativenumber = true,
    -- 侧边栏符号覆盖在行号上面
    signcolumn = 'number',

    mappings = {
      list = {
        { key = 'l', action = 'edit' },
        { key = 'h', action = 'close_node' },
        { key = '<C-k>', action = 'prev_git_item' },
        { key = '<C-j>', action = 'next_git_item' },
        { key = '<<', action = 'git_add', action_cb = lib.git_add },
        { key = '>>', action = 'git_unstage', action_cb = lib.git_unstage },
      },
    },
  },

  renderer = {
    -- 压缩目录层次
    group_empty = true,

    -- 开启缩进线
    indent_markers = { enable = true },

    icons = {
      -- git状态显示在侧边栏上
      git_placement = "signcolumn",
      glyphs = {
        git = {
          unstaged = '*│',
          staged = '+│',
          unmerged = 'x│',
          renamed = '➜│',
          untracked = '%│',
          deleted = '_│',
          ignored = '-│',
        },
      },
    },
  },

  -- 默认不显示点文件
  filters = { dotfiles = true },

  -- 打开文件后自动关闭
  actions = {
    open_file = { quit_on_open = true },
  },
}
