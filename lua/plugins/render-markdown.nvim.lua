return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
            code = {
                border = "none",
            },
            completions = { lsp = { enabled = true } },
            pipe_table = { style = "normal" },
        },
        ft = { "markdown", "codecompanion" },
    },
}
