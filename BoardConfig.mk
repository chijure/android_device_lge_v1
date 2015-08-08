# Copyright (C) 2015 The CyanogenMod Project
# Copyright (C) 2015 The TeamVee Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# 	http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Include Vee Common
include device/lge/vee-common/BoardConfigCommon.mk

TARGET_COMMON_VEE := true

# inherit from the proprietary version
-include vendor/lge-vee/vee3/BoardConfigVendor.mk

# Kernel
TARGET_KERNEL_CONFIG := cyanogenmod_v1_defconfig
BOARD_KERNEL_CMDLINE := androidboot.hardware=v1 androidboot.selinux=permissive

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 12582912
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 12582912
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 958398464
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1876951040
BOARD_FLASH_BLOCK_SIZE := 131072
TARGET_USERIMAGES_USE_EXT4 := true

# BT
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/lge/v1/bluetooth

# Recovery
DEVICE_RESOLUTION := 240x240

# FSTAB
TARGET_RECOVERY_FSTAB := device/lge/v1/rootdir/fstab.v1
#TARGET_RECOVERY_FSTAB := device/lge/v1/recovery/recovery.fstab

