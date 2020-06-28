#!/bin/sh
base=https://github.com/docker/machine/releases/download/v0.16.0
curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine
chmod +x /tmp/docker-machine
sudo mv /tmp/docker-machine /usr/local/bin/docker-machine