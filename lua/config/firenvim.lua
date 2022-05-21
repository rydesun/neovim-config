vim.g.firenvim_config = {
  globalSettings = { alt = 'all' },
  localSettings = { ['.*'] = {
    cmdline = 'firenvim',
    priority = 0,
    selector = 'textarea',
    takeover = 'never',
  }}
}

-- 不要状态栏
vim.o.laststatus = 0

if vim.o.lines < 10 then
  vim.o.lines = 10
end

if vim.fn.bufname():find('.*ipynb.*DIV.*txt') then
  vim.bo.filetype = python
end
