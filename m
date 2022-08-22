Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369FB59C8AD
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbiHVTV7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbiHVTU6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:20:58 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A68E15820;
        Mon, 22 Aug 2022 12:20:34 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 90C11DA3;
        Mon, 22 Aug 2022 22:23:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 90C11DA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661196216;
        bh=wku7u/iSUztYZ4YyKZErSj2fMZzBfaaRtgq0auiZEuw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=LNGdKf0DgN4f+vqoqZliJum63i8RSPJ2aUqctRt3UrkcZxGErEzwr/EtOx/BKlI8Y
         5qc6XXC80ZUxdfOwAcTMRK6Ntc3TV/gXFhtPzmR6c9s3XW2yDzXDMdtNYK8yBSzZYU
         0KT+k6kElM9LVG1NYw0UkOPz01ytTfGjNqoiDbLM=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:20:22 +0300
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
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/13] EDAC/synopsys: Add reference clocks support
Date:   Mon, 22 Aug 2022 22:19:53 +0300
Message-ID: <20220822191957.28546-11-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
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

Currently the driver doesn't support any clock-related resources request
and handling, fairly assuming that all of them are supposed to be enabled
anyway in order for the system to work correctly. It's true for the Core
and AXI Ports reference clocks, but the CSR (APB) and Scrubber clocks
might still be disabled in case if the system firmware doesn't imply any
other software touching the DDR controller internals. Since the DW uMCTL2
DDRC driver does access the controller registers at the very least we need
to make sure the APB clock is enabled. Let's add the reference clocks
support then. First of all the driver will request all the clocks possibly
defined for the controller (Core, AXI, APB and Scrubber). Secondly the APB
clock will be enabled/disabled only since the Scrubber is currently
unsupported by the driver, and the Core and AXI clocks feed the critical
system parts so we need to avoid touching them with a risk to de-stabilize
the system memory. Please note the clocks connection IDs have been chosen
in accordance with the DT-bindings.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 101 +++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index cdfa0e16bc5c..d6d5dfabddf5 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -8,6 +8,7 @@
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/clk.h>
 #include <linux/edac.h>
 #include <linux/fs.h>
 #include <linux/log2.h>
@@ -301,6 +302,25 @@ enum snps_ecc_mode {
 	SNPS_ECC_ADVX4X8 = 5,
 };
 
+/**
+ * enum snps_ref_clk - DW uMCTL2 DDR controller clocks.
+ * @SNPS_CSR_CLK:	CSR/APB interface clock.
+ * @SNPS_AXI_CLK:	AXI (AHB) Port reference clock.
+ * @SNPS_CORE_CLK:	DDR controller (including DFI) clock. SDRAM clock
+ *			matches runs with this freq in 1:1 ratio mode and
+ *			with twice of this freq in case of 1:2 ratio mode.
+ * @SNPS_SBR_CLK:	Scrubber port reference clock (synchronous to
+ *			the core clock).
+ * @SNPS_MAX_NCLK:	Total number of clocks.
+ */
+enum snps_ref_clk {
+	SNPS_CSR_CLK,
+	SNPS_AXI_CLK,
+	SNPS_CORE_CLK,
+	SNPS_SBR_CLK,
+	SNPS_MAX_NCLK
+};
+
 /**
  * struct snps_ddrc_info - DDR controller platform parameters.
  * @caps:		DDR controller capabilities.
@@ -405,6 +425,7 @@ struct snps_ecc_error_info {
  * @pdev:		Platform device.
  * @baseaddr:		Base address of the DDR controller.
  * @lock:		Concurrent CSRs access lock.
+ * @clks:		Controller reference clocks.
  * @message:		Buffer for framing the event specific info.
  */
 struct snps_edac_priv {
@@ -414,6 +435,7 @@ struct snps_edac_priv {
 	struct platform_device *pdev;
 	void __iomem *baseaddr;
 	spinlock_t lock;
+	struct clk_bulk_data clks[SNPS_MAX_NCLK];
 	char message[SNPS_EDAC_MSG_SIZE];
 };
 
@@ -974,6 +996,60 @@ static struct snps_edac_priv *snps_create_data(struct platform_device *pdev)
 	return priv;
 }
 
+/**
+ * snps_get_res - Get platform device resources.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * It's supposed to request all the controller resources available for the
+ * particular platform and enable all the required for the driver normal
+ * work. Note only the CSR and Scrubber clocks are supposed to be switched
+ * on/off by the driver.
+ *
+ * Return: negative errno if failed to get the resources, otherwise - zero.
+ */
+static int snps_get_res(struct snps_edac_priv *priv)
+{
+	const char * const ids[] = {
+		[SNPS_CSR_CLK] = "pclk",
+		[SNPS_AXI_CLK] = "aclk",
+		[SNPS_CORE_CLK] = "core",
+		[SNPS_SBR_CLK] = "sbr",
+	};
+	int i, rc;
+
+	for (i = 0; i < SNPS_MAX_NCLK; i++)
+		priv->clks[i].id = ids[i];
+
+	rc = devm_clk_bulk_get_optional(&priv->pdev->dev, SNPS_MAX_NCLK,
+					priv->clks);
+	if (rc) {
+		edac_printk(KERN_INFO, EDAC_MC, "Failed to get ref clocks\n");
+		return rc;
+	}
+
+	/*
+	 * Don't touch the Core and AXI clocks since they are critical for the
+	 * stable system functioning and are supposed to have been enabled
+	 * anyway.
+	 */
+	rc = clk_prepare_enable(priv->clks[SNPS_CSR_CLK].clk);
+	if (rc) {
+		edac_printk(KERN_INFO, EDAC_MC, "Couldn't enable CSR clock\n");
+		return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * snps_put_res - Put platform device resources.
+ * @priv:	DDR memory controller private instance data.
+ */
+static void snps_put_res(struct snps_edac_priv *priv)
+{
+	clk_disable_unprepare(priv->clks[SNPS_CSR_CLK].clk);
+}
+
 /*
  * zynqmp_init_plat - ZynqMP-specific platform initialization.
  * @priv:	DDR memory controller private data.
@@ -1707,9 +1783,17 @@ static int snps_ddrc_info_show(struct seq_file *s, void *data)
 {
 	struct mem_ctl_info *mci = s->private;
 	struct snps_edac_priv *priv = mci->pvt_info;
+	unsigned long rate;
 
 	seq_printf(s, "SDRAM: %s\n", edac_mem_types[priv->info.sdram_mode]);
 
+	rate = clk_get_rate(priv->clks[SNPS_CORE_CLK].clk);
+	if (rate) {
+		rate = rate / HZ_PER_MHZ;
+		seq_printf(s, "Clock: Core %luMHz SDRAM %luMHz\n",
+			   rate, priv->info.freq_ratio * rate);
+	}
+
 	seq_printf(s, "DQ bus: %u/%s\n", (BITS_PER_BYTE << priv->info.dq_width),
 		   priv->info.dq_mode == SNPS_DQ_FULL ? "Full" :
 		   priv->info.dq_mode == SNPS_DQ_HALF ? "Half" :
@@ -2018,15 +2102,21 @@ static int snps_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
 
-	rc = snps_get_ddrc_info(priv);
+	rc = snps_get_res(priv);
 	if (rc)
 		return rc;
 
+	rc = snps_get_ddrc_info(priv);
+	if (rc)
+		goto put_res;
+
 	snps_get_addr_map(priv);
 
 	mci = snps_mc_create(priv);
-	if (IS_ERR(mci))
-		return PTR_ERR(mci);
+	if (IS_ERR(mci)) {
+		rc = PTR_ERR(mci);
+		goto put_res;
+	}
 
 	rc = snps_setup_irq(mci);
 	if (rc)
@@ -2046,6 +2136,9 @@ static int snps_mc_probe(struct platform_device *pdev)
 free_edac_mc:
 	snps_mc_free(mci);
 
+put_res:
+	snps_put_res(priv);
+
 	return rc;
 }
 
@@ -2066,6 +2159,8 @@ static int snps_mc_remove(struct platform_device *pdev)
 
 	snps_mc_free(mci);
 
+	snps_put_res(priv);
+
 	return 0;
 }
 
-- 
2.35.1

