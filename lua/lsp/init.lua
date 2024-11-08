-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

vim.diagnostic.config({
    float = {
        format = function(diagnostic)
            return string.format("%s (%s)", diagnostic.message, diagnostic.source)
        end,
        border = "single",
    },
})

require("lspconfig.ui.windows").default_options = { border = "single" }

require("lsp.gopls")
require("lsp.sumneko")
-- require("lsp.tsserver")
require("lsp.pyright")

-- require("lspconfig").yamlls.setup({
--     on_attach = require("lsp.attach").on_attach,
--     capabilities = require("lsp.attach").capabilities,
-- })

require("lspconfig").rust_analyzer.setup({
    on_attach = require("lsp.attach").on_attach,
    capabilities = require("lsp.attach").capabilities,
})

require("lspconfig").ruff.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.hoverProvider = false
        require("lsp.attach").on_attach(client, bufnr)
    end,
    capabilities = require("lsp.attach").capabilities,
})

require("lspconfig").bashls.setup({
    on_attach = require("lsp.attach").on_attach,
    capabilities = require("lsp.attach").capabilities,
})

require("lspconfig").typst_lsp.setup({
    on_attach = require("lsp.attach").on_attach,
    capabilities = require("lsp.attach").capabilities,
    settings = {
        -- exportPdf = "onType" -- Choose onType, onSave or never.
        -- serverPath = "" -- Normally, there is no need to uncomment it.
    },
})

-- require("lspconfig").typos_lsp.setup({
--     on_attach = require("lsp.attach").on_attach,
--     capabilities = require("lsp.attach").capabilities,
-- })
require("lspconfig").dartls.setup({
    on_attach = require("lsp.attach").on_attach,
    capabilities = require("lsp.attach").capabilities,
})

require("lspconfig").sourcekit.setup({
    on_attach = require("lsp.attach").on_attach,
    capabilities = require("lsp.attach").capabilities,
})

--                                           *grr* *gra* *grn* *gri* *i_CTRL-S*
-- Some keymaps are created unconditionally when Nvim starts:
-- - "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
-- - "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
-- - "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
-- - "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
-- Remove above keymaps
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grn")
