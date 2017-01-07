#!/bin/bash

if [ $(sudo docker images | grep -c "draw-io") -gt 0 ]; then
    sudo docker rmi draw-io
fi

sudo docker build -t draw-io .
