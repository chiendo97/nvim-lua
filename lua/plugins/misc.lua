return {
    {
        "necrom4/calcium.nvim",
        cmd = { "Calcium" },
        opts = {},
    },
    {
        "brianhuster/live-preview.nvim",
        config = function()
            require("livepreview.config").set({
                port = 5500,
                browser = "",
                dynamic_root = false,
                sync_scroll = true,
                picker = "vim.ui.select",
                address = "127.0.0.1",
            })
        end,
        command = { "LivePreview" },
    },
}
