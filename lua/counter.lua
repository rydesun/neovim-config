local M = {
	zh_range = '[\\u3400-\\u4DBF\\u4E00-\\u9FFC]'
}

function M:cmd_count_zh()
	vim.api.nvim_command('%s/'..self.zh_range..'//gn')
end

return M
