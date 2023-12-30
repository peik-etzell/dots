local function openscad_current_file()
    vim.fn.system(string.format('openscad %s 2>/dev/null &', vim.fn.expand('%:p')))
end

vim.keymap.set(
    'n',
    '<leader>os',
    openscad_current_file,
    { silent = true, buffer = true }
)
