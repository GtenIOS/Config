let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeHijackNetrw=0
nnoremap <C-n> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
