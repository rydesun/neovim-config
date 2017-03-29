# neovim-config
My neovim config file. Use [vim-plug](https://github.com/junegunn/vim-plug) to manage plugins.
## Installation ##
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    curl -fLo ~/.config/nvim/init.vim \
        https://raw.githubusercontent.com/rydesun/neovim-config/master/init.vim

    sudo pacman -S archlinuxcn/vim-youcompleteme-git

    nvim --headless -c "PlugUpgrade | q"
