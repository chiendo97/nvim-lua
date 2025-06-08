return {
    {
        "chiendo97/chatml.nvim",
        branch = "cle/mcp",
        opts = {},
        dependencies = {
            {
                -- (Optional) It is required for sending requests to LLM providers
                "S1M0N38/ai.nvim",
                version = ">=1.4.2",
                opts = {
                    -- (Required) Configure a provider. :help ai-setup or
                    -- https://github.com/S1M0N38/ai.nvim/blob/main/doc/ai.txt
                    base_url = "https://api.openai.com/v1",
                    api_key = vim.fn.getenv("OPENAI_API_KEY"),
                    copilot = false,
                },
            },
        },
    },
}
