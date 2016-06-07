ifeq ($(BUILD_KERNEL),false)
LOCAL_PATH := $(call my-dir)

TARGET_PREBUILT_KERNEL := $(LOCAL_PATH)/kernel-dtb-$(TARGET_DEVICE)
INSTALLED_KERNEL_TARGET ?= $(PRODUCT_OUT)/kernel

file := $(INSTALLED_KERNEL_TARGET)
ALL_PREBUILT += $(file)
$(file) : $(TARGET_PREBUILT_KERNEL) | $(ACP)
	$(transform-prebuilt-to-target)

ALL_PREBUILT += $(INSTALLED_KERNEL_TARGET)
endif
