-- Gp (GPT prompt) lua plugin for Neovim
-- https://github.com/Robitx/gp.defaults")

local cfg = {
    providers = {
        openai = {
            endpoint = "https://api.openai.com/v1/chat/completions",
            secret = os.getenv("OPENAI_API_KEY"),
        },
        ollama = {
            disable = true,
            endpoint = "http://100.72.233.13:11434/v1/chat/completions",
        },
        anthropic = {
            endpoint = "https://api.anthropic.com/v1/messages",
            secret = os.getenv("ANTHROPIC_API_KEY"),
        },
    },
    agents = {
        {
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
            system_prompt = "Please return ONLY code snippets.\nSTART AND END YOUR ANSWER WITH:\n\n```",
        },
        {
            provider = "anthropic",
            name = "CodeClaude-3-5-Sonnet",
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "claude-3-5-sonnet-20240620", temperature = 0.8, top_p = 1 },
            system_prompt = require("gp.defaults").code_system_prompt,
        },
        {
            disable = true,
            name = "CodeClaude-3-Haiku",
        },
        {
            disable = true,
            name = "ChatClaude-3-Haiku",
        },
    },
    toggle_target = "tabnew",
    style_chat_finder_border = "rounded",
    -- write sensitive data to log file for	debugging purposes (like api keys)
    log_sensitive = false,
    -- if true, finished ChatResponder won't move the cursor to the end of the buffer
    chat_free_cursor = true,
    hooks = {
        Concise = function(gp, params)
            local template = "Having following from {{filename}}:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Please help to make the provided text more concise."

            local agent = gp.get_command_agent()
            gp.logger.info("Implementing selection with agent: " .. agent.name)

            gp.Prompt(params, gp.Target.rewrite, agent, template, nil, nil)
        end,
        Proofread = function(gp, params)
            local template = "Having following from {{filename}}:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Please help to proofread the provided text."

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
        Explain = function(gp, params)
            local template = "I have the following text from {{filename}}:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Please respond by explaining the code above."
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.popup, agent, template)
        end,
        Summarize = function(gp, params)
            local template = "Please summarize the following text from {{filename}}:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Provide a brief summary of the code above."
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.popup, agent, template)
        end,
        MakeList = function(gp, params)
            local template = "Please create a list of key components from the following text in {{filename}}:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Generate a list of important elements in the code above."
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.popup, agent, template)
        end,
        MakeKeyPoint = function(gp, params)
            local template = "Please highlight the key points of the following text from {{filename}}:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Identify the main points of interest in the code above."
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

require("gp.defaults").code_system_prompt = "You are an advanced AI code editor designed to assist with programming tasks.\n\n"
    .. "Provide clear and concise code snippets without any additional commentary or explanation.\n"
    .. "Begin and end each response with:\n\n```"

require("gp").setup(cfg)
