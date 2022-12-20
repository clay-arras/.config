filetype off
call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Auto complete
    Plug 'dense-analysis/ale'                           " Linter
    Plug 'tpope/vim-commentary'                         " For comments
    Plug 'Yggdroot/indentLine'                          " For showing indents
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder file
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-surround'                           " Quick surround changes
    Plug 'tmsvg/pear-tree'                              " Braces autocomplete
    Plug 'godlygeek/tabular'                            " Simple alignment
    Plug 'airblade/vim-rooter'                          " Roots
    Plug 'psliwka/vim-smoothie'                         " Smooth scrolling
    Plug 'kien/ctrlp.vim'                               " Navigating buffers
    Plug 'mbbill/undotree'                              " Undo visualizer
    " Plug 'nvim-lua/plenary.nvim'
    " Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
    " Plug 'nvim-treesitter/nvim-treesitter'

    Plug 'morhetz/gruvbox'
    Plug 'arcticicestudio/nord-vim'
call plug#end()

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

set nofoldenable
set confirm
set nobackup
set nowritebackup
filetype plugin indent on
syntax on


" Colors
" colo gruvbox
colo nord
set background=dark
hi Normal guibg=NONE ctermbg=NONE

" Relative number for normal mode, absolute for insert
set number relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
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

" Map key chord `jk` to <Esc>.
let g:esc_j_lasttime = 0
let g:esc_k_lasttime = 0
function! JKescape(key)
	if a:key=='j' | let g:esc_j_lasttime = reltimefloat(reltime()) | endif
	if a:key=='k' | let g:esc_k_lasttime = reltimefloat(reltime()) | endif
	return abs(g:esc_j_lasttime - g:esc_k_lasttime) <= 0.1 ? "\b\e" : a:key
endfunction
inoremap <expr> j JKescape('j')
inoremap <expr> k JKescape('k')

" Redundant
nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
inoremap ; ;<c-g>u

inoremap {<CR> {<CR>}<Esc>O

nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Visual mode move
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Leader mappings
let mapleader=" "
noremap <leader>f :Files ~<CR>
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Use <Tab> and <S-Tab> for navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Cd to current file's directory
autocmd BufEnter * silent! lcd %:p:h

let g:netrw_bufsettings = 'number relativenumber'

let g:smoothie_enabled = 1
let g:gppComp = [
            \ "g++-12 -std=c++17 -D LOCAL -I /usr/local/include -Wl,-stack_size,0x10000000 -O2 ",
            \ "-Wall -Wextra -Wshadow -Wconversion -Wfloat-equal -Wduplicated-cond -Wlogical-op ",
            \ "-ggdb -fsanitize-undefined-trap-on-error -o ."
            \]

" Running shortcuts for CP
autocmd FileType cpp command! -bar Compile execute "cd $PWD" | silent execute 'term cd %:p:h; gtime -f "\nCompile Time: \%es" ' . join(g:gppComp) . expand("%:r") . " " . expand("%")
autocmd FileType cpp command! Run execute 'cd $PWD' | silent execute "!" . join(g:gppComp) . expand("%:r") . " " . expand("%") | silent execute 'term cd %:p:h; gtime -f "\nMem: \%Mkb\nTime: \%es" ./.%:r;'
autocmd FileType cpp nnoremap <leader>o <Esc>:Run<CR>

" Open Finder and Terminal TODO quotes around command
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
    \ 'cpp': ['g++'],
    \ 'c': ['gcc']
\}
let g:ale_linters = {'python': 'all'}
let g:ale_fixers = {'python': ['isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace']}
let g:ale_python_pylint_options = '--rcfile=~/.pylintrc'

let g:ale_c_cc_executable = 'g++'
let g:ale_cpp_cc_executable = 'g++'
let g:ale_c_cc_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'
let g:ale_cpp_cc_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'

let g:ale_cpp_clangcheck_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'
let g:ale_cpp_clangd_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'
let g:ale_cpp_clangtidy_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'
let g:ale_cpp_clazy_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'
let g:ale_cpp_cpplint_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'
let g:ale_cpp_flawfinder_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'

" Configs for indentLine
let g:indentLine_char = '.'

" Config for FZF to include hidden files
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

" Ctrl P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
