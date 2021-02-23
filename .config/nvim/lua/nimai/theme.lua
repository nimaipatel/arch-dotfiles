vim.o.termguicolors = true
vim.o.background = 'dark'
vim.cmd('colorscheme gruvbox8_hard')
vim.cmd('syntax on')
vim.api.nvim_exec([[
    hi Normal guibg=NONE
    hi StatusLine guibg=NONE guifg=#ebdbb2 gui=bold
    hi TabLineFill guibg=NONE gui=bold
    hi TabLine guibg=NONE gui=bold
    hi TabLineSel guibg=NONE gui=bold
]], true)
