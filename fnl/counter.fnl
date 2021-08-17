(local M {
  :zh_range "[\\u3400-\\u4DBF\\u4E00-\\u9FFC]"})

(tset M :cmd_count_zh (fn [self] (
  vim.api.nvim_command (.. "%s/" self.zh_range "//gn"))))

M
