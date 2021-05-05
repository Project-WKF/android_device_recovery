#!/bin/bash
# Sync

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
HOSTNAME="$(whoami)"
distro=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release)

~/tmp/telegram -M "⚒ ***Recovery***: [TWRP](https://github.com/TeamWin) (10.0)
📱 ***Device***: Samsung Galaxy A21s
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a21s

📍 ***Note***: Sync started"
SYNC_START=$(date +"%s")

sudo apt-get update -y
sudo apt-get install default-jdk android-tools-adb bison build-essential curl flex g++-multilib bc zip libstdc++6 python gcc clang libssl-dev flex aria2 gcc-multilib gnupg gperf imagemagick lib32readline-dev lib32z1-dev liblz4-tool libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush yasm zlib1g-dev python3 python3-dev kernel-package bzip2 g++-multilib gcc-multilib make git libfdt-dev ccache flex g++-multilib gcc-multilib gnupg gperf imagemagick lib32ncurses5-dev libsdl1.2-dev libssl-dev rsync schedtool squashfs-tools xsltproc openjdk-8-jdk repo byacc m4 libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev python3-pip
sudo curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
sudo chmod a+rx /usr/local/bin/repo

mkdir -p "$THIS_DIR/TWRP/"
cd "$THIS_DIR/TWRP/"
repo init --depth=1 -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-10.0
repo sync -c -q --force-sync --no-tags --no-clone-bundle --optimized-fetch --prune -j16
git clone https://github.com/a2XX-dev/android_device_samsung_a21s -b twrp-10.0 device/samsung/a21s

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
SYNC_START=$(date +"%s")
~/tmp/telegram -M "⚒ ***Recovery***: [TWRP](https://github.com/TeamWin) (10.0)
📱 ***Device***: Samsung Galaxy A21s
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a21s

📍 ***Note***: Sync completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
