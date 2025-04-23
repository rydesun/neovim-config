if vim.b.did_gotmpl_ftplugin then return end

local threshold = 2 ^ 20
local file = vim.api.nvim_buf_get_name(0)
local stat = vim.uv.fs_stat(file)
if stat and stat.size > threshold then return end

---@return boolean
local function detect_gotmpl_ft()
  local ts = vim.treesitter
  local parser = ts.get_parser(0)
  if not parser then return false end

  local tree = parser:parse()[1]
  local root = tree:root()

  local query = vim.treesitter.query.get('html', 'ftdetect-gotmpl')
  if not query then return false end
  return query:iter_captures(root, 0)() ~= nil
end

if detect_gotmpl_ft() then
  vim.b.did_gotmpl_ftplugin = true
  vim.bo.filetype = 'gotmpl'
end
