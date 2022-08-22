Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEE359C862
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbiHVTQd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbiHVTPU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:15:20 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42DA2419B7;
        Mon, 22 Aug 2022 12:15:03 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id BDDCADA5;
        Mon, 22 Aug 2022 22:17:55 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com BDDCADA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195875;
        bh=SEhYhWwAeDvbFaGOXmwsrF7W8fxPLjwKBh4/wA6K/zg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZgW/iuwQqU0xOX9db7A1b2Z7LelR635HyKx9fU0ZyBroYKdp3bRtW+vLNRXltuOj5
         vZpyktUfepgY5M4f6dxAi3828cDZEkrn0S+AygtqE6ALYyZ26f8FkuIyCeggbrtKoA
         lrXLp04T/m/bdFoSarELRhFmQsY1chxVs3noKEJE=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:14:41 +0300
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
Subject: [PATCH 18/18] EDAC/synopsys: Add mapping-based memory size calculation
Date:   Mon, 22 Aug 2022 22:14:27 +0300
Message-ID: <20220822191427.27969-19-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822191427.27969-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822191427.27969-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Currently the size of the memory attached to the controller is retrieved
by means of the si_meminfo() method. It isn't quite correct because the
system may have more than one memory controller. There is a better and
more portable approach available to find out the attached memory size.
Since now we have the full HIF/SDRAM mapping table available right in the
device probe procedure and the DQ-bus width is detected at that stage too,
that info can be used to calculate the total memory size accessible
over the corresponding DW uMCTL2 DDR controller. It can be done since the
hardware reference manual demands that none two SDRAM bits are mapped to
the same HIF bit [1] and that the unused SDRAM address bits mapping must
be disabled [2].

Note the size calculation procedure takes the ranks mapping into account.
That part will be removed after we add the multi-ranked MC registration.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.108
[2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.109

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 66 ++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 2bdf606ba2b9..90b57986a9b5 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -960,20 +960,6 @@ static inline enum dev_type snps_get_dtype(u32 mstr)
 	return DEV_UNKNOWN;
 }
 
-/**
- * snps_get_memsize - Read the size of the attached memory device.
- *
- * Return: the memory size in bytes.
- */
-static u32 snps_get_memsize(void)
-{
-	struct sysinfo inf;
-
-	si_meminfo(&inf);
-
-	return inf.totalram * inf.mem_unit;
-}
-
 /**
  * snps_get_mtype - Returns controller memory type.
  * @mstr:	Master CSR value.
@@ -1388,6 +1374,51 @@ static void snps_get_addr_map(struct snps_edac_priv *priv)
 	snps_get_hif_rank_map(priv, regval);
 }
 
+/**
+ * snps_get_sdram_size - Calculate SDRAM size.
+ * @priv:	DDR memory controller private data.
+ *
+ * The total size of the attached memory is calculated based on the HIF/SDRAM
+ * mapping table. It can be done since the hardware reference manual demands
+ * that none two SDRAM bits should be mapped to the same HIF bit and that the
+ * unused SDRAM address bits mapping must be disabled.
+ *
+ * Return: the memory size in bytes.
+ */
+static u64 snps_get_sdram_size(struct snps_edac_priv *priv)
+{
+	struct snps_hif_sdram_map *map = &priv->hif_sdram_map;
+	u64 size = 0;
+	int i;
+
+	for (i = 0; i < DDR_MAX_ROW_WIDTH; i++) {
+		if (map->row[i] != DDR_ADDRMAP_UNUSED)
+			size++;
+	}
+
+	for (i = 0; i < DDR_MAX_COL_WIDTH; i++) {
+		if (map->col[i] != DDR_ADDRMAP_UNUSED)
+			size++;
+	}
+
+	for (i = 0; i < DDR_MAX_BANK_WIDTH; i++) {
+		if (map->bank[i] != DDR_ADDRMAP_UNUSED)
+			size++;
+	}
+
+	for (i = 0; i < DDR_MAX_BANKGRP_WIDTH; i++) {
+		if (map->bankgrp[i] != DDR_ADDRMAP_UNUSED)
+			size++;
+	}
+
+	for (i = 0; i < DDR_MAX_RANK_WIDTH; i++) {
+		if (map->rank[i] != DDR_ADDRMAP_UNUSED)
+			size++;
+	}
+
+	return 1ULL << (size + priv->info.dq_width);
+}
+
 /**
  * snps_init_csrows - Initialize the csrow data.
  * @mci:	EDAC memory controller instance.
@@ -1400,7 +1431,8 @@ static void snps_init_csrows(struct mem_ctl_info *mci)
 	struct snps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
-	u32 size, row, width;
+	u32 row, width;
+	u64 size;
 	int j;
 
 	/* Actual SDRAM-word width for which ECC is calculated */
@@ -1408,13 +1440,13 @@ static void snps_init_csrows(struct mem_ctl_info *mci)
 
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
-		size = snps_get_memsize();
+		size = snps_get_sdram_size(priv);
 
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_SECDED;
 			dimm->mtype	= priv->info.sdram_mode;
-			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
+			dimm->nr_pages	= PHYS_PFN(size) / csi->nr_channels;
 			dimm->grain	= width;
 			dimm->dtype	= priv->info.dev_cfg;
 		}
-- 
2.35.1

