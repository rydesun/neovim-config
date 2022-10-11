local packer_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local packer_compiled = vim.fn.stdpath 'config' .. '/plugin/packer_compiled.lua'

if vim.fn.isdirectory(packer_path) == 0 then
  vim.fn.system { 'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', packer_path }
  vim.api.nvim_command('packadd packer.nvim')
end

require 'init'
if vim.fn.filereadable(packer_compiled) then
  vim.fn.delete(packer_compiled)
end
require 'packer'.sync()
