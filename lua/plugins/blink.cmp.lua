return {
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = {
            {
                "rafamadriz/friendly-snippets",
                {
                    "giuxtaposition/blink-cmp-copilot",
                    enabled = vim.fn.executable("node") == 1,
                    lazy = true,
                    dependencies = {
                        "zbirenbaum/copilot.lua",
                        lazy = true,
                        cmd = "Copilot",
                        build = ":Copilot auth",
                        config = function()
                            require("copilot").setup({
                                panel = {
                                    enabled = false,
                                },
                                suggestion = {
                                    enabled = false,
                                },
                                filetypes = {
                                    yaml = true,
                                    markdown = true,
                                    help = true,
                                    gitcommit = true,
                                    svn = false,
                                    cvs = false,
                                    ["."] = false,
                                },
                            })
                        end,
                    },
                },
            },
        },

        -- use a release tag to download pre-built binaries
        version = "*",
        -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- If you use nix, you can build from source using latest nightly rust with:
        -- build = 'nix run .#build-plugin',

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                ["<CR>"] = { "select_and_accept", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-e>"] = { "hide", "fallback" },
                ["<C-_>"] = { "cancel", "fallback" },
                ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<Tab>"] = { "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
            },
            cmdline = {
                enabled = true,
                completion = {
                    menu = { auto_show = true },
                    ghost_text = { enabled = false },
                },
                keymap = {
                    ["<Tab>"] = { "show", "accept" },
                    ["<S-Tab>"] = { "show_and_insert", "select_prev" },

                    ["<C-n>"] = { "select_next", "fallback" },
                    ["<C-p>"] = { "select_prev", "fallback" },

                    ["<C-y>"] = { "select_and_accept" },
                    ["<C-e>"] = { "cancel" },
                },
            },
            completion = {
                list = {
                    selection = {
                        -- When `true`, will automatically select the first item in the completion list
                        preselect = false,
                        -- preselect = function(ctx) return ctx.mode ~= 'cmdline' end,

                        -- When `true`, inserts the completion item automatically when selecting it
                        -- You may want to bind a key to the `cancel` command (default <C-e>) when using this option,
                        -- which will both undo the selection and hide the completion menu
                        auto_insert = true,
                        -- auto_insert = function(ctx) return ctx.mode ~= 'cmdline' end
                    },
                },
                accept = {
                    auto_brackets = {
                        enabled = false,
                        semantic_token_resolution = { enabled = false },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    treesitter_highlighting = true,
                },
                ghost_text = {
                    enabled = true,
                    show_with_menu = true,
                    show_without_selection = true,
                },
            },
            sources = {
                providers = {
                    copilot = vim.fn.executable("node") == 1 and {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                    } or {},
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                },
                default = function()
                    local default = { "lsp", "path", "snippets", "buffer" }
                    table.insert(default, "lazydev")

                    if vim.fn.executable("node") == 1 then
                        table.insert(default, "copilot")
                    end

                    return default
                end,
            },
            appearance = {
                use_nvim_cmp_as_default = false,
                nerd_font_variant = "mono",
            },
            signature = {
                enabled = true,
            },
        },
    },
}
