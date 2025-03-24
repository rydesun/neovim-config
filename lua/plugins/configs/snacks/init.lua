---@module "snacks"

-- NvimTree修改文件名的同时通过LSP修改模块名
local prev = { new_name = '', old_name = '' }
vim.api.nvim_create_autocmd('User', {
  pattern = 'NvimTreeSetup',
  callback = function()
    local events = require 'nvim-tree.api'.events
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
        ['<c-o>'] = { 'system_open', mode = { 'i', 'n' } },
      },
    },
  },
}

picker.sources.projects = {
  win = {
    input = {
      keys = {
        -- c-g已被终端设置占用
        ['<c-g>'] = false,
        ['<c-s>'] = { { 'tcd', 'picker_grep' }, mode = { 'n', 'i' } },
      },
    },
  },
}

-- 即使搜索hidden和ignored也始终排除这些路径。注意.git目录早已被排除
local exclude = { 'build/', 'target/', 'node_modules/', '__pycache__/',
  '.pytest_cache/', '.venv/', '*.lock', '*-lock.json' }
picker.sources.files = { exclude = exclude }
picker.sources.grep = { exclude = exclude }

picker.sources.buffers = { current = false }
picker.sources.smart = {
  -- 来源里去掉files(不如单独用picker.files，并且不影响smart性能)
  multi = { 'buffers', 'recent' },
  -- 没输入pattern时，让buffers保持在最上面
  matcher = { sort_empty = false },
  format = function(item, p)
    local ret = {}
    if item.buf then
      local buf = string.format('%3d', item.buf):gsub(' ', '0')
      ret[#ret+1] = { buf, 'SnacksPickerBufNr' }
      ret[#ret+1] = { ' ' }
    end
    vim.list_extend(ret, Snacks.picker.format.filename(item, p))
    return ret
  end,
}

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
  system_open = function(_, item)
    vim.notify("Open file: " .. item.file)
    vim.ui.open(item.file)
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

-- 添加自制的源
picker.sources = vim.tbl_extend('error', picker.sources,
  require 'plugins.configs.snacks.picker.sources')

return {
  bigfile = {},
  image = {},
  input = {},
  picker = picker,
  scope = {},
}
