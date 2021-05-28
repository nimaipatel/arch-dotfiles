AddEventListener('ScrolloffFraction', { 'BufEnter,WinEnter,WinNew,VimResized *,*.*' }, function ()
	if (vim.opt.filetype ~= 'qf') then
		local vis_lines = vim.api.nvim_win_get_height(vim.fn.win_getid())
		vim.opt.scrolloff = math.floor(vis_lines * 0.25)
	end
end)

AddEventListener('LuaHighlight', { 'TextYankPost *' }, function()
	require'vim.highlight'.on_yank()
end)

AddEventListener('DisableHighLight', { 'InsertEnter *' }, function ()
	vim.opt.hlsearch = false
end)

AddEventListener('EnableHighLight', { 'InsertLeave *' }, function ()
	vim.opt.hlsearch = true
end)
