#!/bin/sh

msg() {
	echo $@ >&2
}

die() {
	msg $@
	exit 1
}

conf=$1
confdir=${2:-"${HOME}/.config/nvim"}

if [[ ! -f $conf ]]; then
	die "wrong init.vim"
fi
if [[ -e $confdir && ! -d $confdir ]]; then
	die "wrong config dir"
else
	mkdir -p ${confdir}
fi

# auto backup
cp "${conf}" "${confdir}/init.vim" -S .bak -v >&2

msg "Download plugin manager..."
curl -o "${confdir}/autoload/plug.vim" --create-dirs --silent \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

msg "Install plugin..."
msg "===== nvim output ====="
nvim --headless +PlugClean +PlugInstall +qa
msg "======================="
msg "Finish."
