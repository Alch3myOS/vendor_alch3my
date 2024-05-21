# Alch3myOS packages
PRODUCT_PACKAGES += \
    AxSandbox \
    BatteryStatsViewer \
    GameSpace \
    LMOFreeform \
    LMOFreeformSidebar

# Additional props
PRODUCT_PRODUCT_PROPERTIES += \
    dalvik.vm.debug.alloc=0 \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.setupwizard.rotation_locked=true \
    ro.com.google.ime.theme_id=5 \
    ro.opa.eligible_device=true \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.network_required=false \
    ro.setupwizard.gservices_delay=-1 \
    ro.setupwizard.mode=OPTIONAL \
    setupwizard.feature.predeferred_enabled=false \
    drm.service.enabled=true \
    persist.sys.dun.override=0 \
    persist.sys.disable_rescue=true

# Broken config
PRODUCT_BROKEN_VERIFY_USES_LIBRARIES := true

# Alch3my-specific init rc file
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/init/init.alch3my.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.alch3my.rc

# BtHelper
PRODUCT_PACKAGES += \
    BtHelper

# ColumbusService
ifneq ($(TARGET_SUPPORTS_QUICK_TAP),false)
PRODUCT_PACKAGES += \
    ColumbusService
endif

# DeviceAsWebcam
ifeq ($(TARGET_BUILD_DEVICE_AS_WEBCAM), true)
    PRODUCT_PACKAGES += \
        DeviceAsWebcam

    PRODUCT_VENDOR_PROPERTIES += \
        ro.usb.uvc.enabled=true
endif

# Face Unlock
ifeq ($(TARGET_FACE_UNLOCK_SUPPORTED),true)
PRODUCT_PACKAGES += \
    FaceUnlock

PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.face.sense_service=true

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/android.hardware.biometrics.face.xml
endif

# Enable blur
TARGET_ENABLE_BLUR ?= true
ifeq ($(TARGET_ENABLE_BLUR),true)
PRODUCT_SYSTEM_PROPERTIES += \
    ro.custom.blur.enable=true \
    persist.sysui.disableBlur=false \
    ro.surface_flinger.supports_background_blur=1
else
PRODUCT_SYSTEM_PROPERTIES += \
    ro.custom.blur.enable=false \
    persist.sysui.disableBlur=true \
    ro.surface_flinger.supports_background_blur=0
endif

# Enable Material Design 3 Expressive
PRODUCT_PRODUCT_PROPERTIES += is_expressive_design_enabled=true

# Cloned app exemption
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/sysconfig/preinstalled-packages-platform-alch3my-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/preinstalled-packages-platform-alch3my-product.xml

# Use a generic profile based boot image by default
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_COPY_FILES += \
    art/build/boot/preloaded-classes:$(TARGET_COPY_OUT_SYSTEM)/etc/preloaded-classes

PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := \
    art/build/boot/boot-image-profile.txt

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/etc/preloaded-classes

# sound
PRODUCT_PRODUCT_PROPERTIES += \
    audio.safemedia.bypass=1

# PERF_ANIM_OVERRIDE
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.activity_anim_perf_override=$(PERF_ANIM_OVERRIDE)

ifeq ($(PERF_ANIM_OVERRIDE),true)
PRODUCT_PRODUCT_PROPERTIES += \
    debug.sf.predict_hwc_composition_strategy=0
endif

# Other ROM feature flags
PERF_ANIM_OVERRIDE ?= false

# Private Keys
ifneq ($(filter OFFICIAL Official official,$(ALCH3MY_BUILD_TYPE)),)
include vendor/lineage-priv/keys/keys.mk
endif
