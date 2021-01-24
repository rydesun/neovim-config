#!/bin/bash -e

msg() {
	echo "$@" >&2
}

datadir=${XDG_DATA_HOME:-"${HOME}/.local/share"}/nvim

msg "Downloading plugin manager..."
curl -fLo "${datadir}/site/autoload/plug.vim" --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

msg
msg "Installing plugins..."
nvim --headless +PlugInstall +qa

msg
msg "Done."
