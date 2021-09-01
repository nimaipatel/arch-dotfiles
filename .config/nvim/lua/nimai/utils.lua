local escape_cmd = function(string)
	return string
		:gsub("'", "\\'")
		:gsub('"', '\\"')
		:gsub('\\[', '\\[')
		:gsub('\\]', '\\]')
		:gsub('<', '<lt>')
end

local bounded_funcs = 'global_bounded_funcs_namespace'
_G[bounded_funcs] = {}
for _, mode in ipairs { '', 'n', 'i', 'v', 't', 's' } do
	_G[mode .. 'noremap'] = function(input, output)
		if type(output) == 'function' then
			local func_name = mode .. '_' .. input
			local func_name_escaped = escape_cmd(func_name)
			_G[bounded_funcs][func_name] = output
			local lua_cmd = ':lua '
				.. bounded_funcs
				.. "['"
				.. func_name_escaped
				.. "']()<cr>"
			vim.api.nvim_set_keymap(
				mode,
				input,
				lua_cmd,
				{ noremap = true, silent = true }
			)
		elseif type(output) == 'string' then
			vim.api.nvim_set_keymap(
				mode,
				input,
				output,
				{ noremap = true, silent = true }
			)
		else
			error(
				mode
					.. 'noremap'
					.. ' expects a string or callback',
				2
			)
		end
	end
end

local global_listener = 'global_listener_namespace'
local autocmdhandlers = {}

_G[global_listener] = function(name)
	autocmdhandlers[name]()
end

_G['AddEventListener'] = function(name, events, cb)
	autocmdhandlers[name] = cb
	vim.cmd('augroup ' .. name)
	vim.cmd 'autocmd!'
	for _, v in ipairs(events) do
		local cmd = 'lua ' .. global_listener .. '("' .. name .. '")'
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
