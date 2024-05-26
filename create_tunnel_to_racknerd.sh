#!/bin/bash

set -ex

source create_def_tunnel.sh


if [[ -n "${!machine_password}" ]]; then
    echo "machine_password 变量存在"
else
    read -s -p "Please enter your password: " machine_password
fi


create_def_port_tunnel racknerd_9012 9012 root 107.173.171.62 9002
create_def_port_tunnel racknerd_9013 9013 root 107.173.171.62 9003
create_def_port_tunnel racknerd_9014 9014 root 107.173.171.62 9004
