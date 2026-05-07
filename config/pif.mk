# =========================================================
# Alch3myOS Global Play Integrity Spoofing (Feb 2026 - BP4A)
# =========================================================

# 1. Set Global Constants 
PIF_ID_0 := BP4A.251205.006
PIF_ID_1 := BP4A.260205.001
PIF_ID_2 := BP4A.260205.002
PIF_RELEASE := 16
PIF_SECURITY_PATCH_0 := 2025-12-05
PIF_SECURITY_PATCH_1 := 2026-02-05
PIF_SDK_INT := 36
PIF_INITIAL_SDK := 34

# 2. Dynamic Device Detection
# --- 7 Series ---
ifeq ($(LINEAGE_BUILD),panther)
PIF_PRODUCT := panther
PIF_MODEL := "Pixel 7"
PIF_INC := 14401865
TARGET_PIF_ID := $(PIF_ID_0)
TARGET_PIF_SECURITY_PATCH := $(PIF_SECURITY_PATCH_0)
endif

ifeq ($(LINEAGE_BUILD),cheetah)
PIF_PRODUCT := cheetah
PIF_MODEL := "Pixel 7 Pro"
PIF_INC := 14401865
TARGET_PIF_ID := $(PIF_ID_0)
TARGET_PIF_SECURITY_PATCH := $(PIF_SECURITY_PATCH_0)
endif

ifeq ($(LINEAGE_BUILD),lynx)
PIF_PRODUCT := lynx
PIF_MODEL := "Pixel 7a"
PIF_INC := 14624666
TARGET_PIF_ID := $(PIF_ID_0)
TARGET_PIF_SECURITY_PATCH := $(PIF_SECURITY_PATCH_0)
endif

# --- 8 Series ---
ifeq ($(LINEAGE_BUILD),shiba)
PIF_PRODUCT := shiba
PIF_MODEL := "Pixel 8"
PIF_INC := 14624666
TARGET_PIF_ID := $(PIF_ID_1)
TARGET_PIF_SECURITY_PATCH := $(PIF_SECURITY_PATCH_1)
endif

ifeq ($(LINEAGE_BUILD),husky)
PIF_PRODUCT := husky
PIF_MODEL := "Pixel 8 Pro"
PIF_INC := 14624666
TARGET_PIF_ID := $(PIF_ID_1)
TARGET_PIF_SECURITY_PATCH := $(PIF_SECURITY_PATCH_1)
endif

ifeq ($(LINEAGE_BUILD),akita)
PIF_PRODUCT := akita
PIF_MODEL := "Pixel 8a"
PIF_INC := 14624666
TARGET_PIF_ID := $(PIF_ID_1)
TARGET_PIF_SECURITY_PATCH := $(PIF_SECURITY_PATCH_1)
endif

# --- 9 Series ---
ifeq ($(LINEAGE_BUILD),tokay)
PIF_PRODUCT := tokay
PIF_MODEL := "Pixel 9"
PIF_INC := 14624737
TARGET_PIF_ID := $(PIF_ID_2)
TARGET_PIF_SECURITY_PATCH := $(PIF_SECURITY_PATCH_1)
endif

ifeq ($(LINEAGE_BUILD),caiman)
PIF_PRODUCT := caiman
PIF_MODEL := "Pixel 9 Pro"
PIF_INC := 14624737
TARGET_PIF_ID := $(PIF_ID_2)
TARGET_PIF_SECURITY_PATCH := $(PIF_SECURITY_PATCH_1)
endif

ifeq ($(LINEAGE_BUILD),komodo)
PIF_PRODUCT := komodo
PIF_MODEL := "Pixel 9 Pro XL"
PIF_INC := 14624737
TARGET_PIF_ID := $(PIF_ID_2)
TARGET_PIF_SECURITY_PATCH := $(PIF_SECURITY_PATCH_1)
endif

ifeq ($(LINEAGE_BUILD),tegu)
PIF_PRODUCT := tegu
PIF_MODEL := "Pixel 9a"
PIF_INC := 14624666
TARGET_PIF_ID := $(PIF_ID_1)
TARGET_PIF_SECURITY_PATCH := $(PIF_SECURITY_PATCH_1)
endif

# --- 10 Series ---
ifeq ($(LINEAGE_BUILD),frankel)
PIF_PRODUCT := frankel
PIF_MODEL := "Pixel 10"
PIF_INC := 14624666
TARGET_PIF_ID := $(PIF_ID_1)
TARGET_PIF_SECURITY_PATCH := $(PIF_SECURITY_PATCH_1)
endif

ifeq ($(LINEAGE_BUILD),blazer)
PIF_PRODUCT := blazer
PIF_MODEL := "Pixel 10 Pro"
PIF_INC := 14624666
TARGET_PIF_ID := $(PIF_ID_1)
TARGET_PIF_SECURITY_PATCH := $(PIF_SECURITY_PATCH_1)
endif

ifeq ($(LINEAGE_BUILD),mustang)
PIF_PRODUCT := mustang
PIF_MODEL := "Pixel 10 Pro XL"
PIF_INC := 14624666
TARGET_PIF_ID := $(PIF_ID_1)
TARGET_PIF_SECURITY_PATCH := $(PIF_SECURITY_PATCH_1)
endif

# 3. Inject the Properties into the Build
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.pihooks_MANUFACTURER?=Google \
    persist.sys.pihooks_BRAND?=google \
    persist.sys.pihooks_PRODUCT?=$(PIF_PRODUCT) \
    persist.sys.pihooks_DEVICE?=$(PIF_PRODUCT) \
    persist.sys.pihooks_RELEASE?=$(PIF_RELEASE) \
    persist.sys.pihooks_DEVICE_INITIAL_SDK_INT?=$(PIF_INITIAL_SDK) \
    persist.sys.pihooks_SDK_INT?=$(PIF_SDK_INT) \
    persist.sys.pihooks_ID?=$(TARGET_PIF_ID) \
    persist.sys.pihooks_SECURITY_PATCH?=$(TARGET_PIF_SECURITY_PATCH)

PRODUCT_BUILD_PROP_OVERRIDES += \
    PihooksGmsFp="google/$(PIF_PRODUCT)/$(PIF_PRODUCT):$(PIF_RELEASE)/$(TARGET_PIF_ID)/$(PIF_INC):user/release-keys" \
    PihooksGmsModel=$(PIF_MODEL)

