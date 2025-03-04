-- NvimTree修改文件名的同时通过LSP修改模块名
local prev = { new_name = "", old_name = "" }
vim.api.nvim_create_autocmd("User", {
  pattern = "NvimTreeSetup",
  callback = function()
    local events = require("nvim-tree.api").events
    events.subscribe(events.Event.NodeRenamed, function(data)
      if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
        data = data
        Snacks.rename.on_rename_file(data.old_name, data.new_name)
      end
    end)
  end,
})

local picker = {
  sources = {
    -- 即使搜索hidden和ignored也始终排除这些目录。注意.git目录早已被排除
    files = {
      exclude = { 'build/', 'target/', 'node_modules/', '__pycache__/',
        '.venv/' }
    },
    grep = {
      exclude = { 'build/', 'target/', 'node_modules/', '__pycache__/',
        '.venv/' }
    },
    -- 不要checkout，改成预览
    git_log_file = { confirm = 'git_show_file' },
    git_log_line = { confirm = 'git_show_file' },
    git_log = { confirm = 'git_show' },
  },
  layouts = {
    -- 奇怪的无边框设计
    vscode = { layout = { backdrop = true } },
  },
  previewers = {
    -- 关闭builtin，使用delta
    diff = { builtin = false },
    git = { builtin = false },
  },
  actions = {
    git_show_file = function(picker, item)
      picker:close()
      require 'gitsigns'.show(item.commit)
    end,
    git_show = function(picker, item)
      picker:close()
      vim.cmd('DiffviewFileHistory --range=' .. item.commit)
    end,
  },
}

return {
  bigfile = { enabled = true },
  image = { enabled = true },
  input = { enabled = true },
  picker = picker,
  scope = { enabled = true, treesitter = { enabled = false } },

  styles = {
    input = {
      keys = {
        hist_up = { "<c-p>", { "hist_up" }, mode = { "i", "n" } },
        hist_down = { "<c-n>", { "hist_down" }, mode = { "i", "n" } },
      },
    },
  },
}
