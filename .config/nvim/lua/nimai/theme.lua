vim.o.termguicolors = true
vim.cmd('syntax on')

function SetColorScheme(colorscheme)
	if colorscheme == 'gruvbox_dark' then
		vim.g.gruvbox_italics = 0
		vim.cmd('colorscheme gruvbox8_hard')
		vim.o.background = 'dark'
		vim.api.nvim_exec([[
			hi Normal guibg=Normal guifg=None
			hi StatusLine guibg=NONE guifg=#ebdbb2 gui=bold
			hi TabLineFill guibg=NONE gui=bold
			hi TabLine guibg=NONE gui=bold
			hi TabLineSel guibg=NONE gui=bold
		]], true)
	elseif colorscheme == 'gruvbox_light' then
		vim.g.gruvbox_italics = 0
		vim.cmd('colorscheme gruvbox8_hard')
		vim.o.background = 'light'
		vim.api.nvim_exec([[
			hi Normal guibg=Normal guifg=None
			hi StatusLine guibg=NONE guifg=#3c3836 gui=bold
			hi TabLineFill guibg=NONE gui=bold
			hi TabLine guibg=NONE gui=bold
			hi TabLineSel guibg=NONE gui=bold
		]], true)
	elseif colorscheme == 'dracula' then
		vim.cmd('colorscheme dracula')
		vim.o.background = 'dark'
		vim.api.nvim_exec([[
			hi Normal guibg=Normal guifg=None
			hi StatusLine guibg=NONE guifg=#f8f8f2 gui=bold
			hi TabLineFill guibg=NONE gui=bold
			hi TabLine guibg=NONE gui=bold
			hi TabLineSel guifg=#50fa7b guibg=NONE gui=bold
		]], true)
	end
end

local colorscheme_name = io.popen("echo $(xrdb -query | grep '^name:' | cut -d: -f2)"):read("*a"):sub(1,-2)
SetColorScheme(colorscheme_name)
