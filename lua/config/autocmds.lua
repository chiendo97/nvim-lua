local my_augroup = vim.api.nvim_create_augroup("MyAutoCmds", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = my_augroup,
    pattern = "qf",
    callback = function()
        vim.api.nvim_cmd({ cmd = "wincmd", args = { "J" } }, {})
    end,
    desc = "Move quickfix window to the bottom",
})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = my_augroup,
    pattern = "*",
    callback = function()
        local line = vim.fn.line("'\"")
        if
            line > 1
            and line <= vim.fn.line("$")
            and vim.bo.filetype ~= "commit"
            and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
        then
            vim.cmd('normal! g`"')
        end
    end,
    desc = "Jump to the last edited line in the buffer",
})
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    group = my_augroup,
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.highlight.on_yank()
    end,
})
