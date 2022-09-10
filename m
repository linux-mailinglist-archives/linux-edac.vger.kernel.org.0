Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688C05B48A5
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiIJT6J (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiIJT5e (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:57:34 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B75BE481DD;
        Sat, 10 Sep 2022 12:57:21 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 3F443DBE;
        Sat, 10 Sep 2022 23:00:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 3F443DBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662840059;
        bh=K6aKoehB8793OjXByHtPsFLU8akSHMdlPDyystd6Lng=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=mm5R+0w4vCxafRs7hYgWdNcKAGDxv4K5Ec+4KJgiHeD+4xAikoxM6JFnwb8ZTsH+U
         6nyYYOlVamz/SWCkzel0oTYfToSfhKzg84a+I8w6n5cSpWDXWZwXGg0nCpxE5coU/h
         xmFy9VCEWzAO/HhDxTuezbqh66QO+lNHoCoelNXU=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:57:08 +0300
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
Subject: [PATCH v2 11/15] EDAC/synopsys: Add DFI alert_n IRQ support
Date:   Sat, 10 Sep 2022 22:56:55 +0300
Message-ID: <20220910195659.11843-12-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
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

In accordance with [1] DW uMCTL2 DDR controller can generate an IRQ in
case if an attached SDRAM detects a CRC/Parity error. That capability is
mainly applicable for the DDR4 memory which has an additional signals
PARITY/ALERT_n indicating the even SDRAM address/command parity signal and
alert if the parity turns to be not even. But in accordance with [1] at
least the SDRAM address/command parity is calculated irrespective of the
memory protocol and then sent out by means of the dfi_parity_n signal
further to the DDR PHY. So depending on the DDR protocol and the DDR PHY
implementation the CRC/Parity error can be checked at some point
independently from the DDR devices type and then signaled via the
dfi_alert_n line. In anycase it would be very much useful to catch the
event and at least warn the user about problems with the DFI/SDRAM signals
integrity.

So here we suggest to add the DFI CRC/Parity IRQs handling support. First
the IRQ line is requested by the name "dfi_e" (defined in the DT-bindings)
and register its handler in case of the platform with the individual DW
uMCTL2 DDRC IRQs. If individual IRQs are unavailable the common IRQ
handler will call the DFI CRC/Parity event handler. Note the handler
doesn't do much. It just checks the IRQ status, reads the number of
errors, reports the fatal error to the MCI core and clears the IRQ status.
Alas neither the erroneous SDRAM address nor the executed command are
available in this case. Secondly the DFI CRC/Parity IRQ is
enabled/disabled together with the ECC CE/UE interrupts in the controller
probe procedure.  Finally the CRC/Parity capability is advertised by the
EDAC controller capabilities flags.

[1] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2)
    Databook, Version 3.91a, October 2020, p.131-132

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 78 ++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 6a47e53deab5..8d8952826bce 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -80,6 +80,12 @@
 #define ECC_POISON0_OFST		0xB8
 #define ECC_POISON1_OFST		0xBC
 
+/* DDR CRC/Parity register */
+#define DDR_CRCPARCTL0_OFST		0xC0
+#define DDR_CRCPARCTL1_OFST		0xC4
+#define DDR_CRCPARCTL2_OFST		0xC8
+#define DDR_CRCPARSTAT_OFST		0xCC
+
 /* DDR Address map0 Registers */
 #define DDR_ADDRMAP0_OFST		0x200
 
@@ -153,6 +159,13 @@
 #define ECC_CEADDR1_BANK_MASK		GENMASK(23, 16)
 #define ECC_CEADDR1_COL_MASK		GENMASK(11, 0)
 
+/* DDR CRC/Parity register definitions */
+#define DDR_CRCPARCTL0_CLR_ALRT_ERRCNT	BIT(2)
+#define DDR_CRCPARCTL0_CLR_ALRT_ERR	BIT(1)
+#define DDR_CRCPARCTL0_EN_ALRT_IRQ	BIT(0)
+#define DDR_CRCPARSTAT_ALRT_ERR		BIT(16)
+#define DDR_CRCPARSTAT_ALRT_CNT_MASK	GENMASK(15, 0)
+
 /* ECC Poison register shifts */
 #define ECC_POISON0_RANK_MASK		GENMASK(27, 24)
 #define ECC_POISON0_COL_MASK		GENMASK(11, 0)
@@ -829,6 +842,48 @@ static irqreturn_t snps_ue_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/**
+ * snps_dfi_irq_handler - DFI CRC/Parity error interrupt handler.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
+ */
+static irqreturn_t snps_dfi_irq_handler(int irq, void *dev_id)
+{
+	struct mem_ctl_info *mci = dev_id;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	unsigned long flags;
+	u32 regval;
+	u16 ecnt;
+
+	/* Make sure IRQ is caused by an DFI alert error */
+	regval = readl(priv->baseaddr + DDR_CRCPARSTAT_OFST);
+	if (!(regval & DDR_CRCPARSTAT_ALRT_ERR))
+		return IRQ_NONE;
+
+	/* Just a number of CRC/Parity errors is available */
+	ecnt = FIELD_GET(DDR_CRCPARSTAT_ALRT_CNT_MASK, regval);
+
+	/* Report the detected errors with just the custom message */
+	snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
+		 "DFI CRC/Parity error detected on dfi_alert_n");
+
+	edac_mc_handle_error(HW_EVENT_ERR_FATAL, mci, ecnt,
+			     0, 0, 0, 0, 0, -1, priv->message, "");
+
+	/* Make sure the DFI alert IRQ status is cleared */
+	spin_lock_irqsave(&priv->lock, flags);
+
+	regval = readl(priv->baseaddr + DDR_CRCPARCTL0_OFST) |
+		 DDR_CRCPARCTL0_CLR_ALRT_ERR | DDR_CRCPARCTL0_CLR_ALRT_ERRCNT;
+	writel(regval, priv->baseaddr + DDR_CRCPARCTL0_OFST);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
 /**
  * snps_com_irq_handler - Interrupt IRQ signal handler.
  * @irq:        IRQ number.
@@ -844,6 +899,8 @@ static irqreturn_t snps_com_irq_handler(int irq, void *dev_id)
 
 	rc |= snps_ue_irq_handler(irq, dev_id);
 
+	rc |= snps_dfi_irq_handler(irq, dev_id);
+
 	return rc;
 }
 
@@ -859,11 +916,16 @@ static void snps_enable_irq(struct snps_edac_priv *priv)
 		return;
 	}
 
-	/* IRQs Enable/Disable feature has been available since v3.10a */
+	/*
+	 * ECC IRQs Enable/Disable feature has been available since v3.10a,
+	 * while CRC/Parity interrupts control - since v2.10a.
+	 */
 	spin_lock_irqsave(&priv->lock, flags);
 
 	writel(ECC_CTRL_EN_CE_IRQ | ECC_CTRL_EN_UE_IRQ,
 	       priv->baseaddr + ECC_CLR_OFST);
+	writel(DDR_CRCPARCTL0_EN_ALRT_IRQ,
+	       priv->baseaddr + DDR_CRCPARCTL0_OFST);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
@@ -883,6 +945,7 @@ static void snps_disable_irq(struct snps_edac_priv *priv)
 	spin_lock_irqsave(&priv->lock, flags);
 
 	writel(0, priv->baseaddr + ECC_CLR_OFST);
+	writel(0, priv->baseaddr + DDR_CRCPARCTL0_OFST);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
@@ -1483,7 +1546,8 @@ static struct mem_ctl_info *snps_mc_create(struct snps_edac_priv *priv)
 	mci->mtype_cap = MEM_FLAG_LPDDR | MEM_FLAG_DDR2 | MEM_FLAG_LPDDR2 |
 			 MEM_FLAG_DDR3 | MEM_FLAG_LPDDR3 |
 			 MEM_FLAG_DDR4 | MEM_FLAG_LPDDR4;
-	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
+	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED | EDAC_FLAG_PARITY;
+	mci->edac_cap = mci->edac_ctl_cap;
 
 	if (priv->info.caps & SNPS_CAP_ECC_SCRUB) {
 		mci->scrub_mode = SCRUB_HW_SRC;
@@ -1493,7 +1557,6 @@ static struct mem_ctl_info *snps_mc_create(struct snps_edac_priv *priv)
 		mci->scrub_cap = SCRUB_FLAG_SW_SRC;
 	}
 
-	mci->edac_cap = EDAC_FLAG_SECDED;
 	mci->ctl_name = "snps_umctl2_ddrc";
 	mci->dev_name = SNPS_EDAC_MOD_STRING;
 	mci->mod_name = SNPS_EDAC_MOD_VER;
@@ -1559,6 +1622,15 @@ static int snps_request_ind_irq(struct mem_ctl_info *mci)
 		return rc;
 	}
 
+	irq = platform_get_irq_byname_optional(priv->pdev, "dfi_e");
+	if (irq > 0) {
+		rc = devm_request_irq(dev, irq, snps_dfi_irq_handler, 0, "dfi_e", mci);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_MC, "Failed to request DFI IRQ\n");
+			return rc;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.37.2

