call plug#begin()
    Plug 'dense-analysis/ale'
    Plug 'flazz/vim-colorschemes'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'jiangmiao/auto-pairs'
    Plug 'wellle/targets.vim'
    Plug 'justinmk/vim-sneak'
call plug#end()
filetype plugin indent on
syntax on

colorscheme gruvbox
highlight Normal guibg=NONE ctermbg=NONE
highlight clear StatusLine

set t_Co=256
set termguicolors
set expandtab
set showmatch
set showcmd
set hlsearch
set clipboard=unnamed
set shiftwidth=4
set softtabstop=4
set tabstop=4
set cursorline
set hlsearch

set number relativenumber
augroup Numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END
augroup Misc
    autocmd!
    autocmd BufEnter * silent! lcd %:p:h
    autocmd BufWritePre * :%s/\s\+$//e
    autocmd FileType cpp command! Run write | execute "!clear && g++-12 -std=c++17 -D LOCAL -I /usr/local/include -Wl,-stack_size,0x10000000 -O2 -Wall -o .%:r % && ./.%:r"
    autocmd FileType cpp nnoremap <buffer> <leader><leader>c <Esc>:Run<CR>
augroup END

let g:ale_linters = { 'cpp': ['g++'], 'c': ['gcc'] }
let g:ale_cpp_cc_executable = 'g++'
let g:ale_cpp_cc_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'

imap jk <Esc>
imap kj <Esc>

nnoremap <expr> j (v:count > 9 ? "m'" . v:count : "") . 'j'
nnoremap <expr> k (v:count > 9 ? "m'" . v:count : "") . 'k'
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
