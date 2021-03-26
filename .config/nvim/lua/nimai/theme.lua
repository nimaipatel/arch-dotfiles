vim.o.termguicolors = true
vim.cmd('syntax on')

function SetColorScheme(colorscheme)
	if colorscheme == 'gruvbox_dark' then
		vim.cmd('colorscheme gruvbox8_hard')
		vim.o.background = 'dark'
		vim.api.nvim_exec([[
		    hi StatusLine guibg=NONE guifg=#ebdbb2 gui=bold
		    hi TabLineFill guibg=NONE gui=bold
		    hi TabLine guibg=NONE gui=bold
		    hi TabLineSel guibg=NONE gui=bold
		]], true)
	elseif colorscheme == 'gruvbox_light' then
		vim.cmd('colorscheme gruvbox8_hard')
		vim.o.background = 'light'
		vim.api.nvim_exec([[
		    hi StatusLine guibg=NONE guifg=#3c3836 gui=bold
		    hi TabLineFill guibg=NONE gui=bold
		    hi TabLine guibg=NONE gui=bold
		    hi TabLineSel guibg=NONE gui=bold
		]], true)
	end
end

SetColorScheme('gruvbox_dark')
