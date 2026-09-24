# Inherit common Lineage stuff
$(call inherit-product, vendor/lineage/config/common_mobile.mk)

PRODUCT_SIZE := full

PRODUCT_PACKAGES += \
    Profiles

# Apps
ifneq ($(WITH_GMS), true)  
PRODUCT_PACKAGES += \
    Aperture \
    AudioFX \
    Camelot \
    Etar \
    Recorder \
    Seedvault \
    Twelve
endif

# Extra cmdline tools
PRODUCT_PACKAGES += \
    unrar \
    zstd

# Include Lineage LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/lineage/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/lineage/overlay/dictionaries
