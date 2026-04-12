#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=latest
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export DESKTOP=/usr/share/applications/tibia.desktop
export DEPLOY_QT=1
export QT_DIR=qt6
export DEPLOY_VULKAN=1

# Deploy dependencies
#quick-sharun ./AppDir/bin/Tibia ./AppDir/bin/client ./AppDir/bin/BattlEye/BEClient.so /usr/bin/env
quick-sharun ./AppDir/bin/Tibia /usr/lib/libnss3.so /usr/bin/env

# Additional changes can be done in between here
# this app has problems with other locales breaking physics
echo 'LC_ALL=C.UTF-8' >> ./AppDir/.env

cc -shared -fPIC -O2 -o ./AppDir/lib/execve-sharun-hack.so execve-sharun-hack.c -ldl
echo 'execve-sharun-hack.so' >> ./AppDir/.preload
echo 'export ANYLINUX_EXECVE_WRAP_PATHS="$DATADIR"' >> ./AppDir/bin/execve-wrap-path.hook

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
