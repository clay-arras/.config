call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'dense-analysis/ale'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'SirVer/ultisnips'
    Plug 'simeji/winresizer'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-repeat'
    Plug 'vim-scripts/YankRing.vim'
    Plug 'rafi/awesome-vim-colorschemes'
    Plug 'jiangmiao/auto-pairs'
    Plug 'wellle/targets.vim'
call plug#end()
filetype plugin indent on
syntax on

set t_Co=256
set termguicolors
set background=dark
colorscheme gruvbox
highlight Normal guibg=NONE ctermbg=NONE
highlight CocErrorVirtualText guibg=NONE guifg=RED

set autoindent
set expandtab
set hlsearch
set ignorecase
set incsearch
set showcmd
set showmatch
set clipboard=unnamedplus
set shiftwidth=4
set softtabstop=4
set tabstop=4
set wildmode=longest,list
set nowrap
set confirm

set number relativenumber
augroup Numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

let mapleader = ","
let g:ctrlp_working_path_mode = 'c'
let g:indentLine_char = '.'
let g:yankring_replace_n_nkey = ']p'
let g:yankring_replace_n_pkey = '[p'
let g:winresizer_start_key = ''
let g:AutoPairsFlyMode = 1

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'
let g:fzf_layout = { 'down': '40%' }
let g:UltiSnipsExpandTrigger="<CR>"
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']
let g:coc_config_home = '~/.config/nvim/'
let g:ale_linters = { 'cpp': ['g++'], 'c': ['gcc'] }
let g:ale_cpp_cc_executable = 'g++'
let g:ale_cpp_cc_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'

let g:gtimecomp = ['term cd %:p:h; gtime -f "\nMem: \%Mkb\nTime: \%es"', '']
let g:gppcomp = [
            \ "g++-12 -std=c++17 -D LOCAL -I /usr/local/include -Wl,-stack_size,0x10000000 -O2 ",
            \ "-Wall -Wextra -Wshadow -Wconversion -Wfloat-equal -Wduplicated-cond -Wlogical-op ",
            \ "-ggdb -fsanitize-undefined-trap-on-error -o ."
            \]
augroup CPP
    autocmd!
    autocmd FileType cpp command! Run write | silent execute "!" . join(g:gppcomp) . "%:r %" | silent execute join(g:gtimecomp) . './.%:r;'
    autocmd FileType cpp nnoremap <buffer> <leader>cc <Esc>:Run<CR>
augroup END

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
augroup Misc
    autocmd!
    autocmd BufEnter * silent! lcd %:p:h
    autocmd BufWritePost ~/.config/nvim/init.vim source %
    autocmd BufWritePre * if !&binary | call TrimWhitespace() | endif
    autocmd TextChanged,TextChangedI <buffer> silent write
augroup END

let g:esc_j_last_time = 0
let g:esc_k_last_time = 0
function! JKescape(key)
    if a:key=='j' | let g:esc_j_last_time = reltimefloat(reltime()) | endif
    if a:key=='k' | let g:esc_k_last_time = reltimefloat(reltime()) | endif
    return abs(g:esc_j_last_time - g:esc_k_last_time) <= 0.1 ? "\b\e" : a:key
endfunction
inoremap <expr> j JKescape('j')
inoremap <expr> k JKescape('k')

nnoremap <leader>er :<C-U><C-R><C-R>='let @'. v:register .' = '. string(getreg(v:register))<CR><C-F><left>
nnoremap <leader>sd :call fzf#run({'sink':'CtrlP','source':'find ~ -type d','down': '40%','options':'--multi'})<CR>
nnoremap <leader>sf :Files ~<CR>
nnoremap <leader>sh :History<CR>

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)
nnoremap c# ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN
nnoremap c* /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap <C-E> :WinResizerStartFocus<CR>
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'

inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
inoremap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
