#!/usr/bin/env sh

wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage
chmod u+x ./nvim.appimage
./nvim.appimage --appimage-extract
rm nvim.appimage
ln -sv "$(pwd)/squashfs-root/usr/bin/nvim" $HOME/.local/bin
