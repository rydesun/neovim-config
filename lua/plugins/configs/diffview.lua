vim.api.nvim_create_autocmd('User', {
  pattern = 'DiffviewViewOpened',
  callback = function()
    local tabpage = vim.api.nvim_get_current_tabpage()
    vim.api.nvim_tabpage_set_var(tabpage, 'title', '[DiffView]')
  end,
})

local function git_pickaxe(all)
  local prompt = all and 'Git Pickaxe' or 'Git Pickaxe %'
  vim.ui.input({ prompt = prompt }, function(query)
    if not query or query == '' then return end
    arg = string.format("-G'%s'", query)
    if not all then arg = '% ' .. arg end
    vim.cmd.DiffviewFileHistory(arg)
  end)
end

vim.api.nvim_create_user_command('DiffViewPickaxeCurrent',
  function() git_pickaxe(false) end, {})
vim.api.nvim_create_user_command('DiffViewPickaxeAll',
  function() git_pickaxe(true) end, {})

return {
  -- 左侧DiffAdd应该为DiffDelete
  enhanced_diff_hl = true,

  view = {
    merge_tool = {
      layout = 'diff3_mixed',
      winbar_info = false,
    },
  },

  hooks = {
    -- statuscolumn已经包含折叠符号
    diff_buf_read = function()
      if vim.wo.statuscolumn ~= '' then vim.wo.foldcolumn = '0' end
    end,
  },
}
