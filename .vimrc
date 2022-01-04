" Line numbers
set nu
set rnu

" Syntaxing
syntax on

" Show a colored column at 80 characters
function! ColorColumn()
if &colorcolumn == ""
    set colorcolumn=80
else
    set colorcolumn=
endif
endfunction

" Cursor Line hightlight
:nnoremap <silent> <space>c :set cursorline!<CR>

" base 16
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Color scheme
let g:solarized_termcolors=256
" deal with colors
set t_Co=256
set termguicolors
set background=dark
colorscheme base16-gruvbox-dark-soft

" Indentation
filetype indent on
set smartindent
set cindent
set shiftwidth=4
set tabstop=4

" Key bindings
nmap <C-s> :w<CR>
imap <C-s> <esc>:w<CR>a
imap jj <esc>
nnoremap <space>v :vsplit<CR>:e 
nnoremap <space>h :call HorizontalSplitWithFile()<CR>
map <silent> <C-E> :call ToggleVExplorer()<CR>
map <silent> <C-d> :cd %:p:h<CR>
nnoremap <space>j :tabprevious<CR>
nnoremap <space>k :tabnext<CR>
nnoremap <space>t :tabnew<CR>:e 

" Function
function! VerticalSplitWithFile()
	let curline = getline('.')
	call inputsave()
	let msg = input('Enter filename: ')
	call inputrestore()
	execute ':vsplit '.msg
endfunction

function! HorizontalSplitWithFile()
	let curline = getline('.')
	call inputsave()
	let msg = input('Enter filename: ')
	call inputrestore()
	execute ':split '.msg
endfunction

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction

" Init
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3 
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | Explore | endif
augroup END

" Misc
set noswapfile
set hidden
set mouse=a

" Vim plug
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'ervandew/supertab'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Initialize plugin system
call plug#end()

filetype plugin indent on

autocmd BufNewFile,BufRead *.rs set filetype=rust

" As-you-type autocomplete
set omnifunc=ale#completion#OmniFunc
set completeopt=menu,menuone,preview,noinsert
let g:ale_completion_autoimport = 1
let g:ale_completion_enabled = 1
let g:ale_disable_lsp = 1

nnoremap <C-LeftMouse> :ALEGoToDefinition<CR>
let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }

" Required, explicitly enable Elixir LS
let g:ale_linters = {
\  'rust': ['analyzer'],
\}

let g:rustfmt_autosave = 1

let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
let g:SuperTabDefaultCompletionType = "context"
