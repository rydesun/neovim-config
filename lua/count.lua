local M = {
	zh_range = '[\\u3400-\\u4DB5\\u4E00-\\u9FEA'..
	'\\uFA0E\\uFA0F\\uFA11\\uFA13\\uFA14\\uFA1F'..
	'\\uFA21\\uFA23\\uFA24\\uFA27-\\uFA29]',
}

function M:cmd_count_zh()
	vim.api.nvim_command('%s/'..self.zh_range..'//gn')
end

return M
