local lspconfig = require('lspconfig')

local shellcheck = {
    lintCommand = "shellcheck -f gcc -x -",
    lintStdin = true,
    lintFormats = {"%f=%l:%c: %trror: %m", "%f=%l:%c: %tarning: %m", "%f=%l:%c: %tote: %m"}
}

local black = {
    formatCommand = "black -",
    formatStdin = true
}

local isort = {
    formatCommand = "isort --stdout --profile black -",
    formatStdin = true
}

local flake8 = {
    lintCommand = "flake8 --max-line-length 160 --stdin-display-name ${INPUT} -",
    lintStdin = true,
    lintIgnoreExitCode = true,
    lintFormats = {"%f=%l:%c: %m"}
}

local mypy = {
    lintCommand = "mypy --show-column-numbers --ignore-missing-imports",
    lintFormats = {"%f=%l:%c: %trror: %m", "%f=%l:%c: %tarning: %m", "%f=%l:%c: %tote: %m"}
}

local prettier = {
    formatCommand = ([[
        ./node_modules/.bin/prettier
        ${--config-precedence:configPrecedence}
        ${--tab-width:tabWidth}
        ${--single-quote:singleQuote}
        ${--trailing-comma:trailingComma}
    ]]):gsub(
        "\n",
        ""
    )
}

local eslint =  {
    lintCommand = "./node_modules/.bin/eslint -f unix --stdin",
    lintIgnoreExitCode = true,
    lintStdin = true
}

local luafmt = {
    formatCommand = "luafmt --stdin",
    formatStdin = true
}

lspconfig.efm.setup {
    on_attach = on_attach,
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {luafmt},
            python = {flake8, black, isort, mypy},
            typescript = {prettier, eslint},
            javascript = {prettier, eslint},
            typescriptreact = {prettier, eslint},
            javascriptreact = {prettier, eslint},
            yaml = {prettier},
            json = {prettier},
            html = {prettier},
            scss = {prettier},
            css = {prettier},
            markdown = {prettier},
            sh = {shellcheck},
        }
    }
}
