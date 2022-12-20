local Plug = vim.fn['plug#']
local PATH = '~/.local/share/nvim/plugged'

vim.call('plug#begin', PATH)

    Plug ('neoclide/coc.nvim', {branch = 'release'})        -- Auto complete
    Plug 'dense-analysis/ale'                               -- Linter

    Plug 'davidhalter/jedi-vim'                             -- Python autocomplete
    Plug 'preservim/vim-markdown'                           -- Markdown support

    Plug 'mhinz/vim-startify'                               -- Vim start menu
    Plug 'Yggdroot/indentLine'                              -- For showing indents

    Plug 'tpope/vim-commentary'                             -- For comments
    Plug 'mg979/vim-visual-multi'                           -- Multiple cursors
    Plug 'tpope/vim-surround'                               -- Quick surround changes
    Plug 'junegunn/vim-easy-align'                          -- More powerful alignment
    Plug 'godlygeek/tabular'                                -- Simple alignment
    Plug 'tmsvg/pear-tree'                                  -- Braces autocomplete

    Plug 'liuchengxu/vista.vim'                             -- Easy function navigation
    Plug 'kien/ctrlp.vim'                                   -- Navigating buffers
    Plug 'mbbill/undotree'                                  -- Undo visualizer

    Plug 'airblade/vim-rooter'                              -- Roots
    Plug 'psliwka/vim-smoothie'                             -- Smooth scrolling

    Plug ('junegunn/fzf', {['do'] = vim.fn['fzf#install']}) -- Fuzzy finder file
    Plug 'junegunn/fzf.vim'

    Plug 'xolox/vim-session'                                -- Vim session management
    Plug 'xolox/vim-misc'
    Plug 'vimwiki/vimwiki'

    Plug 'morhetz/gruvbox'

vim.call('plug#end')
