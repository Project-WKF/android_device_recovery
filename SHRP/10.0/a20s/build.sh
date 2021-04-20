#!/bin/bash
source ~/tmp/config.sh

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
HOSTNAME=´cat /etc/hostname >/dev/null´
distro=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release)

~/tmp/telegram -M "⚒ ***Recovery***: [SHRP](https://github.com/SHRP) (3.1)
📱 ***Device***: Samsung Galaxy A20s
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a20s

📍 ***Note***: Building Recovery started"
SYNC_START=$(date +"%s")

cd "$THIS_DIR/SHRP"

export ALLOW_MISSING_DEPENDENCIES=true
source build/envsetup.sh
lunch omni_a20s-eng
mka recoveryimage

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
if [ -f "$THIS_DIR/SHRP/out/target/product/a20s/SHRP_v*.zip" ]; then
~/tmp/telegram -M "SHRP (v3.1) - A20s (a20s)
***📦 Building completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds***"
   # Output
~/tmp/telegram -M "📦 ***Recovery***: [SHRP](https://github.com/SHRP) (3.1)
📱 ***Device***: Samsung Galaxy A20s
⚙️ ***Device codename***: a20s
🎈 ***Output***: Recovery ZIP Flasheable

📍 ***Tags***: #a20s #shrp #3.1 #stable"
~/tmp/telegram -f "$THIS_DIR/SHRP/out/target/product/a20s/SHRP_v*.zip" ""

   # Output for: Image
~/tmp/telegram -M "📦 ***Recovery***: [SHRP](https://github.com/SHRP) (3.1)
📱 ***Device***: Samsung Galaxy A20s
⚙️ ***Device codename***: a20s
🎈 ***Output***: Recovery Image

📍 ***Tags***: #a20s #shrp #3.1 #stable"
~/tmp/telegram -f "$THIS_DIR/SHRP/out/target/product/a20s/recovery.img" ""

  # Output for: Boot image
~/tmp/telegram -M "📦 ***Recovery***: [SHRP](https://github.com/SHRP) (3.1)
📱 ***Device***: Samsung Galaxy A20s
⚙️ ***Device codename***: a20s
🎈 ***Output***: Boot Image

📍 ***Tags***: #a20s #shrp #3.1 #stable"
~/tmp/telegram -f "$THIS_DIR/SHRP/out/target/product/a20s/boot.img" ""
else
   # Error in build
~/tmp/telegram -M "⚒ ***Recovery***: [SHRP](https://github.com/SHRP) (3.1)
📱 ***Device***: Samsung Galaxy A20s
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a20s

❌ ***Note***: Building completed unsuccessfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
fi

curl --data parse_mode=HTML --data chat_id=$CHATS --data sticker=CAADBQADGgEAAixuhBPbSa3YLUZ8DBYE --request POST https://api.telegram.org/bot$TOKEN/sendSticker
