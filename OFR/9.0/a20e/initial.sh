#!/bin/bash
# Sync

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
HOSTNAME=´cat /etc/hostname´
distro=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release)

~/tmp/telegram -M "⚒ ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy A20e
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a20e

📍 ***Note***: Sync started"
SYNC_START=$(date +"%s")

sudo apt-get update -y
sudo apt-get install bc zip libstdc++6 python gcc clang libssl-dev flex aria2 -y
sudo apt-get install default-jdk android-tools-adb bison build-essential curl flex g++-multilib gcc-multilib gnupg gperf imagemagick lib32readline-dev lib32z1-dev liblz4-tool libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush yasm zlib1g-dev python3 python3-dev kernel-package bzip2 g++-multilib gcc-multilib make git libfdt-dev ccache flex g++-multilib gcc-multilib gnupg gperf imagemagick lib32ncurses5-dev libsdl1.2-dev libssl-dev rsync schedtool squashfs-tools xsltproc openjdk-8-jdk repo byacc m4 libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev python3-pip
sudo curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
sudo chmod a+rx /usr/local/bin/repo

mkdir -p "$THIS_DIR/OrangeFox/"
cd "$THIS_DIR/OrangeFox/"
repo init --depth=1 -u https://gitlab.com/OrangeFox/Manifest.git -b fox_9.0
repo sync --no-repo-verify -c --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j16
git clone --depth 1 https://github.com/a2XX-dev/android_device_samsung_a20e -b fox-9.0-new device/samsung/a20e
mv device/samsung/a20e/*.sh .
chmod +x build_ofox.sh

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
SYNC_START=$(date +"%s")
~/tmp/telegram -M "⚒ ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy A20e
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a20e

📍 ***Note***: Sync completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
