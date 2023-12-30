vim.api.nvim_create_autocmd('BufEnter', {
    pattern = {
        '*.c',
        '*.cpp',
        '*.cc',
        '*.zig',
    },
    callback = function()
        vim.cmd.packadd('termdebug')
    end,
})
