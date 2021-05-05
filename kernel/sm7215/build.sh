#!/bin/bash
source ~/tmp/config.sh

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
HOSTNAME=´cat /etc/hostname >/dev/null´
distro=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release)

~/tmp/telegram -M "⚒ ***Kernel***: [SM7215](https://github.com/Samsung-SM7215/android_kernel_samsung_sm7125) (11)
📱 ***Device***: Samsung Galaxy A52/A72
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a52q, a72q

📍 ***Note***: Building Kernel started"
SYNC_START=$(date +"%s")

cd "$THIS_DIR/Kernel"
./buildKernel.sh

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))

if [ -f "$THIS_DIR/Kernel/a72q/arch/arm64/boot/Image.gz" ]; then
~/tmp/telegram -M "⚒ ***Kernel***: [SM7215](https://github.com/Samsung-SM7215/android_kernel_samsung_sm7125) (11)
📱 ***Device***: Samsung Galaxy A72
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a72q

✅ ***Note***: Building completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

~/tmp/telegram -M "⚒ ***Kernel***: [SM7215](https://github.com/Samsung-SM7215/android_kernel_samsung_sm7125) (11)
📱 ***Device***: Samsung Galaxy A72
⚙️ ***Device codename***: a72q
🎈 ***Output***: Image file

📍 ***Tags***: #a72q #kernel #11"
~/tmp/telegram -f "$THIS_DIR/Kernel/a72q/arch/arm64/boot/Image.gz" ""
else
~/tmp/telegram -M "⚒ ***Kernel***: [SM7215](https://github.com/Samsung-SM7215/android_kernel_samsung_sm7125) (11)
📱 ***Device***: Samsung Galaxy A72
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a72q

❌ ***Note***: Building completed unsuccessfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
fi

if [ -f "$THIS_DIR/Kernel/a52q/arch/arm64/boot/Image.gz" ]; then
~/tmp/telegram -M "⚒ ***Kernel***: [SM7215](https://github.com/Samsung-SM7215/android_kernel_samsung_sm7125) (11)
📱 ***Device***: Samsung Galaxy A52
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a52q

✅ ***Note***: Building completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

~/tmp/telegram -M "⚒ ***Kernel***: [SM7215](https://github.com/Samsung-SM7215/android_kernel_samsung_sm7125) (11)
📱 ***Device***: Samsung Galaxy A52
⚙️ ***Device codename***: a52q
🎈 ***Output***: Image file

📍 ***Tags***: #a52q #kernel #11"
~/tmp/telegram -f "$THIS_DIR/Kernel/a52q/arch/arm64/boot/Image.gz" ""
else
~/tmp/telegram -M "⚒ ***Kernel***: [SM7215](https://github.com/Samsung-SM7215/android_kernel_samsung_sm7125) (11)
📱 ***Device***: Samsung Galaxy A52
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)
⚙️ ***Device codename***: a52q

❌ ***Note***: Building completed unsuccessfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
fi

curl --data parse_mode=HTML --data chat_id=$CHATS --data sticker=CAADBQADGgEAAixuhBPbSa3YLUZ8DBYE --request POST https://api.telegram.org/bot$TOKEN/sendSticker
