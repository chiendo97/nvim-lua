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
        order = { "mode", "relativepath", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
        modules = {
            relativepath = function()
                local stbufnr = function()
                    return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
                end

                local path = vim.api.nvim_buf_get_name(stbufnr())

                if path == "" then
                    return ""
                end

                return "%#St_relativepath# " .. vim.fn.expand("%:.:h") .. "/"
            end,
        },
    },
}

M.lsp = { signature = true }

M.colorify = {
    enabled = false,
    mode = "bg", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
}

return M
