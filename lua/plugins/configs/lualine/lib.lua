local M = {
  cached_colors = { dark = {}, light = {} },
}

---@param ft string
---@return string?
function M.ft_color(ft)
  local ok, devicons = pcall(require, 'nvim-web-devicons')
  if not ok then return nil end

  local _, color = devicons.get_icon_color_by_filetype(ft, { default = true })
  return color
end

local libs = require 'libs'

---@return table
function M.ft_color_blob()
  local ft = vim.bo.filetype
  local bg = vim.o.background
  if M.cached_colors[bg][ft] then return M.cached_colors[bg][ft] end

  local ft_color = M.ft_color(ft)
  if not ft_color then
    M.cached_colors[bg][ft] = {}
    return {}
  end

  local bg_color = bg == 'dark'
      and libs.transform_color(ft_color, 0.3, 30)
      or libs.transform_color(ft_color, 0.5, 56)
  local ret = { bg = bg_color, gui = 'bold' }
  M.cached_colors[bg][ft] = ret
  return ret
end

return M
