local map = vim.api.nvim_set_keymap
vim.g.mapleader = " "

-- Window navigation
map('n', '<C-h>', '<C-w>h', {noremap = true, silent = false})
map('n', '<C-j>', '<C-w>j', {noremap = true, silent = false})
map('n', '<C-k>', '<C-w>k', {noremap = true, silent = false})
map('n', '<C-l>', '<C-w>l', {noremap = true, silent = false})

-- Vim Easy Align
-- xmap ga <Plug>(EasyAlign)
-- nmap ga <Plug>(EasyAlign)

-- Redundant
map('n', 'Y', 'y$', {noremap = true, silent = false})
map('n', 'n', 'nzzzv', {noremap = true, silent = false})
map('n', 'N', 'Nzzzv', {noremap = true, silent = false})
map('n', 'J', 'mzJ`z', {noremap = true, silent = false})
map('i', ';', ';<c-g>u', {noremap = true, silent = false})

-- Brackets autocompletion for c++
map('i', '{<CR>', '{<CR>}<Esc>O', {noremap = true, silent = false})

-- Use '' or <C-o> or `` to go back when the move is bigger than 5
map('n', 'k', [[(v:count > 5 ? "m'" . v:count : "") . 'k']], {noremap = true, silent = false, expr = true})
map('n', 'j', [[(v:count > 5 ? "m'" . v:count : "") . 'j']], {noremap = true, silent = false, expr = true})

-- Visual mode move
map('v', 'J', ":m '>+1<CR>gv=gv", {noremap = true, silent = false})
map('v', 'K', ":m '<-2<CR>gv=gv", {noremap = true, silent = false})

-- Leader mappings
map('n', '<leader>fl', ':Files<CR>', {noremap = true, silent = false})
map('n', '<leader>fg', ':Files ~<CR>', {noremap = true, silent = false})
map('n', '<leader>tl', ':Vista!!<CR>', {noremap = true, silent = false})
map('n', '<leader>so', ':OpenSession!<CR>', {noremap = true, silent = false})
map('n', '<leader>ss', ':SaveSession', {noremap = true, silent = false})
map('n', '<leader>ut', ':UndotreeToggle<CR>', {noremap = true, silent = false})
-- Running NOT WORKING TODO
map('n', '<leader>o', '<Esc>:Run<CR>', {noremap = true, silent = false})

-- Tab and shift tab for autocompletion
map('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], {noremap = true, silent = false})
map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], {noremap = true, silent = false})

map("n", "<leader><CR>", "<cmd>lua ReloadConfig()<CR>", { noremap = true, silent = false })