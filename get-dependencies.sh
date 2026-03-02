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
# Site blocks github, added the mirror inside the PKGBUILD since had to patch with sed multiple lines and it wasn't working
make-aur-package

# If the application needs to be manually built that has to be done down here
