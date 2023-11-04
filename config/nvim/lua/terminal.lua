vim.api.nvim_create_autocmd({
    'BufWinEnter',
    'WinEnter',
    'TermOpen',
}, {
    pattern = { 'term://*' },
    callback = function()
        vim.wo.number = false
        vim.cmd.startinsert()
    end,
})

vim.keymap.set({ 'n', 'i', 't' }, '<A-CR>', function()
    vim.cmd.vs()
    vim.cmd.terminal()
end, { silent = true })

vim.keymap.set({ 't' }, '<A-ESC>', '<C-\\><C-n>', { silent = true })
