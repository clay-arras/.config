filetype off
call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}         " auto complete... maybe remove
    Plug 'dense-analysis/ale'                               " linter
    Plug 'tpope/vim-commentary'                             " for comments
    Plug 'mg979/vim-visual-multi'                           " multiple cursors
    Plug 'mhinz/vim-startify'
    Plug 'Yggdroot/indentLine'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-surround'
    Plug 'vimwiki/vimwiki'
    Plug 'liuchengxu/vista.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'francoiscabrol/ranger.vim'
    Plug 'rbgrouleff/bclose.vim'
    Plug 'ryanoasis/vim-devicons'

    Plug 'rakr/vim-one'
call plug#end()
filetype on
filetype plugin indent on

set t_Co=256
set termguicolors

set autoindent
set showmatch
set ignorecase
set hlsearch
set incsearch
set expandtab
set showcmd

set tabstop=4
set softtabstop=4
set shiftwidth=4
set wildmode=longest,list
set clipboard=unnamedplus
set fileencoding=utf-8
set encoding=utf-8

set ttyfast
set confirm
set nobackup
set nowritebackup
filetype plugin indent on
syntax on

set mouse=a

" Auto colo theme depending on system
colo one
set background=light
if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
    set background=dark
endif

" Relative number for normal mode, absolute for insert
set nu rnu
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END

" Whitespace remover
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
augroup whitespace
    autocmd!
    autocmd BufWritePre * if !&binary | call TrimWhitespace() | endif
augroup END

" Window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap th :tabprevious<CR>
nnoremap tl :tabnext<CR>
map <C-a> <esc>ggVG<CR>
imap jj <Esc>
imap kk <Esc>

nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
inoremap ; ;<c-g>u

" Folding
set foldmethod=indent
nnoremap <enter> zA

nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}

" Visual mode move
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" New tab
noremap T :tabnew<CR>

" Use <Tab> and <S-Tab> for navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let mapleader = " "
noremap <leader>f :Files ~<CR>
noremap <leader>v :Vista!!<CR>
nnoremap <leader>s :w<cr>

" Ranger mapping
let g:ranger_map_keys = 0
map <leader>w :Ranger<CR>

" Cd to current file's directory
autocmd BufEnter * silent! lcd %:p:h

" Running shortcuts for CP
autocmd FileType cpp command! -bar Compile w | silent execute '!g++ -std=c++17 -O2 -Wall -Wextra -Wshadow -fsanitize=undefined % -o .%:r'
autocmd FileType cpp command! Run Compile | !./.%:r
autocmd FileType cpp nnoremap <leader>rr :Run<CR>

" Open Finder and Terminal TODO quotes around command
command! Find silent execute '!open "%:p:h"'
command! Term silent exe '! osascript
    \ -e "tell application \"iTerm\"                        "
    \ -e "  create window with default profile              "
    \ -e "      tell current window                         "
    \ -e "          tell current session                    "
    \ -e "              write text \"cd %:p:h\"             "
    \ -e "      end tell                                    "
    \ -e "  end tell                                        "
    \ -e "end tell                                          "'

" Linting
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'vim': ['vint'],
    \ 'cpp': ['clang'],
    \ 'c': ['clang']
\}
let g:ale_linters = {'python': 'all'}
let g:ale_fixers = {'python': ['isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace']}

" Configs for indentLine
let g:indentLine_char = '.'

" Config for FZF to include hidden files
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

" Disable vista icons b/c I can't get them working
let g:vista#renderer#enable_icon = 0

