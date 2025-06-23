return {
    {
        "chiendo97/chatml.nvim",
        dev = true,
        branch = "cle/mcp",
        opts = {},
        keys = {
            {
                "<leader>lc",
                function()
                    require("chatml/chat").new_chat()
                end,
                mode = { "n" },
                desc = "Create new chatml chat",
            },
            {
                "<leader>lp",
                function()
                    require("chatml/chat").picker()
                end,
                mode = { "n" },
                desc = "Picker chatml chat",
            },
            {
                "<leader>lg",
                function()
                    require("chatml/chat").search()
                end,
                mode = { "n" },
                desc = "Picker chatml chat",
            },
        },
        dependencies = {
            {
                -- (Optional) It is required for sending requests to LLM providers
                "chiendo97/ai.nvim",
                dev = true,
                version = ">=1.4.2",
                opts = {
                    -- (Required) Configure a provider. :help ai-setup or
                    -- https://github.com/S1M0N38/ai.nvim/blob/main/doc/ai.txt
                    base_url = "https://api.openai.com/v1",
                    api_key = vim.fn.getenv("OPENAI_API_KEY"),
                    copilot = false,
                },
            },
            "ravitemer/mcphub.nvim",
        },
    },
}
