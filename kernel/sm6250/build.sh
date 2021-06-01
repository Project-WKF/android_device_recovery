#!/bin/bash
source ~/tmp/config.sh

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
HOSTNAME=´cat /etc/hostname >/dev/null´
distro=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release)

~/tmp/telegram -M "⚒ ***Kernel***: [SM6250](https://github.com/Velosh/android_kernel_xiaomi_sm6250)
📱 ***Device***: MiAtoll
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)

📍 ***Note***: Building Kernel started"
SYNC_START=$(date +"%s")

cd "$THIS_DIR/Kernel"
./buildKernel.sh

SYNC_END=$(date +"%s")
SYNC_DIFF=$((SYNC_END - SYNC_START))

if [ -f "$THIS_DIR/Kernel/out/arch/arm64/boot/Image.gz-dtb" ]; then
~/tmp/telegram -M "⚒ ***Kernel***: [SM6250](https://github.com/Velosh/android_kernel_xiaomi_sm6250)
📱 ***Device***: MiAtoll
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)

✅ ***Note***: Building completed successfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"

~/tmp/telegram -M "⚒ ***Kernel***: [SM6250](https://github.com/Velosh/android_kernel_xiaomi_sm6250)
📱 ***Device***: MiAtoll
🎈 ***Output***: Image file

📍 ***Tags***: #miatoll #kernel"
~/tmp/telegram -f "$THIS_DIR/Kernel/out/arch/arm64/boot/Image.gz-dtb" ""
else
~/tmp/telegram -M "⚒ ***Kernel***: [SM6250](https://github.com/Velosh/android_kernel_xiaomi_sm6250)
📱 ***Device***: MiAtoll
🖥 ***Machine Host***: $HOSTNAME (OS: $distro)

❌ ***Note***: Building completed unsuccessfully in $((SYNC_DIFF / 60)) minute(s) and $((SYNC_DIFF % 60)) seconds"
fi
