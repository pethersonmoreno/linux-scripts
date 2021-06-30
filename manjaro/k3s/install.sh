#!/bin/sh
export INSTALL_K3S_BIN_DIR=/opt/k3s/bin
sudo mkdir -p $INSTALL_K3S_BIN_DIR
curl -sfL https://get.k3s.io | sh -