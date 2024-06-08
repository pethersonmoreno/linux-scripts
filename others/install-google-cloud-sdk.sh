#!/bin/bash
# version got in the creation of this script
VERSION=`curl -s https://cloud.google.com/sdk/docs/release-notes | perl -pe 'BEGIN{undef $/;} s/^.*?devsite-article-body clearfix//sg' | perl -pe 'BEGIN{undef $/;} s/^.*?<h2//sg' | head -n 1 | sed -e 's/^[^>]\+>\s*//' | sed -e 's/^\([0-3\.]\+\).\+/\1/' | sed -E 's#^([^ ]+) .+#\1#g'`
echo "Google Cloud SDK last version is ${VERSION}"
ALREADY_EXIST=`type gcloud >/dev/null 2>&1 && echo 1`
if [ "$ALREADY_EXIST" = "1" ]; then
  echo "Already exist a version of gcloud, use the command 'gcloud components update' to update to version ${VERSION} if you need"
  exit 0
fi
MACHINE_NAME=`uname -m`
FILE_TARGZ="google-cloud-sdk-${VERSION}-linux-${MACHINE_NAME}.tar.gz"
curl -L "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${FILE_TARGZ}" > "/tmp/${FILE_TARGZ}"
tar -zxvf "/tmp/${FILE_TARGZ}" -C /tmp
rm "/tmp/${FILE_TARGZ}"
echo "Moving /tmp/google-cloud-sdk to /opt/google/cloud-sdk"
sudo mv /tmp/google-cloud-sdk /opt/google/cloud-sdk
echo "Running install script of cloud-sdk ..."
/opt/google/cloud-sdk/install.sh