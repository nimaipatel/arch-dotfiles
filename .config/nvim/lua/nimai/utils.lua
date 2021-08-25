for _, mode in ipairs { '', 'n', 'i', 'v', 't', 's' } do
	_G[mode .. 'map'] = function(input, output)
		vim.api.nvim_set_keymap(mode, input, output, {})
	end

	_G[mode .. 'noremap'] = function(input, output)
		vim.api.nvim_set_keymap(mode, input, output, { noremap = true })
	end
end

local globalListenerName = 'globallistenername'
local autocmdhandlers = {}

_G[globalListenerName] = function(name)
	autocmdhandlers[name]()
end

_G['AddEventListener'] = function(name, events, cb)
	autocmdhandlers[name] = cb
	vim.cmd('augroup ' .. name)
	vim.cmd 'autocmd!'
	for _, v in ipairs(events) do
		local cmd = 'lua ' .. globalListenerName .. '("' .. name .. '")'
		vim.cmd('au ' .. v .. ' ' .. cmd)
	end
	vim.cmd 'augroup end'
end

_G['RemoveEventListener'] = function(name)
	vim.cmd('augroup ' .. name)
	vim.cmd 'autocmd!'
	vim.cmd 'augroup end'
	autocmdhandlers[name] = nil
end

_G['RefreshColors'] = function()
	vim.api.nvim_exec(
		[[
		colorscheme base16
		hi Normal guibg=NONE
		hi StatusLine guibg=NONE guifg=color15 gui=bold
		hi StatusLineNC guibg=NONE guifg=color15 gui=bold
		hi LineNr guibg=NONE
		hi GitSignsAdd guifg=green
		hi GitSignsDelete guifg=red
		hi GitSignsChange guifg=yellow
	]],
		true
	)
	vim.g.colors_name = ''
end
