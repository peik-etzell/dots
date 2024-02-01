#!/usr/bin/env sh

wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x ./nvim.appimage
./nvim.appimage --appimage-extract
ln -sv "$(pwd)/squashfs-root/usr/bin/nvim" $HOME/.local/bin
