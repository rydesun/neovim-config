vim.g.everforest_better_performance = 1
-- 使用终端自身的配色
vim.g.everforest_disable_terminal_colors = 1

vim.g.everforest_background = 'hard'
vim.g.everforest_sign_column_background = 'none'
vim.g.everforest_disable_italic_comment = 1

local function everforest_custom()
  -- 在更改background选项后，必须重新获取palette
  local palette = vim.fn['everforest#get_palette'](vim.g.everforest_background,
    vim.fn['everforest#get_configuration']().colors_override)

  -- tabline
  vim.fn['everforest#highlight']('TabLineSep', palette.bg3, palette.bg1)
  vim.fn['everforest#highlight']('TabLineSepSel',
    palette.statusline1, palette.bg1)

  -- virtual text
  for _, name in pairs { 'VirtualTextError', 'VirtualTextWarning', } do
    vim.fn['everforest#highlight'](name, palette.grey0, palette.bg_red)
  end
  for _, name in pairs { 'VirtualTextInfo', 'VirtualTextHint' } do
    vim.fn['everforest#highlight'](name, palette.grey0, palette.bg_green)
  end

  -- InlayHint
  vim.fn['everforest#highlight']('InlayHint', palette.grey0, palette.bg2)

  -- 折叠行
  vim.fn['everforest#highlight']('Folded', palette.aqua, palette.bg_blue)

  -- 浮动窗口
  vim.api.nvim_command('hi! FloatBorder guibg=None')

  -- nvim-cmp
  vim.fn['everforest#highlight']('PmenuSel', palette.none, palette.bg_visual)

  -- vim-better-whitespace
  vim.fn['everforest#highlight']('ExtraWhitespace',
    palette.none, palette.bg_red)

  -- leap.nvim
  vim.api.nvim_command('hi! link LeapLabelPrimary Search')
  vim.api.nvim_command('hi! link LeapLabelSecondary DiffText')

  -- sniprun
  vim.api.nvim_command('hi! link SniprunVirtualTextOk VirtualTextInfo')
  vim.api.nvim_command('hi! link SniprunVirtualTextErr VirtualTextInfo')

  -- 分页时
  if vim.g.paging then
    vim.fn['everforest#highlight']('MsgArea', palette.none, palette.bg2)
  end
end

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'everforest',
  callback = everforest_custom,
})

vim.api.nvim_command('colorscheme everforest')
