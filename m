Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9CE42ACF4
	for <lists+linux-edac@lfdr.de>; Tue, 12 Oct 2021 21:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhJLTJV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Oct 2021 15:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:32836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232568AbhJLTJS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Oct 2021 15:09:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A56561050;
        Tue, 12 Oct 2021 19:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634065637;
        bh=fvFU9eEDCHxxVSMgMcUqyc5olonb7mh0yKqKvjyVRy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iLm6nN1v4YcZrRC36IbEuI6+7xFWnWXkIThpdmiGavNKI87wELACqD54jiR64z1Uj
         G/i+2d6OhEa5w6kDEQQ2ZbvrK9VH9P1CP9e6ZElOpU6Hq+KZ+sifqODBJVr/qlO0uA
         +fyaxiZ8GCc08c5QhKC+J0OVg/VqboUCAJE2ZlVH3PQ5SJ5VLuegB8Zsk7Ggg5CvIx
         O5E9oLQXclZh4Jz9hoUHkX4MinZpC/hQVoHD2zjspBiITERhl9QN/4JyAiiPXzpvWu
         lYkW3P2CT3V3cLjV/grsSk3+w5Ty9qLeKVDitBtNp2WkA3T7qIA1YbSsRiJRXQdWX8
         IepZy12kt9HqA==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     bp@alien8.de
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>
Subject: [PATCHv4 2/4] EDAC/synopsys: add support for version 3 of the Synopsys EDAC DDR
Date:   Tue, 12 Oct 2021 14:07:07 -0500
Message-Id: <20211012190709.1504152-2-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012190709.1504152-1-dinguyen@kernel.org>
References: <20211012190709.1504152-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Adds support for version 3.80a of the Synopsys DDR controller with EDAC. This
version of the controller has the following differences:

- UE/CE are auto cleared
- Interrupts are supported by default

Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v4: Add Reviewed-by
v3: Address comments from Michal Simek
    use bit macro
    removed extra "cleared" word from comment section about v3.0
v2: remove "This patch" from commit message
---
 drivers/edac/synopsys_edac.c | 49 ++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index bf237fccb444..66ee37ea0acc 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -101,6 +101,7 @@
 /* DDR ECC Quirks */
 #define DDR_ECC_INTR_SUPPORT		BIT(0)
 #define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
+#define DDR_ECC_INTR_SELF_CLEAR		BIT(2)
 
 /* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
 /* ECC Configuration Registers */
@@ -171,6 +172,10 @@
 #define DDR_QOS_IRQ_EN_OFST		0x20208
 #define DDR_QOS_IRQ_DB_OFST		0x2020C
 
+/* DDR QOS Interrupt register definitions */
+#define DDR_UE_MASK			BIT(9)
+#define DDR_CE_MASK			BIT(8)
+
 /* ECC Corrected Error Register Mask and Shifts*/
 #define ECC_CEADDR0_RW_MASK		0x3FFFF
 #define ECC_CEADDR0_RNK_MASK		BIT(24)
@@ -533,10 +538,16 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	priv = mci->pvt_info;
 	p_data = priv->p_data;
 
-	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
-	regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
-	if (!(regval & ECC_CE_UE_INTR_MASK))
-		return IRQ_NONE;
+	/*
+	 * v3.0 of the controller has the ce/ue bits cleared automatically,
+	 * so this condition does not apply.
+	 */
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
+		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+		regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
+		if (!(regval & ECC_CE_UE_INTR_MASK))
+			return IRQ_NONE;
+	}
 
 	status = p_data->get_error_info(priv);
 	if (status)
@@ -548,7 +559,9 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 
 	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
-	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+	/* v3.0 of the controller does not have this register */
+	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
+		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 	return IRQ_HANDLED;
 }
 
@@ -834,8 +847,13 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 static void enable_intr(struct synps_edac_priv *priv)
 {
 	/* Enable UE/CE Interrupts */
-	writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
-			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
+		writel(DDR_UE_MASK | DDR_CE_MASK,
+		       priv->baseaddr + ECC_CLR_OFST);
+	else
+		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
+		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+
 }
 
 static void disable_intr(struct synps_edac_priv *priv)
@@ -890,6 +908,19 @@ static const struct synps_platform_data zynqmp_edac_def = {
 			  ),
 };
 
+static const struct synps_platform_data synopsys_edac_def = {
+	.get_error_info	= zynqmp_get_error_info,
+	.get_mtype	= zynqmp_get_mtype,
+	.get_dtype	= zynqmp_get_dtype,
+	.get_ecc_state	= zynqmp_get_ecc_state,
+	.quirks         = (DDR_ECC_INTR_SUPPORT | DDR_ECC_INTR_SELF_CLEAR
+#ifdef CONFIG_EDAC_DEBUG
+			  | DDR_ECC_DATA_POISON_SUPPORT
+#endif
+			  ),
+};
+
+
 static const struct of_device_id synps_edac_match[] = {
 	{
 		.compatible = "xlnx,zynq-ddrc-a05",
@@ -899,6 +930,10 @@ static const struct of_device_id synps_edac_match[] = {
 		.compatible = "xlnx,zynqmp-ddrc-2.40a",
 		.data = (void *)&zynqmp_edac_def
 	},
+	{
+		.compatible = "snps,ddrc-3.80a",
+		.data = (void *)&synopsys_edac_def
+	},
 	{
 		/* end of table */
 	}
-- 
2.25.1

