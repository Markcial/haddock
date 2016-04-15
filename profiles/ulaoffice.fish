function reload_network --description "Reloads the whole network via docker-compose"
    set -x NETWORK_FOLDER ../docker-files/network
    builtin cd $NETWORK_FOLDER
    command docker-compose stop
    command docker-compose rm -f -v --all webserver_office_api webserver_office_front webserver_office_back webserver_chango webserver_trucks webserver_pim
    command docker-compose up -d
end

function unit-tests --description "Phpunit tests"
    docker-shell www bin/phpunit -c app --stop-on-error --testsuite=unit-tests
end

function functional-tests --description "Functional testing"
    docker-shell www bin/phpunit -c app --stop-on-error --testsuite=functional-tests
end

function integration-tests --description "Integration testing"
    docker-shell www bin/behat --format progress --profile=integration --tags=~wip
    docker-shell www bin/behat --format progress --profile=web --tags=~wip
end

function run-tests --description "Runs the complete test suite"
    unit-tests
    functional-tests
    integration-tests
end

function copy_prod_db --description "Restores database from production server"
  set -gx mysql_prod_passwd (vault get mysql-prod-passwd)
  command ssh bo01 "mysqldump -uulaoffice -p(echo $mysql_prod_passwd) ulaoffice | gzip -c" | gunzip | dsh mariadb mysql -uroot -pulabox ulaoffice
end

function docker-pgsql --description "Docker pgsql shell session"
    set -x pgsql_user pim
    set -x pgsql_query
    if contains \"-u\" $argv
      set -x pgsql_user (options '-u' $argv)
    end
    if contains \"-q\" $argv
      set pgsql_query (options '-q' $argv)
    end
    docker-shell postgres psql -U $pgsql_user (if test -n "$pgsql_query"; echo '-c ' $pgsql_query; end)
end

function docker-mysql --description "Docker mysql shell session"
    docker-shell mariadb "TERM=xterm mysql -uroot -pulabox ulaoffice"
end
