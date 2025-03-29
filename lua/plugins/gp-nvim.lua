-- Gp (GPT prompt) lua plugin for Neovim
-- https://github.com/Robitx/gp.defaults")

---@alias AgentType "chat" | "command"

---@class AgentSpec
---@field provider string
---@field model string

---@class Agent
---@field provider string
---@field name string
---@field chat boolean
---@field command boolean
---@field model string
---@field system_prompt string

-- Define global system prompts
local chat_system_prompt = require("gp.defaults").chat_system_prompt
local code_system_prompt = require("gp.defaults").code_system_prompt

---@param spec AgentSpec
---@param agent_type AgentType
---@return Agent
local function create_agent(spec, agent_type)
    local name_prefix = agent_type == "chat" and "Chat" or "Code"
    local model_name = table.concat({ unpack(vim.split(spec.model, "-", { plain = true }), 1, 3) })
    local name = name_prefix .. model_name:gsub("^%l", string.upper)

    return {
        provider = spec.provider,
        name = name,
        chat = agent_type == "chat",
        command = agent_type == "command",
        model = { model = spec.model },
        system_prompt = agent_type == "chat" and chat_system_prompt or code_system_prompt,
    }
end

---@type AgentSpec[]
local agent_specs = {
    {
        provider = "openai",
        model = "gpt-4o",
    },
    {
        provider = "openai",
        model = "gpt-4o-mini",
    },
    {
        provider = "openai",
        model = "o3-mini",
    },
    {
        provider = "anthropic",
        model = "claude-3-7-sonnet-20250219",
    },
}

---@type Agent[]
local agents = {}

for _, spec in ipairs(agent_specs) do
    table.insert(agents, create_agent(spec, "chat"))
    table.insert(agents, create_agent(spec, "command"))
end

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
    agents = agents,
    toggle_target = "tabnew",
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

require("gp.config").agents = {}

require("gp").setup(cfg)
