function RefreshColors()
	vim.api.nvim_exec([[
		colorscheme base16
		hi StatusLine guibg=NONE guifg=color15 gui=bold
		hi GitSignsAdd guifg=green
		hi GitSignsDelete guifg=red
		hi GitSignsChange guifg=yellow
	]], true)
	vim.g.colors_name = ''
end

RefreshColors()
