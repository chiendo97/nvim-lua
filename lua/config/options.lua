-- General settings
vim.o.mouse = "a" -- Enable mouse support in all modes
vim.o.exrc = false -- Disable reading .vimrc/.exrc in current directory for security
vim.o.secure = true -- Restrict dangerous commands in local .vimrc files
vim.o.modelines = 1 -- Check first line for vim modeline commands
vim.o.errorbells = false -- Disable error bells/beeping
vim.o.termguicolors = true -- Enable 24-bit RGB colors in terminal
vim.o.updatetime = 250 -- Faster completion (default 4000ms)
vim.o.autoread = true -- Automatically reload files changed outside vim
vim.o.timeoutlen = 500 -- Time to wait for mapped sequence to complete (ms)
vim.o.fileformat = "unix" -- Use Unix line endings
vim.o.switchbuf = "useopen" -- Switch to existing buffer if already open
vim.o.encoding = "utf-8" -- Internal character encoding
vim.o.fileencoding = "utf-8" -- Character encoding for file writing
vim.o.backspace = "indent,eol,start" -- Allow backspacing over autoindent, line breaks, start of insert

-- UI settings
vim.o.showtabline = 2 -- Always show tab line
vim.o.showmode = true -- Show current mode in command line
vim.o.showcmd = true -- Show incomplete commands in command line
vim.o.cmdheight = 2 -- Height of command line (number of lines)
vim.o.laststatus = 3 -- Global statusline (3 = always show global)
vim.o.scrolloff = 3 -- Keep 3 lines visible above/below cursor when scrolling
vim.o.sidescrolloff = 5 -- Keep 5 columns visible left/right of cursor when scrolling
vim.o.textwidth = 80 -- Maximum line width for text wrapping
vim.o.linespace = 0 -- Extra pixel lines between characters
vim.o.ruler = true -- Show cursor position in status line
vim.o.number = true -- Show line numbers
vim.o.relativenumber = false -- Disable relative line numbers
vim.o.cursorline = true -- Highlight current line
vim.wo.signcolumn = "yes" -- Always show sign column (for git, diagnostics, etc.)
vim.o.wrap = false -- Disable line wrapping
vim.o.breakindent = true -- Indent wrapped lines to match line start
vim.o.linebreak = true -- Break lines at word boundaries
vim.o.winborder = "rounded" -- Use rounded borders for floating windows

-- Completion settings
vim.o.completeopt = "noinsert,menuone,noselect" -- Completion behavior: don't auto-insert, show menu for one match, don't auto-select
vim.o.wildmenu = true -- Enhanced command line completion
vim.o.wildmode = "longest:full,full" -- Command line completion mode
vim.o.wildoptions = "pum" -- Use popup menu for wildmenu
vim.o.pumblend = 15 -- Popup menu transparency (0-100)

-- Indentation settings
vim.o.joinspaces = true -- Insert two spaces after '.', '?', '!' when joining lines
vim.o.autoindent = true -- Copy indent from current line when starting new line
vim.o.smartindent = true -- Smart autoindenting for C-like programs
vim.o.startofline = false -- Don't move cursor to start of line after certain commands
vim.o.tabstop = 4 -- Number of spaces a tab character represents
vim.o.softtabstop = 4 -- Number of spaces for tab in insert mode
vim.o.shiftwidth = 4 -- Number of spaces for each step of autoindent
vim.o.shiftround = true -- Round indent to multiple of shiftwidth
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.smarttab = true -- Smart tab behavior at beginning of lines

-- List characters - visual indicators for whitespace
vim.opt.list = true -- Show invisible characters
vim.opt.listchars = {
    tab = "│ ", -- Show tabs as │ followed by space
    eol = "↴", -- Show end of line as ↴
    trail = "·", -- Show trailing spaces as ·
    extends = "→", -- Show line continuation as →
}

-- Format options - control automatic formatting
vim.opt.formatoptions = vim.opt.formatoptions - "a" - "t" + "c" + "q" - "o" + "r" + "n" + "j" - "2"
-- Remove: a (auto-format paragraphs), t (auto-wrap text), o (auto O command), 2 (use second line indent)
-- Add: c (auto-wrap comments), q (allow gq formatting), r (auto-insert comment leader), n (recognize numbered lists), j (remove comment leader when joining)

-- Window splitting
vim.o.splitbelow = true -- Split new windows below current window
vim.o.splitright = true -- Split new windows to the right of current window

-- Folding
vim.o.foldenable = true -- Enable code folding
vim.o.foldlevel = 99 -- Start with all folds open (high number = more open)
vim.o.foldmethod = "expr" -- Use expression for folding (treesitter)
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter for fold expressions
vim.o.foldtext = "" -- Use default fold text (empty = simple)
vim.opt.foldcolumn = "0" -- Don't show fold column
vim.opt.fillchars:append({ fold = " " }) -- Use space character for fold fill

-- File handling
vim.o.undofile = false -- Disable persistent undo files
vim.o.hidden = true -- Allow switching buffers without saving
vim.o.autochdir = false -- Don't automatically change working directory
vim.o.backup = false -- Don't create backup files
vim.o.writebackup = false -- Don't create backup before writing
vim.o.swapfile = false -- Don't create swap files

-- Search settings
vim.o.magic = false -- Disable magic characters in search patterns (use literal search)
vim.o.hlsearch = true -- Highlight search matches
vim.o.incsearch = true -- Show search matches as you type
vim.o.ignorecase = true -- Ignore case in search patterns
vim.o.smartcase = true -- Override ignorecase if search has uppercase letters
vim.o.showmatch = true -- Briefly jump to matching bracket
vim.o.inccommand = "split" -- Show live preview of substitute commands in split window
vim.o.wrapscan = true -- Search wraps around end of file

-- Session and history
vim.o.shada = [[!,'100,<0,s100,h]] -- ShaDa (shared data) settings: save global vars, 100 files, no registers, 100KB limit, disable hlsearch
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize" -- What to save in sessions
vim.o.diffopt = "internal,filler,algorithm:histogram,indent-heuristic" -- Diff algorithm and options

-- Enable synchronous parsing for Treesitter to ensure immediate syntax updates.
vim.g._ts_force_sync_parsing = false -- Don't force synchronous treesitter parsing (can cause performance issues)

-- Grep settings - use ripgrep if available
if vim.fn.executable("rg") == 1 then
    vim.o.grepprg = "rg --vimgrep --no-heading --smart-case --hidden" -- Use ripgrep with vim-compatible output
    vim.o.grepformat = "%f:%l:%c:%m" -- Format for parsing grep output (file:line:column:message)
end

-- Disable providers - external language support (improves startup time)
vim.g.loaded_python3_provider = 0 -- Disable Python 3 provider
vim.g.loaded_ruby_provider = 0 -- Disable Ruby provider
vim.g.loaded_perl_provider = 0 -- Disable Perl provider
vim.g.loaded_node_provider = 0 -- Disable Node.js provider

-- Disable built-in plugins to improve startup time and reduce conflicts
local disabled_built_ins = {
    "netrw", -- Built-in file explorer
    "netrwPlugin", -- Netrw plugin functionality
    "netrwSettings", -- Netrw settings
    "netrwFileHandlers", -- Netrw file handlers
    "gzip", -- Gzip file support
    "zip", -- Zip file support
    "zipPlugin", -- Zip plugin
    "tar", -- Tar file support
    "tarPlugin", -- Tar plugin
    "getscript", -- Script downloading
    "getscriptPlugin", -- GetScript plugin
    "vimball", -- Vimball archive support
    "vimballPlugin", -- Vimball plugin
    "2html_plugin", -- Convert to HTML
    "logipat", -- Logical patterns
    "rrhelper", -- Remote helper
    "spellfile_plugin", -- Spell file handling
    "matchit", -- Enhanced % matching (replaced by treesitter)
}
for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1 -- Set loaded flag to disable plugin
end
