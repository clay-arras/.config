local map = vim.api.nvim_set_keymap
local cmd = vim.cmd
vim.g.mapleader = " "

map('n', '<C-h>', '<C-w>h', {noremap = true, silent = false}) -- Window navigation
map('n', '<C-j>', '<C-w>j', {noremap = true, silent = false})
map('n', '<C-k>', '<C-w>k', {noremap = true, silent = false})
map('n', '<C-l>', '<C-w>l', {noremap = true, silent = false})

map('n', 'Y', 'y$', {noremap = true, silent = false}) -- Redundant
map('n', 'n', 'nzzzv', {noremap = true, silent = false})
map('n', 'N', 'Nzzzv', {noremap = true, silent = false})
map('n', 'J', 'mzJ`z', {noremap = true, silent = false})
map('i', ';', ';<c-g>u', {noremap = true, silent = false})

map('n', 'k', [[(v:count > 5 ? "m'" . v:count : "") . 'k']], {noremap = true, silent = false, expr = true}) -- Use '' or <C-o> or `` to go back when the move is bigger than 5
map('n', 'j', [[(v:count > 5 ? "m'" . v:count : "") . 'j']], {noremap = true, silent = false, expr = true})

map('v', 'J', ":m '>+1<CR>gv=gv", {noremap = true, silent = false}) -- Visual mode move
map('v', 'K', ":m '<-2<CR>gv=gv", {noremap = true, silent = false})

cmd([[inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"]], {noremap = true, silent = false}) -- Tab and shift tab for autocompletion
cmd([[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]], {noremap = true, silent = false})

cmd([[nnoremap Q @q]]) -- Make a recording work with Q
cmd([[vnoremap Q :norm @q<cr>]])

cmd([[vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>]]) -- Search for Visual Selection

-- Toggling menus
cmd([[nnoremap <leader>Tu :UndotreeToggle<CR>]])
cmd([[nnoremap <leader>Tn :NERDTreeToggle<CR>]])

cmd([[

noremap { }
noremap } {

noremap ( )
noremap ) (

inoremap {<CR> {<CR>}<Esc>O
inoremap {<Space><CR> {<CR>}<Esc>O
]])
