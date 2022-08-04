-- quickfix窗口的默认高度
vim.g.asyncrun_open = 6

vim.g.asyncrun_runner = {
  floaterm_repl = function(opts)
    vim.api.nvim_command(
      "FloatermNew --wintype=split --position=top "..opts.cmd)
    vim.api.nvim_command("stopinsert | wincmd p")
  end,
  floaterm_bottom = function(opts)
    vim.api.nvim_command(
      "FloatermNew --wintype=split --position=bottom "..opts.cmd)
  end,
}
