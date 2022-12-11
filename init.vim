filetype off
call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Auto complete
    Plug 'dense-analysis/ale'                           " Linter
    Plug 'tpope/vim-commentary'                         " For comments
    Plug 'mhinz/vim-startify'                           " Vim start menu
    Plug 'mg979/vim-visual-multi'                       " Multiple cursors
    Plug 'Yggdroot/indentLine'                          " For showing indents
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy finder file
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-surround'                           " Quick surround changes
    Plug 'tmsvg/pear-tree'                              " Braces autocomplete
    Plug 'liuchengxu/vista.vim'                         " Easy function navigation
    Plug 'junegunn/vim-easy-align'                      " More powerful alignment
    Plug 'davidhalter/jedi-vim'                         " Python autocomplete
    Plug 'godlygeek/tabular'                            " Simple alignment
    Plug 'preservim/vim-markdown'                       " Markdown support
    Plug 'airblade/vim-rooter'                          " Roots
    Plug 'psliwka/vim-smoothie'                         " Smooth scrolling
    Plug 'kien/ctrlp.vim'                               " Navigating buffers
    Plug 'xolox/vim-session'                            " Vim session management
    Plug 'xolox/vim-misc'
    Plug 'mbbill/undotree'                              " Undo visualizer
    " Plug 'vimwiki/vimwiki'

    Plug 'morhetz/gruvbox'
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

set nofoldenable
set confirm
set nobackup
set nowritebackup
filetype plugin indent on
syntax on

set mouse=

" Auto colo theme depending on system
colo gruvbox
set background=light
if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
    set background=dark
endif

" Colors
hi Normal guibg=NONE ctermbg=NONE

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

" Vim Easy Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Vim Session Save
let g:session_autoload="yes"
let g:session_autosave="yes"
g:session_lock_enabled = 1

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

" inoremap { {}<Left>
inoremap {<CR> {<CR>}<Esc>O
" inoremap {{ {
" inoremap {} {}
" noremap qq :bdelete<CR>

" Smoother scrolling
" noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 8, 3)<CR>
" noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 8, 3)<CR>
let g:smoothie_enabled = 1

" Folding
" set foldmethod=indent
" nnoremap <enter> za
" nnoremap <C-enter> zA

nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Visual mode move
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Save on exit insert mode TODO make better
" autocmd InsertLeave *.cpp write
" autocmd InsertLeave *.md write

" Leader mappings
let mapleader = " "
noremap <leader>fl :Files<CR>
noremap <leader>fg :Files ~<CR>
noremap <leader>tl :Vista!!<CR>
noremap <leader>so :OpenSession!<CR>
noremap <leader>ss :SaveSession
nnoremap <leader>ut :UndotreeToggle<CR>

" Calculator in Vim
vnoremap ;bc "ey:call CalcBC()<CR>
function! CalcBC()
    let has_equal = 0
    " Remove newlines and trailing spaces
    let @e = substitute (@e, "\n", "", "g")
    let @e = substitute (@e, '\s*$', "", "g")
    " If we end with an equal, strip, and remember for output
    if @e =~ "=$"
        let @e = substitute (@e, '=$', "", "")
        let has_equal = 1
    endif
    " Sub common func names for bc equivalent
    let @e = substitute (@e, '\csin\s*(', "s (", "")
    let @e = substitute (@e, '\ccos\s*(', "c (", "")
    let @e = substitute (@e, '\catan\s*(', "a (", "")
    let @e = substitute (@e, "\cln\s*(", "l (", "")
    " Escape chars for shell
    let @e = escape (@e, '*()')
    " Run bc, strip newline
    let answer = substitute (system ("echo " . @e . " \| bc -l"), "\n", "", "")
    " Append answer or echo
    if has_equal == 1
        normal `>
        exec "normal a" . answer
    else
        echo "answer = " . answer
    endif
endfunction

" nnoremap <Leader><Up> :ls<CR>
" nnoremap <Leader><Left> :bp<CR>
" nnoremap <Leader><Right> :bn<CR>
" nnoremap <Leader>< :bp<CR>
" nnoremap <Leader>> :bn<CR>

" Split find
" command! -nargs=+ Spf silent :sp | find <args>

" Session
" command! Save silent execute 'mksession! ~/.vims/session.vim'
" command! Load silent execute 'source ~/.vims/session.vim'

" Ranger mapping
" let g:ranger_map_keys = 0
" map <leader>m :Ranger<CR>

" Cd to current file's directory
autocmd BufEnter * silent! lcd %:p:h

" Menu
command! Menu Startify

" Running shortcuts for CP
" autocmd FileType cpp command! -bar Compile w | silent execute '!g++ -std=c++17 -D LOCAL -O2 -Wall -Wextra -Wshadow -fsanitize=undefined % -o .%:r'
" autocmd FileType cpp command! Run Compile | !./.%:r
" -fsanitize=address,undefined
autocmd FileType cpp command! -bar Compile w | execute 'cd $PWD' | silent execute 'term cd %:p:h; gtime -f "\nCompile Time: \%es" g++-12 -std=c++17 -D LOCAL -I /usr/local/include -Wl,-stack_size,0x10000000 -O2 -Wall -Wextra -Wshadow -Wconversion -Wfloat-equal -Wduplicated-cond -Wlogical-op -ggdb -fsanitize-undefined-trap-on-error -o .%:r %;'
autocmd FileType cpp command! Run execute 'cd $PWD' | silent execute "!g++-12 -std=c++17 -D LOCAL -I /usr/local/include -Wl,-stack_size,0x10000000 -O2 -Wall -Wextra -Wshadow -Wconversion -Wfloat-equal -Wduplicated-cond -Wlogical-op -ggdb -fsanitize-undefined-trap-on-error -o .%:r %;" | silent execute 'term cd %:p:h; gtime -f "\nMem: \%Mkb\nTime: \%es" ./.%:r;'
autocmd FileType cpp nnoremap <leader>o <Esc>:Run<CR>



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

" Disable vista icons b/c I can't get them working
let g:vista#renderer#enable_icon = 0


let g:ascii = [
          \ '                  <<<<>>>>>>           .----------------------------.          ',
          \ '                _>><<<<>>>>>>>>>       /               _____________)          ',
          \ '       \|/      \<<<<<  < >>>>>>>>>   /            _______________)            ',
          \ ' -------*--===<=<<           <<<<<<<>/         _______________)                ',
          \ '       /|\     << @    _/      <<<<</       _____________)                     ',
          \ '              <  \    /  \      >>>/      ________)  ____                      ',
          \ '                  |  |   |       </      ______)____((- \\\\                   ',
          \ '                  o_|   /        /      ______)         \  \\\\    \\\\\\\     ',
          \ '                       |  ._    (      ______)           \  \\\\\\\\\\\\\\\\   ',
          \ '                       | /       `----------     /       /     \\\\\\\         ',
          \ '                        \\                              \        \\\\          ',
          \ '               .______/\/     /                 /       /          \\          ',
          \ '              / __.____/    _/         ________(       /\                      ',
          \ '             / / / ________/`---------          \     /  \_                    ',
          \ '            / /  \ \                             \   \ \_  \                   ',
          \ '           ( <    \ \                             >  /    \ \                  ',
          \ '            \/      \\_                          / /       > )                 ',
          \ '                     \_|                        / /       / /                  ',
          \ '                                              _//       _//                    ',
          \ '                                             /_|       /_|                     ',
          \ '                                                                               '
          \]

let g:startify_custom_header = g:ascii + startify#fortune#boxed()
let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh']

" Use <Tab> and <S-Tab> for navigate completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Ctrl P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
