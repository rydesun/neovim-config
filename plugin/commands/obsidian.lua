if not vim.g.obsidian_dir then return end
local obsidian_dir = vim.fs.normalize(vim.g.obsidian_dir)

vim.api.nvim_create_user_command(
  'NvimTreeObsidian', 'NvimTreeFindFileToggle ' .. obsidian_dir, {}
)

vim.api.nvim_create_user_command(
  'ObsidianDraft',
  function()
    local name = vim.fn.strftime '%F_%T_' .. vim.fn.rand()
    local path = string.format('%s/quick/%s.md', obsidian_dir, name)
    vim.cmd.edit(path)
  end, {}
)

local function git_add()
  local cmd_add = string.format("cd '%s' && git add .", obsidian_dir)
  vim.api.nvim_command('!' .. cmd_add)
end

local function sync(push, async)
  local msg = 'vault backup: ' .. vim.fn.strftime '%F %T'
  local cmd_commit = string.format(
    "cd '%s' && git add . && git commit -m '%s'", obsidian_dir, msg)
  local cmd_push = string.format(
    "cd '%s' && git pull -r && git push", obsidian_dir)
  return function()
    local prefix = async and 'AsyncRun -mode=term -focus=? -rows=6' or '!'
    local cmd = prefix .. ' ' .. cmd_commit
    if push then cmd = cmd .. ';' .. cmd_push end
    vim.api.nvim_command(cmd)
  end
end

vim.api.nvim_create_user_command('ObsidianGitAdd', git_add, {})
vim.api.nvim_create_user_command('ObsidianSync', sync(true, true), {})
vim.api.nvim_create_user_command('ObsidianCommit', sync(false, true), {})
