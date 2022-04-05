filetype off
call plug#begin()
    Plug 'scrooloose/nerdtree'                              " file navigator
    Plug 'neoclide/coc.nvim', {'branch': 'release'}         " auto complete... maybe remove
    Plug 'jiangmiao/auto-pairs'                             " pairs (might remove) 
    Plug 'dense-analysis/ale'                               " linter
    Plug 'mhinz/vim-startify'                               " starting screen
    Plug 'tpope/vim-commentary'                             " for comments
    Plug 'mg979/vim-visual-multi'                           " multiple cursors
    Plug 'tpope/vim-obsession'                              " session manager
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'mbbill/undotree'
    Plug 'Yggdroot/indentLine'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-surround'

    Plug 'rakr/vim-one'
    Plug 'folke/tokyonight.nvim'
    Plug 'elvessousa/sobrio'
    " Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
call plug#end()
filetype on

if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
    set background=dark
    colo tokyonight
else
    set background=light
    colo one
endif

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

inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ; ;<c-g>u
" inoremap : :<c-g>u

nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Visual mode move
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

let mapleader = ","
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>u :UndotreeToggle<CR>
noremap <leader>f :Files ~<CR>
" noremap <leader>t :Telescope<CR>

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
" command! T silent !osascript -e 'tell app "Terminal" to activate do script with command "cd " & quoted form of "%:p:h"'

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


