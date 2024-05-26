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

set_m_pass() {
    set +ex
    if [[ "${machine_password}" != "" ]]; then
        echo "machine_password 变量存在"
    else
        read -s -p "Please enter your password: " machine_password
    fi
    set -ex
}

create_def_port_tunnel() {
    local screen_name="$1"
    local local_port="$2"
    local remote_user="$3"
    local remote_host="$4"
    local remote_port="$5"
    local screen_log="/tmp/${screen_name}.log"

    set_m_pass

    rm -fr $screen_log

    screen -ls | grep Detached | grep ${screen_name} | cut -d. -f1 | awk '{print $1}' | xargs kill || echo done
    screen -ls || echo done

    screen -s bash -dmS $screen_name -L -Logfile $screen_log ssh -L 0.0.0.0:${local_port}:${remote_host}:${remote_port} ${remote_user}@${remote_host} -N

    set +ex
    wait_for_string_in_log "$screen_log" "yes/no" 30
    if [[ $? -eq 0 ]]; then
        screen -S $screen_name -X stuff "yes$(printf \\r)"
    fi
    set -ex

    wait_for_string_in_log "$screen_log" "password:" 30

    set +ex
    screen -S $screen_name -X stuff "${machine_password}$(printf \\r)"
    set -ex
}

echo 'useage: create_def_port_tunnel screen_name local_port remote_user remote_host remote_port'
echo 'example: create_def_port_tunnel test 9021 root 107.173.171.62 9002'
echo 'onecmd: screen -s bash -dmS $screen_name -L -Logfile $screen_log ssh -L 0.0.0.0:${local_port}:${remote_host}:${remote_port} ${remote_user}@${remote_host} -N'
