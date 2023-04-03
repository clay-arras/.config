call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'dense-analysis/ale'
    Plug 'junegunn/vim-easy-align'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'SirVer/ultisnips'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-repeat'
    Plug 'vim-scripts/YankRing.vim'
    Plug 'rafi/awesome-vim-colorschemes'
    Plug 'jiangmiao/auto-pairs'
    Plug 'wellle/targets.vim'
    Plug 'justinmk/vim-sneak'
    Plug 'terryma/vim-expand-region'
    Plug 'vim-airline/vim-airline'
    Plug 'kevinhwang91/rnvimr'
call plug#end()
filetype plugin indent on
syntax on

set t_Co=256
set termguicolors
highlight Normal guibg=NONE ctermbg=NONE
highlight NormalFloat guibg=NONE ctermbg=NONE

set autoindent
set expandtab
set hlsearch
set incsearch
set showcmd
set showmatch
set clipboard=unnamedplus
set shiftwidth=4
set softtabstop=4
set tabstop=4
set wildmenu
set wildmode=longest,list
set confirm
set nowrap
set mouse=

set number relativenumber
augroup Numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

let g:yankring_replace_n_nkey = ']p'
let g:yankring_replace_n_pkey = '[p'
let g:winresizer_start_key = ''
let g:expand_region_text_objects = {'i]':1,'ib':1,'iB':1,'a]':1,'ab':1,'aB':1}
let g:airline_section_error = ''
let g:airline_section_warning = ''

let g:UltiSnipsExpandTrigger="<CR>"
let g:UltiSnipsSnippetDirectories = ['~/.config/nvim/UltiSnips', 'UltiSnips']
let g:ale_linters = { 'cpp': ['g++'], 'c': ['gcc'] }
let g:ale_cpp_cc_executable = 'g++'
let g:ale_cpp_cc_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'
let g:rnvimr_draw_border = 0
let g:rnvimr_layout = { 'relative':'editor', 'width':float2nr(round(0.5*&columns)), 'height':float2nr(round(1*&lines)), 'col':0, 'row':0, 'style': 'minimal'}

augroup Misc
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
    autocmd BufWritePost ~/.config/nvim/init.vim source %
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

if exists("g:is_ranger_open") == 0 | let g:is_ranger_open = 0 | endif
function! RangerSwitch()
    if g:is_ranger_open == 0 | execute "norm :vnew\<CR>\<C-W>l:RnvimrToggle\<CR>" | endif
    if g:is_ranger_open == 1 | execute "norm :RnvimrToggle\<CR>\<C-\>\<C-N>:RnvimrToggle\<CR>\<C-W>h:bd!\<CR>" | endif
    let g:is_ranger_open = xor(g:is_ranger_open, 1)
endfunction
command! OpenRanger call RangerSwitch()
nnoremap <expr> <C-;> ((g:is_ranger_open == 1) ? ":RnvimrToggle<CR>" : ":w<CR>")
tnoremap <C-;> <C-\><C-N><C-W>l

nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)
nnoremap c# ?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN
nnoremap c* /\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'

inoremap <expr> <S-Tab> pumvisible() ? "\<C-P>" : "\<S-Tab>"
inoremap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
vnoremap / <Esc>/\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap ? <Esc>?\%><C-R>=line("'<")-1<CR>l\%<<C-R>=line("'>")+1<CR>l
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
