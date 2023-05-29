local hlslens = require 'hlslens'

hlslens.setup {}

local function hlslens_start(key)
  return function()
    local ok, res = pcall(vim.cmd.normal, { vim.v.count1 .. key, bang = true })
    if not ok then vim.api.nvim_err_writeln(res) end
    hlslens.start()
  end
end

local kopts = { noremap = true, silent = true }
vim.keymap.set('n', 'n', hlslens_start 'n', kopts)
vim.keymap.set('n', 'N', hlslens_start 'N', kopts)
vim.keymap.set('n', '*', hlslens_start '*', kopts)
vim.keymap.set('n', '#', hlslens_start '#', kopts)
vim.keymap.set('n', 'g*', hlslens_start 'g*', kopts)
vim.keymap.set('n', 'g#', hlslens_start 'g#', kopts)


-- https://github.com/kevinhwang91/nvim-hlslens#vim-visual-multi
local function vm_override_lens(render, posList, nearest, idx, relIdx)
  local _ = relIdx
  local lnum, col = unpack(posList[idx])

  local text, chunks
  if nearest then
    text = ('[%d/%d]'):format(idx, #posList)
    chunks = { { ' ', 'Ignore' }, { text, 'VM_Extend' } }
  else
    text = ('[%d]'):format(idx)
    chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
  end
  render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
end

local config = require 'hlslens.config'
local default_override_lens = config.override_lens

vim.api.nvim_create_autocmd('User', {
  pattern = 'visual_multi_start',
  callback = function()
    config.override_lens = vm_override_lens
    hlslens.start(true)
  end,
})
vim.api.nvim_create_autocmd('User', {
  pattern = 'visual_multi_exit',
  callback = function()
    config.override_lens = default_override_lens
    hlslens.start(true)
  end,
})
