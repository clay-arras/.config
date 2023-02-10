filetype off
call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Auto complete
    Plug 'dense-analysis/ale'                           " Linter
    Plug 'tpope/vim-commentary'                         " For comments
    Plug 'Yggdroot/indentLine'                          " For showing indents
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder file
    Plug 'junegunn/fzf.vim'                             " FZF depencency
    Plug 'tpope/vim-surround'                           " Quick surround changes
    Plug 'godlygeek/tabular'                            " Simple alignment
    Plug 'preservim/nerdtree'                           " File navigator
    Plug 'tpope/vim-unimpaired'                         " Faster navigation
    Plug 'tpope/vim-repeat'                             " Easier repeating
    Plug 'psliwka/vim-smoothie'                         " Smooth scrolling
    Plug 'kien/ctrlp.vim'                               " Navigating buffers
    Plug 'SirVer/ultisnips'                             " Snippet engine
    Plug 'easymotion/vim-easymotion'                    " Fast jumping
    Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Multiple cursors
    Plug 'tpope/vim-fugitive'                           " Git wrapper
    Plug 'morhetz/gruvbox'                              " Colorscheme
    Plug 'folke/tokyonight.nvim'
call plug#end()
filetype plugin indent on
syntax on

set t_Co=256
set termguicolors
set background=dark
colo gruvbox
highlight Normal guibg=NONE ctermbg=NONE

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
set nowrap

set nu rnu
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set rnu
    autocmd BufLeave,FocusLost,InsertEnter * set nornu
augroup END

let g:smoothie_enabled = 1
let g:indentLine_char = '.'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<CR>"

let g:fzf_layout = { 'down': '40%' }
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let g:ale_linters = {
    \ 'python': ['pylint'],
    \ 'vim': ['vint'],
    \ 'cpp': ['g++'],
    \ 'c': ['gcc']
\}
let g:ale_cpp_cc_executable = 'g++'
let g:ale_cpp_cc_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'

let g:gtimeComp = ['term cd %:p:h; gtime -f "\nMem: \%Mkb\nTime: \%es"', '']
let g:gppComp = [
            \ "g++-12 -std=c++17 -D LOCAL -I /usr/local/include -Wl,-stack_size,0x10000000 -O2 ",
            \ "-Wall -Wextra -Wshadow -Wconversion -Wfloat-equal -Wduplicated-cond -Wlogical-op ",
            \ "-ggdb -fsanitize-undefined-trap-on-error -o ."
            \]

autocmd FileType cpp command! -bar Compile w | execute join(g:gtimeComp) . join(g:gppComp) . expand("%:r") . " " . expand("%")
autocmd FileType cpp command! Run Compile | bdelete! | silent execute join(g:gtimeComp) . './.%:r;'
autocmd FileType cpp nnoremap <leader>c <Esc>:Run<CR>

command! Terminal silent exe '! osascript
    \ -e "tell application \"iTerm\"            "
    \ -e "  create window with default profile  "
    \ -e "      tell current window             "
    \ -e "          tell current session        "
    \ -e "              write text \"cd %:p:h\" "
    \ -e "      end tell                        "
    \ -e "  end tell                            "
    \ -e "end tell                              "'

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
augroup whitespace
    autocmd!
    autocmd BufWritePre * if !&binary | call TrimWhitespace() | endif
augroup END

autocmd BufWritePre * silent! lcd %:p:h
autocmd BufWritePost ~/.config/nvim/init.vim source %
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

let g:esc_j_lasttime = 0
let g:esc_k_lasttime = 0
function! JKescape(key)
    if a:key=='j' | let g:esc_j_lasttime = reltimefloat(reltime()) | endif
    if a:key=='k' | let g:esc_k_lasttime = reltimefloat(reltime()) | endif
    return abs(g:esc_j_lasttime - g:esc_k_lasttime) <= 0.1 ? "\b\e" : a:key
endfunction
inoremap <expr> j JKescape('j')
inoremap <expr> k JKescape('k')

let mapleader = " "
noremap <leader>f :Files ~/<CR>
noremap <leader>T :NERDTreeToggle<CR>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

nnoremap <Esc> :noh<CR><Esc>
nnoremap Y y$
nnoremap n n<cmd>call smoothie#do("zz") <CR>
nnoremap N N<cmd>call smoothie#do("zz") <CR>
nnoremap J mzJ`z
inoremap ; ;<c-g>u

inoremap {<CR> {<CR>}<Esc>O
noremap ( )
noremap ) (
noremap { }
noremap } {

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

nnoremap Q @q
vnoremap Q :norm @q<CR>
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
