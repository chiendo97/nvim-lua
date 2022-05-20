local g = vim.g

g.nvim_tree_auto_ignore_ft = { "startify", "dashboard" } -- empty by default, don't auto open tree on specific filetypes.
g.nvim_tree_git_hl = 0 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_highlight_opened_files = 0 -- 0 by default, will enable folder and file icon highlight for opened files/directories.
g.nvim_tree_root_folder_modifier = ":~" -- This is the default. See :help filename-modifiers for more options
g.nvim_tree_width_allow_resize = 1 -- will resize the tree when opening a file
g.nvim_tree_add_trailing = 0 -- 0 by default, append a trailing slash to folder names
g.nvim_tree_group_empty = 0 -- 0 by default, compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_special_files = { "README.md", "Makefile", "MAKEFILE" } -- List of filenames that gets highlighted with NvimTreeSpecialFile
g.nvim_tree_show_icons = { git = 0, folders = 1, files = 1 }

g.nvim_tree_icon_padding = " " -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
g.nvim_tree_symlink_arrow = " ➛ " --  defaults to ' ➛ '. used as a separator between symlinks' source and target.
g.nvim_tree_respect_buf_cwd = 0 -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
g.nvim_tree_refresh_wait = 1000 -- 1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.

g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★",
        deleted = "",
        ignored = "◌",
    },
    folder = {
        arrow_open = "",
        arrow_closed = "",
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
        symlink_open = "",
    },
    lsp = {
        hint = "",
        info = "",
        warning = "",
        error = "",
    },
}

require("nvim-tree").setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_buffer_on_setup = false,
    ignore_ft_on_setup = {},
    auto_reload_on_write = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = false,
    hijack_unnamed_buffer_when_opening = false,
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    diagnostics = {
        enable = false,
        icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
        },
    },
    update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
    },
    system_open = {
        cmd = nil,
        args = {},
    },
    filters = {
        dotfiles = true,
        custom = { "node_modules" },
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        mappings = {
            custom_only = false,
            list = {},
        },
        number = false,
        relativenumber = false,
        signcolumn = "yes",
    },
    renderer = {
        indent_markers = {
            enable = true,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            },
        },
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
    actions = {
        change_dir = {
            enable = true,
            global = false,
        },
        open_file = {
            quit_on_open = false,
            resize_window = false,
            window_picker = {
                enable = true,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
    },
})

vim.api.nvim_set_keymap("n", "<leader>c", "<cmd>NvimTreeToggle<cr>", { noremap = true })
