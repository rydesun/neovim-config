if vim.b.did_gotmpl_ftplugin then return end

---@return true?
local function detect_ft()
  local ts = vim.treesitter
  local parser = ts.get_parser(0)
  if not parser then return end

  local tree = parser:parse()[1]
  local root = tree:root()

  local text_node_query = ts.query.parse('html', [[
    ((text) @_
      (#match? @_ "^\\{\\{")
      (#match? @_ "\\}\\}$"))
  ]])
  if text_node_query:iter_captures(root, 0)() then return true end

  local split_text_node_query = ts.query.parse('html', [[
    (
      (text) @a
      (#match? @a "^\\{\\{")
      (text) @b
      (#match? @b "\\}\\}$")
    )
  ]])
  if split_text_node_query:iter_captures(root, 0)() then return true end

  local attr_node_query = ts.query.parse('html', [[
    ((attribute_value) @_
      (#match? @_ "^\\{\\{"))
  ]])
  if attr_node_query:iter_captures(root, 0)() then return true end
end

if detect_ft() then
  vim.b.did_gotmpl_ftplugin = true
  vim.bo.filetype = 'gotmpl'
end
