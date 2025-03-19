local keymaps = require 'plugins.configs.nvim-tree.keymaps'

local glyphs = {
  default = '󰈔',
  symlink = '󰪹',
  bookmark = ' ♥',
  folder = {
    arrow_closed = '›',
    arrow_open = '▼',
    default = '󰉋',
    empty = '󰉖',
    empty_open = '',
    symlink = '󰉒',
    symlink_open = '',
  },
}

if vim.g.env_console then
  glyphs = {
    folder = { arrow_closed = '▶', arrow_open = '▼' },
  }
end

glyphs.git = {
  unstaged = '*',
  staged = '+',
  unmerged = 'x',
  renamed = '→',
  untracked = '?',
  deleted = '_',
  ignored = '-',
}

return {
  -- BufEnter自动选中文件(不改root)
  update_focused_file = { enable = true },

  -- 已经打开的目录不显示git符号
  git = { show_on_open_dirs = false },

  view = { width = {} },

  renderer = {
    -- 压缩目录层次
    group_empty = true,

    -- 开启缩进线
    indent_markers = { enable = true },

    root_folder_label = ':~:s?$? ?',

    icons = {
      -- git状态显示在侧边栏上
      git_placement = 'signcolumn',
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
