Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAE16F4F00
	for <lists+linux-edac@lfdr.de>; Wed,  3 May 2023 05:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjECDH2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 May 2023 23:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjECDHK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 2 May 2023 23:07:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778B03C31;
        Tue,  2 May 2023 20:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683083224; x=1714619224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rt+NiPHzZk0ufSm8/klt7oGsdG1fjJ5fZs7aIMtC/FE=;
  b=nMG8PNPN5V54JtguOPgZjez9lNHC6AALWkpOBQz2ZE5gctGFh6uPNSAA
   FwlsXtoYwI2seNF2QNcC84YdUivDsem7OCfWUYvSLOkenQT8SVeBnD5hk
   xJ/HGYB6wYoRgAj+qPcEC7W9HG1feqh6unFBq3NgDciIsWksqTS4tzCUh
   QAwxj/vJvxAHfYQtAsKEY4WO8tjvZrE0+flyumEVxggvegWwd1h2gEZLW
   +qkvNsG7+q1B9l+xn+V1nc8NmUq6rZqTxuVgxg2wOUGyo6RCDe7lyZUQp
   nqx/A4ot1mb2UOwr+yj+4q2xAVGeLKdJhh75+SYfAwI5h2IVdlJxLoJub
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="347370857"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="347370857"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2023 20:07:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="765983763"
X-IronPort-AV: E=Sophos;i="5.99,246,1677571200"; 
   d="scan'208";a="765983763"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.116])
  by fmsmga004.fm.intel.com with ESMTP; 02 May 2023 20:07:01 -0700
From:   niravkumar.l.rabara@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Subject: [PATCH 2/2] EDAC/altera: Check previous DDR DBE during driver probe
Date:   Wed,  3 May 2023 11:06:56 +0800
Message-Id: <20230503030656.3269321-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

