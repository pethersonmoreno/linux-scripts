#!/bin/sh
sudo tee -a /etc/sysctl.d/99-sysctl.conf <<-EOF
vm.swappiness=10
vm.vfs_cache_pressure=50
vm.dirty_background_bytes=16777216
vm.dirty_bytes=50331648
EOF
