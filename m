Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2EB5F1709
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiJAAOc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiJAAOX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:14:23 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 625481BE782;
        Fri, 30 Sep 2022 17:14:20 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 6FF28E0EDF;
        Fri, 30 Sep 2022 02:36:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=WgybnlpSz0qS5C7sJdcvK9CZJlWSVytqDqGCt1J2e9k=; b=fjC8Tt7ZuKuy
        ffoYrADyzQc2KqhRVpmr6GC22yt5bBiVUFWg/exM/Obyu7jOa+7PXqorO947HvIb
        Nh8jAH+NxLnM5Y2yMRHu9Q7NpDL4IzfcO1Hq9+s24n+1mPAEOz5AX8OzKJAvosXJ
        xcex/VTp8qT1BegOvjBRT31zDHsgAcs=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 6318FE0E70;
        Fri, 30 Sep 2022 02:36:39 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:36:40 +0300
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
Subject: [PATCH RESEND v3 12/18] EDAC/synopsys: Read data syndrome on errors
Date:   Fri, 30 Sep 2022 02:35:24 +0300
Message-ID: <20220929233530.13016-13-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929233530.13016-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929233530.13016-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

In case of the corrected and uncorrected errors DW uMCTL2 DDR controller
preserves the ECC syndrome of the erroneous data pattern in the ECCCSYN2
and ECCUSYN2 CSRs [1]. Seeing the MCI core permits supplying the ECC
syndrome to the error reporting method, let's read it from the CSRs and
pass the value out to the core so to provide more details of the happened
error.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.826, p.837

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 00417f368893..805ab7879000 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -302,6 +302,7 @@ struct snps_ddrc_info {
  * @bankgrp:	Bank group number.
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
+ * @syndrome:	Erroneous data syndrome.
  */
 struct snps_ecc_error_info {
 	u32 row;
@@ -310,6 +311,7 @@ struct snps_ecc_error_info {
 	u32 bankgrp;
 	u32 bitpos;
 	u64 data;
+	u32 syndrome;
 };
 
 /**
@@ -421,9 +423,7 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 	if (priv->info.dq_width == SNPS_DQ_64)
 		p->ceinfo.data |= (u64)readl(base + ECC_CSYND1_OFST) << 32;
 
-	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
-		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
-		 readl(base + ECC_CSYND2_OFST));
+	p->ceinfo.syndrome = readl(base + ECC_CSYND2_OFST);
 
 ue_err:
 	if (!p->ue_cnt)
@@ -441,6 +441,8 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 	if (priv->info.dq_width == SNPS_DQ_64)
 		p->ueinfo.data |= (u64)readl(base + ECC_UESYND1_OFST) << 32;
 
+	p->ueinfo.syndrome = readl(base + ECC_UESYND2_OFST);
+
 out:
 	spin_lock_irqsave(&priv->lock, flags);
 
@@ -475,7 +477,7 @@ static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *
 			 pinf->bitpos, pinf->data);
 
 		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
-				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
+				     p->ce_cnt, 0, 0, pinf->syndrome, 0, 0, -1,
 				     priv->message, "");
 	}
 
@@ -488,7 +490,7 @@ static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *
 			 pinf->data);
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
-				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
+				     p->ue_cnt, 0, 0, pinf->syndrome, 0, 0, -1,
 				     priv->message, "");
 	}
 
-- 
2.37.3


