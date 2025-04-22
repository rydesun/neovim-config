vim.keymap.set({ 'i', 'c', 's' }, '<C-f>', '<Right>')
vim.keymap.set({ 'i', 'c', 's' }, '<C-b>', '<Left>')

local has_lazy, lazy_config = pcall(require, 'lazy.core.config')
if not has_lazy then return end
local neoscroll_enabled = lazy_config.plugins['neoscroll.nvim'] ~= nil
local noice_enabled = lazy_config.plugins['noice.nvim'] ~= nil

if neoscroll_enabled then
  local keymaps = {
    ['<C-f>'] = function() require 'neoscroll'.ctrl_f { duration = 450 } end,
    ['<C-b>'] = function() require 'neoscroll'.ctrl_b { duration = 450 } end,
    ['<C-u>'] = function() require 'neoscroll'.ctrl_u { duration = 250 } end,
    ['<C-d>'] = function() require 'neoscroll'.ctrl_d { duration = 250 } end,
    ['zt']    = function() require 'neoscroll'.zt { half_win_duration = 250 } end,
    ['zz']    = function() require 'neoscroll'.zz { half_win_duration = 250 } end,
    ['zb']    = function() require 'neoscroll'.zb { half_win_duration = 250 } end,
  }
  for key, func in pairs(keymaps) do
    vim.keymap.set({ 'n', 'x' }, key, func)
  end
end

if noice_enabled then
  if neoscroll_enabled then
    vim.keymap.set({ 'n', 'x' }, '<C-f>', function()
      if require 'noice.lsp'.scroll(4) then return end
      require 'neoscroll'.ctrl_f { duration = 450 }
    end)
    vim.keymap.set({ 'n', 'x' }, '<C-b>', function()
      if require 'noice.lsp'.scroll(-4) then return end
      require 'neoscroll'.ctrl_b { duration = 450 }
    end)
  else
    vim.keymap.set({ 'n', 'x' }, '<C-f>', function()
      if require 'noice.lsp'.scroll(4) then return end
      return '<C-f>'
    end, { expr = true })

    vim.keymap.set({ 'n', 'x' }, '<C-b>', function()
      if require 'noice.lsp'.scroll(-4) then return end
      return '<C-b>'
    end, { expr = true })
  end

  vim.keymap.set({ 'i', 's' }, '<C-f>', function()
    if not require 'noice.lsp'.scroll(4) then return '<Right>' end
  end, { expr = true })

  vim.keymap.set({ 'i', 's' }, '<C-b>', function()
    if not require 'noice.lsp'.scroll(-4) then return '<Left>' end
  end, { expr = true })
end
