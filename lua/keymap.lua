local M = {}

function M.add_indent_cmds()
	local indent_counts = {2, 4, 8}
	local cmd_i_et = "cnoreabb <expr> i%1 "..
		"(getcmdtype() == ':' && getcmdline() =~ '^i%1$')? "..
		"'setl sw=%1 ts=%1 et' : 'i%1'"
	local cmd_i_noet = "cnoreabb <expr> i%1t "..
		"(getcmdtype() == ':' && getcmdline() =~ '^i%1t$')? "..
		"'setl sw=%1 ts=%1 noet' : 'i%1'"
	for _, count in ipairs(indent_counts) do
		local cmd_i_et = string.gsub(count, "(%d)", cmd_i_et)
		local cmd_i_noet = string.gsub(count, "(%d)", cmd_i_noet)
		vim.api.nvim_command(cmd_i_et)
		vim.api.nvim_command(cmd_i_noet)
	end
end

return M
