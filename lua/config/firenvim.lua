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

-- 扩大过小的界面
vim.api.nvim_create_autocmd({"UIEnter"}, {
  pattern = {"*"},
  callback = function()
    if vim.o.lines < 10 then
      vim.o.lines = 10
    end
  end
})
