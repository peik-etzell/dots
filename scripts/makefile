.PHONY: all git

local_bin = ~/.local/bin

LAZYGIT_VERSION = $(shell curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

all: $(local_bin)/nvim $(local_bin)/lazygit

$(local_bin)/nvim: $(local_bin) nvim-squashfs-root
	ln -svf "$(shell pwd)/nvim-squashfs-root/usr/bin/nvim" $(local_bin)/nvim

nvim-squashfs-root:
	wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage
	chmod u+x ./nvim.appimage
	./nvim.appimage --appimage-extract
	rm nvim.appimage
	mv squashfs-root nvim-squashfs-root

$(local_bin)/lazygit: $(local_bin) git
	curl -Lo lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_"$(LAZYGIT_VERSION)"_Linux_x86_64.tar.gz
	tar xf lazygit.tar.gz lazygit
	rm lazygit.tar.gz
	install lazygit $(local_bin)

git:
	sudo add-apt-repository ppa:git-core/ppa -y
	sudo apt update
	sudo apt install git -y

$(local_bin):
	mkdir -p ~/.local/bin
