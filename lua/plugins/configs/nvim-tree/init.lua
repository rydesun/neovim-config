local lib = require 'plugins.configs.nvim-tree.lib'
local keymaps = require 'plugins.configs.nvim-tree.keymaps'

return {
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
  },

  renderer = {
    -- 压缩目录层次
    group_empty = true,

    -- 开启缩进线
    indent_markers = { enable = true },

    icons = {
      -- git状态显示在侧边栏上
      git_placement = 'signcolumn',
      glyphs = {
        default = '󰈔',
        symlink = '󰪹',
        folder = {
          empty = '󰉖',
          empty_open = '',
          symlink = '󰉒',
          symlink_open = '󰷏',
        },
        git = {
          unstaged = ' *',
          staged = ' +',
          unmerged = ' x',
          renamed = ' ➜',
          untracked = ' %',
          deleted = ' _',
          ignored = ' -',
        },
      },
    },
  },

  -- 默认不显示点文件
  filters = { dotfiles = true },

  -- 打开文件后自动关闭
  actions = { open_file = { quit_on_open = true } },

  on_attach = function(buffer) keymaps.init(buffer) end
}
