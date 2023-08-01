-- Change commentstring from default "/*%s*/" to "// %s"
vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
    pattern = { "*.cs" },
    callback = function()
        vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
    end,
})
