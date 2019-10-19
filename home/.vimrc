set nocompatible              " be iMproved, required
filetype plugin indent on                  " required
set noshowmode
set noruler
set noshowcmd
set autoread
set laststatus=2
set path+=**
set splitbelow splitright
set runtimepath^=~/.vim/bundle/ctrlp.vim

let mapleader ="\<Space>"

" set colorsheme
colorscheme dracula

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" activates syntax highlighting among other things
syntax on

" allows you to deal with multiple unsaved
" buffers simultaneously without resorting
" to misusing tabs
set hidden

" just hit backspace without this one and
" see for yourself
set backspace=indent,eol,start

let g:airline_symbols_ascii = 1
let g:airline_detect_spelllang=1
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

let g:UltiSnipsExpandTrigger = '<C-x>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetsDir = '~/.vim/snips'
let g:UltiSnipsSnippetDirectories = ['snips']

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree && Startify | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" comfortable motion
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"


" set the runtime path to include Vundle and initialize
set rtp+=/home/jakub/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-ruby/vim-ruby'
Plugin 'mhinz/vim-startify'
Plugin 'SirVer/ultisnips'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'yuttie/comfortable-motion.vim'
call vundle#end()

let $PYTHONPATH='/usr/lib/python3.6/site-packages'

set number relativenumber

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" autocomplete file explorer
"set wildmenu
"set wildmode=longest,list,full

map <leader>f :Goyo \| set linebreak<CR>

" spellchecking
map <leader>g :setlocal spell! spelllang=pl<CR>

" open file in a new tab
map <leader>t :tabfind

"manage latex and pdf
map <leader>l :!pdflatex -jobname %:r % &> /dev/null<CR><CR>

" compile and run go
map <leader>c :!go run %

"show all buffers and select the one you want to edit
nnoremap <C-i> :buffers<CR>:buffer<Space>
"show all buggers and select the one you wanna delete
nnoremap <C-u> :buffers<CR>:bdelete!<Space>

tnoremap <ESC> <C-\><C-n>

map <C-y> :term<CR>

" Remove trailing whitespace possibly slowing down
autocmd BufWritePre * %s/\s\+$//e

" Recompile suckless programs automatically
autocmd BufWritePost config.h,config.def.h make

" Reload vim config
autocmd BufWritePost .vimrc so %

"autocmd BufWritePost *.md !pandoc -o doc.pdf %
