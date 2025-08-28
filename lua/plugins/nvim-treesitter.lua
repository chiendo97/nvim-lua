return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        config = function()
            -- You can use the capture groups defined in `textobjects.scm`
            local ts_select = require("nvim-treesitter-textobjects.select")
            local ts_move = require("nvim-treesitter-textobjects.move")

            local function map_textobject(modes, key, capture, query_group, desc)
                vim.keymap.set(modes, key, function()
                    ts_select.select_textobject(capture, query_group or "textobjects")
                end, { desc = desc })
            end

            map_textobject({ "x", "o" }, "af", "@function.outer", nil, "Select outer function")
            map_textobject({ "x", "o" }, "if", "@function.inner", nil, "Select inner function")

            map_textobject({ "x", "o" }, "ac", "@class.outer", nil, "Select outer class")
            map_textobject({ "x", "o" }, "ic", "@class.inner", nil, "Select inner class")

            map_textobject({ "x", "o" }, "as", "@local.scope", "locals", "Select local scope")

            -- configuration
            require("nvim-treesitter-textobjects").setup({
                move = {
                    -- whether to set jumps in the jumplist
                    set_jumps = true,
                },
            })

            local function map_moveobject(key, fn, desc)
                vim.keymap.set({ "n", "x", "o" }, key, fn, { silent = true, desc = desc })
            end

            map_moveobject("]m", function()
                ts_move.goto_next_start("@function.outer", "textobjects")
            end, "Next function start")

            map_moveobject("]]", function()
                ts_move.goto_next_start("@class.outer", "textobjects")
            end, "Next class start")

            map_moveobject("]o", function()
                ts_move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
            end, "Next loop start")

            map_moveobject("]s", function()
                ts_move.goto_next_start("@local.scope", "locals")
            end, "Next local scope start")

            map_moveobject("]z", function()
                ts_move.goto_next_start("@fold", "folds")
            end, "Next fold start")

            map_moveobject("]M", function()
                ts_move.goto_next_end("@function.outer", "textobjects")
            end, "Next function end")

            map_moveobject("][", function()
                ts_move.goto_next_end("@class.outer", "textobjects")
            end, "Next class end")

            map_moveobject("[m", function()
                ts_move.goto_previous_start("@function.outer", "textobjects")
            end, "Previous function start")

            map_moveobject("[[", function()
                ts_move.goto_previous_start("@class.outer", "textobjects")
            end, "Previous class start")

            map_moveobject("[M", function()
                ts_move.goto_previous_end("@function.outer", "textobjects")
            end, "Previous function end")

            map_moveobject("[]", function()
                ts_move.goto_previous_end("@class.outer", "textobjects")
            end, "Previous class end")

            map_moveobject("]d", function()
                ts_move.goto_next("@conditional.outer", "textobjects")
            end, "Next conditional")

            map_moveobject("[d", function()
                ts_move.goto_previous("@conditional.outer", "textobjects")
            end, "Previous conditional")
        end,
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
        },
    },
}
