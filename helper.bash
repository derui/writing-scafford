#!/bin/bash

CONTENTS_SERVER=hugo
DRAWIO_SERVER=draw-io

set -eu
if [ -x greadlink ]; then
    current_dir=$(dirname $(greadlink -f $0))
else
    current_dir=$(dirname $(readlink -f $0))
fi
USER_ID=$(id -u $USER)
USER_GROUP=$(id -g $USER)

# initialize anything
init() {

    echo "Build docker image to writing"
    docker build -t hugo-base ${current_dir}/.dockerfiles/hugo-base
    docker build -t draw-io ${current_dir}/.dockerfiles/draw-io
    echo "Done."

}

# launch contents server.
new() {
    echo "Create new skeleton for static site."

    docker run --name=$CONTENTS_SERVER --rm -v ${current_dir}:/documents -it \
         -e USER_ID=$USER_ID -e USER_GROUP=$USER_GROUP \
         hugo-base /bin/bash -l -c 'hugo new site ./site && find ./site -exec chown $USER_ID:$USER_GROUP {} \; && mv site/* . && rm -rf site '
}

# launch contents server.
start() {
    echo "Launch server hosted generated files."

    stop

    docker run --name=$CONTENTS_SERVER -v ${current_dir}:/documents -d \
         -e USER_ID=$USER_ID -e USER_GROUP=$USER_GROUP \
         -p 1313:1313 \
         hugo-base /bin/bash -l -c 'ruby /watcher.rb && sleep 2; hugo server --watch --bind 0.0.0.0'

    docker run --name=$DRAWIO_SERVER -d -p 32000:8000 draw-io
}

stop() {
    echo "Stop serving containers"

    for c in $CONTENTS_SERVER $DRAWIO_SERVER; do
        if [[ `docker ps -f "name=$c" -qa | grep -c ""` -gt 0 ]]; then
            docker rm -f $c
        else
            echo "Not found running container named $c"
        fi
    done

}

build() {
    echo "Build document"

    docker run --name=${CONTENTS_SERVER} -v ${current_dir}:/documents --rm hugo-base /bin/bash -l -c \
         "hugo && find public -exec chown $USER_ID:$USER_GROUP {} \; "
}

subcommand() {
    _ls_available_commands() {
        local fs="$(compgen -A function)"

        join <(echo "$fs") <(echo "$__DEFAULT_FUNCTIONS") | grep -v '^_'
    }

    _show_help() {
        echo 'Available commands'
        _ls_available_commands | awk '{print "-", $0}'
        exit 1
    }

    if [ -n "$(_ls_available_commands | awk -v f=$1 'f==$0')" ]; then
        "$@"
    else
        _show_help
    fi
}

__DEFAULT_FUNCTIONS="$(compgen -A function)"

subcommand "$@"
