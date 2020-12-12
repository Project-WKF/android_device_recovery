#!/bin/bash
source ~/tmp/config.sh

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
HOSTNAME=´cat /etc/hostname >/dev/null´
distro=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release)

~/tmp/telegram -M "⚒ ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy M30s
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: m30sdd

📍 ***Note***: Building Recovery started"
SYNC_START=$(date +"%s")

cd "$THIS_DIR/OrangeFox"

./build_ofox.sh

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
if [ -f "$THIS_DIR/OrangeFox/out/target/product/m30sdd/OrangeFox-R11.0-Stable-m30sdd.zip" ]; then
   # Output for: Build successfully fine
~/tmp/telegram -M "⚒ ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy M30s
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: m30sdd

✅ ***Note***: Building completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

   # Output for: ZIP
~/tmp/telegram -M "📦 ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy M30s
⚙️ ***Device codename***: m30sdd
🎈 ***Output***: Recovery ZIP Flasheable

📍 ***Tags***: #m30sdd #ofr #r11 #stable #staging"
~/tmp/telegram -f "$THIS_DIR/OrangeFox/out/target/product/m30sdd/OrangeFox-R11.0-Stable-m30sdd.zip" ""

   # Output for: Image
~/tmp/telegram -M "📦 ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy M30s
⚙️ ***Device codename***: m30sdd
🎈 ***Output***: Recovery Image

📍 ***Tags***: #m30sdd #ofr #r11 #stable #staging"
~/tmp/telegram -f "$THIS_DIR/OrangeFox/out/target/product/m30sdd/recovery.img" ""
else
~/tmp/telegram -M "⚒ ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy M30s
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: m30sdd

❌ ***Note***: Building completed unsuccessfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
fi

curl --data parse_mode=HTML --data chat_id=$CHATS --data sticker=CAADBQADGgEAAixuhBPbSa3YLUZ8DBYE --request POST https://api.telegram.org/bot$TOKEN/sendSticker
