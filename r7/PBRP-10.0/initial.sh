#!/bin/bash
# Sync

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
HOSTNAME=´cat /etc/hostname´
distro=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release)

~/tmp/telegram -M "⚒ ***Recovery***: [Pitch Black Recovery Project](https://pitchblackrecovery.com/) (3.0.0)
📱 ***Device***: Samsung Galaxy Note 10 Lite
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: r7

📍 ***Note***: Sync started"
SYNC_START=$(date +"%s")

sudo apt-get update -y
sudo apt-get install default-jdk android-tools-adb bison build-essential curl flex g++-multilib bc zip libstdc++6 python gcc clang libssl-dev flex aria2 gcc-multilib gnupg gperf imagemagick lib32readline-dev lib32z1-dev liblz4-tool libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush yasm zlib1g-dev python3 python3-dev kernel-package bzip2 g++-multilib gcc-multilib make git libfdt-dev ccache flex g++-multilib gcc-multilib gnupg gperf imagemagick lib32ncurses5-dev libsdl1.2-dev libssl-dev rsync schedtool squashfs-tools xsltproc openjdk-8-jdk repo byacc m4 libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev python3-pip
sudo curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
sudo chmod a+rx /usr/local/bin/repo

mkdir -p "$THIS_DIR/PBRP/"
cd "$THIS_DIR/PBRP/"
repo init --depth 1 -u git://github.com/PitchBlackRecoveryProject/manifest_pb.git -b android-10.0
repo sync --no-repo-verify -c --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j16
git clone --depth 1 https://github.com/yukosky/android_device_samsung_r7 -b pbrp-10.0 device/samsung/r7

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
SYNC_START=$(date +"%s")
~/tmp/telegram -M "⚒ ***Recovery***: [Pitch Black Recovery Project](https://pitchblackrecovery.com/) (3.0.0)
📱 ***Device***: Samsung Galaxy Note 10 Lite
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: r7

📍 ***Note***: Sync completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"