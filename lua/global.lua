local g = vim.g
local cmd = vim.cmd

g.smoothie_enabled     = 1

-- Linting
g.ale_linters = {
    python = {'pylint'},
    vim    = {'vint'},
    cpp    = {'g++'},
    c      = {'gcc'}
}

g.ale_linters                = {python = 'all'}
g.ale_fixers                 = {python = {'isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace'}}
g.ale_python_pylint_options  = '--rcfile=~/.pylintrc'

g.ale_c_cc_executable        = 'g++'
g.ale_cpp_cc_executable      = 'g++'
g.ale_c_cc_options           = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'
g.ale_cpp_cc_options         = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'

g.ale_cpp_clangcheck_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'
g.ale_cpp_clangd_options     = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'
g.ale_cpp_clangtidy_options  = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'
g.ale_cpp_clazy_options      = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'
g.ale_cpp_cpplint_options    = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'
g.ale_cpp_flawfinder_options = '-Wall -O2 -std=c++17 -D LOCAL -I /usr/local/include'

-- Configs for indentLine
g.indentLine_char            = '.'

-- Ctrl P
g.ctrlp_map = '<c-p>'
g.ctrlp_cmd = 'CtrlP'

-- Config for FZF to include hidden files
cmd([[let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""']])
g.fzf_layout = {down = '~40%'}

local header_art =
[[
 ╭╮╭┬─╮╭─╮┬  ┬┬╭┬╮
 │││├┤ │ │╰┐┌╯││││
 ╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴
]]

-- using the Mini plugins
require('mini.sessions').setup({
    autoread  = false,
    autowrite = true,
    directory = '~/.local/share/nvim/tmp/session',
    file      = 'Session.vim'
})

-- Mini starter
local starter = require('mini.starter')
starter.setup({
	content_hooks = {
		starter.gen_hook.adding_bullet("> "),
		starter.gen_hook.aligning("center", "center"),
	},
	footer = os.date(),
	header = header_art,
	query_updaters = [[abcdefghijklmnopqrstuvwxyz]],
	items = {
        starter.sections.recent_files(10, true),
        starter.sections.sessions(true),
		{ action = "enew", name = "E: New Buffer", section = "Builtin actions" },
		{ action = "qall!", name = "Q: Quit Neovim", section = "Builtin actions" },
	},
})

vim.cmd([[
    augroup MiniStarterJK
        au!
        au User MiniStarterOpened nmap <buffer> <C-j> <Cmd>lua MiniStarter.update_current_item('next')<CR>
        au User MiniStarterOpened nmap <buffer> <C-k> <Cmd>lua MiniStarter.update_current_item('prev')<CR>
    augroup END
]])
