#!/bin/bash

sudo iptables -I PREROUTING -t nat  -p udp --dport 9019 -j DNAT --to 107.175.132.4:5170
sudo iptables -t nat -A POSTROUTING -j MASQUERADE   # 数据回来时需要执行的操作
sudo iptables -I FORWARD -p udp -d 107.175.132.4 --dport 5170 -j ACCEPT
