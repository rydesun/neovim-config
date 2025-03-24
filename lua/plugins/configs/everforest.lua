local hi = vim.fn['everforest#highlight']
-- 在更改background选项后，必须重新获取palette
local function get_palette()
  return
      vim.fn['everforest#get_palette']('hard',
        vim.fn['everforest#get_configuration']().colors_override),
      vim.fn['everforest#get_palette']('soft',
        vim.fn['everforest#get_configuration']().colors_override)
end

vim.g.everforest_background = 'hard'
vim.g.everforest_disable_terminal_colors = 1
vim.g.everforest_disable_italic_comment = 1

local function custom_basic()
  local palette, soft_palette = get_palette()

  -- lualine加载前的临时配色，需要与lualine_c保持一致
  hi('statusline', palette.grey1, palette.bg1)
  hi('WinBar', palette.grey1, palette.bg1)

  -- 报错信息去掉下划线
  hi('ErrorMsg', palette.red, palette.none, 'bold')

  -- 特殊的选中行改为更明显的绿色背景
  hi('CursorLine', palette.none, palette.bg_green)
  hi('QuickFixLine', palette.none, palette.bg_green)

  -- 浮动窗口: 不要bg
  hi('FloatBorder', palette.grey0, palette.none)
  hi('FloatTitle', palette.fg, palette.none, 'bold')

  -- TabLine使用更暗的背景色
  hi('TabLine', palette.grey1, palette.bg_dim)
  hi('TabLineFill', palette.grey1, palette.bg_dim)
  hi('TabLineSel', palette.fg, palette.bg3)

  -- Todo改成下划线
  hi('Todo', palette.none, palette.none, 'bold,underline', palette.blue)

  -- LSP信息: 更明显的高亮
  hi('LspReferenceText', palette.bg0, palette.purple)
  hi('LspReferenceRead', palette.bg0, palette.aqua)
  hi('LspReferenceWrite', palette.bg0, palette.orange)

  -- 更暗的diagnostic下划线和虚拟文本
  hi('VirtualTextError', soft_palette.bg_red, palette.none)
  hi('VirtualTextWarning', soft_palette.bg_yellow, palette.none)
  hi('VirtualTextInfo', soft_palette.bg_blue, palette.none)
  hi('VirtualTextHint', soft_palette.bg_green, palette.none)
  hi('DiagnosticUnderlineError', palette.none, palette.none,
    'undercurl', soft_palette.bg_red)
  hi('DiagnosticUnderlineWarn', palette.none, palette.none,
    'undercurl', soft_palette.bg_yellow)
  hi('DiagnosticUnderlineInfo', palette.none, palette.none,
    'undercurl', soft_palette.bg_blue)
  hi('DiagnosticUnderlineHint', palette.none, palette.none,
    'undercurl', soft_palette.bg_green)
end

local function custom_plugin()
  local palette, _ = get_palette()

  -- diffview: 更暗的空文本区域
  vim.cmd 'hi! link DiffviewDiffDeleteDim NonText'

  -- noice: 更暗的底部消息背景
  hi('NoiceMini', palette.none, palette.bg_dim)

  -- nvim-cmp: text类型不使用fg
  vim.cmd 'hi! link CmpItemKindText CmpItemKind'

  -- nvim-treesitter
  hi('TSNote', palette.none, palette.none, 'bold,underline', palette.green)
  hi('TSWarning', palette.none, palette.none, 'bold,underline', palette.yellow)
  hi('TSDanger', palette.none, palette.none, 'bold,underline', palette.red)

  -- nvim-treesitter-context: 行号同色
  hi('TreesitterContextLineNumber', palette.bg5, palette.bg2)

  -- sniprun：修改默认配色
  vim.cmd 'hi! link SniprunFloatingWinOk HintFloat'
  vim.cmd 'hi! link SniprunFloatingWinErr ErrorFloat'

  -- vim-better-whitespace
  hi('ExtraWhitespace', palette.bg4, palette.bg_red)

  -- vim-matchup
  vim.cmd 'hi! link MatchWord CurrentWord'
  vim.cmd 'hi! link MatchWordCur CurrentWord'
end

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'everforest', callback = custom_basic,
})
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'everforest', callback = custom_plugin,
})

vim.cmd 'colorscheme everforest'
