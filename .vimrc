filetype off
call plug#begin()
    Plug 'scrooloose/nerdtree'                              " file navigator
    Plug 'neoclide/coc.nvim', {'branch': 'release'}         " auto complete... maybe remove
    Plug 'dense-analysis/ale'                               " linter
    Plug 'tpope/vim-commentary'                             " for comments
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-surround'

    Plug 'rakr/vim-one'
call plug#end()
filetype on

set background=light
colo one
if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
    set background=dark
    colo tokyonight
endif

inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}

set t_Co=256
set termguicolors
set autoindent
filetype plugin indent on

set showmatch               
set ignorecase             
set hlsearch                
set incsearch              
set expandtab           
set showcmd

set mouse=a
set tabstop=4             
set softtabstop=4        
set shiftwidth=4          
set wildmode=longest,list
set clipboard=unnamedplus 

set ttyfast              
syntax on 
filetype plugin indent on
set confirm
set nobackup
set nowritebackup

set nu rnu
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END

noremap <C-k> gt
noremap <C-j> gT
imap jj <Esc>
imap kk <Esc>

nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

inoremap ; ;<c-g>u

" Visual mode move
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

let mapleader = ","
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>u :UndotreeToggle<CR>
noremap <leader>f :Files ~<CR>
command! Nf NERDTreeFind

" Open Finder
command! Find silent execute '!open "%:p:h"'
" Open Terminal
command! Term silent exe '! osascript
    \ -e "tell application \"iTerm\""
    \ -e "  create window with default profile"
    \ -e "      tell current window"
    \ -e "          tell current session"
    \ -e "              write text \"cd %:p:h; clear; ls\""
    \ -e "      end tell"
    \ -e "  end tell"
    \ -e "end tell"'

" Config for FZF to include hidden files
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'vim': ['vint'],
    \ 'cpp': ['clang'],
    \ 'c': ['clang']
\}
" Configs for indentLine
let g:indentLine_char = '.'

" Use <Tab> and <S-Tab> for navigate completion list                            
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"                        
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


