if vim.env.NVIM ~= nil then
    print("Exiting with status 2")
    os.exit(2)
end

-- Enable synchronous parsing for Treesitter to ensure immediate syntax updates.
vim.g._ts_force_sync_parsing = true

require("config.options")
require("config.statusline")
require("config.tabline")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
require("config.lsp")

function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, { ... })
    print(unpack(objects))
end
