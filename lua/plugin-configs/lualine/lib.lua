local M = {}

function M.filetype_color(post_effect)
  local ok, devicons = pcall(require, 'nvim-web-devicons')
  if not ok then return nil end

  local _, color = devicons.get_icon_color_by_filetype(
    vim.bo.filetype, { default = true })
  if post_effect ~= nil then return post_effect(color) else return color
  end
end

return M