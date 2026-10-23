# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

# build-manifest.xml
BUILD_BROKEN_SRC_DIR_RW_ALLOWLIST := $(abspath .repo/manifests.git)

# Recovery
BOARD_USES_FULL_RECOVERY_IMAGE ?= true

ifeq ($(TARGET_RECOVERY_UI_MARGIN_HEIGHT),)
    TARGET_RECOVERY_UI_MARGIN_HEIGHT := 165
endif
ifeq ($(TARGET_RECOVERY_UI_MARGIN_WIDTH),)
    TARGET_RECOVERY_UI_MARGIN_WIDTH := 48
endif

include vendor/alch3my/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
    include hardware/qcom-caf/common/BoardConfigQcom.mk
endif

include vendor/alch3my/config/BoardConfigSoong.mk
