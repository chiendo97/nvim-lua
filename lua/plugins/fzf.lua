if not pcall(require, 'telescope') then
    print('sdf')
    return
end

local o = vim.o
local map = vim.api.nvim_set_keymap
local fn = vim.fn

local actions = require 'telescope.actions'
local sorters = require 'telescope.sorters'

local map_options = {noremap = true, silent = true}

local M = {}

require('telescope').setup {
    defaults = {
        prompt_prefix = '❯ ',
        selection_caret = '❯ ',
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        scroll_strategy = 'cycle',
        color_devicons = true,
        winblend = 0,

        layout_strategy = 'flex',
        layout_config = {
            width = 0.95,
            height = 0.85,
            prompt_position = 'top',

            horizontal = {
                -- width_padding = 0.1,
                -- height_padding = 0.1,
                width = 0.9,
                preview_cutoff = 60,
                preview_width = function(_, cols, _)
                    if cols > 200 then
                        return math.floor(cols * 0.7)
                    else
                        return math.floor(cols * 0.6)
                    end
                end
            },
            vertical = {
                -- width_padding = 0.05,
                -- height_padding = 1,
                width = 0.75,
                height = 0.85,
                preview_height = 0.4,
                mirror = true
            },
            flex = {
                -- change to horizontal after 120 cols
                flip_columns = 120
            }
        },

        mappings = {
            i = {
                ['<C-s>'] = actions.select_horizontal,
                ['<C-v>'] = actions.select_vertical,
                ['<C-t>'] = actions.select_tab,

                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,

                ['<C-c>'] = actions.close,
                ['<esc>'] = actions.close
            }
        },

        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},

        file_sorter = sorters.get_fzy_sorter,
        generic_sorter = sorters.get_fzy_sorter,
        file_ignore_patterns = {'node_modules', '.pyc'},

        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

        vimgrep_arguments = {
            'rg',
            '--hidden',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        }
    },

    extensions = {
        fzy_native = {
            override_generic_sorter = true,
            override_file_sorter = true
        },

        fzf_writer = {use_highlighter = false, minimum_grep_characters = 6},

        frecency = {workspaces = {['conf'] = '~/.config/nvim/'}}
    }
}

require('telescope').load_extension('fzy_native')

map('n', '<leader>g',
    [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<cr>]],
    map_options)
map('n', '<leader>f',
    [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<cr>]],
    map_options)
map('n', '<leader>r',
    [[<cmd>lua require('telescope.builtin').live_grep({previewer = false})<cr>]],
    map_options)
map('n', '<leader>h',
    [[<cmd>lua require('telescope.builtin').oldfiles({previewer = false})<cr>]],
    map_options)
map('n', '<leader>H',
    [[<cmd>lua require('telescope.builtin').help_tags({previewer = false})<cr>]],
    map_options)

M.grep_cword = function()
    require('telescope.builtin').grep_string {
        previewer = false,
        search = vim.fn.expand('<cword>')
    }
end

map('n', '<leader>R',
    [[<cmd>lua require('plugins.fzf').grep_cword()<cr>]],
    map_options)

M.grep_visual = function()
    local _, line_start, column_start, _ = unpack(vim.fn.getpos('\'<'))
    local _, line_end, column_end, _ = unpack(vim.fn.getpos('\'>'))
    local lines = fn.getline(line_start, line_end)
    if #lines == 0 then return '' end
    lines[#lines] = string.sub(lines[#lines], 0, column_end -
                                   (o.selection == 'inclusive' and 0 or 1))
    lines[1] = string.sub(lines[1], column_start)
    local currentSelected = table.concat(lines, '\n')

    require('telescope.builtin').grep_string {
        previewer = false,
        search = currentSelected
    }
end

map('v', '<leader>R',
    [[<cmd>lua require('plugins.fzf').grep_visual()<cr>]],
    map_options)

return M
