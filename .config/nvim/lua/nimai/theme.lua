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
        hi StatusLine guibg=NONE guifg=#ebdbb2 gui=bold
        hi TabLineFill guibg=NONE
        hi TabLine guibg=NONE
        hi TabLineSel guibg=NONE
    ]], true)
end
