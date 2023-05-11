Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438C66FEA87
	for <lists+linux-edac@lfdr.de>; Thu, 11 May 2023 06:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjEKEMo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 May 2023 00:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjEKEMj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 May 2023 00:12:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B754EDA;
        Wed, 10 May 2023 21:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683778359; x=1715314359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=axe73vAyyjPq73X02dATlO5y4758SkBzgXH7klxT9xs=;
  b=ImG62oimcSMkmeNbIqKWsvavz4UOepK29KSfhS1vOuS3p6TdlHSOKq+k
   ElpVcEGVCipbnQ1OEnMlQhB0NDPAtlma+6eTBVVEmWFdEs8wGd/xz9mi8
   Ez3ihR9uUrfljwh4Z8/iz+ke86M9Fw4OitxbJ16IPpyzWqGIIx/titxG0
   GnkAuezXD3DwxjdJW4fxRoNr37mQzaBzyeVRGYmoN0ACAdVihVp5Mofq5
   /QuL8fKxe/EkFdv9QOyItwQYJ+EYtJqZ6DJstWZqR9knf9FFNZVY5KQUK
   kHZOdhFvOTXcfVb3tKAbrWgCE2vf1N2G8YajwHpirhwoYACZEcwRDBC45
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="347854511"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="347854511"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2023 21:12:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10706"; a="1029467225"
X-IronPort-AV: E=Sophos;i="5.99,266,1677571200"; 
   d="scan'208";a="1029467225"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga005.fm.intel.com with ESMTP; 10 May 2023 21:12:36 -0700
From:   niravkumar.l.rabara@intel.com
To:     niravkumar.l.rabara@intel.com
Cc:     bp@alien8.de, dinguyen@kernel.org, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, rric@kernel.org, tony.luck@intel.com
Subject: [PATCH v3 2/2] EDAC/altera: Check previous DDR DBE during driver probe
Date:   Thu, 11 May 2023 12:12:21 +0800
Message-Id: <20230511041221.135527-3-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230511041221.135527-1-niravkumar.l.rabara@intel.com>
References: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
 <20230511041221.135527-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/edac/altera_edac.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

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
-- 
2.25.1

