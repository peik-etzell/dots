local pattern = { '*.c', '*.cpp' }

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = pattern,
    callback = function(_)
        local handle = io.popen(
            "clang-format -dump-config | grep ^IndentWidth: | awk '{print $2}'"
        )
        if handle then
            local indent_width = tonumber(handle:read('*a'))
            handle:close()

            vim.opt_local.tabstop = indent_width
            vim.opt_local.shiftwidth = indent_width
        end
    end,
})
