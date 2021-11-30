local M = {}
local hlslens = require("hlslens")
local config = require("hlslens.config")
local lens_backup = nil

local function override_lens(render, plist, nearest, idx, r_idx)
    local lnum, col = unpack(plist[idx])
    local text = nil
    local chunks = nil
    if nearest then
        text = string.format("[%d/%d]", idx, #plist)
        chunks = {{" ", "Ignore"}, {text, "VM_Extend"}}
    else
        text = string.format("[%d]", idx)
        chunks = {{" ", "Ignore"}, {text, "HlSearchLens"}}
    end
    return render.set_virt(0, (lnum - 1), (col - 1), chunks, nearest)
end

function M.start()
    lens_backup = config.override_lens
    config.override_lens = override_lens
    return hlslens.start()
end

function M.exit()
    config.override_lens = lens_backup
    return hlslens.start()
end

return M
