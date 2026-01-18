# Inherit common mobile Lineage stuff
$(call inherit-product, vendor/alch3my/config/common.mk)

# Include AOSP audio files
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioPackage14.mk)
include vendor/alch3my/config/aosp_audio.mk

# Include Lineage audio files
include vendor/alch3my/config/lineage_audio.mk

# Apps
PRODUCT_PACKAGES += \
    AvatarPicker \
    Backgrounds \
    Glimpse \
    LatinIME

# Charger
PRODUCT_PACKAGES += \
    product_charger_res_images \
    product_charger_res_images_vendor

# New charging information
PRODUCT_PRODUCT_PROPERTIES += \
    charging_string.apply_lotx=true \
    charging_string.apply_v2=true

# Credential storage
PRODUCT_PACKAGES += \
    android.software.credentials.prebuilt.xml

# Legal
PRODUCT_PRODUCT_PROPERTIES += \
    ro.lineagelegal.url=https://lineageos.org/legal

# Media
PRODUCT_PRODUCT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

# TextClassifier
PRODUCT_PACKAGES += \
    libtextclassifier_annotator_en_model \
    libtextclassifier_annotator_universal_model \
    libtextclassifier_actions_suggestions_universal_model \
    libtextclassifier_lang_id_model

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/apex/com.google.android.extservices.apex \
    system/app/GoogleExtShared/GoogleExtShared.apk \
    system/app/GooglePrintRecommendationService/GooglePrintRecommendationService.apk \
    system/etc/default-permissions/default_permissions_co.aospa.sense.xml \
    system/etc/permissions/privapp-permissions-google.xml \
    system/etc/permissions/privapp_allowlist_com.google.android.ext.services.xml \
    system/etc/permissions/privapp_whitelist_co.aospa.sense.xml \
    system/etc/sysconfig/derpfest-sysconfig.xml \
    system/etc/sysconfig/hiddenapi-whitelist-co.aospa.sense.xml \
    system/etc/textclassifier/actions_suggestions.universal.model \
    system/etc/textclassifier/lang_id.model \
    system/etc/textclassifier/textclassifier.en.model \
    system/etc/textclassifier/textclassifier.universal.model \
    system/fonts/Arvo-Bold.ttf \
    system/fonts/Arvo-BoldItalic.ttf \
    system/fonts/Arvo-Italic.ttf \
    system/fonts/Arvo-Regular.ttf \
    system/lib64/libFaceDetectCA.so \
    system/lib64/libMegviiUnlock-jni-1.2.so \
    system/lib64/libMegviiUnlock.so \
    system/lib64/libmegface.so \
    system/lib64/libtensorflowlite_jni.so \
    system/priv-app/DocumentsUIGoogle/DocumentsUIGoogle.apk \
    system/priv-app/GoogleExtServices/GoogleExtServices.apk \
    system/priv-app/OmniStyle/OmniStyle.apk \
    system/priv-app/ParanoidSense/ParanoidSense.apk \
    system/priv-app/TagGoogle/TagGoogle.apk

# TFLite service.
PRODUCT_PACKAGES += libtensorflowlite_jni

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/lib/libtensorflowlite_jni.so \
    system/lib64/libtensorflowlite_jni.so

# Themes
PRODUCT_PACKAGES += \
    ThemePicker \
    ThemesStub
