Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA2E5F172D
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 02:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiJAAVI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 20:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiJAAUi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 20:20:38 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D97FD69C5;
        Fri, 30 Sep 2022 17:19:11 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 6C2B1E0EF2;
        Fri, 30 Sep 2022 02:41:34 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=cIQNQRB+EzBKz0kvCwDckrZJ++lBf3trzLG6YlAJ8y0=; b=dIxay6hl9Qd2
        4ss65iniH5Y/RLl+5ISyx6h39V9uvbUFGHy+1US8f3cT4mKVZyaK9pL325tlakah
        CCGkbV2fA56r34FeYcTJ3u85AJ8v9MZQ2yZPRyGxsV4Yn5OsyG+EOmf0q8fDgXSX
        ITy+ytbLrVb2ytIIPTgsl3bBiy4Keac=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 5CA89E0EEA;
        Fri, 30 Sep 2022 02:41:34 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:41:35 +0300
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
Subject: [PATCH v3 11/13] EDAC/synopsys: Add ECC Scrubber support
Date:   Fri, 30 Sep 2022 02:41:19 +0300
Message-ID: <20220929234121.13955-12-Sergey.Semin@baikalelectronics.ru>
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

DW uMCTL2 DDR controller IP-core can by synthesized with an embedded
Scrubber engine. The ECC Scrubber (SBR) is a block which initiates
periodic background burst read commands to the DDRC and further towards
the DDR memory in an attempt to trigger Correctable or Uncorrectable
errors. If a Correctable error is detected the ECC Scrub feature will
execute the Read-Modify-Write (RMW) procedure in order to fix the ECC. In
case of the Uncorrectable error it will be just reported as the
corresponding IRQ event. So it's definitely very useful feature. Let's add
it to the driver then especially seeing the MCI core already has some
infrastructure for it.

First of all even though the Core clock rate is only used for the Scrub
rate calculations we need to have the Scrubber clock enabled if one is
supplied otherwise the engine won't work.

Secondly the Scrubber engine support needs to be detected. Alas there is
no any special CSR indicating whether the DW uMCTL2 DDRC IP-core has been
synthesized with one embedded. Instead we suggest to implement the
detection procedure based on the Scrubber-specific CSRs writability. So if
the SBRWDATA0 CSR is writable then the CSR exists, which means the
Scrubber is available, otherwise the capability will be considered as
absent.

Thirdly the MCI core provides two callbacks utilized for the Scrubber
tuning: set the Scrubber bandwidth in bytes, which can also be used to
disable the periodic scrubbing, and get the Scrubber bandwidth (zero if
disabled). We can implement both of them by using the Scrubber CSRs the
controller provides. In particular aside with the back-to-back periodic
reads the Scrubber provides a way to delay the next read command for the
predefined set of 512's Core/Scrubber clock cycles. It can be used to
change the Scrubber bandwidth from the DDR maximal bandwidth (no delay) to
up to (0x1FFF * 512) Core/Scrubber clock cycles (see the inline comments
for details and utilized formulae). Note the Scrubber clock must be
synchronous to the Core clock by the controller design so here we get to
use the Core clock rate for the calculations. Pleas also note if no Core
clock specified the Scrubber will still be supported, but the bandwidth
will be used directly to calculate the Scrubber reads interval. The
back-to-back reads mode in this case will be indicated by the INT_MAX
bandwidth.

Fourthly the back-to-back scrubbing most likely will cause the significant
system performance drop. The manual says that it has been added to the
controller for the initial SDRAM initialization and the fast SDRAM
scrubbing after getting out of the low-power state. In anyway it is
supposed to be enabled only for a single SDRAM pass. We get to preserve
that semantic here so the back-to-back scrubbing will be disabled in the
Scrubber Done IRQ handler.

Finally the denoted scrub-rate callbacks and the SCRUB_FLAG_HW_PROG and
SCRUB_FLAG_HW_TUN flags will set to the MCI descriptor based on the
detected Scrubber capability. So no capability - no flags and no
callbacks.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 304 +++++++++++++++++++++++++++++++++++
 1 file changed, 304 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 4b204b2050d4..0a00e80ddeb9 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -18,6 +18,7 @@
 #include <linux/seq_file.h>
 #include <linux/sizes.h>
 #include <linux/spinlock.h>
+#include <linux/units.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -34,6 +35,7 @@
 
 /* DDR capabilities */
 #define SNPS_CAP_ECC_SCRUB		BIT(0)
+#define SNPS_CAP_ECC_SCRUBBER		BIT(1)
 #define SNPS_CAP_ZYNQMP			BIT(31)
 
 /* Synopsys uMCTL2 DDR controller registers that are relevant to ECC */
@@ -102,6 +104,12 @@
 #define DDR_SARBASE0_OFST		0xF04
 #define DDR_SARSIZE0_OFST		0xF08
 
+/* ECC Scrubber registers */
+#define ECC_SBRCTL_OFST			0xF24
+#define ECC_SBRSTAT_OFST		0xF28
+#define ECC_SBRWDATA0_OFST		0xF2C
+#define ECC_SBRWDATA1_OFST		0xF30
+
 /* DDR Master Register 0 definitions */
 #define DDR_MSTR_DEV_CFG_MASK		GENMASK(31, 30)
 #define DDR_MSTR_DEV_X4			0x0
@@ -244,6 +252,18 @@
 #define DDR_MAX_NSAR			4
 #define DDR_MIN_SARSIZE			SZ_256M
 
+/* ECC Scrubber registers definitions */
+#define ECC_SBRCTL_SCRUB_INTERVAL	GENMASK(20, 8)
+#define ECC_SBRCTL_INTERVAL_STEP	512
+#define ECC_SBRCTL_INTERVAL_MIN		0
+#define ECC_SBRCTL_INTERVAL_SAFE	1
+#define ECC_SBRCTL_INTERVAL_MAX		(ECC_SBRCTL_SCRUB_INTERVAL >> 8)
+#define ECC_SBRCTL_SCRUB_BURST		GENMASK(6, 4)
+#define ECC_SBRCTL_SCRUB_MODE_WR	BIT(2)
+#define ECC_SBRCTL_SCRUB_EN		BIT(0)
+#define ECC_SBRSTAT_SCRUB_DONE		BIT(1)
+#define ECC_SBRSTAT_SCRUB_BUSY		BIT(0)
+
 /**
  * enum snps_dq_width - SDRAM DQ bus width (ECC capable).
  * SNPS_DQ_32:	32-bit memory data width.
@@ -906,6 +926,47 @@ static irqreturn_t snps_dfi_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+/**
+ * snps_sbr_irq_handler - Scrubber Done interrupt handler.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
+ *
+ * It just checks whether the IRQ has been caused by the Scrubber Done event
+ * and disables the back-to-back scrubbing by falling back to the smallest
+ * delay between the Scrubber read commands.
+ *
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
+ */
+static irqreturn_t snps_sbr_irq_handler(int irq, void *dev_id)
+{
+	struct mem_ctl_info *mci = dev_id;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	unsigned long flags;
+	u32 regval, en;
+
+	/* Make sure IRQ is caused by the Scrubber Done event */
+	regval = readl(priv->baseaddr + ECC_SBRSTAT_OFST);
+	if (!(regval & ECC_SBRSTAT_SCRUB_DONE))
+		return IRQ_NONE;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	regval = readl(priv->baseaddr + ECC_SBRCTL_OFST);
+	en = regval & ECC_SBRCTL_SCRUB_EN;
+	writel(regval & ~en, priv->baseaddr + ECC_SBRCTL_OFST);
+
+	regval = FIELD_PREP(ECC_SBRCTL_SCRUB_INTERVAL, ECC_SBRCTL_INTERVAL_SAFE);
+	writel(regval, priv->baseaddr + ECC_SBRCTL_OFST);
+
+	writel(regval | en, priv->baseaddr + ECC_SBRCTL_OFST);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	edac_mc_printk(mci, KERN_WARNING, "Back-to-back scrubbing disabled\n");
+
+	return IRQ_HANDLED;
+}
+
 /**
  * snps_com_irq_handler - Interrupt IRQ signal handler.
  * @irq:        IRQ number.
@@ -915,6 +976,8 @@ static irqreturn_t snps_dfi_irq_handler(int irq, void *dev_id)
  */
 static irqreturn_t snps_com_irq_handler(int irq, void *dev_id)
 {
+	struct mem_ctl_info *mci = dev_id;
+	struct snps_edac_priv *priv = mci->pvt_info;
 	irqreturn_t rc = IRQ_NONE;
 
 	rc |= snps_ce_irq_handler(irq, dev_id);
@@ -923,6 +986,9 @@ static irqreturn_t snps_com_irq_handler(int irq, void *dev_id)
 
 	rc |= snps_dfi_irq_handler(irq, dev_id);
 
+	if (priv->info.caps & SNPS_CAP_ECC_SCRUBBER)
+		rc |= snps_sbr_irq_handler(irq, dev_id);
+
 	return rc;
 }
 
@@ -972,6 +1038,205 @@ static void snps_disable_irq(struct snps_edac_priv *priv)
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
+/**
+ * snps_get_sdram_bw - Get SDRAM bandwidth.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * The SDRAM interface bandwidth is calculated based on the DDRC Core clock rate
+ * and the DW uMCTL2 IP-core parameters like DQ-bus width and mode and
+ * Core/SDRAM clocks frequency ratio. Note it returns the theoretical bandwidth
+ * which in reality is hardly possible to reach.
+ *
+ * Return: SDRAM bandwidth or zero if no Core clock specified.
+ */
+static u64 snps_get_sdram_bw(struct snps_edac_priv *priv)
+{
+	unsigned long rate;
+
+	/*
+	 * Depending on the ratio mode the SDRAM clock either matches the Core
+	 * clock or runs with the twice its frequency.
+	 */
+	rate = clk_get_rate(priv->clks[SNPS_CORE_CLK].clk);
+	rate *= priv->info.freq_ratio;
+
+	/*
+	 * Scale up by 2 since it's DDR (Double Data Rate) and subtract the
+	 * DQ-mode since in non-Full mode only a part of the DQ-bus is utilised
+	 * on each SDRAM clock edge.
+	 */
+	return (2U << (priv->info.dq_width - priv->info.dq_mode)) * (u64)rate;
+}
+
+/**
+ * snps_get_scrub_bw - Get Scrubber bandwidth.
+ * @priv:	DDR memory controller private instance data.
+ * @interval:	Scrub interval.
+ *
+ * DW uMCTL2 DDRC Scrubber performs periodical progressive burst reads (RMW if
+ * ECC CE is detected) commands from the whole memory space. The read commands
+ * can be delayed by means of the SBRCTL.scrub_interval field. The Scrubber
+ * cycles look as follows:
+ *
+ * |---HIF-burst-read---|-------delay-------|-HIF-burst-read-| etc
+ *
+ * Tb = Bl*[DQ]/Bw[RAM] Td = 512*interval/Fc - periods of the stages, where
+ * Bl - HIF burst length, [DQ] - Full DQ-bus width, Bw[RAM] - SDRAM bandwidth,
+ * Fc - Core clock frequency (Scrubber and Core clocks are synchronous).
+ *
+ * After some simple calculations the expressions above can be used to get the
+ * next Scrubber bandwidth formulae:
+ *
+ * Bw[Sbr] = Bw[RAM] / (1 + F * interval), where
+ * F = 2 * 512 * Fr * Fc * [DQ]e - interval scale factor with
+ * Fr - HIF/SDRAM clock frequency ratio (1 or 2), [DQ]e - DQ-bus width mode.
+ *
+ * Return: Scrubber bandwidth or zero if no Core clock specified.
+ */
+static u64 snps_get_scrub_bw(struct snps_edac_priv *priv, u32 interval)
+{
+	unsigned long fac;
+	u64 bw_ram;
+
+	fac = (2 * ECC_SBRCTL_INTERVAL_STEP * priv->info.freq_ratio) /
+	      (priv->info.hif_burst_len * (1UL << priv->info.dq_mode));
+
+	bw_ram = snps_get_sdram_bw(priv);
+
+	do_div(bw_ram, 1 + fac * interval);
+
+	return bw_ram;
+}
+
+/**
+ * snps_get_scrub_interval - Get Scrubber delay interval.
+ * @priv:	DDR memory controller private instance data.
+ * @bw:		Scrubber bandwidth.
+ *
+ * Similarly to the Scrubber bandwidth the interval formulae can be inferred
+ * from the same expressions:
+ *
+ * interval = (Bw[RAM] - Bw[Sbr]) / (F * Bw[Sbr])
+ *
+ * Return: Scrubber delay interval or zero if no Core clock specified.
+ */
+static u32 snps_get_scrub_interval(struct snps_edac_priv *priv, u32 bw)
+{
+	unsigned long fac;
+	u64 bw_ram;
+
+	fac = (2 * priv->info.freq_ratio * ECC_SBRCTL_INTERVAL_STEP) /
+	      (priv->info.hif_burst_len * (1UL << priv->info.dq_mode));
+
+	bw_ram = snps_get_sdram_bw(priv);
+
+	/* Divide twice so not to cause the integer overflow in (fac * bw) */
+	bw_ram -= bw;
+	do_div(bw_ram, bw);
+	do_div(bw_ram, fac);
+
+	return bw_ram;
+}
+
+/**
+ * snps_set_sdram_scrub_rate - Set the Scrubber bandwidth.
+ * @mci:	EDAC memory controller instance.
+ * @bw:		Bandwidth.
+ *
+ * It calculates the delay between the Scrubber read commands based on the
+ * specified bandwidth and the Core clock rate. If the Core clock is unavailable
+ * the passed bandwidth will be directly used as the interval value.
+ *
+ * Note the method warns about the back-to-back scrubbing since it may
+ * significantly degrade the system performance. This mode is supposed to be
+ * used for a single SDRAM scrubbing pass only. So it will be turned off in the
+ * Scrubber Done IRQ handler.
+ *
+ * Return: Actually set bandwidth (interval-based approximated bandwidth if the
+ * Core clock is unavailable) or zero if the Scrubber was disabled.
+ */
+static int snps_set_sdram_scrub_rate(struct mem_ctl_info *mci, u32 bw)
+{
+	struct snps_edac_priv *priv = mci->pvt_info;
+	u32 regval, interval;
+	unsigned long flags;
+	u64 bw_min, bw_max;
+
+	/* Don't bother with the calculations just disable and return. */
+	if (!bw) {
+		spin_lock_irqsave(&priv->lock, flags);
+
+		regval = readl(priv->baseaddr + ECC_SBRCTL_OFST);
+		regval &= ~ECC_SBRCTL_SCRUB_EN;
+		writel(regval, priv->baseaddr + ECC_SBRCTL_OFST);
+
+		spin_unlock_irqrestore(&priv->lock, flags);
+
+		return 0;
+	}
+
+	/* If no Core clock specified fallback to the direct interval setup. */
+	bw_max = snps_get_scrub_bw(priv, ECC_SBRCTL_INTERVAL_MIN);
+	if (bw_max) {
+		bw_min = snps_get_scrub_bw(priv, ECC_SBRCTL_INTERVAL_MAX);
+		bw = clamp_t(u64, bw, bw_min, bw_max);
+
+		interval = snps_get_scrub_interval(priv, bw);
+	} else {
+		bw = clamp_val(bw, ECC_SBRCTL_INTERVAL_MIN, ECC_SBRCTL_INTERVAL_MAX);
+
+		interval = ECC_SBRCTL_INTERVAL_MAX - bw;
+	}
+
+	/*
+	 * SBRCTL.scrub_en bitfield must be accessed separately from the other
+	 * CSR bitfields. It means the flag must be set/clear with no updates
+	 * to the rest of the fields.
+	 */
+	spin_lock_irqsave(&priv->lock, flags);
+
+	regval = FIELD_PREP(ECC_SBRCTL_SCRUB_INTERVAL, interval);
+	writel(regval, priv->baseaddr + ECC_SBRCTL_OFST);
+
+	writel(regval | ECC_SBRCTL_SCRUB_EN, priv->baseaddr + ECC_SBRCTL_OFST);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	if (!interval)
+		edac_mc_printk(mci, KERN_WARNING, "Back-to-back scrubbing enabled\n");
+
+	if (!bw_max)
+		return interval ? bw : INT_MAX;
+
+	return snps_get_scrub_bw(priv, interval);
+}
+
+/**
+ * snps_get_sdram_scrub_rate - Get the Scrubber bandwidth.
+ * @mci:	EDAC memory controller instance.
+ *
+ * Return: Scrubber bandwidth (interval-based approximated bandwidth if the
+ * Core clock is unavailable) or zero if the Scrubber was disabled.
+ */
+static int snps_get_sdram_scrub_rate(struct mem_ctl_info *mci)
+{
+	struct snps_edac_priv *priv = mci->pvt_info;
+	u32 regval;
+	u64 bw;
+
+	regval = readl(priv->baseaddr + ECC_SBRCTL_OFST);
+	if (!(regval & ECC_SBRCTL_SCRUB_EN))
+		return 0;
+
+	regval = FIELD_GET(ECC_SBRCTL_SCRUB_INTERVAL, regval);
+
+	bw = snps_get_scrub_bw(priv, regval);
+	if (!bw)
+		return regval ? ECC_SBRCTL_INTERVAL_MAX - regval : INT_MAX;
+
+	return bw;
+}
+
 /**
  * snps_create_data - Create private data.
  * @pdev:	platform device.
@@ -1038,7 +1303,18 @@ static int snps_get_res(struct snps_edac_priv *priv)
 		return rc;
 	}
 
+	rc = clk_prepare_enable(priv->clks[SNPS_SBR_CLK].clk);
+	if (rc) {
+		edac_printk(KERN_INFO, EDAC_MC, "Couldn't enable Scrubber clock\n");
+		goto err_disable_pclk;
+	}
+
 	return 0;
+
+err_disable_pclk:
+	clk_disable_unprepare(priv->clks[SNPS_CSR_CLK].clk);
+
+	return rc;
 }
 
 /**
@@ -1047,6 +1323,8 @@ static int snps_get_res(struct snps_edac_priv *priv)
  */
 static void snps_put_res(struct snps_edac_priv *priv)
 {
+	clk_disable_unprepare(priv->clks[SNPS_SBR_CLK].clk);
+
 	clk_disable_unprepare(priv->clks[SNPS_CSR_CLK].clk);
 }
 
@@ -1147,6 +1425,14 @@ static int snps_get_ddrc_info(struct snps_edac_priv *priv)
 	if (!(regval & ECC_CFG0_DIS_SCRUB))
 		priv->info.caps |= SNPS_CAP_ECC_SCRUB;
 
+	/* Auto-detect the scrubber by writing to the SBRWDATA0 CSR */
+	regval = readl(priv->baseaddr + ECC_SBRWDATA0_OFST);
+	writel(~regval, priv->baseaddr + ECC_SBRWDATA0_OFST);
+	if (regval != readl(priv->baseaddr + ECC_SBRWDATA0_OFST)) {
+		priv->info.caps |= SNPS_CAP_ECC_SCRUBBER;
+		writel(regval, priv->baseaddr + ECC_SBRWDATA0_OFST);
+	}
+
 	/* Auto-detect the basic HIF/SDRAM bus parameters */
 	regval = readl(priv->baseaddr + DDR_MSTR_OFST);
 
@@ -1633,6 +1919,12 @@ static struct mem_ctl_info *snps_mc_create(struct snps_edac_priv *priv)
 		mci->scrub_cap = SCRUB_FLAG_SW_SRC;
 	}
 
+	if (priv->info.caps & SNPS_CAP_ECC_SCRUBBER) {
+		mci->scrub_cap |= SCRUB_FLAG_HW_PROG | SCRUB_FLAG_HW_TUN;
+		mci->set_sdram_scrub_rate = snps_set_sdram_scrub_rate;
+		mci->get_sdram_scrub_rate = snps_get_sdram_scrub_rate;
+	}
+
 	mci->ctl_name = "snps_umctl2_ddrc";
 	mci->dev_name = SNPS_EDAC_MOD_STRING;
 	mci->mod_name = SNPS_EDAC_MOD_VER;
@@ -1707,6 +1999,16 @@ static int snps_request_ind_irq(struct mem_ctl_info *mci)
 		}
 	}
 
+	irq = platform_get_irq_byname_optional(priv->pdev, "ecc_sbr");
+	if (irq > 0) {
+		rc = devm_request_irq(dev, irq, snps_sbr_irq_handler, 0, "ecc_sbr", mci);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_MC, "Failed to request Sbr IRQ\n");
+			return rc;
+		}
+	}
+
+
 	return 0;
 }
 
@@ -1813,6 +2115,8 @@ static int snps_ddrc_info_show(struct seq_file *s, void *data)
 	if (priv->info.caps) {
 		if (priv->info.caps & SNPS_CAP_ECC_SCRUB)
 			seq_puts(s, " +Scrub");
+		if (priv->info.caps & SNPS_CAP_ECC_SCRUBBER)
+			seq_puts(s, " +Scrubber");
 		if (priv->info.caps & SNPS_CAP_ZYNQMP)
 			seq_puts(s, " +ZynqMP");
 	} else {
-- 
2.37.3


