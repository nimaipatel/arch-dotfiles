set notermguicolors
set t_Co=16

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

augroup ResetCursorShape
au!
autocmd VimEnter * :normal :startinsert :stopinsert
augroup END

let mapleader=" "

syntax on

set relativenumber
set number

set ignorecase
set smartcase

set incsearch
set hlsearch

set completeopt=menu,preview,longest,noinsert

colorscheme koehler
hi Statusline ctermbg=blue ctermfg=black
hi StatuslineNC ctermbg=darkgray ctermfg=white
hi LineNr ctermfg=darkgray
hi EndOfBuffer ctermfg=darkgray
hi ModeMsg ctermbg=black

cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <c-j> <down>
cnoremap <c-k> <up>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap G Gzz

set path+=**

set timeoutlen=1000 ttimeout ttimeoutlen=0

set shell=/bin/bash

let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_hide=0

runtime ftplugin/man.vim
set keywordprg=:Man

nnoremap <leader>s :set spell!<cr>:set spell?<cr>
nnoremap <leader>r :set wrap!<cr>:set wrap?<cr>
nnoremap <leader>w :set list!<cr>:set list?<cr>
nnoremap <leader>t :terminal ++rows=15<cr>

set cinoptions=l1

set smarttab
set autoindent
set copyindent
set smartindent
set tabstop=8
set autoread
set backspace=indent,eol,start
set complete-=i
set display=lastline
set encoding=utf-8
set formatoptions=tcqj
set history=10000
set hlsearch
set incsearch
set langnoremap
set laststatus=2
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
set nrformats=hex
set sessionoptions-=options
set tabpagemax=50
set tags=./tags;,tags
set ttyfast
set viminfo+=!
set lazyredraw

set splitright
set splitbelow

set wildmenu
if !has('nvim')
  set wildmode=longest:full
  set wildoptions=fuzzy,pum
endif
set wildignorecase
set wildignore+=*.o,*.obj,*.bak,*.exe
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/.ccls-cache/*
set wildignore+=**/build/*
set wildignore+=**/android/*
set wildignore+=**/ios/*
set wildignore+=**/.git/*

vnoremap . :normal .<CR>

vnoremap < <gv
vnoremap > >gv

vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

let g:scrolloff_fraction = 0.10
let g:scrolloff_absolute_filetypes = ['qf']
let g:scrolloff_absolute_value = 0

function! ScrollOffFraction(fraction)
  if index(g:scrolloff_absolute_filetypes, &filetype) == -1
    let l:visible_lines_in_active_window = winheight(win_getid())
    let &scrolloff = float2nr(l:visible_lines_in_active_window * a:fraction)
  else
    let &scrolloff = g:scrolloff_absolute_value
  endif
endfunction

augroup ScrolloffFraction
  autocmd!
  autocmd BufEnter,WinEnter,WinNew,VimResized *,*.*
        \ call ScrollOffFraction(g:scrolloff_fraction)
augroup END

augroup WindowManagement
  autocmd!
  autocmd VimResized * wincmd =
augroup END

nnoremap <c-l> :nohl<cr><c-l>

function! UnsetAltScreen()
  let g:altscreen_save_t_ti = &t_ti
  let g:altscreen_save_t_te = &t_te
  if get(g:, 'altscreen_reset', 1)
    let &t_ti = ""
    let &t_te = ""
  else
    let &t_ti = substitute(&t_ti, '\e\[?1049[hl]', '', '')
    let &t_te = substitute(&t_te, '\e\[?1049[hl]', '', '')
  endif
endfun

function! SetAltScreen()
  let &t_ti = g:altscreen_save_t_ti
  let &t_te = g:altscreen_save_t_te
endfun

function! AltScreenControlZ()
  try
    call SetAltScreen()
    if exists('#AltScreen#User#suspend')
      doauto <nomodeline> AltScreen User suspend
    endif
    suspend!
  finally
    if exists('#AltScreen#User#resume')
      doauto <nomodeline> AltScreen User resume
    endif
    call UnsetAltScreen()
  endtry
endfun

augroup MyNoAltScreen
  autocmd!
  autocmd VimEnter *  call UnsetAltScreen()
  autocmd VimLeave *  call SetAltScreen()
augroup END

silent! noremap <unique> <silent>  <c-z>  :<c-u>call AltScreenControlZ()<cr>

function! s:CycleThroughColorCol()
  if &colorcolumn ==# 0
    set colorcolumn=80
    echom "colorcolumn is set to 80"
  elseif &colorcolumn ==# 80
    set colorcolumn=100
    echom "colorcolumn is set to 100"
  elseif &colorcolumn ==# 100
    set colorcolumn=120
    echom "colorcolumn is set to 120"
  elseif &colorcolumn ==# 120
    set colorcolumn=0
    echom "colorcolumn is set to 0"
  else
    set colorcolumn=0
    echom "colorcolumn is set to 0"
  endif
endfunction
command! -nargs=0 CycleThroughColorCol call s:CycleThroughColorCol()

nmap <leader>cc :CycleThroughColorCol<cr><leader>c
nmap <leader>c<esc> :echom "DONE"<cr>

function! s:Tab(width)
  if a:width !=# 0
    let &expandtab = 1
    let &shiftwidth = a:width
    let &softtabstop = a:width
  else
    let &expandtab = 0
    let &shiftwidth = 8
    let &softtabstop = 8
  endif
endfunction
command! -nargs=1 Tab call s:Tab(<f-args>)

nnoremap <leader>0 :Tab 0<cr>
nnoremap <leader>2 :Tab 2<cr>
nnoremap <leader>4 :Tab 4<cr>
nnoremap <leader>8 :Tab 8<cr>

nnoremap <c-n> :bnext<Cr>
nnoremap <c-p> :bprevious<Cr>

nnoremap <leader>d :bp\|bd #<CR>

function! s:HightlightYank() abort
  let [sl, el, sc, ec] = [line("'["), line("']"), col("'["), col("']")]
  if sl == el
    let pos_list = [[sl, sc, ec - sc + 1]]
  else
    let pos_list = [[sl, sc, col([sl, "$"]) - sc]] + range(sl + 1, el - 1) + [[el, 1, ec]]
  endif

  for chunk in range(0, len(pos_list), 8)
    call matchaddpos('IncSearch', pos_list[chunk:chunk + 7])
  endfor
  redraw!
  call timer_start(100, {t_id -> clearmatches()})
endfunction

augroup HightlightYank
  autocmd!
  autocmd TextYankPost * if v:event.operator ==# 'y' | call s:HightlightYank() | endif
augroup END

" add new line without escaping normal mode and move to it
nnoremap <leader><cr> :call append(line('.'), '')<cr>j

function! s:Marks(char)
  marks
  let s:mark = nr2char(getchar())
  redraw
  execute "normal! " . a:char . s:mark
endfunction

nnoremap ' :call  <SID>Marks("'")<CR>
nnoremap ` :call  <SID>Marks("`")<CR>
nnoremap g' :call <SID>Marks("g'")<CR>
nnoremap g` :call <SID>Marks("g`")<CR>
nnoremap d' :call <SID>Marks("d'")<CR>
nnoremap d` :call <SID>Marks("d`")<CR>
nnoremap c' :call <SID>Marks("c'")<CR>
nnoremap c` :call <SID>Marks("c`")<CR>
nnoremap y' :call <SID>Marks("y'")<CR>
nnoremap y` :call <SID>Marks("y`")<CR>

augroup ClearOnMove
  autocmd!
  autocmd InsertEnter,CursorMoved * set nohlsearch nocursorline
augroup END

nnoremap * *zz:set hlsearch cursorline<cr>
nnoremap # #zz:set hlsearch cursorline<cr>
nnoremap n nzz:set hlsearch cursorline<cr>
nnoremap N Nzz:set hlsearch cursorline<cr>

nnoremap j :cnext<cr> :set cursorline<cr>
nnoremap k :cprevious<cr> :set cursorline<cr>

nnoremap <C-j> :lnext<cr> :set cursorline<cr>
nnoremap <C-k> :lprevious<cr> :set cursorline<cr>

" don't undo the whole thing!!
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u

" add relative jumps to jump point list
nnoremap <EXPR> k (v:count > 5 > "m'" . v:count : "") . 'k'
nnoremap <EXPR> j (v:count > 5 > "m'" . v:count : "") . 'j'

function! s:ExecHighlighted () range
  let l:saved_a = @a
  silent! normal! gv"ay
  let l:text = @a
  let @a = l:saved_a

  let l:text = substitute(l:text, '\n\s*\\\\', ' ', 'g')

  exec l:text

endfunction

augroup ExVimL
  autocmd!
  autocmd FileType vim xnoremap <buffer> <f9> :call <SID>ExecHighlighted()<cr>
augroup ExVimL

" rsi.vim
inoremap        <C-A> <C-O>^
inoremap   <C-X><C-A> <C-A>
cnoremap        <C-A> <Home>
cnoremap   <C-X><C-A> <C-A>

inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"
cnoremap        <C-B> <Left>

inoremap <expr> <C-D> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"

inoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"

inoremap <expr> <C-F> col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"

function! s:transpose() abort
  let pos = getcmdpos()
  if getcmdtype() =~# '[?/]'
    return "\<C-T>"
  elseif pos > strlen(getcmdline())
    let pre = "\<Left>"
    let pos -= 1
  elseif pos <= 1
    let pre = "\<Right>"
    let pos += 1
  else
    let pre = ""
  endif
  return pre . "\<BS>\<Right>".matchstr(getcmdline()[0 : pos-2], '.$')
endfunction

cnoremap <expr> <C-T> <SID>transpose()

function! s:ctrl_u()
  if getcmdpos() > 1
    let @- = getcmdline()[:getcmdpos()-2]
  endif
  return "\<C-U>"
endfunction

cnoremap <expr> <C-U> <SID>ctrl_u()
cnoremap <expr> <C-Y> pumvisible() ? "\<C-Y>" : "\<C-R>-"

silent! exe "set <F29>=\<Esc>b"
silent! exe "set <F30>=\<Esc>f"
silent! exe "set <F31>=\<Esc>d"
silent! exe "set <F32>=\<Esc>n"
silent! exe "set <F33>=\<Esc>p"
silent! exe "set <F34>=\<Esc>\<C-?>"
silent! exe "set <F35>=\<Esc>\<C-H>"
noremap!        <F29> <S-Left>
noremap!        <F30> <S-Right>
noremap!        <F31> <C-O>dw
cnoremap        <F31> <S-Right><C-W>
noremap!        <F32> <Down>
noremap!        <F33> <Up>
noremap!        <F34> <C-W>
noremap!        <F35> <C-W>

set makeprg=
nnoremap <leader><leader>m :set makeprg=
nnoremap <leader>m :make<CR>:cwindow<CR>
autocmd! FileType vim :nnoremap <buffer><leader>m :source %<CR>

nnoremap <leader>q :cclose<cr>

nnoremap <leader>b :buffers<CR>:buffer<Space>

nnoremap <leader>g :vimgrep  **/*<Left><Left><Left><Left><Left>

nnoremap <leader>f :find<Space>

" sleuth.vim
function! s:guess(lines) abort
  let options = {}
  let heuristics = {'spaces': 0, 'hard': 0, 'soft': 0}
  let ccomment = 0
  let podcomment = 0
  let triplequote = 0
  let backtick = 0
  let xmlcomment = 0
  let softtab = repeat(' ', 8)

  for line in a:lines
    if !len(line) || line =~# '^\s*$'
      continue
    endif

    if line =~# '^\s*/\*'
      let ccomment = 1
    endif
    if ccomment
      if line =~# '\*/'
        let ccomment = 0
      endif
      continue
    endif

    if line =~# '^=\w'
      let podcomment = 1
    endif
    if podcomment
      if line =~# '^=\%(end\|cut\)\>'
        let podcomment = 0
      endif
      continue
    endif

    if triplequote
      if line =~# '^[^"]*"""[^"]*$'
        let triplequote = 0
      endif
      continue
    elseif line =~# '^[^"]*"""[^"]*$'
      let triplequote = 1
    endif

    if backtick
      if line =~# '^[^`]*`[^`]*$'
        let backtick = 0
      endif
      continue
    elseif &filetype ==# 'go' && line =~# '^[^`]*`[^`]*$'
      let backtick = 1
    endif

    if line =~# '^\s*<\!--'
      let xmlcomment = 1
    endif
    if xmlcomment
      if line =~# '-->'
        let xmlcomment = 0
      endif
      continue
    endif

    if line =~# '^\t'
      let heuristics.hard += 1
    elseif line =~# '^' . softtab
      let heuristics.soft += 1
    endif
    if line =~# '^  '
      let heuristics.spaces += 1
    endif
    let indent = len(matchstr(substitute(line, '\t', softtab, 'g'), '^ *'))
    if indent > 1 && (indent < 4 || indent % 2 == 0) &&
          \ get(options, 'shiftwidth', 99) > indent
      let options.shiftwidth = indent
    endif
  endfor

  if heuristics.hard && !heuristics.spaces
    return {'expandtab': 0, 'shiftwidth': &tabstop}
  elseif heuristics.soft != heuristics.hard
    let options.expandtab = heuristics.soft > heuristics.hard
    if heuristics.hard
      let options.tabstop = 8
    endif
  endif

  return options
endfunction

function! s:patterns_for(type) abort
  if a:type ==# ''
    return []
  endif
  if !exists('s:patterns')
    redir => capture
    silent autocmd BufRead
    redir END
    let patterns = {
          \ 'c': ['*.c'],
          \ 'html': ['*.html'],
          \ 'sh': ['*.sh'],
          \ 'vim': ['vimrc', '.vimrc', '_vimrc'],
          \ }
    let setfpattern = '\s\+\%(setf\%[iletype]\s\+\|set\%[local]\s\+\%(ft\|filetype\)=\|call SetFileTypeSH(["'']\%(ba\|k\)\=\%(sh\)\@=\)'
    for line in split(capture, "\n")
      let match = matchlist(line, '^\s*\(\S\+\)\='.setfpattern.'\(\w\+\)')
      if !empty(match)
        call extend(patterns, {match[2]: []}, 'keep')
        call extend(patterns[match[2]], [match[1] ==# '' ? last : match[1]])
      endif
      let last = matchstr(line, '\S.*')
    endfor
    let s:patterns = patterns
  endif
  return copy(get(s:patterns, a:type, []))
endfunction

function! s:apply_if_ready(options) abort
  if !has_key(a:options, 'expandtab') || !has_key(a:options, 'shiftwidth')
    return 0
  else
    for [option, value] in items(a:options)
      call setbufvar('', '&'.option, value)
    endfor
    return 1
  endif
endfunction

function! s:detect() abort
  if &buftype ==# 'help'
    return
  endif

  let options = s:guess(getline(1, 1024))
  if s:apply_if_ready(options)
    return
  endif
  let c = get(b:, 'sleuth_neighbor_limit', get(g:, 'sleuth_neighbor_limit', 20))
  let patterns = c > 0 ? s:patterns_for(&filetype) : []
  call filter(patterns, 'v:val !~# "/"')
  let dir = expand('%:p:h')
  while isdirectory(dir) && dir !=# fnamemodify(dir, ':h') && c > 0
    for pattern in patterns
      for neighbor in split(glob(dir.'/'.pattern), "\n")[0:7]
        if neighbor !=# expand('%:p') && filereadable(neighbor)
          call extend(options, s:guess(readfile(neighbor, '', 256)), 'keep')
          let c -= 1
        endif
        if s:apply_if_ready(options)
          let b:sleuth_culprit = neighbor
          return
        endif
        if c <= 0
          break
        endif
      endfor
      if c <= 0
        break
      endif
    endfor
    let dir = fnamemodify(dir, ':h')
  endwhile
  if has_key(options, 'shiftwidth')
    return s:apply_if_ready(extend({'expandtab': 1}, options))
  endif
endfunction

setglobal smarttab

if !exists('g:did_indent_on')
  filetype indent on
endif

function! SleuthIndicator() abort
  let sw = &shiftwidth ? &shiftwidth : &tabstop
  if &expandtab
    return 'sw='.sw
  elseif &tabstop == sw
    return 'ts='.&tabstop
  else
    return 'sw='.sw.',ts='.&tabstop
  endif
endfunction

augroup sleuth
  autocmd!
  autocmd FileType *
        \ if get(b:, 'sleuth_automatic', get(g:, 'sleuth_automatic', 1))
        \ | call s:detect() | endif
  autocmd User Flags call Hoist('buffer', 5, 'SleuthIndicator')
augroup END

command! -bar -bang Sleuth call s:detect()

if has('clipboard')
  set clipboard=unnamedplus
else
  nnoremap <leader>p :set paste!<CR>:set paste?<CR>
endif

function! s:CmdToBuffer(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    " use "new" instead of "tabnew" below if you prefer split windows instead of tabs
    new
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    nnoremap <buffer>q :q<cr>
    silent put=message
  endif
endfunction
command! -nargs=+ -complete=command CmdToBuffer call <SID>CmdToBuffer(<q-args>)

nnoremap <leader>kk :CmdToBuffer map<cr>
nnoremap <leader>kn :CmdToBuffer nmap<cr>
nnoremap <leader>kv :CmdToBuffer vmap<cr>
nnoremap <leader>kx :CmdToBuffer xmap<cr>
nnoremap <leader>ks :CmdToBuffer smap<cr>
nnoremap <leader>ko :CmdToBuffer omap<cr>
nnoremap <leader>ki :CmdToBuffer imap<cr>
nnoremap <leader>kl :CmdToBuffer lmap<cr>
nnoremap <leader>kc :CmdToBuffer cmap<cr>
nnoremap <leader>kt :CmdToBuffer tmap<cr>
