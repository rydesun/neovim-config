vim.g.everforest_better_performance = 1
-- 使用终端自身的配色
vim.g.everforest_disable_terminal_colors = 1

vim.g.everforest_background = 'hard'
vim.g.everforest_disable_italic_comment = 1

local function everforest_custom()
  -- 在更改background选项后，必须重新获取palette
  local palette = vim.fn['everforest#get_palette'](vim.g.everforest_background,
    vim.fn['everforest#get_configuration']().colors_override)

  -- 浮动窗口
  vim.fn['everforest#highlight']('FloatBorder', palette.bg4, palette.none)

  -- cursor
  vim.fn['everforest#highlight']('CursorLine', palette.none, palette.bg0)

  -- winbar
  vim.fn['everforest#highlight']('WinBar', palette.none, palette.bg_blue)
  vim.fn['everforest#highlight']('WinBarNC', palette.none, palette.bg_blue)

  -- tabline
  vim.cmd.hi('clear TabLineFill')

  -- virtual text
  vim.fn['everforest#highlight'](
    'VirtualTextError', palette.grey0, palette.bg_red)
  vim.fn['everforest#highlight'](
    'VirtualTextWarning', palette.grey0, palette.bg_yellow)
  for _, name in pairs { 'VirtualTextInfo', 'VirtualTextHint' } do
    vim.fn['everforest#highlight'](name, palette.grey0, palette.bg_green)
  end

  -- InlayHint
  vim.fn['everforest#highlight']('InlayHint', palette.grey0, palette.bg2)

  -- 折叠行
  vim.fn['everforest#highlight']('Folded', palette.aqua, palette.bg_blue)

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
