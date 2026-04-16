PRODUCT_VERSION_MAJOR = 16
PRODUCT_VERSION_MINOR = 0

# Increase Alch3my Version with each major release.
ALCH3MY_VERSION := v1.0-beta
ALCH3MY_BUILD_TYPE ?= UNOFFICIAL

ifeq ($(WITH_GMS),true)
ALCH3MY_BUILD_VARIANT := GAPPS
else
ALCH3MY_BUILD_VARIANT := VANILLA
endif

# Internal version
LINEAGE_VERSION := Alch3myOS-$(ALCH3MY_VERSION)-$(LINEAGE_BUILD)-$(ALCH3MY_BUILD_VARIANT)-$(ALCH3MY_BUILD_TYPE)-$(shell date -u +%Y%m%d)

# Display version
LINEAGE_DISPLAY_VERSION := v$(ALCH3MY_VERSION)-$(shell date -u +%Y%m%d)

# LineageOS version properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.alch3my.build.version=$(ALCH3MY_VERSION) \
    ro.alch3my.display.version=$(LINEAGE_DISPLAY_VERSION) \
    ro.alch3my.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.alch3my.package.type=$(ALCH3MY_BUILD_VARIANT)-$(ALCH3MY_BUILD_TYPE)
