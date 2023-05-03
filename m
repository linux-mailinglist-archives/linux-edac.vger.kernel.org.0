Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C673D6F55DB
	for <lists+linux-edac@lfdr.de>; Wed,  3 May 2023 12:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjECKSx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 May 2023 06:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjECKSu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 3 May 2023 06:18:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395F446B7;
        Wed,  3 May 2023 03:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683109129; x=1714645129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rt+NiPHzZk0ufSm8/klt7oGsdG1fjJ5fZs7aIMtC/FE=;
  b=nbK/0hW1zDgDugijHefcGDHBs3v5JdIOgzAGwS1dInHMEQuOt2Auw12P
   EVmuLmV1fv/oCamI1BSrpNBUR94QLBWbOzgf5EW5GDFU94goxjcBZX75W
   Fiipoj9Go3EGgK+kcKxbkK9371hLzH3I5B27HqvJmukK+10cCuDH5fipK
   7vHs/WG4F7zYUP/2Xui9DAv4S/G74075SR58BPtHnv3Z4cgwZ3ZocxLtV
   zdptZ36Ouf2pEUsyrQCFqtPy4kH6imJ9uq/4Xm73ncD5dzXXwoOlO6Kem
   SVqvrYWzrxvCqmT7pN4SWhoccbghV+lUZzTCUYqFwjW7Xf/KVD/vCqGY1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="332982811"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="332982811"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 03:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="820720450"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="820720450"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by orsmga004.jf.intel.com with ESMTP; 03 May 2023 03:18:34 -0700
From:   niravkumar.l.rabara@intel.com
To:     niravkumar.l.rabara@intel.com
Cc:     bp@alien8.de, dinguyen@kernel.org, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, rric@kernel.org, tony.luck@intel.com
Subject: [PATCH v2 2/2] EDAC/altera: Check previous DDR DBE during driver probe
Date:   Wed,  3 May 2023 18:18:21 +0800
Message-Id: <20230503101821.3342935-3-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230503101821.3342935-1-niravkumar.l.rabara@intel.com>
References: <20230503061000.3279381-1-niravkumar.l.rabara@intel.com>
 <20230503101821.3342935-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
index 8b31cd54bdb6..398a49a3eb89 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2159,6 +2159,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 #ifdef CONFIG_64BIT
 	{
 		int dberror, err_addr;
+		struct arm_smccc_res result;
 
 		edac->panic_notifier.notifier_call = s10_edac_dberr_handler;
 		atomic_notifier_chain_register(&panic_notifier_list,
@@ -2168,11 +2169,28 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
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
+					0, 0, 0, 0, 0, 0, &result);
+
+				if (!(int)result.a0) {
+					edac_printk(KERN_ERR, EDAC_DEVICE,
+					"Previous DDR UE:Count=0x%X,Address=0x%X,ErrorData=0x%X\n"
+					, (unsigned int)result.a1, (unsigned int)result.a2
+					, (unsigned int)result.a3);
+				} else {
+					edac_printk(KERN_ERR, EDAC_DEVICE,
+						"INTEL_SIP_SMC_SEU_ERR_STATUS failed\n");
+				}
+			} else {
+				regmap_read(edac->ecc_mgr_map, S10_SYSMGR_UE_ADDR_OFST,
+						&err_addr);
+				edac_printk(KERN_ERR, EDAC_DEVICE,
+						"Previous Boot UE detected[0x%X] @ 0x%X\n",
+						dberror, err_addr);
+			}
 			/* Reset the sticky registers */
 			regmap_write(edac->ecc_mgr_map,
 				     S10_SYSMGR_UE_VAL_OFST, 0);
@@ -2180,6 +2198,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 				     S10_SYSMGR_UE_ADDR_OFST, 0);
 		}
 	}
+
 #else
 	edac->db_irq = platform_get_irq(pdev, 1);
 	if (edac->db_irq < 0)
-- 
2.25.1

