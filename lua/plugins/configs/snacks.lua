-- NvimTree修改文件名的同时通过LSP修改模块名
local prev = { new_name = '', old_name = '' }
vim.api.nvim_create_autocmd('User', {
  pattern = 'NvimTreeSetup',
  callback = function()
    local events = require('nvim-tree.api').events
    events.subscribe(events.Event.NodeRenamed, function(data)
      if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
        data = data
        Snacks.rename.on_rename_file(data.old_name, data.new_name)
      end
    end)
  end,
})

local picker = {
  sources = {},
  icons = { kinds = require 'libs.style'.symbols() },
  win = {
    input = {
      keys = {
        -- 不要全选，要移动到开头
        ['<c-a>'] = false,
        -- c-g已被终端设置占用
        ['<c-g>'] = false,
        ['<a-l>'] = { 'toggle_live', mode = { 'i', 'n' } },
      }
    },
  }
}

picker.sources.projects = {
  win = {
    input = {
      keys = {
        -- c-g已被终端设置占用
        ['<c-g>'] = false,
        ['<c-s>'] = { { 'tcd', 'picker_grep' }, mode = { 'n', 'i' } },
      }
    }
  }
}

-- 即使搜索hidden和ignored也始终排除这些目录。注意.git目录早已被排除
local exclude = { 'build/', 'target/', 'node_modules/', '__pycache__/',
  '.venv/' }
picker.sources.files = { exclude = exclude }
picker.sources.grep = { exclude = exclude }

-- 去掉files，直接用picker.files即可。而且不影响性能
picker.sources.smart = { multi = { 'buffers', 'recent' } }
picker.sources.buffers = { current = false }

picker.sources.highlights = {
  confirm = function(p, item)
    p:close()
    vim.api.nvim_feedkeys((':hi %s '):format(item.hl_group), 'n', false)
  end,
}

-- 搜索所有SymbolKind（除了lua_ls）。同时影响lsp_workspace_symbols
picker.sources.lsp_symbols = { filter = { default = true } }

-- 不要checkout，改成预览
picker.sources.git_log = { confirm = 'git_log' }
picker.sources.git_log_file = { confirm = 'git_log_file' }
picker.sources.git_log_line = { confirm = 'git_log_file' }
picker.sources.git_branches = { confirm = 'git_log_branch' }
picker.sources.git_stash = { confirm = 'git_log_stash' }

picker.actions = {
  git_log = function(p, item)
    p:close()
    vim.cmd('DiffviewFileHistory --range=' .. item.commit)
  end,
  git_log_file = function(p, item)
    p:close()
    local cmd = 'DiffviewFileHistory --range=%s %s'
    vim.cmd(cmd:format(item.commit, table.concat(item.files, ' ')))
  end,
  git_log_branch = function(p, item)
    p:close()
    vim.cmd('DiffviewFileHistory --range=origin/HEAD...' .. item.commit
      .. ' --cherry-pick --right-only')
  end,
  git_log_stash = function(p, item)
    p:close()
    vim.cmd('DiffviewFileHistory -g --range=' .. item.stash)
  end,
}

picker.layouts = {
  -- 奇怪的无边框设计
  vscode = { layout = { backdrop = true } },
}

picker.previewers = {
  -- 关闭builtin，使用delta
  diff = { builtin = false },
  git = { builtin = false },
}

return {
  bigfile = {},
  image = {},
  input = {},
  picker = picker,
  scope = {},
}
