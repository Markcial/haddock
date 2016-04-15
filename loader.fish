#!/usr/bin/env fish

set root (dirname (status -f))
# including misc functions
for f in (ls $root/functions/*.fish)
  echo Including function $f
  source $f
end

function profile
  set name $argv[1]
  set file "$root/profiles/$name.fish"
  echo Loading profile with name $name
  echo "Including file $file"
  source $file
end
