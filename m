Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5754059C86A
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbiHVTQb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbiHVTPP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:15:15 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28EE8399D5;
        Mon, 22 Aug 2022 12:14:58 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 7FC76DA4;
        Mon, 22 Aug 2022 22:17:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 7FC76DA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195873;
        bh=B0anltz8f5A2T1BcjFAbjkEPxMyXgO8YKipdgtsvjfw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=FRZXJe4yFFit24L++azXw5LqHgZm/jGZV727prxN6TPRH/HcA1A4/oMOHlfJrp/VB
         L1GIToU8phvZJYYw5X+LCmFTQTt1PB3a4Gt0eXNCads9wMmv/fJ1RljmHLdb8gys/X
         ynVzkJRb+iXpV1Hu+WaUzQCaAWZWMPcQJPbGi3OA=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:14:39 +0300
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
Subject: [PATCH 15/18] EDAC/synopsys: Add HIF/SDRAM mapping debugfs node
Date:   Mon, 22 Aug 2022 22:14:24 +0300
Message-ID: <20220822191427.27969-16-Sergey.Semin@baikalelectronics.ru>
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

Since we are about to add the address mapping to decode the erroneous
SDRAM address it will be useful to have a way to get an info regarding the
most complicated part of the address translation - HIF/SDRAM mapping table
just for in case something gets wrong in the implemented translation
procedures. Let's add the DebugFS node which can be used to print the
HIF/SDRAM mapping table in the hexdump-like manner: first line will
contain the HIF address bit position units, first column will contain the
HIF address bit position tens, the line and column intersection will have
the SDRAM dimension (row/column/bank/etc) and bit position which is used
to encode the corresponding HIF address bit.

Note DW uMCTL2 DDRC IP-core doesn't have a parameter to set the HIF
address width. Instead we've used the maximum value (60 bits) of the
UMCTL2_A_ADDRW synthesize parameter [1]. That parameter defines the
controller ports address bus width and in case if the DQ bus width equals
to eight bits defines the HIF address width too. So its upper constraints
is fully applicable in this case.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.515

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 82 ++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 62b925abbcb4..0ac02775aaf9 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -159,6 +159,7 @@
 /* DDRC address mapping parameters */
 #define DDR_ADDRMAP_NREGS		12
 
+#define DDR_MAX_HIF_WIDTH		60
 #define DDR_MAX_ROW_WIDTH		18
 #define DDR_MAX_COL_WIDTH		14
 #define DDR_MAX_BANK_WIDTH		3
@@ -1318,6 +1319,84 @@ static int snps_ddrc_info_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(snps_ddrc_info);
 
+static u8 snps_find_sdram_dim(struct snps_edac_priv *priv, u8 hif, char *dim)
+{
+	struct snps_hif_sdram_map *map = &priv->hif_sdram_map;
+	int i;
+
+	for (i = 0; i < DDR_MAX_ROW_WIDTH; i++) {
+		if (map->row[i] == hif) {
+			*dim = 'r';
+			return i;
+		}
+	}
+
+	for (i = 0; i < DDR_MAX_COL_WIDTH; i++) {
+		if (map->col[i] == hif) {
+			*dim = 'c';
+			return i;
+		}
+	}
+
+	for (i = 0; i < DDR_MAX_BANK_WIDTH; i++) {
+		if (map->bank[i] == hif) {
+			*dim = 'b';
+			return i;
+		}
+	}
+
+	for (i = 0; i < DDR_MAX_BANKGRP_WIDTH; i++) {
+		if (map->bankgrp[i] == hif) {
+			*dim = 'g';
+			return i;
+		}
+	}
+
+	for (i = 0; i < DDR_MAX_RANK_WIDTH; i++) {
+		if (map->rank[i] == hif) {
+			*dim = 'a';
+			return i;
+		}
+	}
+
+	return DDR_ADDRMAP_UNUSED;
+}
+
+static int snps_hif_sdram_map_show(struct seq_file *s, void *data)
+{
+	struct mem_ctl_info *mci = s->private;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	char dim, buf[SNPS_DBGFS_BUF_LEN];
+	const int line_len = 10;
+	u8 bit;
+	int i;
+
+	seq_printf(s, "%3s", "");
+	for (i = 0; i < line_len; i++)
+		seq_printf(s, " %02d ", i);
+
+	for (i = 0; i < DDR_MAX_HIF_WIDTH; i++) {
+		if (i % line_len == 0)
+			seq_printf(s, "\n%02d ", i);
+
+		bit = snps_find_sdram_dim(priv, i, &dim);
+
+		if (bit != DDR_ADDRMAP_UNUSED)
+			scnprintf(buf, SNPS_DBGFS_BUF_LEN, "%c%hhu", dim, bit);
+		else
+			scnprintf(buf, SNPS_DBGFS_BUF_LEN, "--");
+
+		seq_printf(s, "%3s ", buf);
+	}
+	seq_putc(s, '\n');
+
+	seq_puts(s, "r - row, c - column, b - bank, g - bank group, a - rank\n");
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(snps_hif_sdram_map);
+
 /**
  * snps_data_poison_setup - Update poison registers.
  * @priv:		DDR memory controller private instance data.
@@ -1437,6 +1516,9 @@ static void snps_create_debugfs_nodes(struct mem_ctl_info *mci)
 	edac_debugfs_create_file("ddrc_info", 0400, mci->debugfs, mci,
 				 &snps_ddrc_info_fops);
 
+	edac_debugfs_create_file("hif_sdram_map", 0400, mci->debugfs, mci,
+				 &snps_hif_sdram_map_fops);
+
 	edac_debugfs_create_file("inject_data_error", 0600, mci->debugfs, mci,
 				 &snps_inject_data_error);
 
-- 
2.35.1

