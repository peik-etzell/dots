vim.g.do_filetype_lua = 1

vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins", { change_detection = { notify = false } })

require("keymaps")

vim.filetype.add({
	extension = {
		scad = "openscad",
	},
})

local set = vim.opt
local let = vim.g

set.number = true
set.relativenumber = false
set.shell = "zsh"
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = false
set.timeoutlen = 500
set.undofile = true
set.wrap = false -- Overridden in ft=tex
set.list = true
set.listchars:append("eol:↴")

-- suckless.vim
let.suckless_tmap = 1

-- folding
set.foldlevel = 99
set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
vim.cmd([[
highlight Folded guibg=black guifg=lightgreen
]])

set.updatetime = 300

set.clipboard = "unnamedplus"

-- Resize nvim splits when whole window resizes
vim.api.nvim_create_autocmd({ "VimResized" }, { pattern = { "*" }, command = "wincmd =" })
