#!/bin/bash

set -ex

source create_def_tunnel.sh


if [[ "${machine_password}" != "" ]]; then
    echo "machine_password 变量存在"
else
    read -s -p "Please enter your password: " machine_password
fi


create_def_port_tunnel colo_9015 9015 root 107.175.132.4 9002
create_def_port_tunnel colo_9016 9016 root 107.175.132.4 9003
create_def_port_tunnel colo_9017 9017 root 107.175.132.4 9004
