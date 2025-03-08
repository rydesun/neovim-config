local hlslens = require 'hlslens'

hlslens.setup {
  nearest_only = true,
}

-- 必须覆盖原始按键
for _, key in pairs { 'n', 'N', '*', '#', 'g*', 'g#' } do
  vim.keymap.set('n', key, function()
    -- 在没有搜索项时需要报错
    local ok, res = pcall(vim.cmd.normal, { vim.v.count1 .. key, bang = true })
    if ok then hlslens.start() else vim.api.nvim_err_writeln(res) end
  end, { noremap = true, silent = true })
end
