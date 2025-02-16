-- 使用终端自身的配色
vim.g.everforest_disable_terminal_colors = 1

-- 不要斜体
vim.g.everforest_disable_italic_comment = 1

vim.g.everforest_background = 'hard'

local hi = vim.fn['everforest#highlight']

-- 在更改background选项后，必须重新获取palette
local function get_palette()
  return vim.fn['everforest#get_palette'](
    vim.g.everforest_background,
    vim.fn['everforest#get_configuration']().colors_override
  )
end

local function everforest_custom()
  local palette = get_palette()
  local transparent_background = vim.g.everforest_transparent_background or 0

  vim.cmd 'hi ErrorMsg gui=bold,reverse'

  -- 临时配色，之后被lualine接管
  hi('statusline', palette.grey1, palette.bg1)

  -- 浮动窗口
  hi('FloatBorder', palette.bg4, palette.none)

  -- cursor
  hi('CursorLine', palette.none, palette.bg0)

  -- winbar
  hi('WinBar', palette.none, palette.bg_blue)
  hi('WinBarNC', palette.none, palette.bg_blue)

  -- tabline
  hi('TabLine', palette.fg, palette.bg_dim)
  hi('TabLineSel', palette.fg, palette.none)
  hi('TabLineFill', palette.fg, palette.bg_dim)

  -- statusline
  vim.cmd 'hi StatusLineNC gui=bold,italic'
  hi('StatusLineTermNC', palette.fg, palette.bg1, 'bold,italic')
  if transparent_background == 2 then
    vim.cmd 'hi StatusLineTermNC guibg=none'
  end

  -- quickfix
  hi('QuickFixLine', palette.none, palette.bg_green)

  -- Diagnostic Text
  vim.cmd 'hi! link DiagnosticError Red'
  vim.cmd 'hi! link DiagnosticWarn Yellow'
  vim.cmd 'hi! link DiagnosticInfo Blue'
  vim.cmd 'hi! link DiagnosticHint Green'

  -- virtual text
  local virtual_text = {
    { 'VirtualTextError', palette.bg_red },
    { 'VirtualTextWarning', palette.bg_yellow },
    { 'VirtualTextInfo', palette.bg_green },
    { 'VirtualTextHint', palette.bg_green },
  }
  for _, zip in pairs(virtual_text) do
    local name, fg, bg = zip[1], palette.grey0, zip[2]
    if transparent_background > 0 then bg = palette.none end
    hi(name, fg, bg)
  end

  -- Diff
  hi('DiffChange', palette.none, palette.bg_dim)
  hi('DiffText', palette.none, palette.bg_blue)

  -- 折叠行
  hi('Folded', palette.aqua, palette.bg_blue)
  -- 在Diff时改回原值
  vim.api.nvim_create_autocmd('OptionSet', {
    pattern = 'diff',
    callback = function() hi('Folded', palette.grey1, palette.bg1) end,
  })

  -- telescope
  hi('TelescopeResultsDiffChange', palette.blue, palette.none)
  hi('TelescopeResultsDiffAdd', palette.red, palette.none)
  hi('TelescopeResultsDiffDelete', palette.yellow, palette.none)
  hi('TelescopeResultsDiffUntracked', palette.purple, palette.none)

  -- nvim-cmp
  hi('PmenuSel', palette.none, palette.bg_visual)

  -- nvim-tree
  vim.cmd 'hi! link NvimTreeEndOfBuffer NvimTreeNormalFloat'
  vim.cmd 'hi! link NvimTreeSignColumn NvimTreeNormalFloat'

  -- oil.nvim
  vim.cmd 'hi! link OilDir NvimTreeFolderName'
  vim.cmd 'hi! link OilCreate GreenSign'
  vim.cmd 'hi! link OilDelete RedSign'
  vim.cmd 'hi! link OilMove OrangeSign'
  vim.cmd 'hi! link OilCopy AquaSign'
  vim.cmd 'hi! link OilChange BlueSign'

  -- nvim-treesitter-context
  hi('TreesitterContextLineNumber', palette.bg5, palette.bg2)

  -- vim-matchup
  vim.cmd 'hi! link MatchWord CurrentWord'
  vim.cmd 'hi! link MatchWordCur CurrentWord'

  -- vim-better-whitespace
  hi('ExtraWhitespace', palette.bg4, palette.bg_red)

  -- leap.nvim
  vim.cmd 'hi! link LeapLabelPrimary Search'
  vim.cmd 'hi! link LeapLabelSecondary DiffText'

  -- sniprun
  vim.cmd 'hi! link SniprunVirtualTextOk VirtualTextInfo'
  vim.cmd 'hi! link SniprunVirtualTextErr VirtualTextInfo'
end

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'everforest',
  callback = everforest_custom,
})

vim.cmd 'colorscheme everforest'
