-- 只安装特定工具，优先使用coc-go提供的功能

-- 关闭gopls
vim.g.go_gopls_enabled = 0

-- 禁用omnifunc补全
vim.g.go_code_completion_enabled = 0

-- 关闭vim-go的按键映射
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_def_mapping_enabled = 0

-- 禁止在保存时自动执行GoFmt
vim.g.go_fmt_autosave = 0
