local cmp = require("cmp")

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },

    documentation = {
        border = "rounded",
    },

    preselect = require("cmp.types").cmp.PreselectMode.Item,

    -- You must set mapping if you want.
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.fn["vsnip#available"]() == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function()
            if vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, {
            "i",
            "s",
        }),
    },

    -- You should specify your *installed* sources.
    sources = {
        { name = "nvim_lsp", score = 3 },
        { name = "path", score = 2 },
        { name = "vsnip", score = 1 },
        { name = "orgmode", score = 0 },
        { name = "nvim_lua", score = 0 },
    },

    formatting = {
        format = function(entry, vim_item)
            -- set a name for each source
            vim_item.menu = ({
                path = "[Path]",
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                vsnip = "[VSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]",
                orgmode = "[OrgMode]",
                neorg = "[NeOrg]",
            })[entry.source.name]
            return vim_item
        end,
    },

    experimental = {
        native_menu = false,
        ghost_text = false,
    },
})
