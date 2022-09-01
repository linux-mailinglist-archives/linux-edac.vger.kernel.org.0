Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1636A5AA04E
	for <lists+linux-edac@lfdr.de>; Thu,  1 Sep 2022 21:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbiIATn3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Sep 2022 15:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiIATn3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Sep 2022 15:43:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3358C696CE;
        Thu,  1 Sep 2022 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662061408; x=1693597408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+KjT95G5kF5GHfkSihejwy6zK0A0g4kfEgY4RnNnD+o=;
  b=gMflVZAXdLcCriP1eip7g1ZDc5vWZLDCwA8EZMGzWPutc/xTWInpFEAR
   o7yKd5Y0GQkIWxt1apl4MDe1ma8vEQwB4Q9Ss1eHbH6samepwA9s6bE3t
   93VgrcJKDgJEzDnS/e/2d/HUmS30yuc7U6PrNMB+VuQmrKLDJidOrn+XF
   Wn0VD1x9obUO14Cyzk4NsL/X9UrvsrYZrRT+7kMyG4gFoEagRkAKlb4oi
   4yuo/zuasZlurPcPG0wVH5skYzneddU6yj8UFiTODulrDHpcjbp7ky/s6
   0Eo7SV5FD+WWDSBdGSfVsbySWUlLy/3vso0wWCxbRwqb4kxPIiZY1YaAx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="278830154"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="278830154"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:43:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="674020249"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:43:20 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     linux-edac@vger.kernel.org
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH 1/3] EDAC/skx_common: Use driver decoder first
Date:   Thu,  1 Sep 2022 12:43:08 -0700
Message-Id: <20220901194310.115427-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220901194310.115427-1-tony.luck@intel.com>
References: <20220901194310.115427-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

The performance of driver decoder[1] is better than the performance
of firmware decoder[2], especially on frequent correctable errors.

So use the driver decoder first, fall back to firmware decoder if
the driver decoder is unavailable. Also rename the function pointer
skx_decode to driver_decode (better name to contrast with adxl_decode).

[1] Decode errors by extracting error information from registers of
    memory controllers and/or MCA bank registers.

[2] Decode errors by calling ACPI DSM methods.

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/skx_common.h |  1 +
 drivers/edac/skx_base.c   |  9 +++++++--
 drivers/edac/skx_common.c | 16 +++++++++-------
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 03ac067a80b9..880ecd15ca42 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -136,6 +136,7 @@ struct decoded_addr {
 	int	column;
 	int	bank_address;
 	int	bank_group;
+	bool	decoded_by_adxl;
 };
 
 struct res_config {
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 1abc020d49ab..7e2762f62eec 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -714,8 +714,13 @@ static int __init skx_init(void)
 
 	skx_set_decode(skx_decode, skx_show_retry_rd_err_log);
 
-	if (nvdimm_count && skx_adxl_get() == -ENODEV)
-		skx_printk(KERN_NOTICE, "Only decoding DDR4 address!\n");
+	if (nvdimm_count && skx_adxl_get() != -ENODEV) {
+		skx_set_decode(NULL, skx_show_retry_rd_err_log);
+	} else {
+		if (nvdimm_count)
+			skx_printk(KERN_NOTICE, "Only decoding DDR4 address!\n");
+		skx_set_decode(skx_decode, skx_show_retry_rd_err_log);
+	}
 
 	/* Ensure that the OPSTATE is set correctly for POLL or NMI */
 	opstate_init();
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 19c17c5198c5..9b10c359849b 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -40,7 +40,7 @@ static char *adxl_msg;
 static unsigned long adxl_nm_bitmap;
 
 static char skx_msg[MSG_SIZE];
-static skx_decode_f skx_decode;
+static skx_decode_f driver_decode;
 static skx_show_retry_log_f skx_show_retry_rd_err_log;
 static u64 skx_tolm, skx_tohm;
 static LIST_HEAD(dev_edac_list);
@@ -173,6 +173,8 @@ static bool skx_adxl_decode(struct decoded_addr *res, bool error_in_1st_level_me
 			break;
 	}
 
+	res->decoded_by_adxl = true;
+
 	return true;
 }
 
@@ -183,7 +185,7 @@ void skx_set_mem_cfg(bool mem_cfg_2lm)
 
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log)
 {
-	skx_decode = decode;
+	driver_decode = decode;
 	skx_show_retry_rd_err_log = show_retry_log;
 }
 
@@ -591,7 +593,7 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 			break;
 		}
 	}
-	if (adxl_component_count) {
+	if (res->decoded_by_adxl) {
 		len = snprintf(skx_msg, MSG_SIZE, "%s%s err_code:0x%04x:0x%04x %s",
 			 overflow ? " OVERFLOW" : "",
 			 (uncorrected_error && recoverable) ? " recoverable" : "",
@@ -651,11 +653,11 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	memset(&res, 0, sizeof(res));
 	res.addr = mce->addr;
 
-	if (adxl_component_count) {
-		if (!skx_adxl_decode(&res, skx_error_in_1st_level_mem(mce)))
+	/* Try driver decoder first */
+	if (!(driver_decode && driver_decode(&res))) {
+		/* Then try firmware decoder (ACPI DSM methods) */
+		if (!(adxl_component_count && skx_adxl_decode(&res, skx_error_in_1st_level_mem(mce))))
 			return NOTIFY_DONE;
-	} else if (!skx_decode || !skx_decode(&res)) {
-		return NOTIFY_DONE;
 	}
 
 	mci = res.dev->imc[res.imc].mci;
-- 
2.37.1

