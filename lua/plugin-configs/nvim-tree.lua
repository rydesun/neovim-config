local lib = require("nvim-tree.lib")

local git_add = function()
  local node = lib.get_node_at_cursor()
  vim.api.nvim_command("silent !git add " .. node.absolute_path)
  lib.refresh_tree()
end

local git_unstage = function()
  local node = lib.get_node_at_cursor()
  vim.api.nvim_command("silent !git restore --staged " .. node.absolute_path)
  lib.refresh_tree()
end

require'nvim-tree'.setup {
  -- 取代netrw
  hijack_netrw = true,
  -- 光标在文件名首位
  hijack_cursor = true,
  -- 自动更新
  reload_on_bufenter = true,

  view = {
    -- 浮动窗口
    float = {
      enable = true,
    },
    -- 相对行号
    relativenumber = true,
    -- 侧边栏符号覆盖在行号上面
    signcolumn = "number",
    mappings = {
      list = {
        { key = "l", action = "edit" },
        { key = "h", action = "close_node" },
        { key = "<C-k>", action = "prev_git_item" },
        { key = "<C-j>", action = "next_git_item" },
        { key = "<<", action = "git_add", action_cb = git_add },
        { key = ">>", action = "git_unstage", action_cb = git_unstage },
      },
    },
  },

  renderer = {
    -- 压缩目录层次
    group_empty = true,
    -- 缩进线
    indent_markers = {
      enable = true,
    },
    icons = {
        -- git状态显示在侧边栏上
        git_placement = "signcolumn",
        glyphs = {
          git = {
            unstaged = " *",
            staged = " +",
            unmerged = " ",
            renamed = " ➜",
            untracked = " %",
            deleted = " x",
            ignored = " ◌",
          },
        },
    },
  },

  -- 默认不显示点文件
  filters = {
    dotfiles = true,
  },

  -- 打开文件后自动关闭
  actions = {
    open_file = {
      quit_on_open = true,
    }
  }
}

vim.api.nvim_create_autocmd({"BufEnter"}, {
  pattern = {"*"},
  nested = true,
  -- 如果是最后一个窗口则直接退出
  callback = function()
    if vim.fn.winnr('$') == 1 and
      vim.fn.bufname() == 'NvimTree_'..vim.fn.tabpagenr()
    then
      vim.api.nvim_command('quit')
    end
  end
})
