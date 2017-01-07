#!/bin/sh

cd /draw-io/war

trap 'exit 0' INT

python3 -m http.server 8000
