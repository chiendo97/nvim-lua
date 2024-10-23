local map = vim.keymap.set

-- Leader key as space
vim.g.mapleader = " "

-- Backspace to switch to the most recent file
map("n", "<bs>", "<c-^>", { noremap = true, desc = "Switch to recent file" })

-- Alt + jk to move line up/down
map("n", "<A-j>", ":m .+1<cr>==", { noremap = true, silent = true, desc = "Move line down" })
map("n", "<A-k>", ":m .-2<cr>==", { noremap = true, silent = true, desc = "Move line up" })
map("i", "<A-j>", "<Esc>:m .+1<cr>==gi", { noremap = true, silent = true, desc = "Move line down (insert mode)" })
map("i", "<A-k>", "<Esc>:m .-2<cr>==gi", { noremap = true, silent = true, desc = "Move line up (insert mode)" })
map("x", "<A-j>", ":m '>+1<cr>gv=gv", { noremap = true, silent = true, desc = "Move block down" })
map("x", "<A-k>", ":m '<-2<cr>gv=gv", { noremap = true, silent = true, desc = "Move block up" })

-- ^ - jump to the first non-blank character of the line
map("n", "H", "g^", { noremap = true, desc = "Jump to first non-blank" })
map("x", "H", "g^", { noremap = true, desc = "Jump to first non-blank" })

-- g_ - jump to the end of the line
map("n", "L", "g$", { noremap = true, desc = "Jump to end of line" })
map("x", "L", "g_", { noremap = true, desc = "Jump to end of line" })

-- Ctrl + c to turn off highlight and close quickfix windows and escape
map("n", "<C-C>", ":noh<cr>:ccl<cr><esc>", { noremap = true, silent = true })
map("n", "<esc>", ":noh<cr>:ccl<cr><esc>", { noremap = true, silent = true })

-- * to highlight current word
map(
    "n",
    "*",
    [[:let @/ = '\<'.expand('<cword>').'\>' | set hlsearch <cr>]],
    { silent = true, desc = "Highlight current word" }
)

-- To highlight currently selected word
map("x", [[//]], [[y/\V<C-R>=escape(@",'/\')<cr><cr>]], { noremap = true, desc = "Highlight selected word" })

-- Navigate between tabs
map("n", "gt", ":tabedit<cr>", { noremap = true, silent = true, desc = "Open new tab" })
map("n", "gn", "<cmd>tabnext<cr>", { noremap = true, silent = true, desc = "Next tab" })
map("n", "gp", "<cmd>tabprev<cr>", { noremap = true, silent = true, desc = "Previous tab" })
map("n", "g1", "1gt", { noremap = true, silent = true, desc = "Go to tab 1" })
map("n", "g2", "2gt", { noremap = true, silent = true, desc = "Go to tab 2" })
map("n", "g3", "3gt", { noremap = true, silent = true, desc = "Go to tab 3" })
map("n", "g4", "4gt", { noremap = true, silent = true, desc = "Go to tab 4" })
map("n", "g5", "5gt", { noremap = true, silent = true, desc = "Go to tab 5" })
map("n", "g6", "6gt", { noremap = true, silent = true, desc = "Go to tab 6" })
map("n", "g7", "7gt", { noremap = true, silent = true, desc = "Go to tab 7" })
map("n", "g8", "8gt", { noremap = true, silent = true, desc = "Go to tab 8" })
map("n", "g9", "9gt", { noremap = true, silent = true, desc = "Go to tab 9" })

-- Move up/down without breaking column
map("n", "j", "gj", { noremap = true, silent = true, desc = "Down with line wraps" })
map("n", "k", "gk", { noremap = true, silent = true, desc = "Up with line wraps" })
map("x", "j", "gj", { noremap = true, silent = true, desc = "Down with line wraps" })
map("x", "k", "gk", { noremap = true, silent = true, desc = "Up with line wraps" })

-- Copy to system's clipboard
map("x", "y", '"*y', { noremap = true, desc = "Yank to clipboard" })
map("n", "yy", '"*yy', { noremap = true, desc = "Yank line to clipboard" })

-- Copy current relative path
map("n", "<leader>yp", ':let @* = expand("%:~:.")<cr>', { noremap = true, desc = "Yank relative path" })

-- Copy current absolute path
map("n", "<leader>yP", ':let @* = expand("%:p")<cr>', { noremap = true, desc = "Yank absolute path" })

-- Copy last pasted
map("n", "gV", "`[v`]", { noremap = true, desc = "Select last pasted region" })

-- Terminal mode escape
map("t", "<esc>", "<C-\\><C-n>", { noremap = true, desc = "Escape terminal mode" })

-- Toggle line wrapping
map("n", "<leader>W", ":set wrap!<CR>", { noremap = true, silent = true, desc = "Toggle wrap" })

-- Resize window commands
map("n", "=", "<cmd>vertical resize +5<CR>", { noremap = true, desc = "Increase vertical size" })
map("n", "-", "<cmd>vertical resize -5<CR>", { noremap = true, desc = "Decrease vertical size" })
map("n", "+", "<cmd>horizontal resize +2<CR>", { noremap = true, desc = "Increase horizontal size" })
map("n", "_", "<cmd>horizontal resize -2<CR>", { noremap = true, desc = "Decrease horizontal size" })
