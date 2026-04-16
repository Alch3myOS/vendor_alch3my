# Inherit mobile full common Lineage stuff
$(call inherit-product, vendor/alch3my/config/common_mobile_full.mk)

# Inherit tablet common Lineage stuff
$(call inherit-product, vendor/alch3my/config/tablet.mk)

$(call inherit-product, vendor/alch3my/config/telephony.mk)
