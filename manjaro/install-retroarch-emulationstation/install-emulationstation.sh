#!/bin/bash
CURRENT_DIRECTORY=`pwd`
TMP_DIRECTORY=/tmp
../helpers/install-arch-package.sh emulationstation
rm -rf ~/.emulationstation # remove old configuration
mkdir -p ~/.emulationstation # created directory to configuration again
cd $TMP_DIRECTORY
curl -L https://github.com/RetroPie/es-theme-carbon/archive/master.tar.gz --output es-theme-carbon.tar.gz
tar -zxvf es-theme-carbon.tar.gz
mkdir -p ~/.emulationstation/themes
mv es-theme-carbon-master ~/.emulationstation/themes/carbon
rm es-theme-carbon.tar.gz
cd $CURRENT_DIRECTORY
cp es_systems.cfg ~/.emulationstation/
cp es_input.cfg ~/.emulationstation/