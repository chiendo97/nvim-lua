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
}

M.lsp = { signature = false }

return M
