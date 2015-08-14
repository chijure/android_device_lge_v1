#!/system/bin/sh
# Copyright (c) 2011-2012, The Linux Foundation. All rights reserved.
# Copyright (c) 2015, TeamVee. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# No path is set up at this point so we have to do it here.
PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

# Get device based on baseband
deviceset=`getprop gsm.version.baseband | grep -o "E410" -e "E411" -e "E415" -e "E420" | head -1`

# ReMount /system to Read-Write
mount -o rw,remount /system

# Set Variant in build.prop
case "$deviceset" in
	"E410") busybox sed -i '/ro.product.model=L1 II/c\ro.product.model=E410 (L1 II Single)' system/build.prop ;;
	"E411") busybox sed -i '/ro.product.model=L1 II/c\ro.product.model=E411 (L1 II Single)' system/build.prop ;;
	"E415") busybox sed -i '/ro.product.model=L1 II/c\ro.product.model=E415 (L1 II Dual)' system/build.prop ;;
	"E420") busybox sed -i '/ro.product.model=L1 II/c\ro.product.model=E420 (L1 II Dual)' system/build.prop ;;
esac

# Enable DualSim
case "$deviceset" in
	"E415" | "E420")
	disabledualsim=`getprop persist.disable.dualsim`
	case "$disabledualsim" in
		"false" | "")
		setprop persist.radio.multisim.config dsds
		setprop persist.multisim.config dsds
		setprop ro.multi.rild true
		;;
		"true")
		setprop persist.radio.multisim.config ""
		setprop persist.multisim.config ""
		setprop ro.multi.rild false
		;;
	esac
	;;
esac

# ReMount /system to Read-Only
mount -o ro,remount /system
