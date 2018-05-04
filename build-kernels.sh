export KERNEL_SRC=../kernel
export KERNEL_TMP=../../../../out/kernel-tmp/
export CROSS_COMPILE=../../prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export BUILD="make ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE O=$KERNEL_TMP -j$(nproc)"
export CP_BLOB="cp $KERNEL_TMP/arch/arm64/boot/Image.gz-dtb ../../../../kernel/sony/msm-4.4/common-kernel/kernel-dtb"


LOIRE="suzu kugo blanc"
TONE="dora kagura keyaki"
YOSHINO="lilac maple poplar"
NILE="discovery pioneer"

PLATFORMS="loire tone yoshino nile"

cd $KERNEL_SRC

for platform in $PLATFORMS; do \

case $platform in
loire)
    DEVICE=$LOIRE;;
tone)
    DEVICE=$TONE;;
yoshino)
    DEVICE=$YOSHINO;;
nile)
    DEVICE=$NILE;;
esac

for device in $DEVICE; do \
    $BUILD clean
    $BUILD aosp_$platform"_"$device\_defconfig
    $BUILD
    $CP_BLOB-$device
done
done
