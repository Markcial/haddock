#!/usr/bin/env fish

set folder (dirname (status -f))

set -gx scoreboard

function mtime
  command date +%s%3N
end

function draw_scoreboard
  echo -n $scoreboard \r
end

function test_details
  set time (math (mtime) - $chrono_start)
  set time (echo "scale=4;$time/1000" | bc)
  echo ""
  echo -n Executed (count $scoreboard) tests in $time seconds.
end

function success --on-event success
  set -gx scoreboard $scoreboard .
  draw_scoreboard
end

function fail --on-event fail
  set -gx scoreboard $scoreboard F
end

set -gx chrono_start (mtime)

for f in (ls $folder/*_test.fish)
  . $f
end

test_details

echo ""
