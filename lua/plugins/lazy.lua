local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- add packages
    {
        "tweekmonster/startuptime.vim",
        cmd = "StartupTime",
    },

    -- nvim-tree
    {
        "kyazdani42/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "NvimTreeToggle",
        init = function()
            vim.keymap.set("n", "<leader>c", "<cmd>NvimTreeToggle<cr>", { noremap = true })
        end,
        config = function()
            require("plugins.nvim-tree")
        end,
    },

    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lsp")
        end,
    },

    -- lsp autocomplete
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- lsp source
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-path",
            {
                "zbirenbaum/copilot-cmp",
                config = function()
                    require("copilot_cmp").setup()
                end,
                cond = function()
                    return os.getenv("OPENAI_API_KEY") ~= nil and vim.fn.executable("node") == 1
                end,
            },
        },
        config = function()
            require("plugins.nvim-cmp")
        end,
    },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },

    -- linter, formater
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim",
        },
        config = function()
            require("lsp.null-ls")
        end,
    },

    -- note manager
    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        ft = { "org" },
        config = function()
            require("plugins.orgmode")
        end,
    },

    -- treesitter syntax
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function()
            require("plugins.treesitter")
        end,
    },

    -- Comment code
    {
        "numToStr/Comment.nvim",
        config = function()
            require("plugins.Comment")
        end,
    },

    -- align text with ga=
    {
        "junegunn/vim-easy-align",
        config = function()
            -- Start interactive EasyAlign in visual mode (e.g. vipga)
            vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {})
            -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
            vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
        end,
    },

    -- Add git related info in the signs columns and popups
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.gitsigns")
        end,
        cond = function()
            return vim.fn.isdirectory(".git") == 1
        end,
    },

    -- vim-tmux-navigation
    {
        "alexghergh/nvim-tmux-navigation",
        config = function()
            local nvim_tmux_nav = require("nvim-tmux-navigation")

            nvim_tmux_nav.setup({
                disable_when_zoomed = true, -- defaults to false
            })

            vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
            vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
            vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
            vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
        end,
    },

    {
        "ellisonleao/gruvbox.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- setup must be called before loading the colorscheme
            -- Default options:
            require("gruvbox").setup({
                undercurl = true,
                underline = true,
                bold = true,
                italic = {
                    strings = true,
                    comments = true,
                    operators = false,
                    folds = true,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true, -- invert background for search, diffs, statuslines and errors
                contrast = "", -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
            vim.cmd("colorscheme gruvbox")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        -- cmd = "Telescope",
        init = function()
            require("plugins.telescope_map")
        end,
        config = function()
            require("plugins.telescope")
        end,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            { "nvim-telescope/telescope-ui-select.nvim" },
        },
    },

    -- better quickfix
    {
        "kevinhwang91/nvim-bqf",
        config = function()
            require("plugins.nvim-bqf")
        end,
        ft = "qf",
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("plugins.indent-blankline")
        end,
    },

    {
        "chrisbra/csv.vim",
        ft = "csv",
    },
    {
        "zbirenbaum/copilot.lua",
        cond = function()
            return os.getenv("OPENAI_API_KEY") ~= nil and vim.fn.executable("node") == 1
        end,
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = false,
                    auto_refresh = true,
                },
                suggestion = {
                    enabled = false,
                    -- use the built-in keymapping for "accept" (<M-l>)
                    auto_trigger = true,
                    accept = false, -- disable built-in keymapping
                },
            })

            -- hide copilot suggestions when cmp menu is open
            -- to prevent odd behavior/garbled up suggestions
            local cmp_status_ok, cmp = pcall(require, "cmp")
            if cmp_status_ok then
                cmp.event:on("menu_opened", function()
                    vim.b.copilot_suggestion_hidden = true
                end)

                cmp.event:on("menu_closed", function()
                    vim.b.copilot_suggestion_hidden = false
                end)
            end
        end,
    },
    {
        "stevearc/oil.nvim",
        cmd = "Oil",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "garymjr/nvim-snippets",
        opts = {
            create_cmp_source = true,
            friendly_snippets = true,
        },
        dependencies = {
            "rafamadriz/friendly-snippets",
            "hrsh7th/nvim-cmp",
        },
    },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    {
        "robitx/gp.nvim",
        config = function()
            -- Gp (GPT prompt) lua plugin for Neovim
            -- https://github.com/Robitx/gp.nvim/

            --------------------------------------------------------------------------------
            -- Default config
            --------------------------------------------------------------------------------

            -- README_REFERENCE_MARKER_START
            local config = {
                -- Please start with minimal config possible.
                -- Just openai_api_key if you don't have OPENAI_API_KEY env set up.
                -- Defaults change over time to improve things, options might get deprecated.
                -- It's better to change only things where the default doesn't fit your needs.

                -- required openai api key (string or table with command and arguments)
                -- openai_api_key = { "cat", "path_to/openai_api_key" },
                -- openai_api_key = { "bw", "get", "password", "OPENAI_API_KEY" },
                -- openai_api_key: "sk-...",
                -- openai_api_key = os.getenv("env_name.."),
                openai_api_key = os.getenv("OPENAI_API_KEY"),

                -- at least one working provider is required
                -- to disable a provider set it to empty table like openai = {}
                providers = {
                    -- secrets can be strings or tables with command and arguments
                    -- secret = { "cat", "path_to/openai_api_key" },
                    -- secret = { "bw", "get", "password", "OPENAI_API_KEY" },
                    -- secret : "sk-...",
                    -- secret = os.getenv("env_name.."),
                    openai = {
                        disable = false,
                        endpoint = "https://api.openai.com/v1/chat/completions",
                        -- secret = os.getenv("OPENAI_API_KEY"),
                    },
                },

                -- prefix for all commands
                cmd_prefix = "Gp",
                -- optional curl parameters (for proxy, etc.)
                -- curl_params = { "--proxy", "http://X.X.X.X:XXXX" }
                curl_params = {},

                -- log file location
                -- log_file = vim.fn.stdpath("log"):gsub("/$", "") .. "/gp.nvim.log",

                -- directory for persisting state dynamically changed by user (like model or persona)
                -- state_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/gp/persisted",

                -- default command agents (model + persona)
                -- name, model and system_prompt are mandatory fields
                -- to use agent for chat set chat = true, for command set command = true
                -- to remove some default agent completely set it like:
                -- agents = {  { name = "ChatGPT3-5", disable = true, }, ... },
                agents = {
                    {
                        provider = "openai",
                        name = "ChatGPT4o",
                        chat = true,
                        command = false,
                        -- string with model name or table with model name and parameters
                        model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
                        -- system prompt (use this to specify the persona/role of the AI)
                        system_prompt = require("gp.defaults").chat_system_prompt,
                    },
                    {
                        provider = "openai",
                        name = "ChatGPT4o-mini",
                        chat = true,
                        command = false,
                        -- string with model name or table with model name and parameters
                        model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
                        -- system prompt (use this to specify the persona/role of the AI)
                        system_prompt = require("gp.defaults").chat_system_prompt,
                    },
                    {
                        provider = "openai",
                        name = "CodeGPT4o",
                        chat = false,
                        command = true,
                        -- string with model name or table with model name and parameters
                        model = { model = "gpt-4o", temperature = 0.8, top_p = 1 },
                        -- system prompt (use this to specify the persona/role of the AI)
                        system_prompt = require("gp.defaults").code_system_prompt,
                    },
                    {
                        provider = "openai",
                        name = "CodeGPT4o-mini",
                        chat = false,
                        command = true,
                        -- string with model name or table with model name and parameters
                        model = { model = "gpt-4o-mini", temperature = 0.7, top_p = 1 },
                        -- system prompt (use this to specify the persona/role of the AI)
                        system_prompt = require("gp.defaults").code_system_prompt,
                    },
                },

                -- directory for storing chat files
                -- chat_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/gp/chats",
                -- chat user prompt prefix
                -- chat_user_prefix = "💬:",
                -- chat assistant prompt prefix (static string or a table {static, template})
                -- first string has to be static, second string can contain template {{agent}}
                -- just a static string is legacy and the [{{agent}}] element is added automatically
                -- if you really want just a static string, make it a table with one element { "🤖:" }
                -- chat_assistant_prefix = { "🤖:", "[{{agent}}]" },
                -- The banner shown at the top of each chat file.
                -- chat_template = require("gp.defaults").chat_template,
                -- if you want more real estate in your chat files and don't need the helper text
                -- chat_template = require("gp.defaults").short_chat_template,
                -- chat topic generation prompt
                chat_topic_gen_prompt = "Summarize the topic of our conversation above"
                    .. " in two or three words. Respond only with those words.",
                -- chat topic model (string with model name or table with model name and parameters)
                -- explicitly confirm deletion of a chat file
                chat_confirm_delete = true,
                -- conceal model parameters in chat
                chat_conceal_model_params = true,
                -- local shortcuts bound to the chat buffer
                -- (be careful to choose something which will work across specified modes)
                chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g><C-g>" },
                chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
                chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>s" },
                chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>c" },
                -- default search term when using :GpChatFinder
                chat_finder_pattern = "topic ",
                -- if true, finished ChatResponder won't move the cursor to the end of the buffer
                chat_free_cursor = true,
                -- use prompt buftype for chats (:h prompt-buffer)
                chat_prompt_buf_type = false,

                -- how to display GpChatToggle or GpContext: popup / split / vsplit / tabnew
                toggle_target = "tabnew",

                -- styling for chatfinder
                -- border can be "single", "double", "rounded", "solid", "shadow", "none"
                style_chat_finder_border = "rounded",
                -- margins are number of characters or lines
                style_chat_finder_margin_bottom = 8,
                style_chat_finder_margin_left = 1,
                style_chat_finder_margin_right = 2,
                style_chat_finder_margin_top = 2,
                -- how wide should the preview be, number between 0.0 and 1.0
                style_chat_finder_preview_ratio = 0.5,

                -- styling for popup
                -- border can be "single", "double", "rounded", "solid", "shadow", "none"
                style_popup_border = "rounded",
                -- margins are number of characters or lines
                style_popup_margin_bottom = 8,
                style_popup_margin_left = 1,
                style_popup_margin_right = 2,
                style_popup_margin_top = 2,
                style_popup_max_width = 160,

                -- command config and templates below are used by commands like GpRewrite, GpEnew, etc.
                -- command prompt prefix for asking user for input (supports {{agent}} template variable)
                command_prompt_prefix_template = "🤖 {{agent}} ~ ",
                -- auto select command response (easier chaining of commands)
                -- if false it also frees up the buffer cursor for further editing elsewhere
                command_auto_select_response = true,

                -- templates
                template_selection = "I have the following from {{filename}}:"
                    .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}",
                template_rewrite = "I have the following from {{filename}}:"
                    .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
                    .. "\n\nRespond exclusively with the snippet that should replace the selection above.",
                template_append = "I have the following from {{filename}}:"
                    .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
                    .. "\n\nRespond exclusively with the snippet that should be appended after the selection above.",
                template_prepend = "I have the following from {{filename}}:"
                    .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
                    .. "\n\nRespond exclusively with the snippet that should be prepended before the selection above.",
                template_command = "{{command}}",

                -- example hook functions (see Extend functionality section in the README)
                hooks = {
                    InspectPlugin = function(plugin, params)
                        local bufnr = vim.api.nvim_create_buf(false, true)
                        local copy = vim.deepcopy(plugin)
                        local key = copy.config.openai_api_key or ""
                        copy.config.openai_api_key = key:sub(1, 3) .. string.rep("*", #key - 6) .. key:sub(-3)
                        for provider, _ in pairs(copy.providers) do
                            local s = copy.providers[provider].secret
                            if s and type(s) == "string" then
                                copy.providers[provider].secret = s:sub(1, 3) .. string.rep("*", #s - 6) .. s:sub(-3)
                            end
                        end
                        local plugin_info = string.format("Plugin structure:\n%s", vim.inspect(copy))
                        local params_info = string.format("Command params:\n%s", vim.inspect(params))
                        local lines = vim.split(plugin_info .. "\n" .. params_info, "\n")
                        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
                        vim.api.nvim_win_set_buf(0, bufnr)
                    end,

                    -- Improvement improve wording and fix grammar for the provided selection/range
                    Improvement = function(gp, params)
                        local template = "Having following from {{filename}}:\n\n"
                            .. "```{{filetype}}\n{{selection}}\n```\n\n"
                            .. "Please help to improve wording and fix grammar errors."

                        local agent = gp.get_command_agent()
                        gp.logger.info("Implementing selection with agent: " .. agent.name)

                        gp.Prompt(
                            params,
                            gp.Target.rewrite,
                            agent,
                            template,
                            nil, -- command will run directly without any prompting for user input
                            nil -- no predefined instructions (e.g. speech-to-text from Whisper)
                        )
                    end,

                    -- Consise make the provided selection/range concise
                    Consise = function(gp, params)
                        local template = "Having following from nvim/lua/plugins/lazy.lua:\n\n"
                            .. "```{{filetype}}\n{{selection}}\n```\n\n"
                            .. "Please help to make the provided text more concise."

                        local agent = gp.get_command_agent()
                        gp.logger.info("Implementing selection with agent: " .. agent.name)

                        gp.Prompt(
                            params,
                            gp.Target.rewrite,
                            agent,
                            template,
                            nil, -- command will run directly without any prompting for user input
                            nil -- no predefined instructions (e.g. speech-to-text from Whisper)
                        )
                    end,

                    -- GpImplement rewrites the provided selection/range based on comments in it
                    Implement = function(gp, params)
                        local template = "Having following from {{filename}}:\n\n"
                            .. "```{{filetype}}\n{{selection}}\n```\n\n"
                            .. "Please rewrite this according to the contained instructions."
                            .. "\n\nRespond exclusively with the snippet that should replace the selection above."

                        local agent = gp.get_command_agent()
                        gp.logger.info("Implementing selection with agent: " .. agent.name)

                        gp.Prompt(
                            params,
                            gp.Target.rewrite,
                            agent,
                            template,
                            nil, -- command will run directly without any prompting for user input
                            nil -- no predefined instructions (e.g. speech-to-text from Whisper)
                        )
                    end,

                    -- your own functions can go here, see README for more examples like
                    -- :GpExplain, :GpUnitTests.., :GpTranslator etc.

                    -- example of making :%GpChatNew a dedicated command which
                    -- opens new chat with the entire current buffer as a context
                    BufferChatNew = function(gp, _)
                        -- call GpChatNew command in range mode on whole buffer
                        vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
                    end,

                    -- example of adding command which opens new chat dedicated for translation
                    Translator = function(gp, params)
                        local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
                        gp.cmd.ChatNew(params, chat_system_prompt)

                        -- -- you can also create a chat with a specific fixed agent like this:
                        -- local agent = gp.get_chat_agent("ChatGPT4o")
                        -- gp.cmd.ChatNew(params, chat_system_prompt, agent)
                    end,

                    -- example of adding command which writes unit tests for the selected code
                    UnitTests = function(gp, params)
                        local template = "I have the following code from {{filename}}:\n\n"
                            .. "```{{filetype}}\n{{selection}}\n```\n\n"
                            .. "Please respond by writing table driven unit tests for the code above."
                        local agent = gp.get_command_agent()
                        gp.Prompt(params, gp.Target.enew, agent, template)
                    end,

                    -- example of adding command which explains the selected code
                    Explain = function(gp, params)
                        local template = "I have the following code from {{filename}}:\n\n"
                            .. "```{{filetype}}\n{{selection}}\n```\n\n"
                            .. "Please respond by explaining the code above."
                        local agent = gp.get_chat_agent()
                        gp.Prompt(params, gp.Target.popup, agent, template)
                    end,
                },
            }
            require("gp").setup(config)
            -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
            local function keymapOptions(desc)
                return {
                    noremap = true,
                    silent = true,
                    nowait = true,
                    desc = "GPT prompt " .. desc,
                }
            end

            -- Chat commands
            vim.keymap.set({ "n", "i" }, "<C-g>c", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
            vim.keymap.set({ "n", "i" }, "<C-g>t", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
            vim.keymap.set({ "n", "i" }, "<C-g>f", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

            vim.keymap.set("v", "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
            vim.keymap.set("v", "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
            vim.keymap.set("v", "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

            vim.keymap.set({ "n", "i" }, "<C-g><C-x>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
            vim.keymap.set({ "n", "i" }, "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
            vim.keymap.set({ "n", "i" }, "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

            vim.keymap.set("v", "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
            vim.keymap.set(
                "v",
                "<C-g><C-v>",
                ":<C-u>'<,'>GpChatNew vsplit<cr>",
                keymapOptions("Visual Chat New vsplit")
            )
            vim.keymap.set(
                "v",
                "<C-g><C-t>",
                ":<C-u>'<,'>GpChatNew tabnew<cr>",
                keymapOptions("Visual Chat New tabnew")
            )

            -- Prompt commands
            vim.keymap.set({ "n", "i" }, "<C-g>r", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
            vim.keymap.set({ "n", "i" }, "<C-g>a", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
            vim.keymap.set({ "n", "i" }, "<C-g>b", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

            vim.keymap.set("v", "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
            vim.keymap.set("v", "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
            vim.keymap.set("v", "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))
            vim.keymap.set("v", "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))

            vim.keymap.set({ "n", "i" }, "<C-g>gp", "<cmd>GpPopup<cr>", keymapOptions("Popup"))
            vim.keymap.set({ "n", "i" }, "<C-g>ge", "<cmd>GpEnew<cr>", keymapOptions("GpEnew"))
            vim.keymap.set({ "n", "i" }, "<C-g>gn", "<cmd>GpNew<cr>", keymapOptions("GpNew"))
            vim.keymap.set({ "n", "i" }, "<C-g>gv", "<cmd>GpVnew<cr>", keymapOptions("GpVnew"))
            vim.keymap.set({ "n", "i" }, "<C-g>gt", "<cmd>GpTabnew<cr>", keymapOptions("GpTabnew"))

            vim.keymap.set("v", "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))
            vim.keymap.set("v", "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", keymapOptions("Visual GpEnew"))
            vim.keymap.set("v", "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", keymapOptions("Visual GpNew"))
            vim.keymap.set("v", "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions("Visual GpVnew"))
            vim.keymap.set("v", "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions("Visual GpTabnew"))

            vim.keymap.set({ "n", "i" }, "<C-g>x", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))
            vim.keymap.set("v", "<C-g>x", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

            vim.keymap.set({ "n", "i", "v", "x" }, "<C-g>s", "<cmd>GpStop<cr>", keymapOptions("Stop"))
            vim.keymap.set({ "n", "i", "v", "x" }, "<C-g>n", "<cmd>GpNextAgent<cr>", keymapOptions("Next Agent"))
        end,
    },
})
