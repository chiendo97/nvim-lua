-- Gp (GPT prompt) lua plugin for Neovim
-- https://github.com/Robitx/gp.nvim/

--------------------------------------------------------------------------------
-- Default config
--------------------------------------------------------------------------------
---@alias ModelProvider "openai" | "ollama" | "anthropic"

---@class AgentModel
---@field model string
---@field temperature number
---@field top_p number

---@class Agent
---@field provider ModelProvider
---@field name string
---@field chat boolean
---@field command boolean
---@field model AgentModel
---@field system_prompt string

---Create a new agent configuration
---@param provider ModelProvider
---@param name string
---@param chat boolean
---@param command boolean
---@param model_name string
---@param temperature number
---@param system_prompt string
---@return Agent
local function create_agent(provider, name, chat, command, model_name, temperature, system_prompt)
    return {
        provider = provider,
        name = name,
        chat = chat,
        command = command,
        model = {
            model = model_name,
            temperature = temperature,
            top_p = 1,
        },
        system_prompt = system_prompt,
    }
end

local default_prompts = require("gp.defaults")

local model_configs = {
    {
        provider = "openai",
        models = {
            { name = "gpt-4o" },
            { name = "gpt-4o-mini" },
            { name = "o1-mini" },
            { name = "o1-preview" },
        },
    },
    {
        provider = "ollama",
        models = {
            {
                name = "llama3.1:latest",
                extra_params = { num_ctx = 8192 },
            },
        },
    },
    {
        provider = "anthropic",
        models = {
            { name = "claude-3-5-sonnet-20240620" },
            { name = "claude-3-haiku-20240307" },
        },
    },
}

local agents = {}

for _, config in ipairs(model_configs) do
    for _, model in ipairs(config.models) do
        local base_name = model.name:match("([^:]+)"):gsub("%-", "")

        -- Chat agent
        local chat_agent = create_agent(
            config.provider,
            "Chat" .. config.provider:gsub("^%l", string.upper) .. base_name,
            true, -- chat
            false, -- command
            model.name,
            0.8, -- Fixed temperature for chat agents
            default_prompts.chat_system_prompt
        )

        -- Code agent
        local code_agent = create_agent(
            config.provider,
            "Code" .. config.provider:gsub("^%l", string.upper) .. base_name,
            false, -- chat
            true, -- command
            model.name,
            0.5, -- Fixed temperature for code agents
            default_prompts.code_system_prompt
        )

        -- Add extra parameters if they exist
        if model.extra_params then
            for k, v in pairs(model.extra_params) do
                chat_agent.model[k] = v
                code_agent.model[k] = v
            end
        end

        table.insert(agents, chat_agent)
        table.insert(agents, code_agent)
    end
end

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
    agents = agents,
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

default_prompts.code_system_prompt = "You are an advanced AI code editor designed to assist with programming tasks.\n\n"
    .. "Provide clear and concise code snippets without any additional commentary or explanation.\n"
    .. "Begin and end each response with:\n\n```"

require("gp").setup(cfg)
