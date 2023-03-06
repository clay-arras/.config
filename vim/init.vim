filetype off
call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Auto complete
    Plug 'dense-analysis/ale'                           " Linter
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder file
    Plug 'junegunn/fzf.vim'                             " FZF depencency
    Plug 'SirVer/ultisnips'                             " Snippet engine
    Plug 'Yggdroot/indentLine'                          " For showing indents
    Plug 'ctrlpvim/ctrlp.vim'                           " Navigating buffers
    Plug 'junegunn/vim-easy-align'                      " Simple alignment
    Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Multiple cursors
    Plug 'simeji/winresizer'                            " Window manager
    Plug 'tpope/vim-commentary'                         " For comments
    Plug 'tpope/vim-fugitive'                           " Git wrapper
    Plug 'tpope/vim-surround'                           " Quick surround changes
    Plug 'tpope/vim-unimpaired'                         " Faster navigation
    Plug 'tpope/vim-repeat'                             " Repeat for compatible
    Plug 'vim-scripts/YankRing.vim'                     " Yank ring
    Plug 'rafi/awesome-vim-colorschemes'                " Colorscheme
    Plug 'mbbill/undotree'                              " UndoTree visualizer
    Plug 'vim-airline/vim-airline'                      " Better status line
call plug#end()
filetype plugin indent on
syntax on

set t_Co=256
set termguicolors
set background=dark
colorscheme gruvbox
highlight Normal guibg=NONE ctermbg=NONE

set autoindent
set expandtab
set hlsearch
set incsearch
set ignorecase
set showcmd
set showmatch
set clipboard=unnamedplus
set encoding=utf-8
set fileencoding=utf-8
set shiftwidth=4
set softtabstop=4
set tabstop=4
set wildmode=longest,list
set confirm
set nobackup
set nofoldenable
set nowrap
set nowritebackup

set number relativenumber
augroup Numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

let mapleader = ","
let g:UltiSnipsExpandTrigger="<CR>"
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']
let g:ctrlp_working_path_mode = 'c'
let g:indentLine_char = '.'
let g:yankring_replace_n_nkey = ']p'
let g:yankring_replace_n_pkey = '[p'
let g:winresizer_start_key = ''

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let g:fzf_layout = { 'down': '40%' }
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
augroup CPP
    autocmd!
    autocmd FileType cpp command! -bar Compile write | execute join(g:gtimeComp) . join(g:gppComp) . "%:r %"
    autocmd FileType cpp command! Run write | silent execute "!" . join(g:gppComp) . "%:r %" | silent execute join(g:gtimeComp) . './.%:r;'
    autocmd FileType cpp nnoremap <buffer> <leader>cc <Esc>:Run<CR>
    nnoremap <leader>cq <C-\><C-N>:bp<CR>:bd#<CR>
    nnoremap <leader>cw <C-\><C-N>ggVGy:bd<CR>:belowright new<CR>:resize 20<CR>P
augroup END

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
augroup Whitespace
    autocmd!
    autocmd BufWritePre * if !&binary | call TrimWhitespace() | endif
augroup END

augroup Misc
    autocmd!
    autocmd BufEnter * silent! lcd %:p:h
    autocmd BufWritePost ~/.config/nvim/init.vim source %
    autocmd TextChanged,TextChangedI <buffer> silent write
augroup END

let g:esc_j_lasttime = 0
let g:esc_k_lasttime = 0
function! JKescape(key)
    if a:key=='j' | let g:esc_j_lasttime = reltimefloat(reltime()) | endif
    if a:key=='k' | let g:esc_k_lasttime = reltimefloat(reltime()) | endif
    return abs(g:esc_j_lasttime - g:esc_k_lasttime) <= 0.1 ? "\b\e" : a:key
endfunction
inoremap <expr> j JKescape('j')
inoremap <expr> k JKescape('k')

function g:Undotree_CustomMap()
    nmap <buffer> K <plug>UndotreeNextState
    nmap <buffer> J <plug>UndotreePreviousState
endfunction

nnoremap <leader>er :<C-U><C-R><C-R>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-F><left>
nnoremap <leader>eh :UndotreeToggle<CR>
nnoremap <leader>sd :call fzf#run({'sink':'CtrlP','source':'find ~ -type d','down': '40%','options':'--multi'})<CR>
nnoremap <leader>sf :Files ~<CR>
nnoremap <leader>sh :History<CR>

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

nnoremap <C-L> :noh<CR><C-L>
nnoremap <C-E> :WinResizerStartFocus<CR>
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap c# ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN
nnoremap c* /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap J mzJ`z
nnoremap N Nzzzv
nnoremap n nzzzv
nnoremap Y y$
inoremap ; ;<C-G>u
noremap { }
noremap } {
inoremap {<CR> {<CR>}<Esc>O

inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
inoremap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
