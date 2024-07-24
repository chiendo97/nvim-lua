local vim = vim
local api = vim.api

api.nvim_create_augroup("back_to_line", { clear = true })
api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line('"') > 0 and vim.fn.line('"') <= vim.fn.line("$") then
            vim.cmd('normal! g"`')
        end
    end,
    group = "back_to_line",
})

api.nvim_create_augroup("quickfix_below", { clear = true })
api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.api.nvim_cmd({ cmd = "wincmd", args = { "J" } }, {})
    end,
    group = "quickfix_below",
})
