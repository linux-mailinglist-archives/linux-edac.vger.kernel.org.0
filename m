Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCFE59C852
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiHVTPW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238361AbiHVTO5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:14:57 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C39A2DAA6;
        Mon, 22 Aug 2022 12:14:56 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id BFFCEDAF;
        Mon, 22 Aug 2022 22:17:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com BFFCEDAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195872;
        bh=qk5PF40MhORN4hopt80I1DJzdF9gJ4cgPQgi7eRr1Ms=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=rCK8CXtfzYcn947RIcZ6zYHwC53LQovu0VKYM0w9NyVW/Ij63uUOueTOqZBpLuoN1
         x4myVh/n4jQYvPkmF4SNW1mGjLyJ1u/i+U/q7QgOj4LA7W04WT8iKIaQrv04e8+O40
         7awTfQnNL9UD+hB7y63hGLaq1pi7ihcaDst8kdSk=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:14:38 +0300
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
Subject: [PATCH 14/18] EDAC/synopsys: Simplify HIF/SDRAM column mapping get procedure
Date:   Mon, 22 Aug 2022 22:14:23 +0300
Message-ID: <20220822191427.27969-15-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822191427.27969-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822191427.27969-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
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
index 81d14042ed4c..62b925abbcb4 100644
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
2.35.1

