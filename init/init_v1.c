/*
   Copyright (c) 2013, The Linux Foundation. All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include <stdlib.h>
#include <stdio.h>

#include "vendor_init.h"
#include "property_service.h"
#include "log.h"
#include "util.h"

void vendor_load_properties() {
    char device[PROP_VALUE_MAX];
    char bbversion[92];
    FILE *fp;

    fp = popen("/system/xbin/strings /dev/block/mmcblk0p12 | /system/bin/grep -e '-V10.-' -e '-V20.-' | /system/bin/grep -o -e 'E410' -e 'E411' -e 'E415' -e 'E420' | /system/xbin/head -1", "r");
    fgets(bbversion, sizeof(bbversion), fp);
    pclose(fp);

    if (strstr(bbversion, "E410")) {
        property_set("ro.product.device", "E410");
        property_set("ro.product.model", "E410 (L1 II Single)");
        property_set("persist.radio.multisim.config", "none");
        property_set("persist.multisim.config", "none");
        property_set("ro.multi.rild", "false");
    } else if (strstr(bbversion, "E411")) {
        property_set("ro.product.device", "E411");
        property_set("ro.product.model", "E411 (L1 II Single)");
        property_set("persist.radio.multisim.config", "none");
        property_set("persist.multisim.config", "none");
        property_set("ro.multi.rild", "false");
    } else if (strstr(bbversion, "E415")) {
        property_set("ro.product.device", "E415");
        property_set("ro.product.model", "E415 (L1 II Dual)");
        property_set("persist.radio.multisim.config", "dsds");
        property_set("persist.multisim.config", "dsds");
        property_set("ro.multi.rild", "true");
    } else if (strstr(bbversion, "E420")) {
        property_set("ro.product.device", "E420");
        property_set("ro.product.model", "E420 (L1 II Dual)");
        property_set("persist.radio.multisim.config", "dsds");
        property_set("persist.multisim.config", "dsds");
        property_set("ro.multi.rild", "true");
    };

    property_get("ro.product.device", device);
    ERROR("Found %s baseband setting build properties for %s device\n", bbversion, device);
}
