local lib = require 'plugins.configs.nvim-tree.lib'
local keymaps = require 'plugins.configs.nvim-tree.keymaps'

local glyphs = {
  default = '󰈔',
  symlink = '󰪹',
  bookmark = ' ♥',
  folder = {
    empty = '󰉖',
    empty_open = '',
    symlink = '󰉒',
    symlink_open = '󰷏',
  },
}

-- 在virtual console中的图标会显示为圆圈
if vim.g.env_console then
  local ok, circles = pcall(require, 'circles')
  if ok then glyphs = circles.get_nvimtree_glyphs() end
  glyphs.folder.arrow_closed = '►'
  glyphs.folder.arrow_open = '▼'
end

glyphs.git = {
  unstaged = ' *',
  staged = ' +',
  unmerged = ' x',
  renamed = vim.g.env_console and ' →' or ' ➜',
  untracked = ' %',
  deleted = ' _',
  ignored = ' -',
}

return {
  -- BufEnter自动选中文件(不改root)
  update_focused_file = { enable = true },

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

    root_folder_label = ':~:s?^?↑ ?',

    icons = {
      -- git状态显示在侧边栏上
      git_placement = 'signcolumn',
      glyphs = glyphs,
    },
  },

  -- 默认不显示点文件
  filters = { dotfiles = true },

  -- 打开文件后自动关闭
  actions = { open_file = { quit_on_open = true } },

  on_attach = function(buffer) keymaps.init(buffer) end
}
