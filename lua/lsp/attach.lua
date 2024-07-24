local M = {}

local buf_format = function()
    return vim.lsp.buf.format({ async = true })
end

local toggle_diagnostic = function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

local go_to_next_diagnostic = function()
    vim.diagnostic.jump({ count = 1, float = true })
end

local go_to_prev_diagnostic = function()
    vim.diagnostic.jump({ count = -1, float = true })
end

M.on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>e", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>f", buf_format, opts)
    vim.keymap.set("n", "[d", go_to_prev_diagnostic, opts)
    vim.keymap.set("n", "]d", go_to_next_diagnostic, opts)
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setqflist, opts)
    vim.keymap.set("n", "<leader>Q", toggle_diagnostic, opts)

    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true)
    end
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

return M
