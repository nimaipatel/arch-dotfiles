local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- create capabilities with snippet support for html and css completion
local capabilities_with_snippets = vim.lsp.protocol.make_client_capabilities()
capabilities_with_snippets.textDocument.completion.completionItem.snippetSupport =
	true

require('compe').setup {
	enabled = true,
	autocomplete = true,
	debug = false,
	min_length = 1,
	preselect = 'enable',
	throttle_time = 80,
	source_timeout = 200,
	resolve_timeout = 800,
	incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,
	documentation = {
		border = { '', '', '', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
		winhighlight = 'NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder',
		max_width = 120,
		min_width = 60,
		max_height = math.floor(vim.o.lines * 0.3),
		min_height = 1
	},

	source = {
		path = true,
		buffer = true,
		spell = true,
		calc = true,
		nvim_lsp = true,
		nvim_lua = true,
		vsnip = false,
		ultisnips = false,
		luasnip = false
	}
}

iexprmap('<Tab>', 'v:lua.tab_complete()')
sexprmap('<Tab>', 'v:lua.tab_complete()')
iexprmap('<S-Tab>', 'v:lua.s_tab_complete()')
sexprmap('<S-Tab>', 'v:lua.s_tab_complete()')
iexprmap('<C-Space>', 'compe#complete()')
iexprmap('<CR>', 'compe#confirm(\'<CR>\')')
iexprmap('<C-e>', 'compe#close(\'<C-e>\')')
iexprmap('<C-f>', 'compe#scroll({ \'delta\': +4 })')
iexprmap('<C-d>', 'compe#scroll({ \'delta\': -4 })')

nnoremap(']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>')
nnoremap('[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>')
nnoremap('gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
nnoremap('gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
nnoremap('gr', '<cmd>lua vim.lsp.buf.references()<cr>')
nnoremap('gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
nnoremap('<leader>af', '<cmd>lua vim.lsp.buf.code_action()<cr>')
nnoremap('gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
nnoremap('gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
nnoremap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
nnoremap('<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>')
nnoremap('H', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>')
nnoremap('L', '<cmd>lua vim.lsp.buf.hover()<cr>')

lspconfig.phpactor.setup { root_dir = vim.loop.cwd }

lspconfig.texlab.setup { root_dir = vim.loop.cwd }

lspconfig.bashls.setup {
	root_dir = vim.loop.cwd,
	filetypes = { 'sh', 'zsh', 'bash' }
}

lspconfig.jdtls.setup { root_dir = vim.loop.cwd }

lspconfig.pylsp.setup { root_dir = vim.loop.cwd }

lspconfig.rust_analyzer.setup { root_dir = vim.loop.cwd }

lspconfig.clangd.setup { root_dir = vim.loop.cwd }

lspconfig.sumneko_lua.setup {
	settings = { Lua = { diagnostics = { globals = { 'vim', 'use' } } } },
	cmd = { 'lua-language-server' },
	root_dir = vim.loop.cwd,
	capabilities = capabilities
}

lspconfig.tsserver.setup { root_dir = vim.loop.cwd, capabilities = capabilities }

lspconfig.html.setup {
	root_dir = vim.loop.cwd,
	capabilities = capabilities_with_snippets,
	filetypes = { 'html', 'htmldjango' }
}

lspconfig.cssls.setup {
	root_dir = vim.loop.cwd,
	capabilities = capabilities_with_snippets
}

lspconfig.hls.setup { root_dir = vim.loop.cwd, capabilities = capabilities }

vim.lsp.handlers['textDocument/publishDiagnostics'] =
	vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
	             { virtual_text = false, signs = true, update_in_insert = false })
