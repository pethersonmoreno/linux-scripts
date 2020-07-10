#!/bin/bash
echo "Finding last version of terraform"
VERSION=`curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | sed -e 's/^\s*"tag_name"\s*:\s*"v\?\([^"]\+\).\+/\1/'`
CURRENT_VERSION=`type terraform >/dev/null 2>&1 && terraform --version | grep Terraform | sed -e 's/Terraform\s*v\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/'`
if [ "$CURRENT_VERSION" = "$VERSION" ]; then
  echo "Your terraform version is already latest ${VERSION}"
  exit 0
fi
if [ ! -z "$CURRENT_VERSION" ]; then
  echo "Your terraform current version is ${CURRENT_VERSION}"
fi
echo "terraform last version is ${VERSION}"
FILE_ZIP="terraform_${VERSION}_linux_amd64.zip"
curl -L "https://releases.hashicorp.com/terraform/${VERSION}/${FILE_ZIP}" > "/tmp/${FILE_ZIP}"
unzip "/tmp/${FILE_ZIP}" -d /tmp
sudo mv /tmp/terraform /usr/local/bin/
rm "/tmp/${FILE_ZIP}"