#!/bin/bash
apt-get update -y
curl https://raw.githubusercontent.com/james-cole2015/urban-sniffle/main/ws_bootstrap.sh > ws_bootstrap.sh
chmod +x ws_bootstrap.sh
./ws_bootstrap.sh