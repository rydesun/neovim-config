local function asyncrun_reuse(cmd)
  local pos = vim.g.asynctasks_term_pos
  if pos == '' then pos = 'TAB' end
  vim.cmd.AsyncRun(
    '-mode=term -pos=' .. pos .. ' -focus=0 -listed=0 -reuse ' .. cmd)
end
vim.g['test#custom_strategies'] = { asyncrun_reuse_tab = asyncrun_reuse }

-- 可以在非tab上复用
vim.g['test#strategy'] = 'asyncrun_reuse_tab'
