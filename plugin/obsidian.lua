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
    local name = vim.fn.strftime '%F_%T_' .. vim.fn.rand()
    local path = string.format('%s/quick/%s.md', vim.g.obsidian_dir, name)
    vim.cmd.edit(path)
  end, {}
)

if vim.g.obsidian_diary_dir then
  vim.api.nvim_create_user_command(
    'ObsidianDiary',
    function()
      local name = vim.fn.strftime '%F'
      local path = string.format('%s/%s/%s.md',
        vim.g.obsidian_dir, vim.g.obsidian_diary_dir, name)
      vim.cmd.edit(path)
    end, {}
  )
end

local function sync(push, async)
  local msg = 'vault backup: ' .. vim.fn.strftime '%F %T'
  local cmd_commit = string.format(
    "cd '%s' && git add . && git commit -m '%s'",
    vim.g.obsidian_dir, msg)
  local cmd_push = string.format(
    "cd '%s' && git pull -r && git push",
    vim.g.obsidian_dir)
  return function()
    local prefix = async and 'AsyncRun' or '!'
    local cmd = prefix .. ' ' .. cmd_commit
    if push then cmd = cmd .. ';' .. cmd_push end

    vim.api.nvim_command(cmd)
    if async then
      local cur_win = vim.api.nvim_get_current_win()
      vim.cmd.copen()
      vim.api.nvim_set_current_win(cur_win)
    end
  end
end

vim.api.nvim_create_user_command('ObsidianSync', sync(true, true), {})
vim.api.nvim_create_user_command('ObsidianCommit', sync(false, true), {})
