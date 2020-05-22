#!/bin/bash
PACKAGE_NAME=teamviewer-official
cd /tmp
teamviewerLinkDownload=`curl "https://download.teamviewer.com/download/linux/teamviewer_amd64.deb" | grep "Object moved to" | sed -E "s/.*href=\"([^\"]+)\".*/\1/"`
teamviewerOfficialDomainDownload=`echo $teamviewerLinkDownload | sed -E "s/(.*https?:\/\/)([^\/]+)(\/download\/linux\/version.+)/\2/"`
git clone https://aur.archlinux.org/teamviewer.git "$PACKAGE_NAME"
cd "$PACKAGE_NAME"
domainToReplace=`cat PKGBUILD | grep source_x86_64 | sed -E "s/(.*https?:\/\/)([^\/]+)(\/download\/linux\/version.+)/\2/"`
regexReplace="s/$domainToReplace/$teamviewerOfficialDomainDownload/"
sed -i -E $regexReplace PKGBUILD
makepkg -s
PACKAGE_INSTALL=`ls | grep .tar.xz | grep -v orig`
sudo pacman -U $PACKAGE_INSTALL
cd ..
rm -rf "${PACKAGE_NAME}"
sudo systemctl enable teamviewerd
sudo systemctl start teamviewerd