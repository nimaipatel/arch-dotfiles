vim.o.termguicolors = true
vim.o.background = 'dark'
require("colorbuddy").colorscheme("gruvbox")
vim.cmd('syntax on')

if (vim.g.colors_name == 'moonfly') then
    vim.api.nvim_exec([[
        hi Normal guibg=NONE
        hi StatusLine guibg=NONE guifg=#b2b2b2 gui=bold
        hi TabLineFill guibg=NONE gui=bold
        hi TabLine guibg=NONE gui=bold
        hi TabLineSel guibg=NONE gui=bold
    ]], true)
elseif (vim.g.colors_name == 'gruvbox') then
    vim.g.gruvbox_contrast_dark='hard'
    vim.api.nvim_exec([[
        hi Normal guibg=NONE
        hi StatusLine guibg=NONE guifg=#ebdbb2 gui=bold
        hi TabLineFill guibg=NONE gui=bold
        hi TabLine guibg=NONE gui=bold
        hi TabLineSel guibg=NONE gui=bold
    ]], true)
elseif (vim.g.colors_name == 'dracula') then
    vim.g.gruvbox_contrast_dark='hard'
    vim.api.nvim_exec([[
        hi Normal guibg=NONE
        hi StatusLine guibg=NONE guifg=#f8f8f2 gui=bold
        hi TabLineFill guibg=NONE gui=bold
        hi TabLine guibg=NONE gui=bold
        hi TabLineSel guibg=NONE gui=bold
    ]], true)
end
