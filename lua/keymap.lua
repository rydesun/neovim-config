local M = {}

local cmds = {
    i_et = "cnoreabb <expr> i%1"
        .. " (getcmdtype() == ':' && getcmdline() =~ '^i%1$')?"
        .. " 'setl sw=%1 ts=%1 et' : 'i%1'",
    i_noet = "cnoreabb <expr> i%1t"
        .. " (getcmdtype() == ':' && getcmdline() =~ '^i%1t$')?"
        .. " 'setl sw=%1 ts=%1 noet' : 'i%1t'",
}

function M:setup()
    for _, i in pairs{2, 4, 8} do
        for _, cmd in pairs(cmds) do
            local s = string.gsub(i, "(%d)", cmd)
            vim.api.nvim_command(s)
        end
    end
end

return M
