for _, mode in ipairs({ '', 'n', 'i', 'v', 't', 's' }) do
	_G[mode .. 'map'] = function(input, output)
		vim.api.nvim_set_keymap(mode, input, output, {})
	end

	_G[mode .. 'noremap'] = function(input, output)
		vim.api.nvim_set_keymap(mode, input, output, { noremap = true })
	end

	_G[mode .. 'exprmap'] = function(input, output)
		vim.api.nvim_set_keymap(mode, input, output,
		                        { expr = true, silent = true, noremap = true })
	end
end

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

_G.tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t '<C-n>'
	elseif check_back_space() then
		return t '<Tab>'
	else
		return vim.fn['compe#complete']()
	end
end

_G.s_tab_complete = function()
	if vim.fn.pumvisible() == 1 then
		return t '<C-p>'
	else
		return t '<S-Tab>'
	end
end

local globalListenerName = 'globallistenername'
local autocmdhandlers = {}

_G[globalListenerName] = function(name)
	autocmdhandlers[name]()
end

function AddEventListener(name, events, cb)
	autocmdhandlers[name] = cb
	vim.cmd('augroup ' .. name)
	vim.cmd('autocmd!')
	for _, v in ipairs(events) do
		local cmd = 'lua ' .. globalListenerName .. '("' .. name .. '")'
		vim.cmd('au ' .. v .. ' ' .. cmd)
	end
	vim.cmd('augroup end')
end

function RemoveEventListener(name)
	vim.cmd('augroup ' .. name)
	vim.cmd('autocmd!')
	vim.cmd('augroup end')
	autocmdhandlers[name] = nil
end

function RefreshColors()
	vim.api.nvim_exec([[
		colorscheme base16
		hi Normal guibg=NONE
		hi StatusLine guibg=NONE guifg=color15 gui=bold
		hi StatusLineNC guibg=NONE guifg=color15 gui=bold
		hi LineNr guibg=NONE
		hi GitSignsAdd guifg=green
		hi GitSignsDelete guifg=red
		hi GitSignsChange guifg=yellow
	]], true)
	vim.g.colors_name = ''
end
