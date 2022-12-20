local g = vim.g

g.smoothie_enabled     = 1

-- Vim Session Save
g.session_autoload     = "yes"
g.session_autosave     = "yes"
g.session_lock_enabled = 1

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

-- g.startify_custom_header = g.ascii + startify#fortune#boxed()
g.rooter_patterns = {'.git', 'Makefile', '*.sln', 'build/env.sh'}

-- Ctrl P
g.ctrlp_map = '<c-p>'
g.ctrlp_cmd = 'CtrlP'

-- Config for FZF to include hidden files
-- let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

-- Disable Vista icons because I can't get them working
-- g.vista#renderer#enable_icon = 0

-- NOT WORKING TODO
g.ascii = {
    [[                  <<<<>>>>>>           .----------------------------.          ]],
    [[                _>><<<<>>>>>>>>>       /               _____________)          ]],
    [[       \|/      \<<<<<  < >>>>>>>>>   /            _______________)            ]],
    [[ -------*--===<=<<           <<<<<<<>/         _______________)                ]],
    [[       /|\     << @    _/      <<<<</       _____________)                     ]],
    [[              <  \    /  \      >>>/      ________)  ____                      ]],
    [[                  |  |   |       </      ______)____((- \\\\                   ]],
    [[                  o_|   /        /      ______)         \  \\\\    \\\\\\\     ]],
    [[                       |  ._    (      ______)           \  \\\\\\\\\\\\\\\\   ]],
    [[                       | /       `----------     /       /     \\\\\\\         ]],
    [[                        \\                              \        \\\\          ]],
    [[               .______/\/     /                 /       /          \\          ]],
    [[              / __.____/    _/         ________(       /\                      ]],
    [[             / / / ________/`---------          \     /  \_                    ]],
    [[            / /  \ \                             \   \ \_  \                   ]],
    [[           ( <    \ \                             >  /    \ \                  ]],
    [[            \/      \\_                          / /       > )                 ]],
    [[                     \_|                        / /       / /                  ]],
    [[                                              _//       _//                    ]],
    [[                                             /_|       /_|                     ]],
    [[                                                                               ]]
}

