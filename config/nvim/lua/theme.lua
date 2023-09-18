local config_path = vim.fn.stdpath("state") .. "/theme"

local function write_current_theme()
    local theme = vim.g.colors_name
    local f = io.open(config_path, "w")
    if not f then return end
    f:write(theme)
    f:close()
end

local function get_stored_theme()
    local f = io.open(config_path, "r")
    if not f then return "" end
    local stored_theme = f:read("*all")
    f:close()
    return stored_theme
end

local function change_theme(theme)
    vim.cmd("colorscheme " .. theme)
end

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    callback = write_current_theme,
})

-- Runs on startup:
local persisted_theme = get_stored_theme()
if persisted_theme ~= "" then
    change_theme(persisted_theme)
else
    change_theme("github_dark")
end
