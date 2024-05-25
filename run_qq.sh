#!/bin/bash

current_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $current_path

docker run -d -p 9004:1314 kaka272/unisoc:ss0.1

ssh -R 9003:127.0.0.1:9004  -N ubuntu@106.54.54.7

#config 106.54.54.7 /etc/ssh/sshd_config
#AllowTcpForwarding yes
#GatewayPorts yes


# curl -x socks5://localhost:8089 http://www.google.com
# ssh -D 0.0.0.0:8089 -N 107.175.132.4 
# ssh -L 0.0.0.0:9013:107.173.171.62:9003 root@107.173.171.62 -N
# 远端转发相当于 socks5
