-- Leader key as space
vim.g.mapleader = " "

-- Backspace to switch to the most recent file
vim.api.keymap("n", "<bs>", "<c-^>", { noremap = true, desc = "Switch to recent file" })

-- Alt + jk to move line up/down
vim.api.keymap("n", "<A-j>", ":m .+1<cr>==", { noremap = true, silent = true, desc = "Move line down" })
vim.api.keymap("n", "<A-k>", ":m .-2<cr>==", { noremap = true, silent = true, desc = "Move line up" })
vim.api.keymap(
    "i",
    "<A-j>",
    "<Esc>:m .+1<cr>==gi",
    { noremap = true, silent = true, desc = "Move line down (insert mode)" }
)
vim.api.keymap(
    "i",
    "<A-k>",
    "<Esc>:m .-2<cr>==gi",
    { noremap = true, silent = true, desc = "Move line up (insert mode)" }
)
vim.api.keymap("x", "<A-j>", ":m '>+1<cr>gv=gv", { noremap = true, silent = true, desc = "Move block down" })
vim.api.keymap("x", "<A-k>", ":m '<-2<cr>gv=gv", { noremap = true, silent = true, desc = "Move block up" })

-- ^ - jump to the first non-blank character of the line
vim.api.keymap("n", "H", "g^", { noremap = true, desc = "Jump to first non-blank" })
vim.api.keymap("x", "H", "g^", { noremap = true, desc = "Jump to first non-blank" })

-- g_ - jump to the end of the line
vim.api.keymap("n", "L", "g$", { noremap = true, desc = "Jump to end of line" })
vim.api.keymap("x", "L", "g_", { noremap = true, desc = "Jump to end of line" })

-- Ctrl + c to turn off highlight and close quickfix windows and escape
vim.api.keymap("n", "<C-C>", ":noh<cr>:ccl<cr><esc>", { noremap = true, silent = true })
vim.api.keymap("n", "<esc>", ":noh<cr>:ccl<cr><esc>", { noremap = true, silent = true })

-- * to highlight current word
vim.api.keymap(
    "n",
    "*",
    [[:let @/ = '\<'.expand('<cword>').'\>' | set hlsearch <cr>]],
    { silent = true, desc = "Highlight current word" }
)

-- To highlight currently selected word
vim.api.keymap("x", [[//]], [[y/\V<C-R>=escape(@",'/\')<cr><cr>]], { noremap = true, desc = "Highlight selected word" })

-- Navigate between tabs
vim.api.keymap("n", "gt", ":tabedit<cr>", { noremap = true, silent = true, desc = "Open new tab" })
vim.api.keymap("n", "gn", "<cmd>tabnext<cr>", { noremap = true, silent = true, desc = "Next tab" })
vim.api.keymap("n", "gp", "<cmd>tabprev<cr>", { noremap = true, silent = true, desc = "Previous tab" })
vim.api.keymap("n", "g1", "1gt", { noremap = true, silent = true, desc = "Go to tab 1" })
vim.api.keymap("n", "g2", "2gt", { noremap = true, silent = true, desc = "Go to tab 2" })
vim.api.keymap("n", "g3", "3gt", { noremap = true, silent = true, desc = "Go to tab 3" })
vim.api.keymap("n", "g4", "4gt", { noremap = true, silent = true, desc = "Go to tab 4" })
vim.api.keymap("n", "g5", "5gt", { noremap = true, silent = true, desc = "Go to tab 5" })
vim.api.keymap("n", "g6", "6gt", { noremap = true, silent = true, desc = "Go to tab 6" })
vim.api.keymap("n", "g7", "7gt", { noremap = true, silent = true, desc = "Go to tab 7" })
vim.api.keymap("n", "g8", "8gt", { noremap = true, silent = true, desc = "Go to tab 8" })
vim.api.keymap("n", "g9", "9gt", { noremap = true, silent = true, desc = "Go to tab 9" })

-- Move up/down without breaking column
vim.api.keymap("n", "j", "gj", { noremap = true, silent = true, desc = "Down with line wraps" })
vim.api.keymap("n", "k", "gk", { noremap = true, silent = true, desc = "Up with line wraps" })
vim.api.keymap("x", "j", "gj", { noremap = true, silent = true, desc = "Down with line wraps" })
vim.api.keymap("x", "k", "gk", { noremap = true, silent = true, desc = "Up with line wraps" })

-- Copy to system's clipboard
vim.api.keymap("x", "y", '"*y', { noremap = true, desc = "Yank to clipboard" })
vim.api.keymap({ "x", "n" }, "p", '"+p', { noremap = true, desc = "Paste from last Yank" })
vim.api.keymap("n", "yy", '"*yy', { noremap = true, desc = "Yank line to clipboard" })

-- Copy current relative path
vim.api.keymap("n", "<leader>yp", ':let @* = expand("%:~:.")<cr>', { noremap = true, desc = "Yank relative path" })

-- Copy current absolute path
vim.api.keymap("n", "<leader>yP", ':let @* = expand("%:p")<cr>', { noremap = true, desc = "Yank absolute path" })

-- Copy last pasted
vim.api.keymap("n", "gV", "`[v`]", { noremap = true, desc = "Select last pasted region" })

-- Terminal mode escape
vim.api.keymap("t", "<esc>", "<C-\\><C-n>", { noremap = true, desc = "Escape terminal mode" })

-- Toggle line wrapping
vim.api.keymap("n", "<leader>W", ":set wrap!<CR>", { noremap = true, silent = true, desc = "Toggle wrap" })

-- Resize window commands
vim.api.keymap("n", "=", "<cmd>vertical resize +5<CR>", { noremap = true, desc = "Increase vertical size" })
vim.api.keymap("n", "-", "<cmd>vertical resize -5<CR>", { noremap = true, desc = "Decrease vertical size" })
vim.api.keymap("n", "+", "<cmd>horizontal resize +2<CR>", { noremap = true, desc = "Increase horizontal size" })
vim.api.keymap("n", "_", "<cmd>horizontal resize -2<CR>", { noremap = true, desc = "Decrease horizontal size" })

-- Run lua code in normal mode
vim.keymap.set("n", "<leader><space>x", "<cmd>source %<CR>", { noremap = true, desc = "Source current file" })
vim.keymap.set("n", "<leader>x", ":.lua<CR>", { noremap = true, desc = "Execute current line as Lua" })
vim.keymap.set("v", "<leader>x", ":lua<CR>", { noremap = true, desc = "Execute selected text as Lua" })
