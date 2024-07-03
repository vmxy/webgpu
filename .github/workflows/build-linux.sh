#!/bin/bash
apt update -y
apt install -y \
    git curl wget \
    clang \
    libosmesa6-dev \
    libvulkan-dev \
    libxcursor-dev \
    libxi-dev \
    libxinerama-dev \
    libxrandr-dev \
    libxxf86vm-dev 

#git clone https://github.com/vmxy/webgpu.git
#git clone https://github.com/vmxy/dawn.git webgpu/dawn
#git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git webgpu/depot_tools

cd webgpu
export PATH=`pwd`/depot_tools:$PATH
cd dawn

echo " Add tools for dawn"
cp scripts/standalone.gclient .gclient
gclient sync 
ln -s ../depot_tools/gn ././buildtools/linux64/gn/gn
ln -s ../depot_tools/gn.py ././buildtools/linux64/gn/gn.py
gn gen out/Shared --target_cpu="x64" --args="is_component_build=true is_debug=false is_clang=true"
ninja -C out/Shared


cd ../
Version=0.2.0
printf `pwd`/dawn > PATH_TO_DAWN
npm install
npm run all --dawnversion=$Version
ls -l generated/${Version}/*/build/Release