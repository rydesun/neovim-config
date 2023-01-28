local bool = require 'lib'.bool

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--depth', '1', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath }
end

local install_dev = vim.fn.stdpath('data') .. '/lazy/.install_dev'
if bool(vim.env.VIM_DEV) then
  vim.fn.writefile({}, install_dev)
else
  vim.fn.delete(install_dev)
end

-- 清除旧的packer_compiled.lua
local packer_compiled = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua'
if vim.fn.filereadable(packer_compiled) then
  vim.fn.delete(packer_compiled)
end

require 'init'

require 'lazy'.install { wait = true }
