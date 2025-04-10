local M = {}

local api = require 'nvim-tree.api'
local core = require 'nvim-tree.core'

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
  vim.keymap.set('n', '=', api.tree.change_root_to_node, opts 'CD')
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close Directory')
  vim.keymap.set('n', '<C-k>', api.node.navigate.git.prev, opts 'Prev Git')
  vim.keymap.set('n', '<C-j>', api.node.navigate.git.next, opts 'Next Git')
  vim.keymap.set('n', ']b', api.marks.navigate.next, opts 'Next bookmark')
  vim.keymap.set('n', '[b', api.marks.navigate.prev, opts 'Prev bookmark')

  vim.keymap.set('n', 'sf', function()
    local node = api.tree.get_node_under_cursor()
    if not node then return end
    if node.parent and node.type == 'file' then node = node.parent end
    Snacks.picker.files { dirs = { node.absolute_path } }
  end, opts 'Fuzzy Find Files')

  vim.keymap.set('n', 'sF', function()
    local node = api.tree.get_node_under_cursor()
    if not node then return end
    if node.parent and node.type == 'file' then node = node.parent end
    Snacks.picker.files { dirs = { node.absolute_path },
      exclude = {}, ignored = true, hidden = true }
  end, opts 'Fuzzy Find Files (include all)')

  vim.keymap.set('n', 'ss', function()
    local node = api.tree.get_node_under_cursor()
    if not node then return end
    if node.parent and node.type == 'file' then node = node.parent end
    Snacks.picker.grep { dirs = { node.absolute_path } }
  end, opts 'Fuzzy Grep')

  vim.keymap.set('n', 'sS', function()
    local node = api.tree.get_node_under_cursor()
    if not node then return end
    if node.parent and node.type == 'file' then node = node.parent end
    Snacks.picker.grep { dirs = { node.absolute_path },
      exclude = {}, ignored = true, hidden = true }
  end, opts 'Fuzzy Grep (include all)')

  vim.keymap.set('n', ',', function()
    local target_dir
    local node = api.tree.get_node_under_cursor()
    if node and node.type == 'directory' then
      target_dir = node.absolute_path
    else
      target_dir = core.get_cwd()
    end
    api.tree.toggle()
    vim.notify('RooterPin ' .. target_dir)
    vim.cmd.RooterPin(target_dir)
    api.tree.toggle()
  end, opts 'Rooter Pin Cwd')

  vim.keymap.set('n', '<<', function()
    local node = api.tree.get_node_under_cursor()
    vim.api.nvim_command('silent !git add ' .. node.absolute_path)
  end, opts 'Git Add')

  vim.keymap.set('n', '>>', function()
    local node = api.tree.get_node_under_cursor()
    vim.api.nvim_command('silent !git restore --staged ' .. node.absolute_path)
  end, opts 'Git Unstage')
end

return M
