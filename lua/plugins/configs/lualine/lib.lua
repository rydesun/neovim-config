local M = {}

---@return string?
function M.ft_color()
  local ok, devicons = pcall(require, 'nvim-web-devicons')
  if not ok then return nil end

  local _, color = devicons.get_icon_color_by_filetype(
    vim.bo.filetype, { default = true })
  return color
end

local libs = require 'libs'

---@return table
function M.ft_color_blob()
  local ft_color = M.ft_color()
  if not ft_color then return {} end

  local bg = vim.o.background == 'dark'
      and libs.transform_color(ft_color, 0.3, 30)
      or libs.transform_color(ft_color, 0.5, 56)
  return { bg = bg, gui = 'bold' }
end

return M
