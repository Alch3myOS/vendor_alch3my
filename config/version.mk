PRODUCT_VERSION_MAJOR = 17
PRODUCT_VERSION_MINOR = 0

# Increase Alch3my Version with each major release.
ALCH3MY_VERSION := 1.0
ALCH3MY_BUILD_TYPE ?= UNOFFICIAL
ALCH3MY_BUILD_VARIANT := GMS
ALCH3MY_BUILD := $(DEVICE_CODENAME)
BUILD_DATE := $(shell TZ="America/New_York" date +%Y%m%d)
BUILD_TIME := $(shell TZ="America/New_York" date +%H%M)

# Internal version
ALCH3MY_FULL_VERSION := Alch3myOS-$(ALCH3MY_VERSION)-$(ALCH3MY_BUILD)-$(ALCH3MY_BUILD_TYPE)-$(BUILD_DATE)-$(BUILD_TIME)

# Display version
ALCH3MY_DISPLAY_VERSION := $(ALCH3MY_VERSION)-$(BUILD_DATE)

# Alch3myOS version properties
PRODUCT_PRODUCT_PROPERTIES += \
    ro.alch3my.build.version=$(ALCH3MY_VERSION) \
    ro.alch3my.build=$(ALCH3MY_FULL_VERSION) \
    ro.alch3my.display.version=$(ALCH3MY_DISPLAY_VERSION) \
    ro.alch3my.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR) \
    ro.alch3my.package.type=$(ALCH3MY_BUILD_VARIANT)-$(ALCH3MY_BUILD_TYPE)
