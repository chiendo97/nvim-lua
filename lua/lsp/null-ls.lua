local null_ls = require("null-ls")

local sources = {
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.chktex,

    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.fixjson,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports.with({ extra_args = { "-format-only" } }),
    null_ls.builtins.formatting.golines.with({ extra_args = { "--base-formatter", "gofmt", "--shorten-comments" } }),
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.stylua,

    -- null_ls.builtins.diagnostics.languagetool,
    -- null_ls.builtins.code_actions.languagetool,
}

null_ls.config({
    sources = sources,
    diagnostics_format = "[#{c}] #{m} (#{s})",
})

require("lspconfig")["null-ls"].setup({
    on_attach = require("lsp.attach").on_attach,
    capabilities = require("lsp.attach").capabilities,
})
