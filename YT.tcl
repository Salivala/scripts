#!/usr/bin/expect --
exp_internal 1
debug 0
log_user 0
set search [exec fetch 1]

spawn youtube-viewer $search
expect -re "=>>.*"
puts "before"
set out $expect_out(buffer)
set choice [exec fetch $out]
puts "after"
puts $choice
puts $choice

send -- "$choice \n"
wait

