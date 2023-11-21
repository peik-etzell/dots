local set = vim.opt
local let = vim.g

set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true

function format()
    vim.lsp.buf.format()
end
