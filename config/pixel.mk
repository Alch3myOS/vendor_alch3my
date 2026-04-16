# Pixel APN list
include vendor/google/CarrierSettings/telephony.mk

# Google Face Unlock
$(call inherit-product, vendor/google/faceunlock/config.mk)

PRODUCT_SYSTEM_EXT_PACKAGES += \
	FaceUnlockSettingsOverlay

# GoogleCamera
$(call inherit-product, vendor/google/camera/config.mk)
