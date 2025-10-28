local is_node_available = vim.fn.executable("node") == 1

return {
    {
        "saghen/blink.cmp",
        -- optional: provides snippets for the snippet source
        dependencies = { "rafamadriz/friendly-snippets", "fang2hou/blink-copilot" },

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
                menu = {
                    auto_show = true,
                    draw = {
                        columns = { { "label", "label_description", gap = 1 }, { "kind" } },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                    treesitter_highlighting = true,
                },
                ghost_text = {
                    enabled = true,
                    show_with_menu = false,
                    show_without_selection = false,
                },
            },
            sources = {
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                    },
                    path = {
                        opts = {
                            get_cwd = function()
                                return vim.fn.getcwd()
                            end,
                        },
                    },
                },
                default = function()
                    local default_sources = { "lsp", "path", "snippets", "buffer", "lazydev" }

                    if is_node_available then
                        table.insert(default_sources, "copilot")
                    end

                    return default_sources
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
