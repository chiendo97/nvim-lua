local cmp = require("cmp")
if not cmp then
    return
end

local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },

    preselect = require("cmp.types").cmp.PreselectMode.None,

    -- You must set mapping if you want.
    mapping = {
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),

        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    },

    -- You should specify your *installed* sources.
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "copilot" },
    }, {
        { name = "buffer" },
    }),

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
                Copilot = "[Copilot]",
            })[entry.source.name]
            return vim_item
        end,
    },

    experimental = {
        native_menu = false,
        ghost_text = true,
    },

    sorting = {
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.length,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.order,
        },
    },
})
