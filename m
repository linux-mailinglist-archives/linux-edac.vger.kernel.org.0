Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068325F1700
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiJAAO0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiJAAOW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:14:22 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E320C1BE794;
        Fri, 30 Sep 2022 17:14:20 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 5225EE0EE5;
        Fri, 30 Sep 2022 02:36:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=fLk6rJYWeyYo4X/R2uE+Au2WurJdhW4dQUs6qfLE/oo=; b=tJDA55MjLgJ5
        JBicrg77k89Ow7lQHHk80YN0RaIExFZd1gHmOxVOZsWrtI7eG1A6qFBFaWAYA6ta
        36zK8LfUBXh7taF0eZqJ5G2fmV1X0Bq7NRa0Ife+Vp/HfW6/bbtS/l/EA/SGutIs
        /jZMgeyJEH48iXbnmtou5mjsV9069gk=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 41F07E0E70;
        Fri, 30 Sep 2022 02:36:43 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:36:44 +0300
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
Subject: [PATCH RESEND v3 18/18] EDAC/synopsys: Add mapping-based memory size calculation
Date:   Fri, 30 Sep 2022 02:35:30 +0300
Message-ID: <20220929233530.13016-19-Sergey.Semin@baikalelectronics.ru>
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
index 84bede647947..e1e5468acbd2 100644
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
2.37.3


