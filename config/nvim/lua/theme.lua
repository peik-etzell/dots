local config_path = vim.fn.stdpath("config")


local function write_theme()
    local theme = vim.g.colors_name
    local f = assert(io.open(config_path .. "/theme", "w"))
    f:write(theme)
    f:close()
end

local function read_theme()
    local f = assert(io.open(config_path .. "/theme", "r"))
    local stored_theme = f:read("*all")
    return stored_theme
end

local function change_theme(theme)
    vim.cmd("colorscheme " .. theme)
end

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    callback = write_theme,
})

local persisted_theme = read_theme()

if persisted_theme ~= "" then
    change_theme(persisted_theme)
else
    change_theme("github_dark")
end
