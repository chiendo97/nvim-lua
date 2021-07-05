require('plugins/nvim_compe')
require('plugins/nvim_tree')
require('plugins/lspfzf')

local g = vim.g
local o = vim.o
local exec = vim.api.nvim_exec
local api = vim.api

g.nvim_tree_side = 'left' -- left by default
g.nvim_tree_width = 30 -- 30 by default
g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'} -- empty by default
g.nvim_tree_gitignore = 0 -- 0 by default
g.nvim_tree_auto_open = 0 -- 0 by default, opens the tree when typing `vim $DIR` or `vim`
g.nvim_tree_auto_close = 1 -- 0 by default, closes the tree when it's the last window
g.nvim_tree_auto_ignore_ft = {'startify', 'dashboard'} -- empty by default, don't auto open tree on specific filetypes.
g.nvim_tree_quit_on_open = 0 -- 0 by default, closes the tree when you open a file
g.nvim_tree_follow = 1 -- 0 by default, this option allows the cursor to be updated when entering a buffer
g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
g.nvim_tree_hide_dotfiles = 1 -- 0 by default, this option hides files and folders starting with a dot `.`
g.nvim_tree_git_hl = 0 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_highlight_opened_files = 0 -- 0 by default, will enable folder and file icon highlight for opened files/directories.
g.nvim_tree_root_folder_modifier = ':~' -- This is the default. See :help filename-modifiers for more options
g.nvim_tree_tab_open = 0 -- 0 by default, will open the tree when entering a new tab and the tree was previously open
g.nvim_tree_width_allow_resize = 1 -- 0 by default, will not resize the tree when opening a file
g.nvim_tree_disable_netrw = 1 -- 1 by default, disables netrw
g.nvim_tree_hijack_netrw = 1 -- 1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
g.nvim_tree_add_trailing = 0 -- 0 by default, append a trailing slash to folder names
g.nvim_tree_group_empty = 0 -- 0 by default, compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_lsp_diagnostics = 0 -- 0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
g.nvim_tree_disable_window_picker = 0 -- 0 by default, will disable the window picker.
g.nvim_tree_special_files = {'README.md', 'Makefile', 'MAKEFILE'} -- List of filenames that gets highlighted with NvimTreeSpecialFile
g.nvim_tree_show_icons = {git = 0, folders = 1, files = 1}

g.git_messenger_no_default_mappings = true

g.vimwiki_list = {path = '~/vimwiki/', syntax = 'markdown', ext = '.md'}

g.NERDCreateDefaultMappings = 0
g.NERDSpaceDelims = 1
g.NERDDefaultAlign = 'left'

g.gitgutter_map_keys = 0
g.gitgutter_preview_win_floating = 0

g.gitgutter_sign_added = '▌'
g.gitgutter_sign_modified = '▌'
g.gitgutter_sign_removed = '▁'
g.gitgutter_sign_removed_first_line = '▌'
g.gitgutter_sign_modified_removed = '▌'
g.gitgutter_realtime = 1

exec([[
highlight GitGutterDelete guifg=#F97CA9
highlight GitGutterAdd    guifg=#BEE275
highlight GitGutterChange guifg=#96E1EF
]], false)

g.winresizer_start_key = '<C-T>'

g.mkdp_auto_start = 0
g.mkdp_echo_preview_url = 1

function _G.Float()
    local width = vim.fn.float2nr(o.columns * 0.8)
    local height = vim.fn.float2nr(o.lines * 0.6)
    local opts = {relative = 'editor', row = (o.lines - height) / 2, col = (o.columns - width) / 2, width = width, height = height}

    api.nvim_open_win(api.nvim_create_buf(false, true), true, opts)
end

g.fzf_layout = {window = 'lua Float()'}

g.user_emmet_leader_key = '<c-z>'

g.go_gopls_enabled = 0
g.go_doc_keywordprg_enabled = 0
g.go_def_mapping_enabled = 0
g.go_code_completion_enabled = 0
g.go_doc_keywordprg_enabled = 0
g.go_echo_go_info = 0
g.go_fmt_command = "goimports"
