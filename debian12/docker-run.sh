#!/bin/bash

apt update
apt install -y git

cd /repos && git clone https://github.com/Linuxfabrik/monitoring-plugins.git
cd /repos/monitoring-plugins/build/debian12
chmod +x /repos/monitoring-plugins/build/debian12/build.sh
./build.sh
