local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")

local FORMATTING = methods.internal.FORMATTING

null_ls.register(helpers.make_builtin({
    name = "hledger",
    method = FORMATTING,
    filetypes = { "ledger" },
    generator_opts = {
        command = "hledger",
        args = {
            "-c",
            "1,000.0 vnd",
            "-c",
            "1,000.00 sgd",
            "-f-",
            "print",
        },
        to_stdin = true,
    },
    factory = helpers.formatter_factory,
}))

null_ls.register(helpers.make_builtin({
    name = "latex",
    method = FORMATTING,
    filetypes = { "plaintex" },
    generator_opts = {
        command = "latexindent",
        args = { "-" },
        to_stdin = true,
    },
    factory = helpers.formatter_factory,
}))

local sources = {
    -- null_ls.builtins.diagnostics.flake8,
    -- null_ls.builtins.diagnostics.markdownlint,
    -- null_ls.builtins.diagnostics.buf,
    -- null_ls.builtins.diagnostics.ruff,
    -- null_ls.builtins.diagnostics.shellcheck,

    -- null_ls.builtins.diagnostics.protoc_gen_lint,
    -- null_ls.builtins.diagnostics.protolint,

    null_ls.builtins.formatting.typstfmt,

    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
    -- require("none-ls.formatting.ruff"),

    null_ls.builtins.formatting.buf,
    -- null_ls.builtins.formatting.protolint,
    --
    -- null_ls.builtins.formatting.beautysh,
    null_ls.builtins.formatting.shfmt,
    -- null_ls.builtins.formatting.fixjson,

    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports.with({ extra_args = { "-format-only" } }),
    null_ls.builtins.formatting.golines.with({ extra_args = { "--base-formatter", "gofmt", "--shorten-comments" } }),

    -- null_ls.builtins.formatting.markdownlint,

    -- null_ls.builtins.formatting.pg_format,
    -- null_ls.builtins.formatting.sql_formatter,
    --
    -- null_ls.builtins.diagnostics.eslint_d,
    -- null_ls.builtins.formatting.prettierd,

    -- null_ls.builtins.formatting.rustfmt,
    --
    null_ls.builtins.formatting.stylua,

    null_ls.builtins.formatting.yamlfmt,

    -- null_ls.builtins.code_actions.eslint_d,
    -- null_ls.builtins.code_actions.shellcheck,
}

null_ls.setup({
    -- debug = true,
    sources = sources,
    on_attach = require("lsp.attach").on_attach,
    capabilities = require("lsp.attach").capabilities,
})
