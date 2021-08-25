-- configure efm for code formatters and linters
local lspconfig = require 'lspconfig'

local shellcheck = {
	lintCommand = 'shellcheck -f gcc -x -',
	lintStdin = true,
	lintFormats = {
		'%f:%l:%c: %trror: %m',
		'%f:%l:%c: %tarning: %m',
		'%f:%l:%c: %tote: %m',
	},
}

local black = { formatCommand = 'black -', formatStdin = true }

local isort = {
	formatCommand = 'isort --stdout --profile black -',
	formatStdin = true,
}

local flake8 = {
	lintCommand = 'flake8 --max-line-length 160 --stdin-display-name ${INPUT} -',
	lintStdin = true,
	lintIgnoreExitCode = true,
	lintFormats = { '%f=%l:%c: %m' },
}

local mypy = {
	lintCommand = 'mypy --show-column-numbers --ignore-missing-imports',
	lintFormats = {
		'%f=%l:%c: %trror: %m',
		'%f=%l:%c: %tarning: %m',
		'%f=%l:%c: %tote: %m',
	},
}

local prettier = { formatCommand = './node_modules/.bin/prettier' }

local eslint = {
	lintCommand = './node_modules/.bin/eslint -f unix --stdin',
	lintIgnoreExitCode = true,
	lintStdin = true,
}

local luaformat = { formatCommand = 'stylua -', formatStdin = true }

lspconfig.efm.setup {
	init_options = { documentFormatting = true },
	settings = {
		rootMarkers = { vim.loop.cwd() },
		languages = {
			lua = { luaformat },
			python = { flake8, black, isort, mypy },
			typescript = { prettier, eslint },
			javascript = { prettier, eslint },
			typescriptreact = { prettier, eslint },
			javascriptreact = { prettier, eslint },
			yaml = { prettier },
			json = { prettier },
			html = { prettier },
			scss = { prettier },
			css = { prettier },
			markdown = { prettier },
			sh = { shellcheck },
		},
	},
}
