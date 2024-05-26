#!/bin/bash

set -x


if [[ "${machine_password}" != "" ]]; then
    echo "machine_password 变量存在"
else
    read -s -p "Please enter your password: " machine_password
fi


if command -v apt &> /dev/null; then
    echo "Using apt to install screen"
    sudo apt update -y
    sudo apt install screen -y
elif command -v yum &> /dev/null; then
    echo "Using yum to install screen"
    sudo yum check-update -y
    sudo yum install screen -y
else
    echo "Neither apt nor yum found"
fi


source create_tunnel_to_racknerd.sh
source create_tunnel_to_colocrossing.sh
