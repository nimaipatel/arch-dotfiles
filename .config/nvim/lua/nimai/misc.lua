AddEventListener('LuaHighlight', { 'TextYankPost *' }, function()
    require'vim.highlight'.on_yank()
end)

AddEventListener('DisableHighLight', { 'InsertEnter *' }, function ()
    vim.o.hlsearch = false
end)

AddEventListener('EnableHighLight', { 'InsertLeave *' }, function ()
    vim.o.hlsearch = true
end)

AddEventListener('CenterOnInsert', { 'InsertEnter *' }, function ()
    vim.cmd(':norm zz')
end)
