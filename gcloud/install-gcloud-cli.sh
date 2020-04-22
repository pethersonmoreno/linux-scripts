#!/bin/sh
PACKAGE_VERSION="288.0.0-linux-x86_64"
PACKAGE_NAME="google-cloud-sdk"
cd /tmp
curl "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz" --output "${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz"
tar -zxvf "${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz"
mv $PACKAGE_NAME ~/.$PACKAGE_NAME
mkdir -p ~/.bin
ln -s ~/.$PACKAGE_NAME/bin/gcloud ~/.bin/gcloud
rm "${PACKAGE_NAME}-${PACKAGE_VERSION}.tar.gz"
