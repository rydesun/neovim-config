-- 该文件确保所有插件安装成功
-- 用于首次安装。后续无需加载

local bool = require 'libs'.bool

-- 安装插件管理器
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--depth', '1', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath }
end

-- 清除旧的packer_compiled.lua
local packer_compiled = vim.fn.stdpath('config') .. '/plugin/packer_compiled.lua'
if vim.fn.filereadable(packer_compiled) then
  vim.fn.delete(packer_compiled)
end

-- 选择安装用于开发的插件
local install_dev = vim.fn.stdpath('data') .. '/lazy/.install_dev'
if bool(vim.env.VIM_DEV) then
  vim.fn.writefile({}, install_dev)
else
  vim.fn.delete(install_dev)
end

-- 安装所有插件
require 'init'
require 'lazy'.install { wait = true }
