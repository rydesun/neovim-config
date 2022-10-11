local packer_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.isdirectory(packer_path) == 0 then
  vim.fn.system { 'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim', packer_path }
  vim.api.nvim_command('packadd packer.nvim')
end

require 'init'
require 'packer'.sync()
