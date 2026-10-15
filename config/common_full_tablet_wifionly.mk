# Inherit mobile full common Alch3myOS stuff
$(call inherit-product, vendor/alch3my/config/common_mobile_full.mk)

# Inherit tablet common Alch3myOS stuff
$(call inherit-product, vendor/alch3my/config/tablet.mk)
$(call inherit-product, vendor/alch3my/config/wifionly.mk)
