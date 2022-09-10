Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01995B486C
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiIJTv0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiIJTvB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:51:01 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13CF532BA3;
        Sat, 10 Sep 2022 12:50:47 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 6C4D7DC0;
        Sat, 10 Sep 2022 22:54:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 6C4D7DC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662839659;
        bh=F7VO/av0SRD4yobJKltu4xKD3FVv7YOOlNZLINK8uxQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=OdGRqAkEE55GDR4xJIqQGqbqeqzEa8CPZscz8vRk54ltzYFm86Gs6qnX5gYr04jkc
         Z3kgQiEmJmTwMJ6CwxrsYvNk29wABwCJNaB8JoPHl2VF7d2yMrjnD2cjvJbBsQgTjG
         m4ZZyk5mIIkhibBc2NdCcV4VjhwNtT/bJoakVipE=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:50:28 +0300
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
Subject: [PATCH RESEND v2 15/18] EDAC/synopsys: Add HIF/SDRAM mapping debugfs node
Date:   Sat, 10 Sep 2022 22:50:04 +0300
Message-ID: <20220910195007.11027-16-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910195007.11027-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910195007.11027-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 9c4f7d60b820..26fd797d3f00 100644
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
2.37.2

