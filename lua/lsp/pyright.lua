local nvim_lsp = require("lspconfig")
local util = nvim_lsp.util
local path = util.path

local function get_python_path(workspace)
    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
    end

    -- Fallback to system Python.
    return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

nvim_lsp.basedpyright.setup({
    on_attach = function(client, bufnr)
        client.server_capabilities.document_formatting = false
        client.server_capabilities.semanticTokensProvider = nil
        require("lsp.attach").on_attach(client, bufnr)
    end,
    capabilities = require("lsp.attach").capabilities,
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "all",
                diagnosticSeverityOverrides = {
                    reportAny = false,
                    reportMissingTypeArgument = false,
                    reportMissingTypeStubs = false,
                    reportUnknownArgumentType = false,
                    reportUnknownMemberType = false,
                    reportUnknownParameterType = false,
                    reportUnknownVariableType = false,
                    reportUnusedCallResult = false,
                },
            },
        },
    },
    before_init = function(_, config)
        config.settings.basedpyright.pythonPath = get_python_path(config.root_dir)
    end,
})
