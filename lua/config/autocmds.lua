---@diagnostic disable: param-type-mismatch

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
            and vim.bo.filetype ~= "help"
            and vim.bo.filetype ~= "snacks_picker_list"
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
        -- local copy_to_unnamedplus = require("vim.ui.clipboard.osc52").copy("+")
        -- copy_to_unnamedplus(vim.v.event.regcontents)
        -- local copy_to_unnamed = require("vim.ui.clipboard.osc52").copy("*")
        -- copy_to_unnamed(vim.v.event.regcontents)
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = my_augroup,
    callback = function()
        require("lazy").update({ show = false })
    end,
    desc = "Update lazy plugins silently on VimEnter",
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
    group = my_augroup,
    desc = "Start treesitter on FileType event",
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("clearjumps")
    end,
    group = my_augroup,
    desc = "Clear jump list on VimEnter",
})
