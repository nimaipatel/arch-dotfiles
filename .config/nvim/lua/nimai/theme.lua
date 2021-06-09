vim.opt.termguicolors = true
vim.cmd('syntax on')

function SetColorScheme(col_name)
	if col_name == 'gruvbox_dark' then
		vim.cmd('colorscheme gruvbox8_hard')
		vim.opt.background = 'dark'
	elseif col_name == 'gruvbox_light' then
		vim.cmd('colorscheme gruvbox8_hard')
		vim.opt.background = 'light'
	elseif col_name == 'classic' then
		vim.cmd('colorscheme vividchalk')
	else vim.cmd('colorscheme ' .. col_name )
	end
	vim.api.nvim_exec([[
		hi Normal guibg=Normal guifg=None
		hi StatusLine guibg=NONE guifg=color15 gui=bold
		hi GitSignsAdd guifg=green
		hi GitSignsDelete guifg=red
		hi GitSignsChange guifg=yellow
	]], true)
end

local colorscheme_name = io.popen("echo $(xrdb -query | grep '^name:' | cut -d: -f2)"):read("*a"):sub(1,-2)
SetColorScheme(colorscheme_name)
