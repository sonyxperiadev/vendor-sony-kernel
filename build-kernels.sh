export ANDROID_ROOT=../../../..
export KERNEL_TOP=$ANDROID_ROOT/kernel/sony/msm-4.9/
export KERNEL_TMP=$ANDROID_ROOT/out/kernel-tmp

# Cross Compiler
export CROSS_COMPILE=../../prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
# Mkdtimg tool
export MKDTIMG=$ANDROID_ROOT/out/host/linux-x86/bin/mkdtimg
# Build command
export BUILD="make O=$KERNEL_TMP ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILE -j$(nproc)"
# Copy prebuilt kernel
export CP_BLOB="cp $KERNEL_TMP/arch/arm64/boot/Image.gz-dtb $KERNEL_TOP/common-kernel/kernel-dtb"

# Check if mkdtimg tool exists
if [ ! -f $MKDTIMG ]; then
    echo "mkdtimg: File not found!"
    echo "Building mkdtimg"
    cd  $ANDROID_ROOT/
    export ALLOW_MISSING_DEPENDENCIES=true
    make mkdtimg
fi

LOIRE="suzu kugo blanc"
TONE="dora kagura keyaki"
YOSHINO="lilac maple poplar"
NILE="discovery pioneer voyager"
TAMA="akari apollo akatsuki"

PLATFORMS="loire tone yoshino nile tama"

cd $KERNEL_TOP/kernel

for platform in $PLATFORMS; do \

case $platform in
loire)
    DEVICE=$LOIRE;
    DTBO="false";;
tone)
    DEVICE=$TONE;
    DTBO="false";;
yoshino)
    DEVICE=$YOSHINO;
    DTBO="false";;
nile)
    DEVICE=$NILE;
    DTBO="false";;
tama)
    DEVICE=$TAMA;
    DTBO="true";;
esac

for device in $DEVICE; do \
    rm -r $KERNEL_TMP
    $BUILD aosp_$platform"_"$device\_defconfig
    $BUILD
    $CP_BLOB-$device
    if [ $DTBO = "true" ]; then
        $MKDTIMG create $KERNEL_TOP/common-kernel/dtbo-$device\.img `find $KERNEL_TMP/arch/arm64/boot/dts -name "*.dtbo"`
    fi
done
done
