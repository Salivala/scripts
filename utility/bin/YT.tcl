#!/usr/bin/expect --
set search [exec fetch 1]
puts $search

eval spawn youtube-viewer --player=mpv $search
expect -re "=>>.*"
set out $expect_out(buffer)
set choice [exec fetch $out $out]

send -- "$choice \n"
wait

