#!/bin/bash
source ~/tmp/config.sh

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
HOSTNAME=´cat /etc/hostname >/dev/null´
distro=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release)

~/tmp/telegram -M "⚒ ***Recovery***: [Pitch Black Recovery Project](https://pitchblackrecovery.com/) (3.0.0)
📱 ***Device***: Samsung Galaxy A50
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a50dd

📍 ***Note***: Building Recovery started"
SYNC_START=$(date +"%s")

export ALLOW_MISSING_DEPENDENCIES=true && export LC_ALL=C

cd "$THIS_DIR/PBRP"

. build/envsetup.sh
lunch omni_a50dd-eng
# change the 8 for your total cores, mine is 8
mka recoveryimage -j8

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
if [ -f "$THIS_DIR/PBRP/out/target/product/a50dd/recovery.img" ]; then
   # Output for a nice build lol
~/tmp/telegram -M "⚒ ***Recovery***: [Pitch Black Recovery Project](https://pitchblackrecovery.com/) (3.0.0)
📱 ***Device***: Samsung Galaxy A50
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a50dd

✅ ***Note***: Building completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

   # Output
   # Output for: Image
~/tmp/telegram -M "📦 ***Recovery***: [Pitch Black Recovery Project](https://pitchblackrecovery.com/) (3.0.0)
📱 ***Device***: Samsung Galaxy A50
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a50dd

📍 ***Tags***: #a50dd #pbrp #10"
~/tmp/telegram -f "$THIS_DIR/PBRP/out/target/product/a50dd/recovery.img" ""
else
   # Error in build
~/tmp/telegram -M "⚒ ***Recovery***: [Pitch Black Recovery Project](https://pitchblackrecovery.com/) (3.0.0)
📱 ***Device***: Samsung Galaxy A50
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a50dd

❌ ***Note***: Building completed unsuccessfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
fi

curl --data parse_mode=HTML --data chat_id=$CHATS --data sticker=CAADBQADGgEAAixuhBPbSa3YLUZ8DBYE --request POST https://api.telegram.org/bot$TOKEN/sendSticker
