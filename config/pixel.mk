# Pixel APN list
$(call inherit-product-if-exists, vendor/google/CarrierSettings/telephony.mk)

# Google Face Unlock (inherited in alch3my.mk)
TARGET_FACE_UNLOCK_SUPPORTED ?= true
TARGET_SUPPORTS_GFU ?= true

# GoogleCamera
$(call inherit-product-if-exists, vendor/google/camera/config.mk)
