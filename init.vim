call plug#begin()
    Plug 'dense-analysis/ale'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'SirVer/ultisnips'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'vim-scripts/YankRing.vim'
    Plug 'flazz/vim-colorschemes'
    Plug 'jiangmiao/auto-pairs'
    Plug 'wellle/targets.vim'
    Plug 'justinmk/vim-sneak'
    Plug 'voldikss/vim-floaterm'
    Plug 'simeji/winresizer'
call plug#end()
filetype plugin indent on
syntax on

set t_Co=256
set termguicolors
if !exists("g:colors_name") || g:colors_name == 'default'
    colorscheme gruvbox
endif
highlight Normal guibg=NONE ctermbg=NONE
highlight clear StatusLine

set autoindent
set expandtab
set hlsearch
set incsearch
set showcmd
set showmatch
set clipboard=unnamed
set shiftwidth=4
set softtabstop=4
set tabstop=4
set wildmenu
set wildmode=longest,list
set mouse=
set nowrap
set cursorline

set number relativenumber
augroup Numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

let g:UltiSnipsExpandTrigger="<CR>"
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']
let g:yankring_replace_n_nkey = ']p'
let g:yankring_replace_n_pkey = '[p'
let g:winresizer_start_key = ''
let g:ale_linters = { 'cpp': ['g++'], 'c': ['gcc'] }
let g:ale_cpp_cc_executable = 'g++'
let g:ale_cpp_cc_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'

let g:gtimeComp = ['term cd %:p:h; gtime -f "\nMem: \%Mkb\nTime: \%es"', '']
let g:gppComp = [ "g++-12 -std=c++17 -D LOCAL -I /usr/local/include -Wl,-stack_size,0x10000000 -O2 ",
                \ "-Wall -Wextra -Wshadow -Wconversion -Wfloat-equal -Wduplicated-cond -Wlogical-op ",
                \ "-ggdb -fsanitize-undefined-trap-on-error -o ." ]
augroup CPP
    autocmd!
    autocmd FileType cpp command! -bar Compile write | execute join(g:gtimeComp) . join(g:gppComp) . "%:r %"
    autocmd FileType cpp command! Run write | silent execute "!" . join(g:gppComp) . "%:r %" | silent execute join(g:gtimeComp) . './.%:r;'
    autocmd FileType cpp nnoremap <buffer> <leader><leader>c :Run<CR>
augroup END
augroup Misc
    autocmd!
    autocmd BufEnter * silent! lcd %:p:h
    autocmd BufWritePre * :%s/\s\+$//e
augroup END

let g:esc_j_last_time = 0
let g:esc_k_last_time = 0
function! JKescape(key)
    if a:key == 'j' | let g:esc_j_last_time = reltimefloat(reltime()) | endif
    if a:key == 'k' | let g:esc_k_last_time = reltimefloat(reltime()) | endif
    return abs(g:esc_j_last_time - g:esc_k_last_time) <= 0.1 ? "\b\e" : a:key
endfunction
inoremap <expr> j JKescape('j')
inoremap <expr> k JKescape('k')

let g:is_term_open = 0
if exists("g:is_term_open") == 0 | let g:is_term_open = 0 | endif
function! TermSwitch()
    if g:is_term_open == 0 | execute "norm :FloatermNew --height=0.95 --width=0.5 --wintype=float --position=right\<CR>" | endif
    if g:is_term_open == 1 | execute "norm :FloatermToggle\<CR>" | endif
    let g:is_term_open = 1
endfunction
nnoremap <C-\> :call TermSwitch()<CR>
tnoremap <C-\> <C-\><C-n>:FloatermToggle<CR>

nnoremap <C-E> :WinResizerStartFocus<CR>
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
