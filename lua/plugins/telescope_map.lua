local M = {}
local map = vim.api.nvim_set_keymap
local map_options = { noremap = true, silent = true }

M.load_telescope = function()
    if not pcall(require, "telescope.nvim") then
        require("packer").loader("plenary.nvim")
        require("packer").loader("popup.nvim")
        require("packer").loader("telescope-fzy-native.nvim")
        require("packer").loader("telescope.nvim")
    end
end

M.grep_cword = function()
    M.load_telescope()
    require("telescope.builtin").grep_string({
        previewer = false,
        search = vim.fn.expand("<cword>"),
    })
end

M.grep_visual = function()
    local _, csrow, cscol, cerow, cecol
    local mode = vim.fn.mode()
    if mode == "v" or mode == "V" or mode == "" then
        -- if we are in visual mode use the live position
        _, csrow, cscol, _ = unpack(vim.fn.getpos("."))
        _, cerow, cecol, _ = unpack(vim.fn.getpos("v"))
        if mode == "V" then
            -- visual line doesn't provide columns
            cscol, cecol = 0, 999
        end
        -- exit visual mode
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
    else
        -- otherwise, use the last known visual position
        _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
        _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
    end
    -- swap vars if needed
    if cerow < csrow then
        csrow, cerow = cerow, csrow
    end
    if cecol < cscol then
        cscol, cecol = cecol, cscol
    end
    local lines = vim.fn.getline(csrow, cerow)
    local n = #lines
    if n <= 0 then
        return ""
    end
    lines[n] = string.sub(lines[n], 1, cecol)
    lines[1] = string.sub(lines[1], cscol)

    dump(csrow, cscol, cerow, cecol, lines)

    M.load_telescope()
    require("telescope.builtin").grep_string({
        previewer = false,
        search = table.concat(lines, "\n"),
    })
end

map("n", "<leader>g", [[<cmd>Telescope find_files previewer=false<cr>]], map_options)
map("n", "<leader>r", [[<cmd>Telescope live_grep previewer=false<cr>]], map_options)
map("n", "<leader>h", [[<cmd>Telescope help_tags previewer=false<cr>]], map_options)
map("n", "<leader>j", [[<cmd>Telescope oldfiles previewer=false<cr>]], map_options)
map("n", "<leader>m", [[<cmd>Telescope keymaps previewer=false<cr>]], map_options)
map("n", "<leader>b", [[<cmd>Telescope builtin previewer=false<cr>]], map_options)

map("v", "<leader>r", [[<cmd>lua require('plugins.telescope_map').grep_visual()<cr>]], map_options)
map("n", "<leader>R", [[<cmd>lua require('plugins.telescope_map').grep_cword()<cr>]], map_options)

return M
