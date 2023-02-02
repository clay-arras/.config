local cmd = vim.cmd

cmd([[let mapleader = " "]])

cmd([[

let g:gppComp = [
    \ "g++-12 -std=c++17 -D LOCAL -I /usr/local/include -Wl,-stack_size,0x10000000 -O2 ",
    \ "-Wall -Wextra -Wshadow -Wconversion -Wfloat-equal -Wduplicated-cond -Wlogical-op ",
    \ "-ggdb -fsanitize-undefined-trap-on-error -o ."
    \]

" Running shortcuts for CP
autocmd FileType cpp command! -bar Compile w | execute "cd %:p:h" | execute 'term cd %:p:h; gtime -f "\nCompile Time: \%es" ' . join(g:gppComp) . expand("%:r") . " " . expand("%")
autocmd FileType cpp command! Run w | execute 'cd $PWD' | silent execute "!" . join(g:gppComp) . expand("%:r") . " " . expand("%") | silent execute 'term cd %:p:h; gtime -f "\nMem: \%Mkb\nTime: \%es" ./.%:t:r;'
autocmd FileType cpp nnoremap <leader>c <Esc>:Run<CR>

" Open Finder and Terminal TODO quotes around command
command! Term silent exe '! osascript
\ -e "tell application \"iTerm\"                        "
\ -e "  create window with default profile              "
\ -e "      tell current window                         "
\ -e "          tell current session                    "
\ -e "              write text \"cd %:p:h\"             "
\ -e "      end tell                                    "
\ -e "  end tell                                        "
\ -e "end tell                                          "'

]])


-- Unnecessary but so are you
cmd([[

let g:esc_j_lasttime = 0
let g:esc_k_lasttime = 0
function! JKescape(key)
	if a:key=='j' | let g:esc_j_lasttime = reltimefloat(reltime()) | endif
	if a:key=='k' | let g:esc_k_lasttime = reltimefloat(reltime()) | endif
	return abs(g:esc_j_lasttime - g:esc_k_lasttime) <= 0.1 ? "\b\e" : a:key
endfunction
inoremap <expr> j JKescape('j')
inoremap <expr> k JKescape('k')

]])

-- For searching files
cmd([[nnoremap <leader>f <Esc>:Files ~<CR>]])

-- Paste register
cmd([[nmap <leader>p <Plug>yankstack_substitute_older_paste]])
cmd([[nmap <leader>P <Plug>yankstack_substitute_newer_paste]])
