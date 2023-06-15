Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33B9730D37
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 04:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbjFOC0J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Jun 2023 22:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjFOC0J (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Jun 2023 22:26:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606F31FE2;
        Wed, 14 Jun 2023 19:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686795968; x=1718331968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SLNeuotNLMI/3Ntsow9FV7NDL8oIwObXrmZLtFT8TiM=;
  b=mw9jnnXZpW/gxR3XJ6B6tpMogArfMSMdbiMyfwVWqos9VmrAI/fBytLz
   IhZufN43JlH14MOAOu4V4rRU3qiVsEtor56JrbHhYCD1MoLzTFp1G4IE2
   UZbSNNQ1U8CLChe8JBH+Pe12QFkDXKoEd/A6nlhk+HQY3CIv6728mhn5q
   4eg0jRcCleEfyyLVQDJh44R6s3jsQhHQg120LW5mHiAP4oUl+3Jaa1biQ
   aVk8diLklYVKMQJ5GCg7E6cFURH2y/yzhE4mehz/60KvtluZDf3pIHZ2/
   wscIApdVITuHWgltac8VKARIQQZ78ZVs1xt2yjram6hJfTwUbejF7ieKf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361270562"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="361270562"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 19:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="856753144"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="856753144"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2023 19:25:59 -0700
From:   niravkumar.l.rabara@intel.com
To:     niravkumar.l.rabara@intel.com
Cc:     bp@alien8.de, dinguyen@kernel.org, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, rric@kernel.org, tony.luck@intel.com
Subject: [PATCH v4 1/1] EDAC/altera: Check previous DDR DBE during driver probe
Date:   Thu, 15 Jun 2023 10:25:34 +0800
Message-Id: <20230615022534.4163918-2-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615022534.4163918-1-niravkumar.l.rabara@intel.com>
References: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
 <20230615022534.4163918-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add DDR DBE check during driver probe to notify user if previous
reboot cause by DDR DBE and print DBE error related information.

Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 drivers/edac/altera_edac.c                   | 29 ++++++++++++++++----
 include/linux/firmware/intel/stratix10-smc.h | 20 ++++++++++++++
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 8b31cd54bdb6..04c0675adc8c 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2159,6 +2159,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 #ifdef CONFIG_64BIT
 	{
 		int dberror, err_addr;
+		struct arm_smccc_res result;
 
 		edac->panic_notifier.notifier_call = s10_edac_dberr_handler;
 		atomic_notifier_chain_register(&panic_notifier_list,
@@ -2168,11 +2169,29 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		regmap_read(edac->ecc_mgr_map, S10_SYSMGR_UE_VAL_OFST,
 			    &dberror);
 		if (dberror) {
-			regmap_read(edac->ecc_mgr_map, S10_SYSMGR_UE_ADDR_OFST,
-				    &err_addr);
-			edac_printk(KERN_ERR, EDAC_DEVICE,
-				    "Previous Boot UE detected[0x%X] @ 0x%X\n",
-				    dberror, err_addr);
+			/* Bit-31 is set if previous DDR UE happened */
+			if (dberror & (1 << 31)) {
+				/* Read previous DDR UE info */
+				arm_smccc_smc(INTEL_SIP_SMC_READ_SEU_ERR, 0,
+					      0, 0, 0, 0, 0, 0, &result);
+
+				if (!result.a0) {
+					edac_printk(KERN_ERR, EDAC_DEVICE,
+						    "Previous DDR UE:Count=0x%X,Address=0x%X,ErrorData=0x%X\n"
+						    , (unsigned int)result.a1
+						    , (unsigned int)result.a2
+						    , (unsigned int)result.a3);
+				} else {
+					edac_printk(KERN_ERR, EDAC_DEVICE,
+						    "INTEL_SIP_SMC_SEU_ERR_STATUS failed\n");
+				}
+			} else {
+				regmap_read(edac->ecc_mgr_map, S10_SYSMGR_UE_ADDR_OFST,
+					    &err_addr);
+				edac_printk(KERN_ERR, EDAC_DEVICE,
+					    "Previous Boot UE detected[0x%X] @ 0x%X\n",
+					    dberror, err_addr);
+			}
 			/* Reset the sticky registers */
 			regmap_write(edac->ecc_mgr_map,
 				     S10_SYSMGR_UE_VAL_OFST, 0);
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index a718f853d457..48810c39f612 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -595,4 +595,24 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
 
+/**
+ * Request INTEL_SIP_SMC_READ_SEU_ERR
+ * Sync call to get Single Event Upset Error information
+ * SEU detects both corrected and uncorrected error
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_READ_SEU_ERR
+ * a1-7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 error count of response data
+ * a2 sector address of response data
+ * a3 error data
+ */
+#define INTEL_SIP_SMC_FUNCID_SEU_ERR_STATUS 153
+#define INTEL_SIP_SMC_READ_SEU_ERR \
+		INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_SEU_ERR_STATUS)
+
 #endif
-- 
2.25.1

