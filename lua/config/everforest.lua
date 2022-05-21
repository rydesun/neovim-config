vim.g.everforest_better_performance = 1
-- 使用终端自身的配色
vim.g.everforest_disable_terminal_colors = 1

vim.g.everforest_background = 'hard'
vim.g.everforest_sign_column_background = 'none'
vim.g.everforest_disable_italic_comment = 1

vim.api.nvim_command("colorscheme everforest")

local palette = vim.fn['everforest#get_palette'](vim.g.everforest_background)

-- 折叠行
vim.fn['everforest#highlight']('Folded', palette.aqua, palette.bg1)

-- vim-better-whitespace
vim.g.better_whitespace_guicolor = palette.none[0]
vim.fn['everforest#highlight']('ExtraWhitespace', palette.none, palette.none, 'undercurl', palette.red)

-- indent-blankline
vim.fn['everforest#highlight']('IndentBlanklineContextChar', palette.grey2, palette.none)

-- coc-rust
vim.fn['everforest#highlight']('CocRustTypeHint', palette.grey0, palette.none)
vim.fn['everforest#highlight']('CocRustChainingHint', palette.grey2, palette.none)

-- 分页时
if vim.g.paging then
  vim.fn['everforest#highlight']('MsgArea', palette.none, palette.bg2)
end
