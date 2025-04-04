-- 默认取消折叠(除了close_fold_kinds)
vim.o.foldlevel = 99
-- 新打开的buffer不应用foldlevel已有的值
vim.o.foldlevelstart = 99

local ufo = require 'ufo'

-- 展开所有折叠
vim.keymap.set('n', 'zR', ufo.openAllFolds)
-- 展开所有折叠，除了close_fold_kinds
vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)

-- 折叠全部
vim.keymap.set('n', 'zM', ufo.closeAllFolds)
-- 按count层级折叠
vim.keymap.set('n', 'zm', ufo.closeFoldsWith)

-- 跳转到折叠
vim.keymap.set('n', 'zj', ufo.goNextClosedFold)
vim.keymap.set('n', 'zk', ufo.goPreviousClosedFold)

vim.keymap.set('n', 'zv', ufo.peekFoldedLinesUnderCursor)

return {
  -- 关闭闪烁
  open_fold_hl_timeout = 0,
  -- LSP自动折叠指定的kinds
  close_fold_kinds_for_ft = {
    default = { 'imports' },
  },
  -- 不透明
  preview = { win_config = { winblend = 0 } },

  -- 自定义折叠行的文本
  fold_virt_text_handler = function(virtual_texts, start_lnum, end_lnum)
    local suffix = (' (+%dL) '):format(end_lnum - start_lnum)
    virtual_texts[#virtual_texts+1] = { suffix, 'NonText' }
    return virtual_texts
  end,
}
