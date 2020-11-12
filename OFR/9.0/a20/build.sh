#!/bin/bash
source ~/tmp/config.sh

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
HOSTNAME=´cat /etc/hostname >/dev/null´
distro=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release)

~/tmp/telegram -M "⚒ ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy A20
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a20

📍 ***Note***: Building Recovery started"
SYNC_START=$(date +"%s")

cd "$THIS_DIR/OrangeFox"

./build_ofox.sh

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))
if [ -f "$THIS_DIR/OrangeFox/out/target/product/a20/OrangeFox-R11.0-Stable-a20.zip" ]; then
~/tmp/telegram -M "OrangeFox (R11.0) - A20 (a20)
***📦 Building completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds***"
   # Output
~/tmp/telegram -M "📦 ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy A20
⚙️ ***Device codename***: a20
🎈 ***Output***: Recovery ZIP Flasheable

📍 ***Tags***: #a20 #ofr #r11 #stable"
~/tmp/telegram -f "$THIS_DIR/OrangeFox/out/target/product/a20/OrangeFox-R11.0-Stable-a20.zip" ""

   # Output for: Image
~/tmp/telegram -M "📦 ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy A20
⚙️ ***Device codename***: a20
🎈 ***Output***: Recovery Image

📍 ***Tags***: #a20 #ofr #r11 #stable"
~/tmp/telegram -f "$THIS_DIR/OrangeFox/out/target/product/a20/recovery.img" ""
else
   # Error in build
~/tmp/telegram -M "⚒ ***Recovery***: [OrangeFox](https://gitlab.com/OrangeFox) (R11.0)
📱 ***Device***: Samsung Galaxy A20
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a20

❌ ***Note***: Building completed unsuccessfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
fi

curl --data parse_mode=HTML --data chat_id=$CHATS --data sticker=CAADBQADGgEAAixuhBPbSa3YLUZ8DBYE --request POST https://api.telegram.org/bot$TOKEN/sendSticker
