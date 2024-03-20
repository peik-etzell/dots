.PHONY: all git

local_bin = ~/.local/bin
fonts = ~/.local/share/fonts

LAZYGIT_VERSION = $(shell curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

all: neovim lazygit
install: $(local_bin)/nvim $(local_bin)/lazygit hack-install

$(local_bin)/nvim: $(local_bin) neovim 
	ln -svf "$(shell pwd)/nvim-squashfs-root/usr/bin/nvim" $(local_bin)/nvim

neovim:
	wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage
	chmod u+x ./nvim.appimage
	./nvim.appimage --appimage-extract
	rm nvim.appimage
	mv squashfs-root neovim

$(local_bin)/lazygit: lazygit $(local_bin) git
	install lazygit $(local_bin)

lazygit: $(local_bin) git
	curl -Lo lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_"$(LAZYGIT_VERSION)"_Linux_x86_64.tar.gz
	tar xf lazygit.tar.gz lazygit
	rm lazygit.tar.gz

$(fonts)/%.ttf: hack/%.ttf
	cp $< $@

hack-install: hack $(fonts)
	cp -f hack/*.ttf $(fonts)/

hack:
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
	unzip Hack.zip -d hack
	rm Hack.zip

git:
	sudo add-apt-repository ppa:git-core/ppa -y
	sudo apt update
	sudo apt install git -y

$(local_bin):
	mkdir -p $(local_bin)

$(fonts):
	mkdir -p $(fonts)
