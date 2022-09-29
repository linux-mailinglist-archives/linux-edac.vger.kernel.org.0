Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F705F1701
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiJAAOc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiJAAOW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:14:22 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E38A81BE788;
        Fri, 30 Sep 2022 17:14:21 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 7C741E0EDC;
        Fri, 30 Sep 2022 02:36:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=+gffREL+K6veIlsNb4BHOvW1gUCYTw2NHh8nSyrRSlc=; b=lwHIMY2KU1CZ
        NGgHUANrRRDsCgZcqlyN86o+7UYosHOWzdGPqmTlaF+z4pY8GTkZJu8wGhHbbLzw
        soK6+8MUXb0ix0Qs0r0w2xghDUOB8W/YJ5Z5S0njFdupPt7f0sbrIUCozwe9c91r
        zJKpiKitvoGDWmgOBe9pGQbFIpJVJDo=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 6F4BEE0E70;
        Fri, 30 Sep 2022 02:36:37 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:36:38 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3 09/18] EDAC/synopsys: Set actual DIMM ECC errors grain
Date:   Fri, 30 Sep 2022 02:35:21 +0300
Message-ID: <20220929233530.13016-10-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929233530.13016-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929233530.13016-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

It was wrong to set the DIMM errors grain parameter to just 1 byte because
DW uMCTL2 DDRC calculates ECC for each SDRAM word and passes it as an
additional byte of data to the memory chips. SDRAM word is the actual
DQ-bus width determined by the DQ-width set during the IP-core synthesize
and the DQ-bus mode (part of the DQ-bus actually used to get data from the
memory chips) selected during the DDR controller initial setup procedure.
Thus let's set the MCI DIMMs grain based on these parameters determined
during the DW uMCTL2 DDRC config getting procedure.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 87acb683ab5c..c0e5476d5c85 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -26,9 +26,6 @@
 /* Number of channels per memory controller */
 #define SNPS_EDAC_NR_CHANS		1
 
-/* Granularity of reported error in bytes */
-#define SNPS_EDAC_ERR_GRAIN		1
-
 #define SNPS_EDAC_MSG_SIZE		256
 
 #define SNPS_EDAC_MOD_STRING		"snps_edac"
@@ -733,9 +730,12 @@ static void snps_init_csrows(struct mem_ctl_info *mci)
 	struct snps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
-	u32 size, row;
+	u32 size, row, width;
 	int j;
 
+	/* Actual SDRAM-word width for which ECC is calculated */
+	width = 1U << (priv->info.dq_width - priv->info.dq_mode);
+
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
 		size = snps_get_memsize();
@@ -745,7 +745,7 @@ static void snps_init_csrows(struct mem_ctl_info *mci)
 			dimm->edac_mode	= EDAC_SECDED;
 			dimm->mtype	= priv->info.sdram_mode;
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
-			dimm->grain	= SNPS_EDAC_ERR_GRAIN;
+			dimm->grain	= width;
 			dimm->dtype	= priv->info.dev_cfg;
 		}
 	}
-- 
2.37.3


