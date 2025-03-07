-- 该文件确保所有插件安装成功
-- 用于首次安装。后续无需加载

-- 安装插件管理器
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none',
    lazyrepo, '--branch=stable', lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

-- 选择安装用于开发的插件
local install_dev = vim.fn.stdpath('data') .. '/lazy/.install_dev'
if vim.env.VIM_DEV == '1' then
  vim.fn.writefile({}, install_dev)
else
  vim.fn.delete(install_dev)
end

-- 安装所有插件
vim.cmd.source(vim.fn.stdpath('config') .. '/init.lua')
require 'lazy'.install { wait = true }
