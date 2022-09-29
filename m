Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402E85F16FA
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiJAAOX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiJAAOV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:14:21 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DB611BE78C;
        Fri, 30 Sep 2022 17:14:19 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id B9DD0E0EE1;
        Fri, 30 Sep 2022 02:36:40 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=YDzYuOyuDWeLpM4botukPDxFRqBQd1koKC81hFPdd2Q=; b=fxhBJcJS0XdK
        wzUpSA/CLfYsVvdrEqKui019XvcrQw+EtHUpcOa3xiGkwIUgpWAG5uar3NTTDoit
        6uLPEsP/9ccfbQ2G6+KEOI8SVfH6jCEM7MDKvX3bYRoFRMeojJqWTRF7QW+zPSAq
        xzv5Roig5u+tp0nEiM1aJjnzP2LSTSM=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id AD9EFE0E70;
        Fri, 30 Sep 2022 02:36:40 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:36:41 +0300
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
Subject: [PATCH RESEND v3 14/18] EDAC/synopsys: Simplify HIF/SDRAM column mapping get procedure
Date:   Fri, 30 Sep 2022 02:35:26 +0300
Message-ID: <20220929233530.13016-15-Sergey.Semin@baikalelectronics.ru>
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

What is currently implemented in the driver by means of the multiple
if-else-if-else statements in fact is described in the hardware reference
manual [1]. It says:
1. All of the column bits shift up 1 bit when only half of the data bus is
in use. In this case, for instance, you need to look at
ADDRMAP3.addrmap_col_b6 instead to determine the value of column address
bit 7.
2. All of the column bits shift up 2 bits when only a quarter of the data
bus is in use. In this case, for instance, you need to look at
ADDRMAP2.addrmap_col_b5 instead to determine the value of column address
bit 7.
3. In addition to the above, the column bit 10 is reserved for the
auto-precharge command in DDR2/3/4/mDDR. So the column bits must be
further shifted up 1 bit when one of these DDR protocols is enabled.

So taking into account all of the notes above and what the column bit 12
is always reserved, the SDRAM column bits mapping procedure can be
significantly simplified. Initially we get to read the mapping as if for
the LPDDR2/3/4 memory with Full DQ-bus utilized. Then we shift the column
bits up in accordance with the detected DQ-bus width mode. That's it.
Simple, canonical and scalable.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 83 ++++++++++++------------------------
 1 file changed, 27 insertions(+), 56 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 9baa62f6d22b..9c4f7d60b820 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -990,8 +990,22 @@ static void snps_get_hif_col_map(struct snps_edac_priv *priv, u32 *addrmap)
 	map->col[9] = map->col[9] == DDR_ADDRMAP_MAX_15 ?
 		      DDR_ADDRMAP_UNUSED : map->col[9] + COL_B9_BASE;
 
+	map->col[10] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[4]);
+	map->col[10] = map->col[10] == DDR_ADDRMAP_MAX_15 ?
+		      DDR_ADDRMAP_UNUSED : map->col[10] + COL_B10_BASE;
+
+	map->col[11] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[4]);
+	map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
+		      DDR_ADDRMAP_UNUSED : map->col[11] + COL_B11_BASE;
+
+	/*
+	 * In case of the non-Full DQ bus mode the lowest columns are
+	 * unmapped and used by the controller to read the full DQ word
+	 * in multiple cycles (col[0] for the Half bus mode, col[0:1] for
+	 * the Quarter bus mode).
+	 */
 	if (priv->info.dq_mode) {
-		for (i = 9; i > priv->info.dq_mode; i--) {
+		for (i = 11 + priv->info.dq_mode; i >= priv->info.dq_mode; i--) {
 			map->col[i] = map->col[i - priv->info.dq_mode];
 			map->col[i - priv->info.dq_mode] = DDR_ADDRMAP_UNUSED;
 		}
@@ -1001,65 +1015,22 @@ static void snps_get_hif_col_map(struct snps_edac_priv *priv, u32 *addrmap)
 	 * Per JEDEC DDR2/3/4/mDDR specification, column address bit 10 is
 	 * reserved for indicating auto-precharge, and hence no source
 	 * address bit can be mapped to col[10].
+	 */
+	if (priv->info.sdram_mode == MEM_LPDDR || priv->info.sdram_mode == MEM_DDR2 ||
+	    priv->info.sdram_mode == MEM_DDR3 || priv->info.sdram_mode == MEM_DDR4) {
+		for (i = 12 + priv->info.dq_mode; i > 10; i--) {
+			map->col[i] = map->col[i - 1];
+			map->col[i - 1] = DDR_ADDRMAP_UNUSED;
+		}
+	}
+
+	/*
 	 * Per JEDEC specification, column address bit 12 is reserved
 	 * for the Burst-chop status, so no source address bit mapping
 	 * for col[12] either.
 	 */
-	if (priv->info.dq_mode == SNPS_DQ_FULL) {
-		if (priv->info.sdram_mode == MEM_LPDDR3) {
-			map->col[10] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[4]);
-			map->col[10] = map->col[10] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[10] + COL_B10_BASE;
-
-			map->col[11] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[4]);
-			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B11_BASE;
-		} else {
-			map->col[11] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[4]);
-			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B10_BASE;
-
-			map->col[13] = FIELD_GET(DDR_ADDRMAP_B8_M15, addrmap[4]);
-			map->col[13] = map->col[13] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[13] + COL_B11_BASE;
-		}
-	} else if (priv->info.dq_mode == SNPS_DQ_HALF) {
-		if (priv->info.sdram_mode == MEM_LPDDR3) {
-			map->col[10] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[3]);
-			map->col[10] = map->col[10] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[10] + COL_B9_BASE;
-
-			map->col[11] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[4]);
-			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B10_BASE;
-		} else {
-			map->col[11] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[3]);
-			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B9_BASE;
-
-			map->col[13] = FIELD_GET(DDR_ADDRMAP_B0_M15, addrmap[4]);
-			map->col[13] = map->col[13] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[13] + COL_B10_BASE;
-		}
-	} else {
-		if (priv->info.sdram_mode == MEM_LPDDR3) {
-			map->col[10] = FIELD_GET(DDR_ADDRMAP_B16_M15, addrmap[3]);
-			map->col[10] = map->col[10] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[10] + COL_B8_BASE;
-
-			map->col[11] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[3]);
-			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B9_BASE;
-		} else {
-			map->col[11] = FIELD_GET(DDR_ADDRMAP_B16_M15, addrmap[3]);
-			map->col[11] = map->col[11] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[11] + COL_B8_BASE;
-
-			map->col[11] = FIELD_GET(DDR_ADDRMAP_B24_M15, addrmap[3]);
-			map->col[13] = map->col[13] == DDR_ADDRMAP_MAX_15 ?
-				       DDR_ADDRMAP_UNUSED : map->col[13] + COL_B9_BASE;
-		}
-	}
+	map->col[13] = map->col[12];
+	map->col[12] = DDR_ADDRMAP_UNUSED;
 }
 
 /**
-- 
2.37.3


