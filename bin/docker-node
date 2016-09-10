#!/usr/bin/env bash
cmd="$@"
docker run --rm -it -w $PWD -v $PWD:$PWD node bash -c "npm install && $cmd"
