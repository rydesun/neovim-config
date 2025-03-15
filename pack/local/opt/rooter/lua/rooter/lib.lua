local M = {}

function M.set_bufvar_rootpath(rules)
  local start_dir = vim.fn.expand '%:p:h'
  local found_dir = M.search(start_dir, rules)
  vim.b.rootpath = found_dir and found_dir or start_dir
end

function M.search(start_dir, rules)
  local components = vim.fn.split(start_dir, '/')
  for _, pattern_set in ipairs(rules) do
    local mode = pattern_set['mode']
    local upward = pattern_set['upward']
    local func
    if mode == 'contains' then
      func = upward and M.dir_contains_upward or M.dir_contains_downward
    elseif mode == 'dirname' then
      func = upward and M.match_dirname_upward or M.match_dirname_downward
    else
      vim.notify('rooter: malformed rules', vim.log.levels.ERROR)
    end
    if func then
      for _, pattern in ipairs(pattern_set) do
        local dir = func(components, pattern)
        if dir then return dir end
      end
    end
  end
end

function M.dir_contains_upward(components, pattern)
  for idx = #components, 1, -1 do
    local dir = '/' .. table.concat(components, '/', 1, idx)
    local target = dir .. '/' .. pattern
    if vim.uv.fs_stat(target) ~= nil then return dir end
  end
end

function M.dir_contains_downward(components, pattern)
  for idx, _ in ipairs(components) do
    local dir = '/' .. table.concat(components, '/', 1, idx)
    local target = dir .. '/' .. pattern
    if vim.uv.fs_stat(target) ~= nil then return dir end
  end
end

function M.match_dirname_upward(components, pattern)
  for idx = #components, 1, -1 do
    if components[idx] == pattern then
      return '/' .. table.concat(components, '/', 1, idx)
    end
  end
end

function M.match_dirname_downward(components, pattern)
  for idx, component in ipairs(components) do
    if component == pattern then
      return '/' .. table.concat(components, '/', 1, idx)
    end
  end
end

return M
