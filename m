Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0678E5F16F7
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiJAAOW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiJAAOU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:14:20 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D2F81BE784;
        Fri, 30 Sep 2022 17:14:15 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id C8A69E0EDE;
        Fri, 30 Sep 2022 02:36:38 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=okIVpyfoGlEW1Hxvcm8w+CRE1E3C28Kn50cbDgxN1aw=; b=DoaSgVqbi6VV
        tvW2KlYOXGxYxz5e9HaIf/DaByJs3heDLdMyB1I6VGMiUNMGQiAMg26XvQRP6D+W
        h1vW66UZ5CpkHrOnNM0ianigCDTfukDYSRaWmzLVc0veCpvrNIgbLIb5RPX2R+xP
        WF2Hfo10bX1OksN7gUIITsUHrYjndPQ=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id BD331E0E70;
        Fri, 30 Sep 2022 02:36:38 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:36:39 +0300
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
Subject: [PATCH RESEND v3 11/18] EDAC/synopsys: Read full data pattern on errors
Date:   Fri, 30 Sep 2022 02:35:23 +0300
Message-ID: <20220929233530.13016-12-Sergey.Semin@baikalelectronics.ru>
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

DW uMCTL2 DDRC calculates ECC for the DQ-bus word. If non-Full bus width
mode is activated the leftover DQ-bits will be padded with zeros, but the
ECC syndrome is calculated for the whole width anyway [1]. For some reason
the DW uMCTL2 DDRC driver currently doesn't read the whole SDRAM word in
case of the ECC errors even though the 64-bit DQ-bus has been supported
for a long time. Let's fix that by extending the data field of the ECC
error info structure and reading the upper 32-bits part of the data
pattern if an ECC error happens and the DDR controller has been configured
with the 64-bits DQ bus. As before the data will be printed as a part of
the custom error message passed to the edac_mc_handle_error() method.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.424-425

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 1cfbc5a2a564..00417f368893 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -309,7 +309,7 @@ struct snps_ecc_error_info {
 	u32 bank;
 	u32 bankgrp;
 	u32 bitpos;
-	u32 data;
+	u64 data;
 };
 
 /**
@@ -418,6 +418,8 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 	p->ceinfo.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
 
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
+	if (priv->info.dq_width == SNPS_DQ_64)
+		p->ceinfo.data |= (u64)readl(base + ECC_CSYND1_OFST) << 32;
 
 	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
 		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
@@ -436,6 +438,8 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 	p->ueinfo.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
 
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
+	if (priv->info.dq_width == SNPS_DQ_64)
+		p->ueinfo.data |= (u64)readl(base + ECC_UESYND1_OFST) << 32;
 
 out:
 	spin_lock_irqsave(&priv->lock, flags);
@@ -466,7 +470,7 @@ static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *
 		pinf = &p->ceinfo;
 
 		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
-			 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08x",
+			 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08llx",
 			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
 			 pinf->bitpos, pinf->data);
 
@@ -479,8 +483,9 @@ static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *
 		pinf = &p->ueinfo;
 
 		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
-			 "Row %d Col %d Bank %d Bank Group %d",
-			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp);
+			 "Row %d Col %d Bank %d Bank Group %d Data 0x%08llx",
+			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
+			 pinf->data);
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
 				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
-- 
2.37.3


