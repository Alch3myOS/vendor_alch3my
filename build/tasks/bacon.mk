# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# -----------------------------------------------------------------
# Alch3myOS OTA update package

ALCH3MY_TARGET_PACKAGE := $(PRODUCT_OUT)/$(ALCH3MY_FULL_VERSION).zip

SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

$(ALCH3MY_TARGET_PACKAGE): $(INTERNAL_OTA_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(ALCH3MY_TARGET_PACKAGE)
	$(hide) $(SHA256) $(ALCH3MY_TARGET_PACKAGE) | sed "s|$(PRODUCT_OUT)/||" > $(ALCH3MY_TARGET_PACKAGE).sha256sum
	$(hide) ALCH3MY_VERSION=$(ALCH3MY_VERSION) ALCH3MY_BUILD_TYPE=$(ALCH3MY_BUILD_TYPE) ./vendor/alch3my/build/tools/createjson.sh $(TARGET_DEVICE) $(PRODUCT_OUT) $(ALCH3MY_FULL_VERSION).zip
	$(hide) rm -rf $(call intermediates-dir-for,PACKAGING,target_files)
	$(hide) ./vendor/alch3my/build/tasks/ascii_output.sh
	echo -e "\n${CL_BLD}${CL_GRN}================================================================================${CL_RST}" >&2
	echo -e "${CL_BLD}${CL_CYN}                🎊✨ BUILD COMPLETED SUCCESSFULLY! ✨🎊${CL_RST}" >&2
	echo -e "${CL_BLD}${CL_GRN}================================================================================${CL_RST}" >&2
	echo -e "" >&2
	echo -e "${CL_BLD}${CL_WHT}📦 Package:${CL_RST}  ${CL_BLD}${CL_YEL}$(notdir $(ALCH3MY_TARGET_PACKAGE))${CL_RST}" >&2
	echo -e "${CL_BLD}${CL_WHT}📍 Location:${CL_RST} ${CL_BLD}${CL_BLU}$(dir $(ALCH3MY_TARGET_PACKAGE))${CL_RST}" >&2
	echo -e "${CL_BLD}${CL_WHT}📱 Device:${CL_RST}   ${CL_BLD}${CL_CYN}$(TARGET_DEVICE) [$(TARGET_BUILD_VARIANT)]${CL_RST}" >&2
	echo -e "${CL_BLD}${CL_WHT}💾 Size:${CL_RST}     ${CL_BLD}${CL_YEL}$(shell du -h $(ALCH3MY_TARGET_PACKAGE) | cut -f1)${CL_RST}" >&2
	echo -e "${CL_BLD}${CL_WHT}⏱️ Finished At:${CL_RST} ${CL_BLD}${CL_MAG}$(shell date '+%Y-%m-%d %H:%M:%S')${CL_RST}" >&2
	echo -e "" >&2
	echo -e "${CL_BLD}${CL_RED}                ❤️ Thank you for building Alch3myOS! ❤️${CL_RST}" >&2
	echo -e "" >&2
	echo -e "${CL_BLD}${CL_GRN}=============================================================================${CL_RST}" >&2
	echo -e "${CL_BLD}${CL_YEL}	🎉 The Magic has only just started, ready to flash? 🎉${CL_RST}" >&2
	echo -e "${CL_BLD}${CL_GRN}=============================================================================${CL_RST}" >&2
	echo -e "" >&2

.PHONY: bacon
bacon: $(ALCH3MY_TARGET_PACKAGE) $(DEFAULT_GOAL) 
