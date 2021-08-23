local prettier = {
    formatCommand = 'prettierd --stdin-filepath ${INPUT}',
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
    formatCommand = 'lua-format -i --chop-down-parameter --chop-down-table --double-quote-to-single-quote --no-keep-simple-function-one-line',
    formatStdin = true
}

local python_flake8 = {
    lintCommand = 'flake8 --stdin-display-name ${INPUT} -',
    lintStdin = true,
    lintFormats = {'%f:%l:%c: %m'}
}
local python_black = {formatCommand = 'black --quiet -S -', formatStdin = true}
local python_isort = {formatCommand = 'isort --quiet -', formatStdin = true}

local go_goimports = {formatCommand = 'goimports', formatStdin = true}
-- local go_ci = {lintCommand = 'golangci-lint run'}

local json_jq = {formatCommand = 'jq .', formatStdin = true}

local format_config = {
    python = {python_black, python_flake8, python_isort},
    lua = {lua_format},
    typescript = {prettier, eslint_d},
    javascript = {prettier, eslint_d},
    typescriptreact = {prettier, eslint_d},
    javascriptreact = {prettier, eslint_d},
    json = {json_jq},
    go = {go_goimports}
}

require'lspconfig'.efm.setup {
    on_attach = require('lsp.attach').on_attach,
    init_options = {documentFormatting = true},
    root_dir = function(fname)
        return require'lspconfig.util'.root_pattern('.git')(fname) or
                   require'lspconfig.util'.path.dirname(fname)
    end,
    filetypes = vim.tbl_keys(format_config),
    settings = {languages = format_config}
}

