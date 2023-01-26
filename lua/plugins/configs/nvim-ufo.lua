-- 默认取消折叠，即使有foldenable
vim.o.foldlevel = 99
-- 新打开的buffer不应用foldlevel的值
vim.o.foldlevelstart = 99

require 'ufo'.setup {
  -- 关闭闪烁
  open_fold_hl_timeout = 0,
  -- 自动折叠
  close_fold_kinds = { 'imports' },
  -- 不透明
  preview = { win_config = { winblend = 0 } },
}
