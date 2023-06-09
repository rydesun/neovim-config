local M = {}

local function get_parent_dir(dir)
  return vim.fn.fnamemodify(dir, ':h')
end

local function _dir_owns(dir, filename_pattern)
  return #vim.fn.globpath(vim.fn.escape(dir, '?*[]'), filename_pattern, 1) > 0
end

local function dir_owns(dir, filename_pattern, l_to_r)
  local is_found = false
  local current_dir, matched_dir = dir, ''
  local loop = true
  while loop do
    if _dir_owns(current_dir, filename_pattern) then
      is_found, matched_dir = true, current_dir
      if not l_to_r then loop = false end
    end
    current_dir = get_parent_dir(current_dir)
    if current_dir == '/' then loop = false end
  end
  return is_found, matched_dir
end

local function dir_owns_all(dir, patterns, l_to_r)
  for _, pattern in pairs(patterns) do
    local ok, res = dir_owns(dir, pattern, l_to_r)
    if ok then return res end
  end
  return nil
end

local function dir_match_names(dir, patterns)
  local is_found = false
  for _, pattern in ipairs(patterns) do
    local current_dir = dir
    local loop = true
    while loop do
      if vim.fn.fnamemodify(current_dir, ':t') == pattern then
        is_found, loop = true, false
      else
        current_dir = get_parent_dir(current_dir)
        if current_dir == '/' then loop = false end
      end
    end
    if is_found then return current_dir end
  end
  return nil
end

function M.get(right_own, left_own, right_names)
  if ((vim.b.rootpath ~= nil) and (vim.b.rootpath ~= "")) then
    return vim.b.rootpath
  end
  local dir = vim.fn.expand("%:p:h")
  local res = dir_owns_all(dir, right_own, false)
  if res == nil and left_own then
    res = dir_owns_all(dir, left_own, true)
  end
  if res == nil and right_names then
    res = dir_match_names(dir, right_names)
  end

  if res == nil or res == '' then
    vim.b.rootpath = dir
  else
    vim.b.rootpath = res
  end
  return vim.b.rootpath
end

function M.clear()
  vim.b.rootpath = nil
end

return M
