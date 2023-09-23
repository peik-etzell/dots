-- Change commentstring from default "/* %s */" to "// %s"
-- For C++, C, header files and C# files
vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
    pattern = { "*.c", "*.cpp", "*.h", "*.hpp", "*.cs" },
    callback = function()
        vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
    end,
})
