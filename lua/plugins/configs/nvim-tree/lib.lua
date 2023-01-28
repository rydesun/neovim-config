local M = {}

local lib = require 'nvim-tree.lib'

function M.git_add()
  local node = lib.get_node_at_cursor()
  vim.api.nvim_command('silent !git add ' .. node.absolute_path)
  lib.refresh_tree()
end

function M.git_unstage()
  local node = lib.get_node_at_cursor()
  vim.api.nvim_command('silent !git restore --staged ' .. node.absolute_path)
  lib.refresh_tree()
end

function M.center_floating()
  local screen_w = vim.opt.columns:get()
  local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
  local window_w = math.min(60, screen_w * 0.6)
  local window_h = math.min(30, screen_h * 0.6)
  local window_w_int = math.floor(window_w)
  local window_h_int = math.floor(window_h)
  local center_x = (screen_w - window_w) / 2
  local center_y = ((vim.opt.lines:get() - window_h) / 2)
      - vim.opt.cmdheight:get()
  return {
    border = 'single',
    relative = 'editor',
    row = center_y,
    col = center_x,
    width = window_w_int,
    height = window_h_int,
  }
end

return M
