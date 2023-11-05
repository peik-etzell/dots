local function openscad_current_file()
    vim.fn.system('openscad ' .. vim.fn.expand('%:p') .. ' 2> /dev/null &')
end

vim.keymap.set(
    'n',
    '<leader>os',
    openscad_current_file,
    { silent = true, buffer = true }
)
