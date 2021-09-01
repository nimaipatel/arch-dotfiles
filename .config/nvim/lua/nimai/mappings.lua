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
nnoremap('<c-p>', require('fzf-lua').files)

-- live grep
nnoremap('<c-t>', require('fzf-lua').live_grep)

-- switch buffers
nnoremap('<c-b>', require('fzf-lua').buffers)

-- turn on search highlighting when jumping using n
nnoremap('*', '*:set hlsearch<cr>')

-- turn on search highlighting when jumping using n
nnoremap('n', 'n:set hlsearch<cr>')

-- turn on search highlighting when jumping using N
nnoremap('N', 'N:set hlsearch<cr>')

-- control + h is left arrow in insert mode
inoremap('<c-h>', '<esc><left>a')

-- control + l is right arrow in insert mode
inoremap('<c-l>', '<esc><right>a')

-- place cursor in pairs automatically
-- LuaFormatter off
for _, pair in ipairs {
	{ "'", "'" },
	{ '"', '"' },
	{ '`', '`' },
	{ '(', ')' },
	{ '{', '}' },
	{ '[', ']' },
} do
	local f_char = pair[1]
	local s_char = pair[2]
	inoremap(f_char .. f_char, f_char .. s_char .. '<left>')
end
-- LuaFormatter on
