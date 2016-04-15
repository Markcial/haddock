#!/usr/bin/env fish

function index --description "Searches elements in a collection of items"
  set pos 1
  for a in $argv[2..-1]
    if test $a = $argv[1]
      echo $pos
      return 0
    end
    set pos (math $pos+1)
  end
  return 1
end
