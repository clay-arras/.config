filetype off
call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Auto complete
    Plug 'dense-analysis/ale'                           " Linter
    Plug 'tpope/vim-commentary'                         " For comments
    Plug 'Yggdroot/indentLine'                          " For showing indents
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder file
    Plug 'junegunn/fzf.vim'                             " FZF depencency
    Plug 'tpope/vim-surround'                           " Quick surround changes
    Plug 'junegunn/vim-easy-align'                      " Simple alignment
    Plug 'tpope/vim-unimpaired'                         " Faster navigation
    Plug 'psliwka/vim-smoothie'                         " Smooth scrolling
    Plug 'SirVer/ultisnips'                             " Snippet engine
    Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Multiple cursors
    Plug 'tpope/vim-fugitive'                           " Git wrapper
    Plug 'simeji/winresizer'                            " Window manager
    Plug 'morhetz/gruvbox'                              " Colorscheme
call plug#end()
filetype plugin indent on
syntax on

set t_Co=256
set termguicolors
set background=dark
colorscheme gruvbox
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
set statusline=%#PmenuSel#%#LineNr#%f\ %h%w%m%r%=%#CursorColumn#%-20.(%4l,%c%V\ %=\ %P%)

set number relativenumber
augroup Numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

let mapleader = " "
let g:smoothie_enabled = 1
let g:indentLine_char = '.'
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<CR>"

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let g:fzf_layout = { 'down': '20%' }
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
    autocmd FileType cpp command! -bar Compile w | execute join(g:gtimeComp) . join(g:gppComp) . "%:r %"
    autocmd FileType cpp command! Run w | silent execute "!" . join(g:gppComp) . "%:r %" | silent execute join(g:gtimeComp) . './.%:r;'
    autocmd FileType cpp nnoremap <leader>c <Esc>:Run<CR>
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

function! NormCycleCmd()
    let g:call_lasttime = 1
    execute "Buffers"
endfunction
function! CycleCmd()
    if g:call_lasttime == 0 | silent execute "normal :q\<CR>:Buffers\<CR>" | endif
    if g:call_lasttime == 1 | silent execute "normal :q\<CR>:Files .\<CR>" | endif
    if g:call_lasttime == 2 | silent execute "normal :q\<CR>:call fzf#run({'sink': 'Files', 'source': 'find ~ -type d',  'down': '20%', 'options': '--multi' })\<CR>" | endif
    sleep 5m | silent execute "normal \<C-w>ji"
    let g:call_lasttime = (g:call_lasttime + 1) % 3
endfunction
tnoremap <c-space> <C-\><C-N>:call CycleCmd()<CR>
nnoremap <c-space> :call NormCycleCmd()<CR>

tnoremap <C-C> <C-\><C-n>:bn<CR>:bd#<CR>
nnoremap <Esc><Esc> :let @/=""<CR><Esc>
nnoremap n n<cmd>call smoothie#do("zz") <CR>
nnoremap N N<cmd>call smoothie#do("zz") <CR>
nnoremap Y y$
nnoremap J mzJ`z
inoremap ; ;<c-g>u

noremap ( )
noremap ) (
noremap { }
noremap } {
nnoremap Q @q
vnoremap Q :norm @q<CR>
inoremap {<CR> {<CR>}<Esc>O

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
