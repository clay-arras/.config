local api = vim.api
local bo = vim.bo


-- Open Finder and Terminal TODO quotes around command
-- NOT WORKING TODO
api.nvim_create_user_command('Terminal', [[execute '! osascript
    \ -e "tell application \"iTerm\"                        "
    \ -e "  create window with default profile              "
    \ -e "      tell current window                         "
    \ -e "          tell current session                    "
    \ -e "              write text \"cd %:p:h\"             "
    \ -e "      end tell                                    "
    \ -e "  end tell                                        "
    \ -e "end tell                                          "'
]], {})

-- Running shortcuts for CP
-- NOT WORKING TODO
if bo.filetype == 'cpp' then

    api.nvim_create_user_command('Compile', [[w | execute 'cd $PWD' | silent execute 'term cd %:p:h;]]                              ..
                                            [[gtime -f "\nCompile Time: \%es" g++-12 -std=c++17 -D LOCAL ]]                         ..
                                            [[-I /usr/local/include -Wl,-stack_size,0x10000000 -O2 ]]                               ..
                                            [[-Wall -Wextra -Wshadow -Wconversion -Wfloat-equal -Wduplicated-cond -Wlogical-op ]]   ..
                                            [[-ggdb -fsanitize-undefined-trap-on-error -o .%:r %;']], {})

    api.nvim_create_user_command('Run', [[execute 'cd $PWD' | silent execute "!g++-12 -std=c++17 -D LOCAL ]]                    ..
                                        [[-I /usr/local/include -Wl,-stack_size,0x10000000 -O2 ]]                               ..
                                        [[-Wall -Wextra -Wshadow -Wconversion -Wfloat-equal -Wduplicated-cond -Wlogical-op ]]   ..
                                        [[-ggdb -fsanitize-undefined-trap-on-error -o .%:r %;" | ]]                             ..
                                        [[silent execute 'term cd %:p:h; gtime -f "\nMem: \%Mkb\nTime: \%es" ./.%:r;' ]], {})
end

-- TODO GET CHORD JK WORKING
