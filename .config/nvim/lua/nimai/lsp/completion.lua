local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- create capabilities with snippet support for html and css completion
local capabilities_with_snippets = vim.lsp.protocol.make_client_capabilities()
capabilities_with_snippets.textDocument.completion.completionItem.snippetSupport = true

inoremap('<expr><tab>', 'pumvisible() ? "<c-n>" : "<tab>"')
inoremap('<expr><s-tab>', 'pumvisible() ? "<c-p>" : "<s-tab>"')
imap('<tab>', '<plug>(completion_smart_tab)')
imap('<s-tab>', '<plug>(completion_smart_s_tab)')
imap('<c-space>', '<plug>(completion_trigger)')

local on_attach = function(client, bufnr)
	require('completion').on_attach()
	local function bufnoremap(type, input, output)
		vim.api.nvim_buf_set_keymap(bufnr, type, input, output, { noremap=true, silent=true })
	end
	bufnoremap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>')
	bufnoremap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>')
	bufnoremap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
	bufnoremap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
	bufnoremap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
	bufnoremap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
	bufnoremap('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<cr>')
	bufnoremap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
	bufnoremap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
	bufnoremap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>')
	bufnoremap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>')
	bufnoremap('n', 'H', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>')
	bufnoremap('n', 'L', '<cmd>lua vim.lsp.buf.hover()<cr>')
	vim.api.nvim_set_current_dir(client.config.root_dir)
end

lspconfig.jdtls.setup{
	on_attach = on_attach,
}

lspconfig.pyls.setup{
	on_attach = on_attach,
}

lspconfig.rust_analyzer.setup{
	on_attach = on_attach,
}

lspconfig.clangd.setup{
	on_attach = on_attach,
}

lspconfig.sumneko_lua.setup{
	settings = { Lua = { diagnostics = { globals = { 'vim', 'use' } } } },
	cmd = {"lua-language-server"},
	on_attach = on_attach,
	root_dir = vim.loop.cwd,
	capabilities = capabilities
}

lspconfig.tsserver.setup {
	on_attach = on_attach,
	root_dir = vim.loop.cwd,
	capabilities = capabilities
}

lspconfig.html.setup {
	on_attach = on_attach,
	root_dir = vim.loop.cwd,
	capabilities = capabilities_with_snippets,
	filetypes = { "html", "htmldjango" }
}

lspconfig.cssls.setup {
	on_attach = on_attach,
	root_dir = vim.loop.cwd,
	capabilities = capabilities_with_snippets
}

lspconfig.hls.setup {
	on_attach = on_attach,
	root_dir = vim.loop.cwd,
	capabilities = capabilities
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		signs = true,
		update_in_insert = false,
	}
)
