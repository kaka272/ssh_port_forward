#!/bin/bash

docker pull probezy/cpolar
docker run -d -p 9004:1314 kaka272/unisoc:ss0.1
echo 'input token'
read token
cmd="cpolar authtoken YjI4NzQxY2UtOWQyYy${token}MzQ2LTk5ZTQtZDM4ZDJmY2U5NDIx"
docker run -id --network host --name cpolar probezy/cpolar bash -c "${cmd} ; cpolar tcp 9004"
