#!/bin/bash

set -ex

source create_def_tunnel.sh


set_m_pass


create_def_port_tunnel colo_9015 9015 root 107.175.132.4 9002
create_def_port_tunnel colo_9016 9016 root 107.175.132.4 9003
create_def_port_tunnel colo_9017 9017 root 107.175.132.4 9004
