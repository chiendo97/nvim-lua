local prettier = {
    formatCommand = 'prettier --stdin --stdin-filepath ${INPUT}',
    formatStdin = true
}

local eslint_d = {
    lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
    lintStdin = true,
    lintFormats = {'%f:%l:%c: %m'},
    lintIgnoreExitCode = true,

    formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
    formatStdin = true
}

local lua_format = {
    formatCommand = 'lua-format -i --double-quote-to-single-quote --no-keep-simple-function-one-line',
    formatStdin = true
}

local python_black = {formatCommand = 'black --quiet -', formatStdin = true}
local python_flake8 = {
    lintCommand = 'flake8 --stdin-display-name ${INPUT} -',
    lintStdin = true,
    lintFormats = {'%f:%l:%c: %m'}
}

require'lspconfig'.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {
        'python', 'py', 'javascript', 'typescript', 'typescriptreact',
        'javascriptreact', 'lua'
    },
    settings = {
        rootMarkers = {'.git/'},
        languages = {
            python = {python_black, python_flake8},
            lua = {lua_format},
            typescript = {prettier, eslint_d},
            javascript = {prettier, eslint_d},
            typescriptreact = {prettier, eslint_d},
            javascriptreact = {prettier, eslint_d}
        }
    }
}

