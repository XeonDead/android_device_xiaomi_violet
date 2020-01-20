#
# Copyright (C) 2019 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_p.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Inherit from violet device
$(call inherit-product, device/xiaomi/violet/device.mk)

# Inherit some common PixelExperience stuff.
#TARGET_BOOT_ANIMATION_RES := 1080
#TARGET_GAPPS_ARCH := arm64
#TARGET_INCLUDE_WIFI_EXT := true
#TARGET_INCLUDE_STOCK_ARCORE := true
#$(call inherit-product, vendor/aosp/config/common_full_phone.mk)

# Inherit some common CARBON stuff.
$(call inherit-product, vendor/carbon/config/common.mk)

# Inherit Carbon GSM telephony parts
$(call inherit-product, vendor/carbon/config/gsm.mk)

## included from PE common_full_phone
# Telephony

IS_PHONE := true

# World APN list
PRODUCT_PACKAGES += \
    apns-conf.xml

# Telephony packages
PRODUCT_PACKAGES += \
    Stk \
    CellBroadcastReceiver

# Tethering - allow without requiring a provisioning app
# (for devices that check this)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    net.tethering.noprovisioning=true

## included from PE common_full
PRODUCT_SIZE := full

## included from PE common
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dataroaming=false \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.com.android.dateformat=MM-dd-yyyy \
    persist.sys.disable_rescue=true \
    ro.setupwizard.rotation_locked=true

#ifeq ($(TARGET_BUILD_VARIANT),eng)
# Disable ADB authentication
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=0
#else
# Enable ADB authentication
#PRODUCT_SYSTEM_DEFAULT_PROPERTIES += ro.adb.secure=1
#endif

# Ambient Play
#PRODUCT_PACKAGES += \
#    AmbientPlayHistoryProvider

# Backup Tool
#PRODUCT_COPY_FILES += \
#    vendor/aosp/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
#    vendor/aosp/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
#    vendor/aosp/prebuilt/common/bin/50-base.sh:system/addon.d/50-base.sh \
#    vendor/aosp/prebuilt/common/bin/blacklist:system/addon.d/blacklist

#ifneq ($(AB_OTA_PARTITIONS),)
#PRODUCT_COPY_FILES += \
#    vendor/aosp/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
#    vendor/aosp/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
#    vendor/aosp/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
#endif

# Some permissions
#PRODUCT_COPY_FILES += \
#    vendor/aosp/config/permissions/backup.xml:system/etc/sysconfig/backup.xml \
#    vendor/aosp/config/permissions/privapp-permissions-fm.xml:system/etc/permissions/privapp-permissions-fm.xml \
#    vendor/aosp/config/permissions/privapp-permissions-snap.xml:system/etc/permissions/privapp-permissions-snap.xml \
#    vendor/aosp/config/permissions/privapp-permissions-camera2.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-camera2.xml

# Copy all custom init rc files
$(foreach f,$(wildcard vendor/aosp/prebuilt/common/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
#PRODUCT_COPY_FILES += \
#    vendor/aosp/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable Android Beam on all targets
#PRODUCT_COPY_FILES += \
#    vendor/aosp/config/permissions/android.software.nfc.beam.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.nfc.beam.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

# Power whitelist
#PRODUCT_COPY_FILES += \
#    vendor/aosp/config/permissions/custom-power-whitelist.xml:system/etc/sysconfig/custom-power-whitelist.xml

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    fsck.ntfs \
    mke2fs \
    mkfs.exfat \
    mkfs.ntfs \
    mount.ntfs

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

#PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/aosp/overlay
#DEVICE_PACKAGE_OVERLAYS += vendor/aosp/overlay/common

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := aosp_violet
PRODUCT_DEVICE := violet
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Redmi Note 7 Pro
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME="violet" \
    TARGET_DEVICE="violet"

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
