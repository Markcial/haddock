function docker-shell --description 'Docker shell, enters any of the available boxes via docker exec'

  set -gx hostname $argv[1]
  if test "$hostname" -eq ""
    echo 'Missing argument. defaulting to (www)'
    set -gx hostname www
  end

  set extra_args
  if test (count $argv) -gt 1
    set extra_args -c "$argv[2..-1]"
  end

  command docker exec -i(if isatty; echo t;end) (docker-find $hostname) bash $extra_args
end

abbr -a dsh docker-shell
