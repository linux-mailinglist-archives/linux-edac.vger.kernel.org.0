Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D85B4869
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiIJTwM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiIJTvS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:51:18 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8180B399F6;
        Sat, 10 Sep 2022 12:50:48 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 0C983DC1;
        Sat, 10 Sep 2022 22:54:20 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 0C983DC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662839660;
        bh=bNJ/SZc3qL5Hy015LB4LZc4W03OXk2Jz7DZzh2puOoc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=rFPM23sDEkhFCFBE1iqwQwWy1AbQ3GFItyGizNHCumEwEEmQKbEpIgnAGCBsRWXRI
         Qyp16rVwSlTtKB+CnP2epIpU1N9d09K9IUBWb+66R2pvAewwq5KAXzvyUC1nrBWgdE
         56jLJhXeGKU3BPJX3RmEhee+KgK4Eit02YPQpxh4=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:50:29 +0300
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
Subject: [PATCH RESEND v2 16/18] EDAC/synopsys: Add erroneous page-frame/offset reporting
Date:   Sat, 10 Sep 2022 22:50:05 +0300
Message-ID: <20220910195007.11027-17-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910195007.11027-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910195007.11027-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since System/SDRAM address translation interface is now available we can
use it to determine the system address causing the ECC faults. In order to
do so first we need to add the System->Application->HIF->SDRAM address
translation procedures based on the DW uMCTL2 DDRC DQ-bus config and
HIF/SDRAM mapping table retrieved on the device probe stage. Secondly for
the sake of simplification we need to convert the snps_ecc_error_info
structure to contain the snps_sdram_addr structure instance, since the
erroneous SDRAM address will now participate in the address translation
chain. Finally we need to perform the SDRAM->System address translation
before passing the later to the edac_mc_handle_error() method.

Note the ECC address rank needs to be retrieved now too in order to
determine a correct system address. But the rank won't be passed to the
MCI core for now since the MCI device is registered with a single ranked
layer 0.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 142 +++++++++++++++++++++++++++++------
 1 file changed, 118 insertions(+), 24 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 26fd797d3f00..946b86149ff8 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/log2.h>
 #include <linux/module.h>
+#include <linux/pfn.h>
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
@@ -344,19 +345,13 @@ struct snps_sdram_addr {
 
 /**
  * struct snps_ecc_error_info - ECC error log information.
- * @row:	Row number.
- * @col:	Column number.
- * @bank:	Bank number.
- * @bankgrp:	Bank group number.
+ * @sdram:	SDRAM address.
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
  * @syndrome:	Erroneous data syndrome.
  */
 struct snps_ecc_error_info {
-	u32 row;
-	u32 col;
-	u32 bank;
-	u32 bankgrp;
+	struct snps_sdram_addr sdram;
 	u32 bitpos;
 	u64 data;
 	u32 syndrome;
@@ -416,6 +411,21 @@ static void snps_map_app_to_hif(struct snps_edac_priv *priv,
 	*hif = app >> priv->info.dq_width;
 }
 
+/**
+ * snps_map_hif_to_app - Map HIF address to Application address.
+ * @priv:	DDR memory controller private instance data.
+ * @hif:	HIF address (source).
+ * @app:	Application address (destination).
+ *
+ * Backward HIF-to-App translation is just the opposite DQ-width-based
+ * shift operation.
+ */
+static void snps_map_hif_to_app(struct snps_edac_priv *priv,
+				u64 hif, u64 *app)
+{
+	*app = hif << priv->info.dq_width;
+}
+
 /**
  * snps_map_hif_to_sdram - Map HIF address to SDRAM address.
  * @priv:	DDR memory controller private instance data.
@@ -467,6 +477,58 @@ static void snps_map_hif_to_sdram(struct snps_edac_priv *priv,
 	}
 }
 
+/**
+ * snps_map_sdram_to_hif - Map SDRAM address to HIF address.
+ * @priv:	DDR memory controller private instance data.
+ * @sdram:	SDRAM address (source).
+ * @hif:	HIF address (destination).
+ *
+ * SDRAM-HIF address mapping is similar to the HIF-SDRAM mapping procedure, but
+ * we'll traverse each SDRAM rank/bank/column/row bit.
+ *
+ * Note the unmapped bits of the SDRAM address components will be just
+ * ignored. So make sure the source address is valid.
+ */
+static void snps_map_sdram_to_hif(struct snps_edac_priv *priv,
+				  struct snps_sdram_addr *sdram, u64 *hif)
+{
+	struct snps_hif_sdram_map *map = &priv->hif_sdram_map;
+	unsigned long addr;
+	int i;
+
+	*hif = 0;
+
+	addr = sdram->row;
+	for_each_set_bit(i, &addr, DDR_MAX_ROW_WIDTH) {
+		if (map->row[i] != DDR_ADDRMAP_UNUSED)
+			*hif |= BIT_ULL(map->row[i]);
+	}
+
+	addr = sdram->col;
+	for_each_set_bit(i, &addr, DDR_MAX_COL_WIDTH) {
+		if (map->col[i] != DDR_ADDRMAP_UNUSED)
+			*hif |= BIT_ULL(map->col[i]);
+	}
+
+	addr = sdram->bank;
+	for_each_set_bit(i, &addr, DDR_MAX_BANK_WIDTH) {
+		if (map->bank[i] != DDR_ADDRMAP_UNUSED)
+			*hif |= BIT_ULL(map->bank[i]);
+	}
+
+	addr = sdram->bankgrp;
+	for_each_set_bit(i, &addr, DDR_MAX_BANKGRP_WIDTH) {
+		if (map->bankgrp[i] != DDR_ADDRMAP_UNUSED)
+			*hif |= BIT_ULL(map->bankgrp[i]);
+	}
+
+	addr = sdram->rank;
+	for_each_set_bit(i, &addr, DDR_MAX_RANK_WIDTH) {
+		if (map->rank[i] != DDR_ADDRMAP_UNUSED)
+			*hif |= BIT_ULL(map->rank[i]);
+	}
+}
+
 /**
  * snps_map_sys_to_sdram - Map System address to SDRAM address.
  * @priv:	DDR memory controller private instance data.
@@ -488,6 +550,27 @@ static void snps_map_sys_to_sdram(struct snps_edac_priv *priv,
 	snps_map_hif_to_sdram(priv, hif, sdram);
 }
 
+/**
+ * snps_map_sdram_to_sys - Map SDRAM address to SDRAM address.
+ * @priv:	DDR memory controller private instance data.
+ * @sys:	System address (source).
+ * @sdram:	SDRAM address (destination).
+ *
+ * Perform a full mapping of the SDRAM address (row/column/bank/etc) to
+ * the system address specific to the controller system bus ports.
+ */
+static void snps_map_sdram_to_sys(struct snps_edac_priv *priv,
+				  struct snps_sdram_addr *sdram, dma_addr_t *sys)
+{
+	u64 app, hif;
+
+	snps_map_sdram_to_hif(priv, sdram, &hif);
+
+	snps_map_hif_to_app(priv, hif, &app);
+
+	*sys = app;
+}
+
 /**
  * snps_get_bitpos - Get DQ-bus corrected bit position.
  * @bitnum:	Bit number retrieved from the ECCSTAT.corrected_bit_num field.
@@ -540,12 +623,13 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 	p->ceinfo.bitpos = snps_get_bitpos(p->ceinfo.bitpos, priv->info.dq_width);
 
 	regval = readl(base + ECC_CEADDR0_OFST);
-	p->ceinfo.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
+	p->ceinfo.sdram.rank = FIELD_GET(ECC_CEADDR0_RANK_MASK, regval);
+	p->ceinfo.sdram.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
 
 	regval = readl(base + ECC_CEADDR1_OFST);
-	p->ceinfo.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
-	p->ceinfo.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
-	p->ceinfo.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
+	p->ceinfo.sdram.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
+	p->ceinfo.sdram.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
+	p->ceinfo.sdram.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
 
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
 	if (priv->info.dq_width == SNPS_DQ_64)
@@ -558,12 +642,13 @@ static int snps_get_error_info(struct snps_edac_priv *priv)
 		goto out;
 
 	regval = readl(base + ECC_UEADDR0_OFST);
-	p->ueinfo.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
+	p->ueinfo.sdram.rank = FIELD_GET(ECC_CEADDR0_RANK_MASK, regval);
+	p->ueinfo.sdram.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
 
 	regval = readl(base + ECC_UEADDR1_OFST);
-	p->ueinfo.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
-	p->ueinfo.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
-	p->ueinfo.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
+	p->ueinfo.sdram.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
+	p->ueinfo.sdram.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
+	p->ueinfo.sdram.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
 
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
 	if (priv->info.dq_width == SNPS_DQ_64)
@@ -595,17 +680,22 @@ static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *
 {
 	struct snps_edac_priv *priv = mci->pvt_info;
 	struct snps_ecc_error_info *pinf;
+	dma_addr_t sys;
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
 
 		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
-			 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08llx",
-			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
+			 "Row %hu Col %hu Bank %hhu Bank Group %hhu Rank %hhu Bit %d Data 0x%08llx",
+			 pinf->sdram.row, pinf->sdram.col, pinf->sdram.bank,
+			 pinf->sdram.bankgrp, pinf->sdram.rank,
 			 pinf->bitpos, pinf->data);
 
-		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
-				     p->ce_cnt, 0, 0, pinf->syndrome, 0, 0, -1,
+		snps_map_sdram_to_sys(priv, &pinf->sdram, &sys);
+
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, p->ce_cnt,
+				     PHYS_PFN(sys), offset_in_page(sys),
+				     pinf->syndrome, 0, 0, -1,
 				     priv->message, "");
 	}
 
@@ -613,12 +703,16 @@ static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *
 		pinf = &p->ueinfo;
 
 		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
-			 "Row %d Col %d Bank %d Bank Group %d Data 0x%08llx",
-			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
+			 "Row %hu Col %hu Bank %hhu Bank Group %hhu Rank %hhu Data 0x%08llx",
+			 pinf->sdram.row, pinf->sdram.col, pinf->sdram.bank,
+			 pinf->sdram.bankgrp, pinf->sdram.rank,
 			 pinf->data);
 
-		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
-				     p->ue_cnt, 0, 0, pinf->syndrome, 0, 0, -1,
+		snps_map_sdram_to_sys(priv, &pinf->sdram, &sys);
+
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, p->ue_cnt,
+				     PHYS_PFN(sys), offset_in_page(sys),
+				     pinf->syndrome, 0, 0, -1,
 				     priv->message, "");
 	}
 
-- 
2.37.2

