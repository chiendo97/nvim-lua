-- vim.lsp.set_log_level("debug")
-- require("vim.lsp.log").set_format_func(vim.inspect)

-- vim.api.nvim_create_autocmd("LspProgress", {
--     group = vim.api.nvim_create_augroup("lsp_progress", { clear = true }),
--     ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
--     callback = function(ev)
--         local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
--         vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
--             id = "lsp_progress",
--             title = "LSP Progress",
--             opts = function(notif)
--                 notif.icon = ev.data.params.value.kind == "end" and " "
--                     or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
--             end,
--         })
--     end,
-- })

-- vim.diagnostic.config opts.jump.float
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

-- Load attach handler first
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local bufnr = args.buf

        local keymapOptions = function(desc)
            return {
                nowait = true,
                noremap = true,
                silent = true,
                buffer = bufnr,
                desc = "LSP " .. desc,
            }
        end

        local toggle_diagnostic = function()
            local buffnr_opts = { bufnr = bufnr }
            vim.diagnostic.enable(not vim.diagnostic.is_enabled(buffnr_opts), buffnr_opts)
        end

        local diagnostic_qflist = function()
            vim.diagnostic.setqflist({
                open = true,
                format = function(diagnostic)
                    -- print(bufnr, vim.inspect(diagnostic))
                    if diagnostic.bufnr ~= bufnr then
                        return nil
                    end
                    return string.format("%s (%s)", diagnostic.message, diagnostic.source)
                end,
            })
        end

        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, keymapOptions("Go to declaration"))
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymapOptions("Go to definition"))
        vim.keymap.set("n", "gr", vim.lsp.buf.references, keymapOptions("Go to references"))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, keymapOptions("Hover for info"))
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, keymapOptions("Go to implementation"))
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, keymapOptions("Go to type definition"))
        vim.keymap.set("n", "<leader>e", vim.lsp.buf.rename, keymapOptions("Rename symbol"))
        vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, keymapOptions("Show code actions"))
        vim.keymap.set("n", "<leader>q", diagnostic_qflist, keymapOptions("Set quickfix list"))
        vim.keymap.set("n", "<leader>Q", toggle_diagnostic, keymapOptions("Toggle diagnostics"))

        -- Handle client-specific capabilities
        local lsp_servers = { "gopls", "lua_ls", "basedpyright", "ruff" }
        if vim.tbl_contains(lsp_servers, client.name) then
            client.server_capabilities.documentFormattingProvider = false
        end

        if client.name == "basedpyright" then
            client.server_capabilities.semanticTokensProvider = nil
        end

        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true)
        end

        if client:supports_method("textDocument/documentColor") then
            vim.lsp.document_color.enable(true)
        end

        -- Enable LLM-based inline completion
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion) then
            vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
            vim.lsp.inline_completion.enable(true)
            vim.keymap.set("i", "<CR>", function()
                if not vim.lsp.inline_completion.get() then
                    return "<CR>"
                end
            end, {
                expr = true,
                replace_keycodes = true,
                desc = "Get the current inline completion",
            })
        end
    end,
})

-- Global capabilities for all servers
local is_blink, blink_cmp = pcall(require, "blink.cmp")
local capabilities = is_blink and blink_cmp.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

-- Define configurations
vim.lsp.config("*", {
    capabilities = capabilities,
    root_markers = { ".git" },
})

-- Configure individual servers
local servers = {
    "basedpyright",
    "bashls",
    "copilot",
    "dartls",
    "gopls",
    "jsonls",
    "lua_ls",
    "ruff",
    "rust_analyzer",
    "sourcekit",
    "tinymist",
    "ts_ls",
    "yamlls",
    "zls",
}

for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

-- Remove default global keymaps
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grn")
