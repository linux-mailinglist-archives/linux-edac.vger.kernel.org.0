Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C483A4752
	for <lists+linux-edac@lfdr.de>; Fri, 11 Jun 2021 19:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhFKRDt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Jun 2021 13:03:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:56284 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231553AbhFKRDs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Jun 2021 13:03:48 -0400
IronPort-SDR: /W00vI96cSHst7dEHD523X9/hUA7MDx3EOwHYaxZA9oz+Q2JXgZRarn/8bnZufZXWTr/QGMJ9u
 SnEUE61XKh8g==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="266715349"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="266715349"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:01:36 -0700
IronPort-SDR: 4TgZR69ad4IDrXRLwAr2qnCxH0WflIiKDR5COVOZ9LNc9FtDL+7aV1PTcbQO/jM4ywBx9Uo3Fr
 AzjCjVWbYD8A==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="483329860"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:01:36 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     tony.luck@intel.com
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] EDAC/skx_common: Add new ADXL components for 2-level memory
Date:   Fri, 11 Jun 2021 10:01:18 -0700
Message-Id: <20210611170123.1057025-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611170123.1057025-1-tony.luck@intel.com>
References: <20210611170123.1057025-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Some Intel servers may configure memory in 2 levels, using
fast "near" memory (e.g. DDR) as a cache for larger, slower,
"far" memory (e.g. 3D X-point).

In these configurations the BIOS ADXL address translation for
an address in a 2-level memory range will provide details of
both the "near" and far components.

Current exported ADXL components are only for 1-level memory
system or for 2nd level memory of 2-level memory system. So
add new ADXL components for 1st level memory of 2-level memory
system to fully support 2-level memory system and the detection
of memory error source(1st level memory or 2nd level memory).

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/skx_common.c | 67 ++++++++++++++++++++++++++++++++-------
 drivers/edac/skx_common.h | 11 +++++++
 2 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 81c3e2ec6f56..c8691abb720d 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -23,10 +23,13 @@
 #include "skx_common.h"
 
 static const char * const component_names[] = {
-	[INDEX_SOCKET]	= "ProcessorSocketId",
-	[INDEX_MEMCTRL]	= "MemoryControllerId",
-	[INDEX_CHANNEL]	= "ChannelId",
-	[INDEX_DIMM]	= "DimmSlotId",
+	[INDEX_SOCKET]		= "ProcessorSocketId",
+	[INDEX_MEMCTRL]		= "MemoryControllerId",
+	[INDEX_CHANNEL]		= "ChannelId",
+	[INDEX_DIMM]		= "DimmSlotId",
+	[INDEX_NM_MEMCTRL]	= "NmMemoryControllerId",
+	[INDEX_NM_CHANNEL]	= "NmChannelId",
+	[INDEX_NM_DIMM]		= "NmDimmSlotId",
 };
 
 static int component_indices[ARRAY_SIZE(component_names)];
@@ -34,12 +37,14 @@ static int adxl_component_count;
 static const char * const *adxl_component_names;
 static u64 *adxl_values;
 static char *adxl_msg;
+static unsigned long adxl_nm_bitmap;
 
 static char skx_msg[MSG_SIZE];
 static skx_decode_f skx_decode;
 static skx_show_retry_log_f skx_show_retry_rd_err_log;
 static u64 skx_tolm, skx_tohm;
 static LIST_HEAD(dev_edac_list);
+static bool skx_mem_cfg_2lm;
 
 int __init skx_adxl_get(void)
 {
@@ -56,14 +61,25 @@ int __init skx_adxl_get(void)
 		for (j = 0; names[j]; j++) {
 			if (!strcmp(component_names[i], names[j])) {
 				component_indices[i] = j;
+
+				if (i >= INDEX_NM_FIRST)
+					adxl_nm_bitmap |= 1 << i;
+
 				break;
 			}
 		}
 
-		if (!names[j])
+		if (!names[j] && i < INDEX_NM_FIRST)
 			goto err;
 	}
 
+	if (skx_mem_cfg_2lm) {
+		if (!adxl_nm_bitmap)
+			skx_printk(KERN_NOTICE, "Not enough ADXL components for 2-level memory.\n");
+		else
+			edac_dbg(2, "adxl_nm_bitmap: 0x%lx\n", adxl_nm_bitmap);
+	}
+
 	adxl_component_names = names;
 	while (*names++)
 		adxl_component_count++;
@@ -99,7 +115,7 @@ void __exit skx_adxl_put(void)
 	kfree(adxl_msg);
 }
 
-static bool skx_adxl_decode(struct decoded_addr *res)
+static bool skx_adxl_decode(struct decoded_addr *res, bool error_in_1st_level_mem)
 {
 	struct skx_dev *d;
 	int i, len = 0;
@@ -116,11 +132,20 @@ static bool skx_adxl_decode(struct decoded_addr *res)
 	}
 
 	res->socket  = (int)adxl_values[component_indices[INDEX_SOCKET]];
-	res->imc     = (int)adxl_values[component_indices[INDEX_MEMCTRL]];
-	res->channel = (int)adxl_values[component_indices[INDEX_CHANNEL]];
-	res->dimm    = (int)adxl_values[component_indices[INDEX_DIMM]];
+	if (error_in_1st_level_mem) {
+		res->imc     = (adxl_nm_bitmap & BIT_NM_MEMCTRL) ?
+			       (int)adxl_values[component_indices[INDEX_NM_MEMCTRL]] : -1;
+		res->channel = (adxl_nm_bitmap & BIT_NM_CHANNEL) ?
+			       (int)adxl_values[component_indices[INDEX_NM_CHANNEL]] : -1;
+		res->dimm    = (adxl_nm_bitmap & BIT_NM_DIMM) ?
+			       (int)adxl_values[component_indices[INDEX_NM_DIMM]] : -1;
+	} else {
+		res->imc     = (int)adxl_values[component_indices[INDEX_MEMCTRL]];
+		res->channel = (int)adxl_values[component_indices[INDEX_CHANNEL]];
+		res->dimm    = (int)adxl_values[component_indices[INDEX_DIMM]];
+	}
 
-	if (res->imc > NUM_IMC - 1) {
+	if (res->imc > NUM_IMC - 1 || res->imc < 0) {
 		skx_printk(KERN_ERR, "Bad imc %d\n", res->imc);
 		return false;
 	}
@@ -151,6 +176,11 @@ static bool skx_adxl_decode(struct decoded_addr *res)
 	return true;
 }
 
+void skx_set_mem_cfg(bool mem_cfg_2lm)
+{
+	skx_mem_cfg_2lm = mem_cfg_2lm;
+}
+
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log)
 {
 	skx_decode = decode;
@@ -578,6 +608,21 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 			     optype, skx_msg);
 }
 
+static bool skx_error_in_1st_level_mem(const struct mce *m)
+{
+	u32 errcode;
+
+	if (!skx_mem_cfg_2lm)
+		return false;
+
+	errcode = GET_BITFIELD(m->status, 0, 15);
+
+	if ((errcode & 0xef80) != 0x280)
+		return false;
+
+	return true;
+}
+
 int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -597,7 +642,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	res.addr = mce->addr;
 
 	if (adxl_component_count) {
-		if (!skx_adxl_decode(&res))
+		if (!skx_adxl_decode(&res, skx_error_in_1st_level_mem(mce)))
 			return NOTIFY_DONE;
 	} else if (!skx_decode || !skx_decode(&res)) {
 		return NOTIFY_DONE;
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index bf56bebff138..8b5a49058ce4 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -9,6 +9,8 @@
 #ifndef _SKX_COMM_EDAC_H
 #define _SKX_COMM_EDAC_H
 
+#include <linux/bits.h>
+
 #define MSG_SIZE		1024
 
 /*
@@ -92,9 +94,17 @@ enum {
 	INDEX_MEMCTRL,
 	INDEX_CHANNEL,
 	INDEX_DIMM,
+	INDEX_NM_FIRST,
+	INDEX_NM_MEMCTRL = INDEX_NM_FIRST,
+	INDEX_NM_CHANNEL,
+	INDEX_NM_DIMM,
 	INDEX_MAX
 };
 
+#define BIT_NM_MEMCTRL	BIT_ULL(INDEX_NM_MEMCTRL)
+#define BIT_NM_CHANNEL	BIT_ULL(INDEX_NM_CHANNEL)
+#define BIT_NM_DIMM	BIT_ULL(INDEX_NM_DIMM)
+
 struct decoded_addr {
 	struct skx_dev *dev;
 	u64	addr;
@@ -133,6 +143,7 @@ typedef void (*skx_show_retry_log_f)(struct decoded_addr *res, char *msg, int le
 int __init skx_adxl_get(void);
 void __exit skx_adxl_put(void);
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log);
+void skx_set_mem_cfg(bool mem_cfg_2lm);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
 int skx_get_node_id(struct skx_dev *d, u8 *id);
-- 
2.29.2

