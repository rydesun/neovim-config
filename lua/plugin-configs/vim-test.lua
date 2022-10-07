local function asyncrun_reuse_tab(cmd)
  vim.api.nvim_command('AsyncRun -mode=term -pos=TAB -focus=0 -reuse ' .. cmd)
end

vim.g['test#custom_strategies'] = { asyncrun_reuse_tab = asyncrun_reuse_tab }
vim.g['test#strategy'] = 'asyncrun_reuse_tab'
