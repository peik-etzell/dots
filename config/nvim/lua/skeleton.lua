local filetypes = { 'c', 'cpp', 'py' }

for index, extension in ipairs(filetypes) do
    vim.api.nvim_create_autocmd({ 'BufNewFile' }, {
        pattern = { '*.' .. extension },
        callback = function()
            print('hello world')
            vim.cmd(
                '0r'
                    .. vim.fn.stdpath('config')
                    .. '/templates/template.'
                    .. extension
            )
        end,
    })
end
