Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46B5B486F
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiIJTun (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiIJTuc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:50:32 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2197C2FFDD;
        Sat, 10 Sep 2022 12:50:29 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 2E1FEDBB;
        Sat, 10 Sep 2022 22:54:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 2E1FEDBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662839653;
        bh=72t56VXs1cjhHpQUQZkjoqkAzyc1oHLibCWTV4LfNx8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bG852FxdZetzXaWKPQH/oDg8iNT2YqyGQ0kFsh/C8giGzN9u0cP4Ic6izWdjQ16JA
         +BGszyGaGqCeSWYjat7pOfOa7Q/VB+G2NOiaqFyJfQTHEy2UZjYr1UrbCcFWXrzgCe
         JIaFXNW6Rn9llzbBXWls8csS3P/tBmCLmzcscP7I=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:50:22 +0300
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
Subject: [PATCH RESEND v2 06/18] EDAC/synopsys: Convert plat-data to plat-init function
Date:   Sat, 10 Sep 2022 22:49:55 +0300
Message-ID: <20220910195007.11027-7-Sergey.Semin@baikalelectronics.ru>
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

Since DW uMCTL2 device info and capabilities infrastructure is now
available there is no point in supporting an additional abstraction like
platform quirks. Instead we can convert the already defined ZynqMP quirk
to the ZynqMP-specific capability and add the platform-specific
initialization function support. This function will be called after the
device parameters are detected and thus fixing some of them if required.
This modification will provide a much more flexible interface of the
platform-specific setups. The platform-specific init callback can be used
not only for the capabilities flags modification, but for example for the
resources requests or custom CSRs alterations.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 68 +++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index b4db70224ee9..2d323afa288b 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -34,8 +34,8 @@
 #define SNPS_EDAC_MOD_STRING		"snps_edac"
 #define SNPS_EDAC_MOD_VER		"1"
 
-/* DDR ECC Quirks */
-#define SNPS_ZYNQMP_IRQ_REGS		BIT(0)
+/* DDR capabilities */
+#define SNPS_CAP_ZYNQMP			BIT(31)
 
 /* Synopsys uMCTL2 DDR controller registers that are relevant to ECC */
 
@@ -336,7 +336,6 @@ struct snps_ecc_status {
  * @lock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
  * @stat:		ECC status information.
- * @p_data:		Platform data.
  * @poison_addr:	Data poison address.
  * @row_shift:		Bit shifts for row bit.
  * @col_shift:		Bit shifts for column bit.
@@ -351,7 +350,6 @@ struct snps_edac_priv {
 	spinlock_t lock;
 	char message[SNPS_EDAC_MSG_SIZE];
 	struct snps_ecc_status stat;
-	const struct snps_platform_data *p_data;
 #ifdef CONFIG_EDAC_DEBUG
 	ulong poison_addr;
 	u32 row_shift[18];
@@ -362,14 +360,6 @@ struct snps_edac_priv {
 #endif
 };
 
-/**
- * struct snps_platform_data - Synopsys uMCTL2 DDRC platform data.
- * @quirks:	IP-core specific quirks.
- */
-struct snps_platform_data {
-	u32 quirks;
-};
-
 /**
  * snps_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
@@ -484,7 +474,7 @@ static void snps_enable_irq(struct snps_edac_priv *priv)
 	unsigned long flags;
 
 	/* Enable UE/CE Interrupts */
-	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS) {
+	if (priv->info.caps & SNPS_CAP_ZYNQMP) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
 
@@ -505,7 +495,7 @@ static void snps_disable_irq(struct snps_edac_priv *priv)
 	unsigned long flags;
 
 	/* Disable UE/CE Interrupts */
-	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS) {
+	if (priv->info.caps & SNPS_CAP_ZYNQMP) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 
@@ -534,7 +524,7 @@ static irqreturn_t snps_irq_handler(int irq, void *dev_id)
 
 	priv = mci->pvt_info;
 
-	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS) {
+	if (priv->info.caps & SNPS_CAP_ZYNQMP) {
 		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 		regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
 		if (!(regval & ECC_CE_UE_INTR_MASK))
@@ -548,7 +538,7 @@ static irqreturn_t snps_irq_handler(int irq, void *dev_id)
 	snps_handle_error(mci, &priv->stat);
 
 
-	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS)
+	if (priv->info.caps & SNPS_CAP_ZYNQMP)
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 
 	return IRQ_HANDLED;
@@ -572,16 +562,26 @@ static struct snps_edac_priv *snps_create_data(struct platform_device *pdev)
 	if (IS_ERR(priv->baseaddr))
 		return ERR_CAST(priv->baseaddr);
 
-	priv->p_data = of_device_get_match_data(&pdev->dev);
-	if (!priv->p_data)
-		return ERR_PTR(-ENODEV);
-
 	priv->pdev = pdev;
 	spin_lock_init(&priv->lock);
 
 	return priv;
 }
 
+/*
+ * zynqmp_init_plat - ZynqMP-specific platform initialization.
+ * @priv:	DDR memory controller private data.
+ *
+ * Return: always zero.
+ */
+static int zynqmp_init_plat(struct snps_edac_priv *priv)
+{
+	priv->info.caps |= SNPS_CAP_ZYNQMP;
+	priv->info.dq_width = SNPS_DQ_64;
+
+	return 0;
+}
+
 /**
  * snps_get_dtype - Return the controller memory width.
  * @mstr:	Master CSR value.
@@ -715,7 +715,10 @@ static int snps_get_ddrc_info(struct snps_edac_priv *priv)
 
 	writel(1, priv->baseaddr + DDR_SWCTL);
 
-	return 0;
+	/* Apply platform setups after all the configs auto-detection */
+	init_plat = device_get_match_data(&priv->pdev->dev);
+
+	return init_plat ? init_plat(priv) : 0;
 }
 
 /**
@@ -819,8 +822,6 @@ static void snps_mc_free(struct mem_ctl_info *mci)
 	edac_mc_free(mci);
 }
 
-
-
 static int snps_setup_irq(struct mem_ctl_info *mci)
 {
 	struct snps_edac_priv *priv = mci->pvt_info;
@@ -879,6 +880,15 @@ static int snps_ddrc_info_show(struct seq_file *s, void *data)
 		   priv->info.ecc_mode == SNPS_ECC_ADVX4X8 ? "Advanced X4/X8" :
 		   "Unknown");
 
+	seq_puts(s, "Caps:");
+	if (priv->info.caps) {
+		if (priv->info.caps & SNPS_CAP_ZYNQMP)
+			seq_puts(s, " +ZynqMP");
+	} else {
+		seq_puts(s, " -");
+	}
+	seq_putc(s, '\n');
+
 	return 0;
 }
 
@@ -1342,17 +1352,9 @@ static int snps_mc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct snps_platform_data zynqmp_edac_def = {
-	.quirks = SNPS_ZYNQMP_IRQ_REGS,
-};
-
-static const struct snps_platform_data snps_edac_def = {
-	.quirks = 0,
-};
-
 static const struct of_device_id snps_edac_match[] = {
-	{ .compatible = "xlnx,zynqmp-ddrc-2.40a", .data = &zynqmp_edac_def },
-	{ .compatible = "snps,ddrc-3.80a", .data = &snps_edac_def },
+	{ .compatible = "xlnx,zynqmp-ddrc-2.40a", .data = zynqmp_init_plat },
+	{ .compatible = "snps,ddrc-3.80a" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, snps_edac_match);
-- 
2.37.2

