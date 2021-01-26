#!/bin/bash -e

datadir=${XDG_DATA_HOME:-"${HOME}/.local/share"}/nvim

echo "Downloading plugin manager..."
curl -fLo "${datadir}/site/autoload/plug.vim" --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo
echo "Installing plugins..."
nvim --headless +PlugInstall +qa

echo
echo "Done."
