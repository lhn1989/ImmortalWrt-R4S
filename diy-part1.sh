#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# openclash var
OPENCLASH_DIR="openclash"
OPENCLASH_GIT="https://github.com/vernesong/OpenClash.git"
OPENCLASH_SRC="luci-app-openclash"
OPENCLASH_BRANCH="dev"

# aliyundrive var
ALIYUNDRIVE_DIR="aliyundrive"
ALIYUNDRIVE_GIT="https://github.com/messense/aliyundrive-fuse.git"
ALIYUNDRIVE_SRC="openwrt"
ALIYUNDRIVE_BRANCH="main"

# git shallow clone
shallowClone(){
    mkdir $1
    cd $1
    git init
    git remote add origin $2
    git config core.sparsecheckout true
    echo $3 >> .git/info/sparse-checkout
    git pull --depth 1 origin $4
}

# Print Commands
set -x

# Add SSR
echo "src-git helloworld https://github.com/fw876/helloworld" >>feeds.conf.default

# Add aliyundrive
shallowClone $ALIYUNDRIVE_DIR $ALIYUNDRIVE_GIT $ALIYUNDRIVE_SRC $ALIYUNDRIVE_BRANCH
echo "src-link aliyundrive /workdir/openwrt/$ALIYUNDRIVE_DIR/openwrt" >> /workdir/openwrt/feeds.conf.default

# Add openclash
shallowClone $OPENCLASH_DIR $OPENCLASH_GIT $OPENCLASH_SRC $OPENCLASH_BRANCH
cp $OPENCLASH_DIR/$OPENCLASH_SRC /workdir/openwrt/package/
pwd > 1
cd ..
# rm -rf openclash
