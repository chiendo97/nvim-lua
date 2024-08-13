local map = vim.api.nvim_set_keymap
local map_options = { noremap = true, silent = true }

map("n", "<leader>g", [[<cmd>Telescope find_files <cr>]], map_options)
map("n", "<leader>r", [[<cmd>Telescope live_grep  <cr>]], map_options)
map("x", "<leader>r", [[<cmd>Telescope grep_string  <cr>]], map_options)
map("n", "<leader>R", [[<cmd>Telescope grep_string  <cr>]], map_options)
map("n", "<leader>h", [[<cmd>Telescope help_tags  <cr>]], map_options)
map("n", "<leader>j", [[<cmd>Telescope oldfiles only_cwd=true<cr>]], map_options)
map("n", "<leader>m", [[<cmd>Telescope keymaps    <cr>]], map_options)
map("n", "<leader>n", [[<cmd>Telescope resume    <cr>]], map_options)
map("n", "<leader>b", [[<cmd>Telescope builtin    <cr>]], map_options)
map("n", "<leader>s", [[<cmd>Telescope spell_suggest <cr>]], map_options)
