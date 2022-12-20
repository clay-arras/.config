local cmd = vim.cmd
local opt = vim.opt

cmd('syntax on')
cmd('filetype plugin indent on')

-- Terminal colors
opt.termguicolors = true

-- Light/dark mode
vim.api.nvim_set_option('background', 'dark')
cmd('colorscheme gruvbox')

cmd('highlight Normal guibg=NONE ctermbg=NONE')

opt.autoindent    = true
opt.showmatch     = true
opt.ignorecase    = true

opt.hlsearch      = true
opt.incsearch     = true

opt.showcmd       = true
opt.confirm       = true
-- opt.nofoldenable  = true

opt.mouse         = ""

-- Backup files
HOME                  = '~/.local/share/nvim'

opt.backup          = true                   -- Use backup files
opt.writebackup     = false
opt.swapfile        = false                  -- Do not use swap file
opt.undodir         = HOME .. '/tmp/undo/'   -- Undo files
opt.backupdir       = HOME .. '/tmp/backup/' -- Backups
opt.directory       = HOME .. '/tmp/swap/'   -- Swap files

-- Tab settings
opt.expandtab     = true
opt.tabstop       = 4
opt.softtabstop   = 4
opt.shiftwidth    = 4

-- NOT WORKING: TODO
opt.wildmode      = {longest = true, list = true}
opt.clipboard     = {unnamedplus = true}

-- File encodings
opt.fileencoding  = 'utf-8'
opt.encoding      = 'utf-8'

-- Relative numbering for normal, absolute numbering for insert
cmd([[
    set number relativenumber
    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
        autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
    augroup END
]])

-- Whitespace remover
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
