local M = {}

M.base46 = {
    theme = "gruvchad", -- default theme
}

M.ui = {
    cmp = {
        icons_left = true, -- only for non-atom styles!
    },
    tabufline = {
        enabled = false,
    },
    telescope = { style = "bordered" }, -- borderless / bordered
    statusline = {
        theme = "default", -- default/vscode/vscode_colored/minimal
        -- default/round/block/arrow separators work only for default statusline theme
        -- round and block will work for minimal theme only
        separator_style = "default",
        order = nil,
        modules = nil,
    },
}

M.lsp = { signature = true }

return M
