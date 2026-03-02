#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    gendesk \
    glu     \
    python

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
# Site blocks github
PRE_BUILD_CMDS="sed -i 's|https://static.tibia.com\"|https://api.rv.pkgforge.dev/https://static.tibia.com\")|; /agreement.php/d; /html2text/d; s/sha256sums=(.*/sha256sums=(\"SKIP\")/ ; /            '\''SKIP'\'')/d' ./PKGBUILD" make-aur-package tibia

# If the application needs to be manually built that has to be done down here
