-- Gp (GPT prompt) lua plugin for Neovim
-- https://github.com/Robitx/gp.nvim/

--------------------------------------------------------------------------------
-- Default config
--------------------------------------------------------------------------------

-- README_REFERENCE_MARKER_START
local cfg = {
    providers = {
        openai = {
            endpoint = "https://api.openai.com/v1/chat/completions",
            secret = os.getenv("OPENAI_API_KEY"),
        },
        ollama = {
            endpoint = "http://100.72.233.13:11434/v1/chat/completions",
        },
        anthropic = {
            endpoint = "https://api.anthropic.com/v1/messages",
            secret = os.getenv("ANTHROPIC_API_KEY"),
        },
    },
    agents = {
        {
            provider = "openai",
            name = "ChatGPT4o",
            chat = true,
            command = false,
            model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
            system_prompt = require("gp.defaults").chat_system_prompt,
        },
        {
            provider = "openai",
            name = "ChatGPT4o-mini",
            chat = true,
            command = false,
            model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
            system_prompt = require("gp.defaults").chat_system_prompt,
        },
        {
            provider = "openai",
            name = "CodeGPT4o",
            chat = false,
            command = true,
            model = { model = "gpt-4o", temperature = 0.8, top_p = 1 },
            system_prompt = require("gp.defaults").code_system_prompt,
        },
        {
            provider = "openai",
            name = "CodeGPT4o-mini",
            chat = false,
            command = true,
            model = { model = "gpt-4o-mini", temperature = 0.7, top_p = 1 },
            system_prompt = require("gp.defaults").code_system_prompt,
        },
        {
            provider = "ollama",
            name = "ChatOllamaLlama3",
            chat = true,
            command = false,
            model = {
                model = "llama3.1:latest",
                temperature = 0,
                top_p = 1,
                num_ctx = 8192,
            },
            system_prompt = require("gp.defaults").chat_system_prompt,
        },
        {
            provider = "ollama",
            name = "CodeOllamaLlama3",
            chat = false,
            command = true,
            model = {
                model = "llama3.1:latest",
                temperature = 0,
                top_p = 1,
                num_ctx = 8192,
            },
            system_prompt = require("gp.defaults").code_system_prompt,
        },
        {
            provider = "anthropic",
            name = "ChatClaude-3-5-Sonnet",
            chat = true,
            command = false,
            model = { model = "claude-3-5-sonnet-20240620", temperature = 0.8, top_p = 1 },
            system_prompt = require("gp.defaults").chat_system_prompt,
        },
        {
            provider = "anthropic",
            name = "ChatClaude-3-Haiku",
            chat = true,
            command = false,
            model = { model = "claude-3-haiku-20240307", temperature = 0.8, top_p = 1 },
            system_prompt = require("gp.defaults").chat_system_prompt,
        },
        {
            provider = "anthropic",
            name = "CodeClaude-3-5-Sonnet",
            chat = false,
            command = true,
            model = { model = "claude-3-5-sonnet-20240620", temperature = 0.8, top_p = 1 },
            system_prompt = require("gp.defaults").code_system_prompt,
        },
        {
            provider = "anthropic",
            name = "CodeClaude-3-Haiku",
            chat = false,
            command = true,
            model = { model = "claude-3-haiku-20240307", temperature = 0.8, top_p = 1 },
            system_prompt = require("gp.defaults").code_system_prompt,
        },
    },
    toggle_target = "tabnew",
    style_chat_finder_border = "rounded",
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
        Improvement = function(gp, params)
            local template = "Having following from {{filename}}:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Please help to improve wording and fix grammar errors."

            local agent = gp.get_command_agent()
            gp.logger.info("Implementing selection with agent: " .. agent.name)

            gp.Prompt(params, gp.Target.rewrite, agent, template, nil, nil)
        end,
        Consise = function(gp, params)
            local template = "Having following from nvim/lua/plugins/lazy.lua:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Please help to make the provided text more concise."

            local agent = gp.get_command_agent()
            gp.logger.info("Implementing selection with agent: " .. agent.name)

            gp.Prompt(params, gp.Target.rewrite, agent, template, nil, nil)
        end,
        Implement = function(gp, params)
            local template = "Having following from {{filename}}:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Please rewrite this according to the contained instructions."
                .. "\n\nRespond exclusively with the snippet that should replace the selection above."

            local agent = gp.get_command_agent()
            gp.logger.info("Implementing selection with agent: " .. agent.name)

            gp.Prompt(params, gp.Target.rewrite, agent, template, nil, nil)
        end,
        BufferChatNew = function(gp, _)
            vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
        end,
        Translator = function(gp, params)
            local chat_system_prompt = "You are a Translator, please translate between English and Vietnamese."
            gp.cmd.ChatNew(params, chat_system_prompt)
        end,
        UnitTests = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Please respond by writing table driven unit tests for the code above."
            local agent = gp.get_command_agent()
            gp.Prompt(params, gp.Target.enew, agent, template)
        end,
        Explain = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Please respond by explaining the code above."
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.popup, agent, template)
        end,
    },
    whisper = {
        disable = true,
    },
    image = {
        disable = true,
    },
}

require("gp").setup(cfg)
