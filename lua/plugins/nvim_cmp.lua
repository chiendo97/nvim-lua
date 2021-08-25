local cmp = require('cmp')
local map = vim.api.nvim_set_keymap

cmp.setup {
    snippet = {
        expand = function(args)
            -- You must install `vim-vsnip` if you use the following as-is.
            vim.fn['vsnip#anonymous'](args.body)
        end
    },

    documentation = {border = 'rounded'},

    -- You must set mapping if you want.
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        })
    },

    -- You should specify your *installed* sources.
    sources = {{name = 'nvim_lsp'}, {name = 'path'}, {name = 'buffer'}}
}

map('i', '<Tab>',
    [[vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>']],
    {expr = true})
map('s', '<Tab>',
    [[vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>']],
    {expr = true})
map('i', '<S-Tab>',
    [[vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>']],
    {expr = true})
map('s', '<S-Tab>',
    [[vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>']],
    {expr = true})
