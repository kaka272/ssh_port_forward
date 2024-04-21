#!/bin/bash

current_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $current_path

docker build -t ss:0.1 -f ssDockerfilePyInDocker . 

docker run -d -p 9004:1314 ss:0.1
