-- 压缩目录层次
vim.g.nvim_tree_group_empty = 1

vim.g.nvim_tree_icons = {
  git = {
    unstaged = " *",
    staged = " +",
    unmerged = " ",
    renamed = " ➜",
    untracked = " %",
    deleted = " x",
    ignored = " ◌",
  },
}

require'nvim-tree'.setup {
  -- 取代netrw
  hijack_netrw = true,
  -- 光标在文件名首位
  hijack_cursor = true,
  -- 自动更新
  reload_on_bufenter = true,

  view = {
    -- 相对行号
    relativenumber = true,
    -- 侧边栏符号覆盖在行号上面
    signcolumn = "number",
    mappings = {
      list = {
        { key = "l", action = "edit" },
        { key = "<C-k>", action = "prev_git_item" },
        { key = "<C-j>", action = "next_git_item" },
      },
    },
  },

  renderer = {
    -- 缩进线
    indent_markers = {
      enable = true,
    },
    -- git状态显示在侧边栏上
    icons = {
        git_placement = "signcolumn",
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
