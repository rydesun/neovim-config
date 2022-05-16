local M = {}

local function has(dir, pattern)
    return #vim.fn.globpath(vim.fn.escape(dir, "?*[]"), pattern, 1) > 0
end

local function parent(path)
    return vim.fn.fnamemodify(path, ":h")
end

local function match_dir(dir, pattern)
    local ok = false
    local pdir = dir
    local current = ""
    local loop = true
    while loop do
        if has(pdir, pattern) then
            ok = true
            loop = false
        else
            current = pdir
            pdir = parent(pdir)
            if (current == pdir) then
                loop = false
            end
        end
    end
    return ok, pdir
end

local function match_all(dir, patterns)
    for _, pattern in pairs(patterns) do
        local ok, res = match_dir(dir, pattern)
        if ok then
            return res
        end
    end
    return nil
end

function M.get(patterns)
    if ((vim.b.rootpath ~= nil) and (vim.b.rootpath ~= "")) then
        return vim.b.rootpath
    end
    local dir = vim.fn.expand("%:p:h")
    local res = match_all(dir, patterns)
    if ((res ~= nil) and (res ~= "")) then
        vim.b.rootpath = res
    else
        vim.b.rootpath = dir
    end
    return vim.b.rootpath
end

function M.clear()
    vim.b.rootpath = nil
end

return M
