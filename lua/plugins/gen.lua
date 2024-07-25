local gen = require("gen")

gen.setup({
    model = "gpt-4o-mini", -- The default model to use.
    host = "api.openai.com", -- The host running the Ollama service.
    port = "443", -- The port on which the Ollama service is listening.
    quit_map = "q", -- set keymap for close the response window
    retry_map = "<c-r>", -- set keymap to re-send the current prompt
    command = function(options)
        local body = { model = options.model, stream = true }
        return "curl"
            .. " --silent"
            .. " --no-buffer"
            .. " -H 'Content-Type: application/json'"
            .. ' -H "Authorization: Bearer $OPENAI_API_KEY"'
            .. " https://api.openai.com/v1/chat/completions"
            .. " -d $body"
    end,
    display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split".
    show_prompt = false, -- Shows the prompt submitted to Ollama.
    show_model = true, -- Displays which model you are using at the beginning of your chat session.
    no_auto_close = false, -- Never closes the window automatically.
    debug = false, -- Prints errors and the command which is run.
})

gen.prompts["Elaborate_Text"] = {
    prompt = "Elaborate the following text:\n$text",
}

gen.prompts["Implement_Code"] = {
    prompt = "$input. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
}

gen.prompts["Docstring"] = {
    prompt = "Generate short and concise docstring for this code ```$filetype\n$text\n```."
        .. "Only output the code with docstring in format ```$filetype\n...\n```",
    replace = true,
    extract = "```$filetype\n(.-)```",
}

gen.prompts["Refactor_Code"] = {
    prompt = "$input. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
    replace = true,
    extract = "```$filetype\n(.-)```",
}
gen.prompts["Improve_Text"] = {
    prompt = "Modify the following text as this request: %input, just output the final text without additional quotes around it:\n$text",
    replace = true,
}
