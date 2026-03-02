#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    glu    \
    python

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
# Site blocks github
PRE_BUILD_CMDS="sed -i 's|https://static.tibia.com/download/tibia.x64.tar.gz|https://api.rv.pkgforge.dev/https://static.tibia.com/download/tibia.x64.tar.gz|' ./PKGBUILD" make-aur-package tibia

# If the application needs to be manually built that has to be done down here
