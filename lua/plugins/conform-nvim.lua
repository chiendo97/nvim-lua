require("conform").setup({
    -- Define your formatters
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        typst = { "typstfmt" },
        bash = { "shfmt" },
        go = { "gofumpt", "goimports", "golines" },
        yaml = { "yamlfmt" },
        ledger = { "hledger" },
    },
    -- Set default options
    default_format_opts = {
        lsp_format = "fallback",
    },
    -- Customize formatters
    formatters = {
        shfmt = {
            prepend_args = { "-i", "2" },
        },
        hledger = {
            -- This can be a string or a function that returns a string.
            -- When defining a new formatter, this is the only field that is required
            command = "hledger",
            -- A list of strings, or a function that returns a list of strings
            -- Return a single string instead of a list to run the command in a shell
            args = {
                "-c",
                "1,000.0 vnd",
                "-c",
                "1,000.00 sgd",
                "-f-",
                "print",
            },
            -- Send file contents to stdin, read new contents from stdout (default true)
            -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
            -- file is assumed to be modified in-place by the format command.
            stdin = true,
            -- When cwd is not found, don't run the formatter (default false)
            require_cwd = false,
        },
        goimports = {
            prepend_args = { "-format-only" },
        },
        goline = {
            prepend_args = { "--base-formatter", "gofmt", "--shorten-comments"}
        },
    },
})