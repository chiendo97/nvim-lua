return {
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        enabled = false,
        opts = {
            terminal_cmd = "~/.claude/local/claude --dangerously-skip-permissions", -- Point to local installation
            terminal = {
                split_side = "right", -- "left" or "right"
                split_width_percentage = 0.40,
                provider = "auto", -- "auto", "snacks", "native", "external", or custom provider table
                auto_close = true,
                provider_opts = {
                    external_terminal_cmd = "tmux split-window -h %s", -- Command template for external terminal provider (e.g., "alacritty -e %s")
                },
            },
        },
        config = true,
        keys = {
            -- { "<leader>c", nil, desc = "AI/Claude Code" },
            { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
            { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
            { "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
            { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
            { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
            { "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
            {
                "<leader>cs",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
            },
            -- Diff management
            { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
        },
    },
}
