#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    alsa-lib \
    gendesk         \
    glu             \
    kvantum         \
    libxml2-legacy  \
    lxqt-qtplugin   \
    python          \
    qt6-base        \
    qt6-declarative \
    qt6-scxml       \
    qt6-wayland     \
    qt6-webengine   \
    qt6ct

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#PRE_BUILD_CMDS='sed -i "s|https://static.tibia.com|https://pkgforge.dev|" ./PKGBUILD' make-aur-package tibia

# If the application needs to be manually built that has to be done down here
echo "Getting app..."
echo "---------------------------------------------------------------"
mkdir -p ./AppDir/bin
wget https://api.rv.pkgforge.dev/https://static.tibia.com/download/tibia.x64.tar.gz
tar -xvf tibia.x64.tar.gz --strip-components=1
rm -f *.tar.gz
mv -v Tibia ./AppDir/bin
