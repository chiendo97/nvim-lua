require("gitsigns").setup({
    keymaps = {
        noremap = true,
        ["n ]h"] = {
            expr = true,
            "&diff ? ']h' : '<cmd>lua require\"gitsigns\".next_hunk()<cr>'",
        },
        ["n [h"] = {
            expr = true,
            "&diff ? '[h' : '<cmd>lua require\"gitsigns\".prev_hunk()<cr>'",
        },
        ["n ghs"] = '<cmd>lua require"gitsigns".stage_hunk()<cr>',
        ["v ghs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
        ["n ghu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<cr>',
        ["n ghr"] = '<cmd>lua require"gitsigns".reset_hunk()<cr>',
        ["v ghr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<cr>',
        ["n ghR"] = '<cmd>lua require"gitsigns".reset_buffer()<cr>',
        ["n ghp"] = '<cmd>lua require"gitsigns".preview_hunk()<cr>',
        ["n ghb"] = '<cmd>lua require"gitsigns".blame_line(true)<cr>',

        ["o ih"] = '<cmd>lua require"gitsigns".select_hunk()<cr>',
        ["x ih"] = '<cmd>lua require"gitsigns".select_hunk()<cr>',
    },
})
