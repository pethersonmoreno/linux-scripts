#!/bin/sh
export HELM_INSTALL_DIR=/opt/helm/bin
sudo mkdir -p $HELM_INSTALL_DIR
export PATH="${HELM_INSTALL_DIR}:${PATH}"
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
echo -ne "\n\n# Helm bin directory" >> ~/.bashrc
echo -ne "\nexport PATH=\"${HELM_INSTALL_DIR}:\${PATH}\"" >> ~/.bashrc