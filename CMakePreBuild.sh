#!/usr/bin/env bash
# this script is automatically run from CMakeLists.txt

BUILD_ROOT=$PWD
BUILD_INTERACTIVE=$1

echo "[Pre-build]  dependency installer script running..."
echo "[Pre-build]  build root directory: $BUILD_ROOT"
echo "[Pre-build]  build interactive:    $BUILD_INTERACTIVE"
echo " "


# break on errors
#set -e


# install packages only if apt is available
if hash apt 2>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y dialog
    sudo apt-get install -y libglew-dev glew-utils libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libglib2.0-dev
    sudo apt-get install -y libopencv-calib3d-dev libopencv-dev
    # libgstreamer0.10-0-dev libgstreamer-plugins-base0.10-dev libxml2-dev
    sudo apt-get update
fi


# run the model downloader
./download-models.sh $BUILD_INTERACTIVE


# run the pytorch installer
./install-pytorch.sh $BUILD_INTERACTIVE


echo "[Pre-build]  Finished CMakePreBuild script"
