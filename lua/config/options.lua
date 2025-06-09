-- General settings
vim.o.mouse = "a"
vim.o.exrc = false
vim.o.secure = true
vim.o.modelines = 1
vim.o.errorbells = false
vim.o.termguicolors = true
vim.o.updatetime = 250
vim.o.autoread = true
vim.o.timeoutlen = 500
vim.o.fileformat = "unix"
vim.o.switchbuf = "useopen"
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"
vim.o.backspace = "indent,eol,start"

-- UI settings
vim.o.showtabline = 2
vim.o.showmode = true
vim.o.showcmd = true
vim.o.cmdheight = 2
vim.o.laststatus = 3
vim.o.scrolloff = 3
vim.o.sidescrolloff = 5
vim.o.textwidth = 80
vim.o.linespace = 0
vim.o.ruler = true
vim.o.number = true
vim.o.relativenumber = false
vim.o.cursorline = true
vim.wo.signcolumn = "yes"
vim.o.wrap = false
vim.o.breakindent = true
vim.o.linebreak = true

-- Completion settings
vim.o.completeopt = "noinsert,menuone,noselect"
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"
vim.o.wildoptions = "pum"
vim.o.pumblend = 15

-- Indentation settings
vim.o.joinspaces = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.startofline = false
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.shiftround = true
vim.o.expandtab = true
vim.o.smarttab = true

-- List characters
vim.opt.list = true
vim.opt.listchars = {
    tab = "│ ",
    eol = "↴",
    trail = "·",
    extends = "→",
}

-- Format options
vim.opt.formatoptions = vim.opt.formatoptions - "a" - "t" + "c" + "q" - "o" + "r" + "n" + "j" - "2"

-- Window splitting
vim.o.splitbelow = true
vim.o.splitright = true

-- Folding
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })

-- File handling
vim.o.undofile = false
vim.o.hidden = true
vim.o.autochdir = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- Search settings
vim.o.magic = false
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmatch = true
vim.o.inccommand = "split"
vim.o.wrapscan = true

-- Session and history
vim.o.shada = [[!,'100,<0,s100,h]]
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize"
vim.o.diffopt = "internal,filler,algorithm:histogram,indent-heuristic"

-- Grep settings
if vim.fn.executable("rg") == 1 then
    vim.o.grepprg = "rg --vimgrep --no-heading --smart-case --hidden"
    vim.o.grepformat = "%f:%l:%c:%m"
end

-- Disable providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Disable built-in plugins
local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit",
}
for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end
