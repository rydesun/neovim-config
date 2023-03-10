local default_dir = vim.fn.expand('~/Data/Documents/Obsidian Vault')
local diary_dir = default_dir .. '/日记'

vim.api.nvim_create_user_command(
  'NvimTreeObsidian', 'NvimTreeFindFileToggle ' .. default_dir, {}
)

vim.api.nvim_create_user_command(
  'ObsidianDraft',
  function()
    name = vim.fn.strftime '%F_%T_' .. vim.fn.rand()
    path = string.format('%s/quick/%s.md', default_dir, name)
    vim.cmd.edit(path)
  end, {}
)

vim.api.nvim_create_user_command(
  'ObsidianDiary',
  function()
    name = vim.fn.strftime '%F'
    path = string.format('%s/%s.md', diary_dir, name)
    vim.cmd.edit(path)
  end, {}
)

vim.api.nvim_create_user_command(
  'ObsidianSync', function()
    msg = 'vault backup: ' .. vim.fn.strftime '%F %T'
    vim.api.nvim_command(string.format(
      "!cd '%s' && git add . && git commit -m '%s'", default_dir, msg))
    vim.api.nvim_command(string.format(
      "!cd '%s' && git pull -r && git push", default_dir, msg))
  end, {}
)

return {
  dir = default_dir,
  disable_frontmatter = true,
}
