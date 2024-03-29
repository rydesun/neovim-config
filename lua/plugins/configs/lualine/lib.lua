local M = {}

function M.filetype_color(post_effect)
  local ok, devicons = pcall(require, 'nvim-web-devicons')
  if not ok then return nil end

  local _, color = devicons.get_icon_color_by_filetype(
    vim.bo.filetype, { default = true })
  if post_effect ~= nil then return post_effect(color) else return color end
end

local transform_dark_color = require 'libs'.transform_color(0.3, 30)
local transform_light_color = require 'libs'.transform_color(0.5, 56)

function M.blob_color()
  local color = vim.o.background == 'dark'
      and M.filetype_color(transform_dark_color)
      or M.filetype_color(transform_light_color)
  return color and { bg = color, gui = 'bold' } or {}
end

return M
