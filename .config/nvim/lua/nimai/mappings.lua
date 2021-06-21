-- use jj to escape to normal mode
imap('jj', '<esc>')
tmap('jj', '<esc>')

-- toggle whitespace rendering
nnoremap('<leader>w', ':set list!<cr>')

-- unmap control + z for now
nnoremap('<c-z>', '')

-- toggle relative and absolute line numbering
nnoremap('<leader>n', ':set relativenumber!<cr>')

-- remove search highlighting with leader + enter
nnoremap('<leader><cr>', ':nohl<cr>')

-- when jumping to bottom, center the page
nnoremap('G', 'Gzz')

-- turn terminal to normal mode with escape
nnoremap('<esc>', '<c-\\><c-n>')

local snap = require('snap')

snap.register.map({"n"}, {"<c-p>"}, function ()
	snap.run {
		producer = snap.get('consumer.fzf')(snap.get('producer.ripgrep.file')),
		select = snap.get('select.file').select,
		multiselect = snap.get('select.file').multiselect,
		views = {snap.get('preview.file')}
	}
end)

snap.register.map({"n"}, {"<c-t>"}, function ()
	snap.run {
		producer = snap.get('producer.ripgrep.vimgrep'),
		select = snap.get('select.vimgrep').select,
		multiselect = snap.get('select.vimgrep').multiselect,
		views = {snap.get('preview.vimgrep')}
	}
end)

snap.register.map({"n"}, {"<leader><leader>"}, function ()
	snap.run {
		producer = snap.get('consumer.fzf')(snap.get('producer.vim.buffer')),
		select = snap.get('select.file').select,
		multiselect = snap.get('select.file').multiselect,
		views = {snap.get('preview.file')}
	}
end)
