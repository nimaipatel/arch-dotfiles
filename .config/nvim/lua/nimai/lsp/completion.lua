-- define capabilities for language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport =
	true
capabilities.textDocument.completion.completionItem.tagSupport = {
	valueSet = { 1 },
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
	properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

-- individually configure all language servers
local lspconfig = require 'lspconfig'
lspconfig.phpactor.setup { root_dir = vim.loop.cwd }

lspconfig.texlab.setup { root_dir = vim.loop.cwd }

lspconfig.bashls.setup {
	root_dir = vim.loop.cwd,
	filetypes = { 'sh', 'zsh', 'bash' },
}

lspconfig.jdtls.setup { root_dir = vim.loop.cwd }

lspconfig.pylsp.setup { root_dir = vim.loop.cwd }

lspconfig.rust_analyzer.setup { root_dir = vim.loop.cwd }

lspconfig.clangd.setup { root_dir = vim.loop.cwd }

lspconfig.sumneko_lua.setup {
	settings = { Lua = { diagnostics = { globals = { 'vim', 'use' } } } },
	cmd = { 'lua-language-server' },
	root_dir = vim.loop.cwd,
	capabilities = capabilities,
}

lspconfig.tsserver.setup { root_dir = vim.loop.cwd, capabilities = capabilities }

lspconfig.html.setup {
	root_dir = vim.loop.cwd,
	capabilities = capabilities,
	filetypes = { 'html', 'htmldjango' },
}

lspconfig.cssls.setup { root_dir = vim.loop.cwd, capabilities = capabilities }

lspconfig.hls.setup { root_dir = vim.loop.cwd, capabilities = capabilities }

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{ virtual_text = false, signs = true, update_in_insert = false }
)

-- setup nvim-cmp for completion and related bindings
local cmp = require 'cmp'
cmp.setup {
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(
					vim.api.nvim_replace_termcodes(
						'<C-n>',
						true,
						true,
						true
					),
					'n'
				)
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(
					vim.api.nvim_replace_termcodes(
						'<C-p>',
						true,
						true,
						true
					),
					'n'
				)
			else
				fallback()
			end
		end,
	},
	sources = {
		{ name = 'nvim_lua' },
		{ name = 'nvim_lsp' },
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'calc' },
	},
}

-- bindings for non-completion related LSP features
nnoremap(']d', vim.lsp.diagnostic.goto_next)
nnoremap('[d', vim.lsp.diagnostic.goto_prev)
nnoremap('gD', vim.lsp.buf.declaration)
nnoremap('gd', vim.lsp.buf.definition)
nnoremap('gr', vim.lsp.buf.references)
nnoremap('gs', vim.lsp.buf.signature_help)
nnoremap('<leader>af', vim.lsp.buf.code_action)
nnoremap('gi', vim.lsp.buf.implementation)
nnoremap('gt', vim.lsp.buf.type_definition)
nnoremap('<leader>rn', vim.lsp.buf.rename)
nnoremap('<leader>f', vim.lsp.buf.formatting)
nnoremap('H', vim.lsp.diagnostic.show_line_diagnostics)
nnoremap('L', vim.lsp.buf.hover)
