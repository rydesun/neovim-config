local M = {}

local api = require 'nvim-tree.api'

local lib = require 'plugins.configs.nvim-tree.lib'

function M.init(bufnr)
  api.config.mappings.default_on_attach(bufnr)

  local function opts(desc)
    return {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true,
    }
  end
  vim.keymap.set('n', 'l', api.node.open.edit, opts 'Open')
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close Directory')
  vim.keymap.set('n', '<C-k>', api.node.navigate.git.prev, opts 'Prev Git')
  vim.keymap.set('n', '<C-j>', api.node.navigate.git.next, opts 'Next Git')
  vim.keymap.set('n', '<<', function()
    local node = api.tree.get_node_under_cursor()
    lib.git_add(node.absolute_path)
  end, opts 'Git Add')

  vim.keymap.set('n', '>>', function()
    local node = api.tree.get_node_under_cursor()
    lib.git_unstage(node.absolute_path)
  end, opts 'Git Unstage')
end

return M
