#!/bin/bash
#TODO
#https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz
curl -L "" > "/tmp/${FILE_TARGZ}"
tar -xvf "/tmp/${FILE_TARGZ}" -C /tmp
rm "/tmp/${FILE_TARGZ}"
