#!/bin/bash

msg() {
	echo "$@" >&2
}
die() {
	msg "$@"
	exit 1
}

conf=$1
confdir=${XDG_CONFIG_HOME:-"${HOME}/.config"}/nvim
datadir=${XDG_DATA_HOME:-"${HOME}/.local/share"}/nvim

if [[ ! -f $conf ]]; then
	die "wrong init.vim"
fi

mkdir -p "${confdir}"
# backup file will be generated
cp "${conf}" "${confdir}/init.vim" -S .bak -v >&2

msg "Download plugin manager..."
curl -fLo "${datadir}/site/autoload/plug.vim" --create-dirs --silent \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

msg "Install plugin..."
msg "===== nvim output ====="
nvim --headless +PlugClean +PlugInstall +qa
msg "======================="
msg "Finish."
