set = vim.opt
let = vim.g

set.number = true
set.relativenumber = true
set.shell = "zsh"
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = false
set.timeoutlen = 500
set.undofile = true
set.wrap = false
set.list = true
set.listchars:append("eol:↴")
-- set.listchars:append({ eol = "↵", tab = "-", space = "_" })

-- suckless.vim
let.suckless_tmap = 1

-- vim.o.background = "dark"
-- vim.cmd("colorscheme catppuccin-frappe")

-- folding
set.foldlevel = 99
set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
vim.cmd([[
highlight Folded guibg=black guifg=lightgreen
]])

let.vimtex_view_method = "zathura"
let.tex_flavor = "latex"
let.vimtex_compiler_latexmk = {
	build_dir = "build",
}
-- set.conceallevel = 1
-- let.tex_conceal = "abdmg"
set.updatetime = 300

set.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd({ "VimResized" }, { pattern = { "*" }, command = "wincmd =" })
