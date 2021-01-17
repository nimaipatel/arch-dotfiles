vim.api.nvim_exec([[
    imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
    smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

    imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
    smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

    imap <expr> <c-k> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<c-k>'
    smap <expr> <c-k> vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<c-k>'
    imap <expr> <c-j> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<c-j>'
    smap <expr> <c-j> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<c-j>'
]], true)
