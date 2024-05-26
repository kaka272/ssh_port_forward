#!/bin/bash


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


read -p "Please enter your password: " password


screen -s bash -L /tmp/racknerd_9003 -dmS racknerd_9003 ssh -L 0.0.0.0:9013:107.173.171.62:9003 root107.173.171.62

wait_for_string_in_log "/tmp/racknerd_9003" "yes" 30

screen -S racknerd_9003 -X stuff "yes$(printf \\r)"

wait_for_string_in_log "/tmp/racknerd_9003" "password:" 30

screen -S racknerd_9003 -X stuff "${password}$(printf \\r)"


