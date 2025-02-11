#!/usr/bin/env sh

wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x ./nvim.appimage
./nvim.appimage --appimage-extract
rm nvim.appimage
DIR="${HOME}/.local/bin"
if [ ! -d "${DIR}" ]; then
    mkdir -p "${DIR}"
fi
ln -sv "$(pwd)/squashfs-root/usr/bin/nvim" "${DIR}"
