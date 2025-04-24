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

local function new_hl(palette)
  -- 模拟highlight-undo.nvim
  vim.api.nvim_set_hl(0, 'TextChanged', {
    fg = '#dcd7ba', bg = '#2d4f67', default = true })

  hi('FoldSign', palette.orange, palette.bg_dim)
end

local function custom_basic(palette, soft_palette)
  -- lualine加载前的临时配色，需要与lualine_c保持一致
  hi('statusline', palette.grey1, palette.bg1)
  hi('WinBar', palette.grey1, palette.bg1)

  -- 报错信息去掉下划线
  hi('ErrorMsg', palette.red, palette.none, 'bold')

  -- 折叠行采用深色
  hi('Folded', palette.grey1, palette.bg_dim)

  -- 特殊的选中行改为更明显的绿色背景
  hi('CursorLine', palette.none, palette.bg_green)
  hi('QuickFixLine', palette.none, palette.bg_green)

  -- 有边框的浮动窗口: 边框不要bg
  hi('FloatBorder', palette.grey0, palette.none)
  hi('FloatTitle', palette.fg, palette.none, 'bold')

  -- Pmenu无bg
  vim.cmd 'hi! link PmenuExtra Comment'

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

local function custom_plugin(palette)
  -- ccc.nvim
  vim.cmd 'hi! link CccFloatNormal Normal'

  -- diffview: 更暗的空文本区域
  vim.cmd 'hi! link DiffviewDiffDeleteDim NonText'

  -- noice: 更暗的底部消息背景
  hi('NoiceMini', palette.none, palette.bg_dim)
  -- 更亮些
  vim.cmd 'hi! link NoiceFormatLevelError DiagnosticError'
  vim.cmd 'hi! link NoiceFormatLevelWarn DiagnosticWarn'
  vim.cmd 'hi! link NoiceFormatLevelInfo DiagnosticInfo'
  vim.cmd 'hi! link NoiceFormatLevelHint DiagnosticHint'
  vim.cmd 'hi! link NoiceFormatLevelDebug Comment'
  vim.cmd 'hi! link NoiceFormatLevelTrace Comment'
  vim.cmd 'hi! link NoiceFormatEvent Comment'
  vim.cmd 'hi! link NoiceFormatKind Comment'

  -- blink.cmp
  vim.cmd 'hi! link BlinkCmpKindText Yellow'
  vim.cmd 'hi! link BlinkCmpDocSeparator Blue'

  -- molten
  vim.cmd 'hi! link MoltenOutputWin Normal'

  -- mini.operators
  vim.cmd 'hi! link MiniOperatorsExchangeFrom Substitute'

  -- nvim-coverage
  vim.cmd 'hi! link CoverageSummaryNormal Normal'

  -- nvim-treesitter
  hi('TSNote', palette.none, palette.none, 'bold,underline', palette.green)
  hi('TSWarning', palette.none, palette.none, 'bold,underline', palette.yellow)
  hi('TSDanger', palette.none, palette.none, 'bold,underline', palette.red)

  -- nvim-treesitter-context: 行号同色
  hi('TreesitterContextLineNumber', palette.bg5, palette.bg2)

  -- vim-better-whitespace
  hi('ExtraWhitespace', palette.bg4, palette.bg_red)

  -- vim-matchup
  vim.cmd 'hi! link MatchWord CurrentWord'
  vim.cmd 'hi! link MatchWordCur CurrentWord'

  -- yanky.nvim
  vim.cmd 'hi! link YankyPut TextChanged'
end

local function setup()
  local palette, soft_palette = get_palette()
  new_hl(palette)
  custom_basic(palette, soft_palette)
  custom_plugin(palette, soft_palette)
end

vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = 'everforest', callback = setup,
})

-- 带边框的窗口不要背景色
vim.api.nvim_create_autocmd('WinNew', {
  callback = function()
    local win = vim.api.nvim_get_current_win()
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative == '' or cfg.border == '' or not cfg.border
        or vim.wo.winhighlight:match 'NormalFloat' then
      return
    end
    vim.wo.winhighlight =
        vim.wo.winhighlight == '' and 'NormalFloat:Normal' or
        vim.wo.winhighlight .. ',NormalFloat:Normal'
  end,
})

vim.cmd 'colorscheme everforest'
