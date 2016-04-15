function docker-find --description "Finds a container by hostname"
  set hostname $argv[1]
  set label "$hostname.ulabox.rocks"
  echo (docker ps -f="label=traefik.frontend.value=$label" -q)
end
