# neovim-config

My NeoVim configuration files, using [packer.nvim](https://github.com/wbthomason/packer.nvim)
to manage plugins.

## Installation

```shell
# 安装插件管理器
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ${XDG_DATA_HOME:-~/.local/share}/nvim/site/pack/packer/start/packer.nvim

# 安装插件
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```
