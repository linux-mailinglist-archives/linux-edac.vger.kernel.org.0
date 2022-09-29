Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24935F1727
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiJAAVH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiJAAUh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:20:37 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D54A31DEF;
        Fri, 30 Sep 2022 17:19:11 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id C19EDE0EF1;
        Fri, 30 Sep 2022 02:41:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=JmyWEFHqnZbX/7cjgk0aJnlcaMnB6W0vJpBtKtboKLM=; b=MduLogv8+/Mz
        5wpquD8FEHH9Q63r+pi5F8jYdzg8h0Weyo6pR1OIBdnJTdSfSbsED6AvWGNj7x+b
        FjVnZJHmgj/QSsrCRiVm6ojaq0BLMnmTGmJJG2Od79cGgIv3c2XJ3zF+Oi3Vzk14
        dwVpS6I1sHgYu9E5+c+r+u1oCOl4i00=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id B1BE0E0EEA;
        Fri, 30 Sep 2022 02:41:33 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:41:34 +0300
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
Subject: [PATCH v3 10/13] EDAC/synopsys: Add reference clocks support
Date:   Fri, 30 Sep 2022 02:41:18 +0300
Message-ID: <20220929234121.13955-11-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929234121.13955-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929234121.13955-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
index 8d8952826bce..4b204b2050d4 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
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
2.37.3


