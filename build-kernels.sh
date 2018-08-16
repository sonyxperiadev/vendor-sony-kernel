export ANDROID_ROOT=../../../..
export KERNEL_TOP=$ANDROID_ROOT/kernel/sony/msm-4.9/
export KERNEL_TMP=$ANDROID_ROOT/out/kernel-tmp

# Cross Compiler
export CROSS_COMPILE=../../prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
# Build command
export BUILD="make O=$KERNEL_TMP ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE -j$(nproc)"
# Copy prebuilt kernel
export CP_BLOB="cp $KERNEL_TMP/arch/arm64/boot/Image.gz-dtb $KERNEL_TOP/common-kernel/kernel-dtb"

LOIRE="suzu kugo blanc"
TONE="dora kagura keyaki"
YOSHINO="lilac maple poplar"
NILE="discovery pioneer"
TAMA="akari apollo"

PLATFORMS="loire tone yoshino nile tama"

cd $KERNEL_TOP/kernel

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
tama)
    DEVICE=$TAMA;;
esac

for device in $DEVICE; do \
    rm -r $KERNEL_TMP
    $BUILD aosp_$platform"_"$device\_defconfig
    $BUILD
    $CP_BLOB-$device
done
done
