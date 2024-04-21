#!/bin/bash

current_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $current_path

docker run -d -p 9004:1314 kaka272/unisoc:ss0.1

ssh -R 9003:127.0.0.1:9004  -N root@116.205.238.201
