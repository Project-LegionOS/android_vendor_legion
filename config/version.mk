# Copyright (C) 2016 The Pure Nexus Project
# Copyright (C) 2016 The JDCTeam
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

LEGION_MOD_VERSION = v5.0
LEGION_BUILD_TYPE := UNOFFICIAL
LEGION_BUILD_ZIP_TYPE := VANILLA

ifeq ($(LEGION_BETA),true)
    LEGION_BUILD_TYPE := BETA
endif

ifeq ($(LEGION_GAPPS), true)
    $(call inherit-product, vendor/gapps/common/common-vendor.mk)
    LEGION_BUILD_ZIP_TYPE := GAPPS
endif

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

ifeq ($(LEGION_OFFICIAL), true)
   LIST = $(shell cat vendor/legion/legion.devices)
    ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
      IS_OFFICIAL=true
      LEGION_BUILD_TYPE := OFFICIAL

PRODUCT_PACKAGES += \
    Updater

    endif
    ifneq ($(IS_OFFICIAL), true)
       LEGION_BUILD_TYPE := UNOFFICIAL
       $(error Device is not official "$(CURRENT_DEVICE)")
    endif
endif

LEGION_VERSION := Legion-$(LEGION_MOD_VERSION)-$(CURRENT_DEVICE)-$(LEGION_BUILD_TYPE)-$(shell date -u +%Y%m%d)-$(LEGION_BUILD_ZIP_TYPE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.legion.version=$(LEGION_VERSION) \
  ro.legion.releasetype=$(LEGION_BUILD_TYPE) \
  ro.legion.ziptype=$(LEGION_BUILD_ZIP_TYPE) \
  ro.modversion=$(LEGION_MOD_VERSION)

LEGION_DISPLAY_VERSION := Legion-$(LEGION_MOD_VERSION)-$(LEGION_BUILD_TYPE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.legion.display.version=$(LEGION_DISPLAY_VERSION)
