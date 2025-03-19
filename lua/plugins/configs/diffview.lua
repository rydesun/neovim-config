vim.api.nvim_create_autocmd('User', {
  pattern = 'DiffviewViewOpened',
  callback = function()
    local tabpage = vim.api.nvim_get_current_tabpage()
    vim.api.nvim_tabpage_set_var(tabpage, 'title', '[DiffView]')
  end,
})

return {
  -- 左侧DiffAdd应该为DiffDelete
  enhanced_diff_hl = true,

  view = {
    merge_tool = {
      layout = 'diff3_mixed',
      winbar_info = false,
    },
  },
}
