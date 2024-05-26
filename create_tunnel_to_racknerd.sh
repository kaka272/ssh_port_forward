#!/bin/bash

set -ex

source create_def_tunnel.sh


set_m_pass


create_def_port_tunnel racknerd_9012 9012 root 107.173.171.62 9002
create_def_port_tunnel racknerd_9013 9013 root 107.173.171.62 9003
create_def_port_tunnel racknerd_9014 9014 root 107.173.171.62 9004
