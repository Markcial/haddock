bind \cl "commandline 'docker ps -a'"
bind \cr "commandline 'docker run'"
bind \ce "commandline 'docker exec -it'"
bind \cf "commandline 'docker rm (docker ps -a -q)'"
bind \cu "commandline 'docker-compose up -d'"
bind \cy "commandline 'docker-compose stop; and docker-compose rm -f -v --all; and docker-compose up -d'"