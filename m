Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B58FD105987
	for <lists+linux-edac@lfdr.de>; Thu, 21 Nov 2019 19:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfKUS3Z (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 21 Nov 2019 13:29:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:51962 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUS3Z (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 21 Nov 2019 13:29:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 10:29:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,226,1571727600"; 
   d="scan'208";a="381823392"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga005.jf.intel.com with ESMTP; 21 Nov 2019 10:29:23 -0800
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com
Cc:     Meng.Li@windriver.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCHv2 2/3] EDAC/altera: Cleanup the ECC Manager
Date:   Thu, 21 Nov 2019 12:30:47 -0600
Message-Id: <1574361048-17572-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574361048-17572-1-git-send-email-thor.thayer@linux.intel.com>
References: <1574361048-17572-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Cleanup the ECC Manager peripheral test in probe function as suggested
by James. Remove the check for Stratix10.

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
V2 No change
---
 drivers/edac/altera_edac.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 0be3d1b17f03..3e86cf327ad0 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1014,11 +1014,6 @@ static int socfpga_is_a10(void)
 	return of_machine_is_compatible("altr,socfpga-arria10");
 }
 
-static int socfpga_is_s10(void)
-{
-	return of_machine_is_compatible("altr,socfpga-stratix10");
-}
-
 static __init int __maybe_unused
 altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 			u32 ecc_ctrl_en_mask, bool dual_port)
@@ -1126,9 +1121,6 @@ static int __init __maybe_unused altr_init_a10_ecc_device_type(char *compat)
 	int irq;
 	struct device_node *child, *np;
 
-	if (!socfpga_is_a10() && !socfpga_is_s10())
-		return -ENODEV;
-
 	np = of_find_compatible_node(NULL, NULL,
 				     "altr,socfpga-a10-ecc-manager");
 	if (!np) {
@@ -2271,18 +2263,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		if (!of_device_is_available(child))
 			continue;
 
-		if (of_device_is_compatible(child, "altr,socfpga-a10-l2-ecc") || 
-		    of_device_is_compatible(child, "altr,socfpga-a10-ocram-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-eth-mac-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-nand-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-dma-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-usb-ecc") ||
-		    of_device_is_compatible(child, "altr,socfpga-qspi-ecc") ||
-#ifdef CONFIG_EDAC_ALTERA_SDRAM
-		    of_device_is_compatible(child, "altr,sdram-edac-s10") ||
-#endif
-		    of_device_is_compatible(child, "altr,socfpga-sdmmc-ecc"))
-
+		if (of_match_node(altr_edac_a10_device_of_match, child))
 			altr_edac_a10_device_add(edac, child);
 
 #ifdef CONFIG_EDAC_ALTERA_SDRAM
-- 
2.7.4

