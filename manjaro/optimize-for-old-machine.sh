#!/bin/sh
sudo tee -a /etc/sysctl.d/99-sysctl.conf <<-EOF
vm.min_free_kbytes=262144
vm.swappiness=1
vm.vfs_cache_pressure=80
vm.dirty_background_ratio=5
vm.dirty_ratio=10
EOF

#default
# vm.min_free_kbytes=67584
# vm.swappiness=60
# vm.vfs_cache_pressure=100
# vm.dirty_background_bytes = 0
# vm.dirty_background_ratio = 20
# vm.dirty_bytes = 0
# vm.dirty_ratio = 50
