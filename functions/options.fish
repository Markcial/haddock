function options --description "Parses an array of flag and value parameters"
  set which $argv[1]
  set args $argv[2..-1]
  set pos (index $which $args)
  echo $args[(math $pos+1)]
end
