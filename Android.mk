ifeq ($(BUILD_KERNEL),false)
ifeq ($(filter-out yukon rhine shinano shinano2 kitakami,$(PRODUCT_PLATFORM)),)

LOCAL_PATH := $(call my-dir)

TARGET_PREBUILT_KERNEL := vendor/sony/kernel/kernel-$(TARGET_DEVICE)
INSTALLED_KERNEL_TARGET ?= $(PRODUCT_OUT)/kernel

DTB_DIR := $(ANDROID_BUILD_TOP)/vendor/sony/kernel/dtbs
DTB_FILES := $(shell find -L $(DTB_DIR) -name "*$(TARGET_DEVICE)*.dtb")
DTB_OUT_DIR := $(PRODUCT_OUT)/dtbs
DTBS := $(foreach dtb,$(DTB_FILES),$(DTB_OUT_DIR)/$(notdir $(dtb)))
$(DTB_OUT_DIR)/%.dtb : $(DTB_DIR)/%.dtb | $(ACP)
	$(hide) @mkdir -p $(DTB_OUT_DIR)
	$(transform-prebuilt-to-target)

file := $(INSTALLED_KERNEL_TARGET)
ALL_PREBUILT += $(file)
$(file) : $(TARGET_PREBUILT_KERNEL) $(DTBS) | $(ACP)
	$(transform-prebuilt-to-target)

ALL_PREBUILT += $(INSTALLED_KERNEL_TARGET)
endif

endif
