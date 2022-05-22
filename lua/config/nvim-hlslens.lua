require'hlslens'.setup{nearest_only = true}

local hlslens = require'hlslens'
local config = require'hlslens.config'
local lensBak

local keymap = vim.api.nvim_set_keymap
local kopts = {noremap = true, silent = true}
keymap('n', 'n',
  [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts)
keymap('n', 'N',
  [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  kopts)
keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

-- https://github.com/kevinhwang91/nvim-hlslens#integrate-with-other-plugins
local function override_lens(render, posList, nearest, idx, relIdx)
    local _ = relIdx
    local lnum, col = unpack(posList[idx])

    local text, chunks
    if nearest then
        text = ('[%d/%d]'):format(idx, #posList)
        chunks = {{' ', 'Ignore'}, {text, 'VM_Extend'}}
    else
        text = ('[%d]'):format(idx)
        chunks = {{' ', 'Ignore'}, {text, 'HlSearchLens'}}
    end
    render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
end

local function vmlens_start()
    if hlslens then
        lensBak = config.override_lens
        config.override_lens = override_lens
        hlslens.start(true)
    end
end

local function vmlens_exit()
    if hlslens then
        config.override_lens = lensBak
        hlslens.start(true)
    end
end

vim.api.nvim_create_autocmd({"User"}, {
  pattern = {"visual_multi_start"},
  callback = function() vmlens_start() end
})
vim.api.nvim_create_autocmd({"User"}, {
  pattern = {"visual_multi_exit"},
  callback = function() vmlens_exit() end
})
