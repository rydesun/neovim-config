local keymaps = require 'plugins.configs.nvim-tree.keymaps'

local glyphs = {
  default = '󰈔',
  symlink = '󰪹',
  bookmark = '󰓎',
  folder = {
    arrow_closed = '+',
    arrow_open = '-',
    default = '󰉋',
    empty = '󰉖',
    empty_open = '',
    symlink = '󰉒',
    symlink_open = '',
  },
  git = {
    unstaged = '*',
    staged = '+',
    unmerged = 'x',
    renamed = '→',
    untracked = '?',
    deleted = '_',
    ignored = '-',
  },
}

return {
  -- BufEnter自动选中文件(不改root)
  update_focused_file = { enable = true },

  -- 自动调整宽度
  view = { width = {} },

  -- 已经打开的目录不显示git符号
  git = { show_on_open_dirs = false },

  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
    icons = { error = '•', warning = '▴', info = '▪', hint = '▪' },
  },

  renderer = {
    -- 压缩目录层次
    group_empty = true,

    -- 开启缩进线
    indent_markers = { enable = true },

    root_folder_label = ':~',

    icons = {
      git_placement = 'right_align',
      diagnostics_placement = 'signcolumn',
      bookmarks_placement = 'before',
      glyphs = glyphs,
      symlink_arrow = ' → ',
    },
  },

  -- 默认不显示点文件
  filters = { dotfiles = true },

  -- 打开文件后自动关闭
  actions = { open_file = { quit_on_open = true } },

  on_attach = function(buffer) keymaps.init(buffer) end,
}
