set mouse=a
set rnu
set number
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set shiftround
set foldmethod=marker
set smartindent
set colorcolumn=81
set cursorline
set cursorcolumn
set laststatus=2
set noshowmode
set incsearch
set smartcase
set backspace=indent,eol,start
" syntax on
filetype on
set path=$PWD/**        " enable fuzzy finding in the vim command line
set wildmenu            " enable fuzzy menu
let g:netrw_winsize=30

hi ColorColumn ctermbg=8
hi CursorLine cterm=bold
hi CursorColumn ctermbg=240
hi CursorLineNr cterm=bold ctermfg=250
hi LineNr cterm=none ctermfg=250
hi StatusLine ctermfg=250 ctermbg=none
hi EndOfBuffer ctermfg=black ctermbg=black
hi Normal ctermfg=250
hi Visual ctermfg=black ctermbg=250 cterm=bold
hi Pmenu ctermfg=black ctermbg=253
hi PmenuSel ctermfg=black ctermbg=250 cterm=bold
hi CocMenuSel ctermfg=black ctermbg=250 cterm=bold
hi CocFloating ctermfg=black ctermbg=253
hi CocInlayHint ctermfg=240 ctermbg=none

let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '^V' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '^S' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

set statusline=\ [%{toupper(g:currentmode[mode()])}]
set statusline+=\ [%n]                          " Buffer number
set statusline+=\ %F                            " File name
set statusline+=\ %Y                            " File type
set statusline+=\ %{''.(&fenc!=''?&fenc:&enc).''} " File encoding
set statusline+=\ %=                            " Align left
set statusline+=\Col:%c                         " Current column
set statusline+=\ Line:%l/%L(%p%%)              " Line X of Y [percent of file]

hi statusline ctermfg=none ctermbg=none
hi User1 ctermfg=black ctermbg=cyan
hi User2 ctermfg=007 ctermbg=239 guibg=#4e4e4e guifg=#adadad

function! FZF() abort
    let l:tempname = tempname()
    " fzf | awk '{ print $1":1:0" }' > file
    execute 'silent !fzf --multi ' . '| awk ''{ print $1":1:0" }'' > ' . fnameescape(l:tempname)
    try
        execute "cfile " . expand(l:tempname)
        redraw!
    finally
        call delete(l:tempname)
    endtry
endfunction

" :Files
command! -nargs=* Files call FZF()

nnoremap <C-s> :w<CR>
inoremap <nowait> jj <ESC>
nnoremap <S-left> <C-w>h
nnoremap <S-down> <C-w>j
nnoremap <S-up> <C-w>k
nnoremap <S-right> <C-w>l
nnoremap <M-left> :tabprevious<CR>
nnoremap <M-right> :tabnext<CR>
nnoremap <C-S-w> :tabclose<CR>
nnoremap <C-S-o> :tabonly<CR>
nnoremap <C-t> :tab ter<CR>
nnoremap <Space> <Nop>
let mapleader=" "
nnoremap <Leader>f :tabnew<CR>:Files<CR>
nnoremap <C-f> :find 
map <C-n> :Lex<CR>

