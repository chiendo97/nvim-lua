-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)

vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
            id = "lsp_progress",
            title = "LSP Progress",
            opts = function(notif)
                notif.icon = ev.data.params.value.kind == "end" and " "
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

vim.diagnostic.config({
    float = {
        format = function(diagnostic)
            return string.format("%s (%s)", diagnostic.message, diagnostic.source)
        end,
    },
    jump = {
        float = true,
    },
})

require("lsp.gopls")
require("lsp.sumneko")
require("lsp.tsserver")
require("lsp.pyright")

-- require("lspconfig").yamlls.setup({
--     on_attach = require("lsp.attach").on_attach,
--     capabilities = require("lsp.attach").capabilities,
-- })

require("lspconfig").zls.setup({
    on_attach = require("lsp.attach").on_attach,
    capabilities = require("lsp.attach").capabilities,
})

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

require("lspconfig").tinymist.setup({
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
