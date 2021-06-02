vim.api.nvim_exec([[
	autocmd FileType html,htmldjango,xml,xsd,dtd,xslt,css,python,javascript setlocal shiftwidth=4 softtabstop=4 softtabstop=4 expandtab
	autocmd FileType haskell setlocal shiftwidth=2 softtabstop=2 softtabstop=2 expandtab
]],true)
