#!/bin/bash -e

msg() {
	echo "$@" >&2
}

msg "Updating plugins..."
nvim --headless +PlugUpdate +qa

msg
msg "Updating plugin manager..."
nvim --headless +PlugUpgrade +qa

msg
msg "Updating coc extensions..."
nvim --headless +CocUpdateSync +qa

msg
msg "Done."
