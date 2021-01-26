#!/bin/bash -e

echo "Updating plugins..."
nvim --headless +PlugUpdate +qa

echo
echo "Updating plugin manager..."
nvim --headless +PlugUpgrade +qa

echo
echo "Updating coc extensions..."
nvim --headless +CocUpdateSync +qa

echo
echo "Done."
