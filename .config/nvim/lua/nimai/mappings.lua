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

-- switch buffers quickly
nnoremap('<leader><leader>', ':buffers<cr>:buffer ')

-- spawn zsh shell with control + t
nnoremap('<c-t>', ':8sp term://zsh <cr>')
-- turn terminal to normal mode with escape
nnoremap('<esc>', '<c-\\><c-n>')

nnoremap('<C-p>', '<cmd>Telescope find_files<CR>')
nnoremap('<space>g', '<cmd>Telescope live_grep<CR>')
nnoremap('<space>b', '<cmd>Telescope buffers<CR>')
