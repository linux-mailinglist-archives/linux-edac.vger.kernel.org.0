Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB275F16FB
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiJAAOX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiJAAOV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:14:21 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C583D1BE788;
        Fri, 30 Sep 2022 17:14:19 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 225DDE0ED9;
        Fri, 30 Sep 2022 02:36:36 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=+4CnoI1Och8RfWq5lk3Wp2ogQ+AivldUPbPw9ueGlvc=; b=d8BReDONNU+t
        Mui8MTS+mrtGjJUQBh7Qa1K6sMglMvNRxXWRxfX1YlyIsPDoVKlxGzSdeVYd3mRl
        RlE0KTOMWFZlO74Q9Hlp4DumCv7XXfDno4IRbo+NLOmyIia2+2sfwTi7ABoq9qXe
        4NVfNaIm41cdaMOwYEa9JfkORpX/4dU=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 16198E0E70;
        Fri, 30 Sep 2022 02:36:36 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:36:36 +0300
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
Subject: [PATCH RESEND v3 07/18] EDAC/synopsys: Parse ADDRMAP[7-8] CSRs for (LP)DDR4 only
Date:   Fri, 30 Sep 2022 02:35:19 +0300
Message-ID: <20220929233530.13016-8-Sergey.Semin@baikalelectronics.ru>
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

These CSRs contain the SDRAM Bank Groups and row[16]/row[17] bits mapping,
which are applicable for the DDR4 and LPDDR4 memory only. For the rest of
the memories the ADDRMAP[7-8] are unused by the controller and may be read
as garbage (for instance, return an outcome of the previous read
operation). The retrieved values might be perceived by the HIF/SDRAM
mapping detection procedure as normal bit positions, which is wrong. So
let's parse these registers only if they are applicable for the detected
DDR protocol.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 2d323afa288b..a55ae7ff931c 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1005,12 +1005,15 @@ static void snps_setup_row_address_map(struct snps_edac_priv *priv, u32 *addrmap
 	priv->row_shift[15] = (((addrmap[6] >> 24) & ROW_MAX_VAL_MASK) ==
 				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 24) &
 				ROW_MAX_VAL_MASK) + ROW_B15_BASE);
-	priv->row_shift[16] = ((addrmap[7] & ROW_MAX_VAL_MASK) ==
-				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[7] &
-				ROW_MAX_VAL_MASK) + ROW_B16_BASE);
-	priv->row_shift[17] = (((addrmap[7] >> 8) & ROW_MAX_VAL_MASK) ==
-				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[7] >> 8) &
-				ROW_MAX_VAL_MASK) + ROW_B17_BASE);
+
+	if (priv->info.sdram_mode == MEM_DDR4 || priv->info.sdram_mode == MEM_LPDDR4) {
+		priv->row_shift[16] = ((addrmap[7] & ROW_MAX_VAL_MASK) ==
+					ROW_MAX_VAL_MASK) ? 0 : ((addrmap[7] &
+					ROW_MAX_VAL_MASK) + ROW_B16_BASE);
+		priv->row_shift[17] = (((addrmap[7] >> 8) & ROW_MAX_VAL_MASK) ==
+					ROW_MAX_VAL_MASK) ? 0 : (((addrmap[7] >> 8) &
+					ROW_MAX_VAL_MASK) + ROW_B17_BASE);
+	}
 }
 
 static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addrmap)
@@ -1126,6 +1129,10 @@ static void snps_setup_bank_address_map(struct snps_edac_priv *priv, u32 *addrma
 
 static void snps_setup_bg_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
+	/* Bank group signals are available on the DDR4 memory only */
+	if (priv->info.sdram_mode != MEM_DDR4)
+		return;
+
 	priv->bankgrp_shift[0] = (addrmap[8] &
 				BANKGRP_MAX_VAL_MASK) + BANKGRP_B0_BASE;
 	priv->bankgrp_shift[1] = (((addrmap[8] >> 8) & BANKGRP_MAX_VAL_MASK) ==
-- 
2.37.3


