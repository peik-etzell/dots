local handle = io.popen(
    "clang-format -dump-config | grep ^IndentWidth: | awk '{print $2}'"
)
if handle then
    local indent_width = handle:read('*a')
    handle:close()

    vim.opt.tabstop = tonumber(indent_width)
    vim.opt.shiftwidth = tonumber(indent_width)
end
