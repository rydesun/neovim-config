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
