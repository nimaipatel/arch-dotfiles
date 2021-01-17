vim.o.termguicolors = true
vim.o.background = 'dark'
require('colorbuddy').colorscheme('gruvbox')
vim.cmd('syntax on')

if (vim.g.colors_name == 'moonfly') then
    vim.api.nvim_exec([[
        hi Normal guibg=NONE
        hi StatusLine guibg=#080808
        hi TabLineFill guibg=#080808
        hi TabLine guibg=#080808
        hi TabLineSel guibg=#080808
    ]], true)
elseif (vim.g.colors_name == 'gruvbox') then
    vim.g.gruvbox_contrast_dark='hard'
    vim.api.nvim_exec([[
        hi Normal guibg=NONE
        hi StatusLine guifg=#1d2021
        hi TabLineFill guibg=#1d2021
        hi TabLine guibg=#1d2021
        hi TabLineSel guibg=#1d2021
    ]], true)
end
