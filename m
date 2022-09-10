Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341285B4889
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiIJT6C (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiIJT52 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:57:28 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11F424504A;
        Sat, 10 Sep 2022 12:57:14 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 9C54CDBC;
        Sat, 10 Sep 2022 23:00:56 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 9C54CDBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662840056;
        bh=iiuELFMYspx8+vlrwKdZM4fx0g6sV+ojseVw14/aQyE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=lMG2pbNlTvnwmI4d/Mh2RzYbyPwFi+d192Pbwv814ttU8rvcLcl6tWuzfr4pf6bYJ
         y+Onq2sn2NwkrNLO/JjYSOxUU5Nwvt+Ov/uw5kKwTIeQCTrO7F3lugywQyBPW3Mf+8
         2/hQayjcrzGjiKc9Ey2nK7d4x/qeI3OVY9U4bBE4=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:57:05 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
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
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/15] EDAC/synopsys: Drop ECC poison address from private data
Date:   Sat, 10 Sep 2022 22:56:51 +0300
Message-ID: <20220910195659.11843-8-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
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

Since the driver now has the generic Sys/SDRAM address translation
interface there is no need in preserving the poisonous address in the
driver private data especially seeing it is used in the framework of the
DebugFS node anyway. So let's drop the snps_edac_priv.poison_addr field
and just perform Sys/SDRAM back and forth address translation right in
place of the "inject_data_error" node accessors.

It causes a bit more modifications than a simple field removal. Since the
poisonous address is not preserved now there is no point in having the
snps_data_poison_setup() method so its content can be moved right into the
"inject_data_error" write operation. For the same reason there is no point
in printing the ECCPOISONADDR{0,1} registers content in the
"inject_data_error" read operation. Since the CSRs content is now parsed
anyway let's print the SDRAM address instead.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 68 +++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index b36f7ec4a79e..8771d69f6c5a 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -407,7 +407,6 @@ struct snps_ecc_status {
  * @lock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
  * @stat:		ECC status information.
- * @poison_addr:	Data poison address.
  */
 struct snps_edac_priv {
 	struct snps_ddrc_info info;
@@ -418,9 +417,6 @@ struct snps_edac_priv {
 	spinlock_t lock;
 	char message[SNPS_EDAC_MSG_SIZE];
 	struct snps_ecc_status stat;
-#ifdef CONFIG_EDAC_DEBUG
-	ulong poison_addr;
-#endif
 };
 
 /**
@@ -1713,44 +1709,32 @@ static int snps_hif_sdram_map_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(snps_hif_sdram_map);
 
-/**
- * snps_data_poison_setup - Update poison registers.
- * @priv:		DDR memory controller private instance data.
- *
- * Update poison registers as per DDR mapping.
- * Return: none.
- */
-static void snps_data_poison_setup(struct snps_edac_priv *priv)
-{
-	struct snps_sdram_addr sdram;
-	u32 regval;
-
-	snps_map_sys_to_sdram(priv, priv->poison_addr, &sdram);
-
-	regval = FIELD_PREP(ECC_POISON0_RANK_MASK, sdram.rank) |
-		 FIELD_PREP(ECC_POISON0_COL_MASK, sdram.col);
-	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
-
-	regval = FIELD_PREP(ECC_POISON1_BANKGRP_MASK, sdram.bankgrp) |
-		 FIELD_PREP(ECC_POISON1_BANK_MASK, sdram.bank) |
-		 FIELD_PREP(ECC_POISON1_ROW_MASK, sdram.row);
-	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
-}
-
 static ssize_t snps_inject_data_error_read(struct file *filep, char __user *ubuf,
 					   size_t size, loff_t *offp)
 {
 	struct mem_ctl_info *mci = filep->private_data;
 	struct snps_edac_priv *priv = mci->pvt_info;
+	struct snps_sdram_addr sdram;
 	char buf[SNPS_DBGFS_BUF_LEN];
+	dma_addr_t sys;
+	u32 regval;
 	int pos;
 
-	pos = scnprintf(buf, sizeof(buf), "Poison0 Addr: 0x%08x\n\r",
-			readl(priv->baseaddr + ECC_POISON0_OFST));
-	pos += scnprintf(buf + pos, sizeof(buf) - pos, "Poison1 Addr: 0x%08x\n\r",
-			 readl(priv->baseaddr + ECC_POISON1_OFST));
-	pos += scnprintf(buf + pos, sizeof(buf) - pos, "Error injection Address: 0x%lx\n\r",
-			 priv->poison_addr);
+	regval = readl(priv->baseaddr + ECC_POISON0_OFST);
+	sdram.rank = FIELD_GET(ECC_POISON0_RANK_MASK, regval);
+	sdram.col = FIELD_GET(ECC_POISON0_COL_MASK, regval);
+
+	regval = readl(priv->baseaddr + ECC_POISON1_OFST);
+	sdram.bankgrp = FIELD_PREP(ECC_POISON1_BANKGRP_MASK, regval);
+	sdram.bank = FIELD_PREP(ECC_POISON1_BANK_MASK, regval);
+	sdram.row = FIELD_PREP(ECC_POISON1_ROW_MASK, regval);
+
+	snps_map_sdram_to_sys(priv, &sdram, &sys);
+
+	pos = scnprintf(buf, sizeof(buf),
+			"%pad: Row %hu Rank %hu Bank %hhu Bank Group %hhu Rank %hhu\n",
+			&sys, sdram.row, sdram.col, sdram.bank, sdram.bankgrp,
+			sdram.rank);
 
 	return simple_read_from_buffer(ubuf, size, offp, buf, pos);
 }
@@ -1760,13 +1744,25 @@ static ssize_t snps_inject_data_error_write(struct file *filep, const char __use
 {
 	struct mem_ctl_info *mci = filep->private_data;
 	struct snps_edac_priv *priv = mci->pvt_info;
+	struct snps_sdram_addr sdram;
+	u32 regval;
+	u64 sys;
 	int rc;
 
-	rc = kstrtoul_from_user(ubuf, size, 0, &priv->poison_addr);
+	rc = kstrtou64_from_user(ubuf, size, 0, &sys);
 	if (rc)
 		return rc;
 
-	snps_data_poison_setup(priv);
+	snps_map_sys_to_sdram(priv, sys, &sdram);
+
+	regval = FIELD_PREP(ECC_POISON0_RANK_MASK, sdram.rank) |
+		 FIELD_PREP(ECC_POISON0_COL_MASK, sdram.col);
+	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
+
+	regval = FIELD_PREP(ECC_POISON1_BANKGRP_MASK, sdram.bankgrp) |
+		 FIELD_PREP(ECC_POISON1_BANK_MASK, sdram.bank) |
+		 FIELD_PREP(ECC_POISON1_ROW_MASK, sdram.row);
+	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
 
 	return size;
 }
-- 
2.37.2

