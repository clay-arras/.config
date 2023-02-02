local Plug = vim.fn['plug#']
local PATH = '~/.local/share/nvim/plugged'

vim.call('plug#begin', PATH)
    Plug ('neoclide/coc.nvim', {branch = 'release'})        -- Auto complete
    Plug 'dense-analysis/ale'                               -- Linter

    Plug 'echasnovski/mini.nvim'                            -- Starting screen and other QOL modules
    Plug 'Yggdroot/indentLine'                              -- For showing indents
    Plug 'psliwka/vim-smoothie'                             -- Smooth scrolling

    Plug 'tpope/vim-commentary'                             -- For comments
    Plug 'tpope/vim-surround'                               -- Quick surround changes
    Plug 'mg979/vim-visual-multi'                           -- Multiple cursors
    Plug 'godlygeek/tabular'                                -- Simple alignment
    Plug 'maxbrunsfeld/vim-yankstack'                       -- Register navigation
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-repeat'

    Plug 'kien/ctrlp.vim'                                   -- Navigating buffers
    Plug 'mbbill/undotree'                                  -- Undo visualizer
    Plug 'preservim/nerdtree'                               -- File browser on the side
    Plug ('junegunn/fzf', {['do'] = vim.fn['fzf#install']}) -- Fuzzy finder file
    Plug 'junegunn/fzf.vim'

    Plug 'morhetz/gruvbox'                                  -- Color theme red/orange
    Plug 'arcticicestudio/nord-vim'                         -- Color theme blue
vim.call('plug#end')

