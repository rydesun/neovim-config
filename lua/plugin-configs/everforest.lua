vim.g.everforest_better_performance = 1
-- 使用终端自身的配色
vim.g.everforest_disable_terminal_colors = 1

vim.g.everforest_background = 'hard'
vim.g.everforest_sign_column_background = 'none'
vim.g.everforest_disable_italic_comment = 1

vim.api.nvim_command("colorscheme everforest")

local palette = vim.fn['everforest#get_palette'](vim.g.everforest_background,
  vim.fn['everforest#get_configuration']().colors_override)

-- 折叠行
vim.fn['everforest#highlight']('Folded', palette.aqua, palette.bg1)

-- nvim-cmp
vim.fn['everforest#highlight']('PmenuSel', palette.none, palette.bg_visual)

-- vim-better-whitespace
vim.fn['everforest#highlight']('ExtraWhitespace', palette.none, palette.none, 'undercurl', palette.red)

-- indent-blankline
vim.fn['everforest#highlight']('IndentBlanklineContextChar', palette.grey2, palette.none)

-- leap
vim.api.nvim_command('hi! link LeapLabelPrimary Search')
vim.api.nvim_command('hi! link LeapLabelSecondary DiffText')

-- 分页时
if vim.g.paging then
  vim.fn['everforest#highlight']('MsgArea', palette.none, palette.bg2)
end
