#!/bin/bash
echo "Finding last version of packer"
VERSION=`curl -s https://api.github.com/repos/hashicorp/packer/releases/latest | grep tag_name | sed -e 's/^\s*"tag_name"\s*:\s*"v\?\([^"]\+\).\+/\1/'`
CURRENT_VERSION=`type packer >/dev/null 2>&1 && packer --version`
if [ "$CURRENT_VERSION" = "$VERSION" ]; then
  echo "Your packer version is already latest ${VERSION}"
  exit 0
fi
if [ ! -z "$CURRENT_VERSION" ]; then
  echo "Your packer current version is ${CURRENT_VERSION}"
fi
echo "packer last version is ${VERSION}"
ARCHTECTURE=amd64
FILE_ZIP="packer_${VERSION}_linux_${ARCHTECTURE}.zip"
curl -L "https://releases.hashicorp.com/packer/${VERSION}/${FILE_ZIP}" > "/tmp/${FILE_ZIP}"
unzip "/tmp/${FILE_ZIP}" -d /tmp
sudo mv /tmp/packer /usr/local/bin/
rm "/tmp/${FILE_ZIP}"