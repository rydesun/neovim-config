vim.g.everforest_better_performance = 1
-- 使用终端自身的配色
vim.g.everforest_disable_terminal_colors = 1

vim.g.everforest_background = 'hard'
vim.g.everforest_disable_italic_comment = 1

local function everforest_custom()
  local hi = vim.fn['everforest#highlight']
  -- 在更改background选项后，必须重新获取palette
  local palette = vim.fn['everforest#get_palette'](vim.g.everforest_background,
    vim.fn['everforest#get_configuration']().colors_override)

  -- 浮动窗口
  hi('FloatBorder', palette.bg4, palette.none)

  -- cursor
  hi('CursorLine', palette.none, palette.bg0)

  -- winbar
  hi('WinBar', palette.none, palette.bg_blue)
  hi('WinBarNC', palette.none, palette.bg_blue)

  -- tabline
  vim.cmd 'hi clear TabLineFill'

  -- virtual text
  local virtual_text = {
    { 'VirtualTextError',   palette.bg_red },
    { 'VirtualTextWarning', palette.bg_yellow },
    { 'VirtualTextInfo',    palette.bg_green },
    { 'VirtualTextHint',    palette.bg_green },
  }
  for _, zip in pairs(virtual_text) do hi(zip[1], palette.grey0, zip[2]) end

  -- InlayHint
  hi('InlayHint', palette.grey0, palette.bg2)

  -- 折叠行
  hi('Folded', palette.aqua, palette.bg_blue)

  -- nvim-cmp
  hi('PmenuSel', palette.none, palette.bg_visual)

  -- vim-better-whitespace
  hi('ExtraWhitespace', palette.none, palette.bg_red)

  -- leap.nvim
  vim.cmd 'hi link LeapLabelPrimary Search'
  vim.cmd 'hi link LeapLabelSecondary DiffText'

  -- sniprun
  vim.cmd 'hi link SniprunVirtualTextOk VirtualTextInfo'
  vim.cmd 'hi link SniprunVirtualTextErr VirtualTextInfo'

  -- 分页时
  if vim.g.paging then hi('MsgArea', palette.none, palette.bg2) end
end

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'everforest',
  callback = everforest_custom,
})

vim.cmd 'colorscheme everforest'
