if not vim.g.obsidian_dir then
  return
end

vim.g.obsidian_dir = vim.fn.expand(vim.g.obsidian_dir)

vim.api.nvim_create_user_command(
  'NvimTreeObsidian', 'NvimTreeFindFileToggle ' .. vim.g.obsidian_dir, {}
)

vim.api.nvim_create_user_command(
  'ObsidianDraft',
  function()
    name = vim.fn.strftime '%F_%T_' .. vim.fn.rand()
    path = string.format('%s/quick/%s.md', vim.g.obsidian_dir, name)
    vim.cmd.edit(path)
  end, {}
)

if vim.g.obsidian_diary_dir then
  vim.api.nvim_create_user_command(
    'ObsidianDiary',
    function()
      name = vim.fn.strftime '%F'
      path = string.format('%s/%s/%s.md',
        vim.g.obsidian_dir, vim.g.obsidian_diary_dir, name)
      vim.cmd.edit(path)
    end, {}
  )
end

vim.api.nvim_create_user_command(
  'ObsidianSync', function()
    msg = 'vault backup: ' .. vim.fn.strftime '%F %T'
    vim.api.nvim_command(string.format(
      "!cd '%s' && git add . && git commit -m '%s'", vim.g.obsidian_dir, msg))
    vim.api.nvim_command(string.format(
      "!cd '%s' && git pull -r && git push", vim.g.obsidian_dir, msg))
  end, {}
)
