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

-- find files
nnoremap('<c-p>', ':FZF<cr>')

-- live grep
nnoremap('<c-t>', ':Rg<cr>')

-- switch buffers
nnoremap('<leader><leader>', ':Buffers<cr>')

-- place cursor in pairs automatically
-- LuaFormatter off
for _, pair in ipairs({
	{ '\'', '\'' },
	{ '"' , '"'  },
	{ '`' , '`'  },
	{ '(' , ')'  },
	{ '{' , '}'  },
	{ '[' , ']'  }
}) do
	local f_char = pair[1]
	local s_char = pair[2]
	inoremap(f_char .. f_char, f_char .. s_char .. '<left>')
end
-- LuaFormatter on
