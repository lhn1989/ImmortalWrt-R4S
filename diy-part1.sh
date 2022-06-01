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

# aliyundrive var
ALIYUNDRIVE_DIR="aliyundrive"
ALIYUNDRIVE_GIT="https://github.com/messense/aliyundrive-fuse.git"
ALIYUNDRIVE_SRC="openwrt"
ALIYUNDRIVE_BRANCH="main"

# git shallow clone
shallowClone(){
    mkdir -p /workdir/$1
    cd /workdir/$1
    git init
    git remote add origin $2
    git config core.sparsecheckout true
    echo $3 >> .git/info/sparse-checkout
    git pull --depth 1 origin $4
}

# Print Commands
set -x

# Add aliyundrive
shallowClone $ALIYUNDRIVE_DIR $ALIYUNDRIVE_GIT $ALIYUNDRIVE_SRC $ALIYUNDRIVE_BRANCH
echo "src-link aliyundrive /workdir/$ALIYUNDRIVE_DIR/$ALIYUNDRIVE_SRC" >> /workdir/openwrt/feeds.conf.default
