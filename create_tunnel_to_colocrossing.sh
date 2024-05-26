#!/bin/bash

set -ex

wait_for_string_in_log() {
    local log_file="$1"
    local target_string="$2"
    local timeout=$3
    local start_time=$(date +%s)

    while true; do
        if grep -q "$target_string" "$log_file"; then
            echo "发现指定字符！"
            return 0  # 返回成功
        else
            current_time=$(date +%s)
            elapsed_time=$((current_time - start_time))
            if [ $elapsed_time -ge $timeout ]; then
                echo "超时！未能找到指定字符。"
                return 1  # 返回失败
            fi
            sleep 1  # 每秒检查一次日志文件
        fi
    done
}


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


read -s -p "Please enter your password: " machine_password


create_def_port_tunnel() {
    local screen_name="$1"
    local local_port="$2"
    local remote_port="$3"
    local screen_log="/tmp/${screen_name}.log"

    rm -fr $screen_log

    screen -s bash -dmS $screen_name -L -Logfile $screen_log ssh -L 0.0.0.0:${local_port}:107.175.132.4:${remote_port} root@107.175.132.4

    wait_for_string_in_log "$screen_log" "yes/no" 30
    screen -S $screen_name -X stuff "yes$(printf \\r)"

    wait_for_string_in_log "$screen_log" "password:" 30
    screen -S $screen_name -X stuff "${password}$(printf \\r)"



create_def_port_tunnel "colo_9003" 9013 9003


