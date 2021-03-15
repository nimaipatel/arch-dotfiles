-- use jj to escape to normal mode
imap('jj', '<esc>')
tmap('jj', '<esc>')

-- toggle whitespace rendering
nnoremap('<leader>ws', ':set list!<cr>')

-- save buffer with control + w
nnoremap('<c-s>', ':w<cr>')

-- unmap control + z for now
nnoremap('<c-z>', '')

-- toggle relative and absolute line numbering
nnoremap('<leader>nb', ':set relativenumber!<cr>')

-- remove search highlighting with leader + enter
nnoremap('<leader><cr>', ':nohl<cr>')

-- when jumping to bottom, center the page
nnoremap('G', 'Gzz')

-- Make j and k move to the next row, not file line
nnoremap('j', 'gj')
nnoremap('k', 'gk')

-- select all in visual line mode
nnoremap('vA', 'ggVG')

-- yank till end of line
nnoremap('Y', 'y$')

-- delete till end of line
nnoremap('D', 'd$')

-- new tab
nnoremap('<c-t>', ':tabnew<cr>')

-- next and previous tab like in vimium with K and J
nnoremap('J', ':tabprevious<cr>')
nnoremap('K', ':tabnext<cr>')

-- original J and K functionality to <leader>j <leader>k
nnoremap('<leader>j', 'J')
nnoremap('<leader>k', 'K')

-- shift tabs with alt + j and alt + k
nnoremap('<a-j>', ':tabmove -1<cr>')
nnoremap('<a-k>', ':tabmove +1<cr>')

-- spawn zsh shell with control + t
nnoremap('<c-y>', ':8sp term://zsh <cr>')
-- turn terminal to normal mode with escape
nnoremap('<esc>', '<c-\\><c-n>')
