Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8372959C80F
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbiHVTId (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbiHVTIY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:08:24 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A57E1705B;
        Mon, 22 Aug 2022 12:08:11 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 6CF4BDB2;
        Mon, 22 Aug 2022 22:10:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 6CF4BDB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195459;
        bh=GTr+vigspdMiYwjq5M0V31YF9sVAd9c0ypdr3o4rReE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=FmfvurtYIzH7/numEY1Khx1m3JgklXxTZ+SVV0YagnSUAf0LGqW7DTPzahwCoDbd4
         sMB5BPRg3i7eMBjkhf65bvCfxb+3Guotq6NOK+3cWyPQ9U5NpzUp8+xbX7hbkW97aI
         Q7JyARMQaL4a4svz8RMToox1pgc6Csmz3bTTSmM0=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:07:45 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>,
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
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 17/20] EDAC/synopsys: Detach Zynq DDRC controller support
Date:   Mon, 22 Aug 2022 22:07:27 +0300
Message-ID: <20220822190730.27277-18-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
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

It was a bad idea in the first place to combine two absolutely different
controllers support in a single driver [1]. It caused having an additional
level of abstraction, which obviously have needlessly overcomplicated the
driver and as such caused many problems in the new main controller
features support implementation. The solution looks even more unreasonable
now seeing the justification of having both controllers support in a
single driver hasn't been implemented by the original code author [2].

Anyway since the Zynq A05 DDRC controller has nothing in common with DW
uMCTL2 DDRC (even the CSRs layout is absolutely different, not to say it
doesn't support IRQs), since the EDAC MC core driver now support MC index
auto-generation and since we are going to extend the DW uMCTL2 EDAC driver
functionality (having an incompatible code support will greatly complicate
the resultant driver and the upcoming patches) let's move the Xilinx Zynq
DDRC support to another driver - zynq_edac.c. Basically it means to simply
detach the Zynq-specific callbacks, init/probe/remove methods and move
them in the new driver. The resultant driver will mostly look similar to
the code submitted in the initial commit ae9b56e3996d ("EDAC, synps: Add
EDAC support for zynq ddr ecc controller") except a few fixes added
afterwards. The Zynq-specific code and macros are removed from the
original module of course thus leaving the DWC uMCTL2 DDRC driver purely
synopsys DDRC specific.

Note 1. In order to improve the new driver code readability all the
internal entities have been equipped with the vendor-specific prefix. Thus
the local, global and EDAC-core specific names will be explicitly
distinguishable right from the place they are called.

Note 2. Some of the Zynq-specific macros have been used in the framework
of the DW uMCTL2 DDRC-specific functions. In most of the cases it was
wrong even though hasn't caused any problem since the macro substituted
with correct values (for instance, CTRL_OFST macro usage where
DDR_MSTR_OFST should have been utilized). Anyway since these macros are
now moved to another driver let's fix the places where the macros have
been improperly used.

[1] Link: https://lore.kernel.org/all/808655a9-77eb-4e3a-9781-2b059ad9517b@BN1AFFO11FD020.protection.gbl/
[2] Link: https://lore.kernel.org/all/9dc2a947-d2ab-4f00-8ed3-d2499cb6fdfd@BN1BFFO11FD002.protection.gbl/

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 MAINTAINERS                  |   1 +
 drivers/edac/Kconfig         |   9 +-
 drivers/edac/Makefile        |   1 +
 drivers/edac/synopsys_edac.c | 271 +++----------------
 drivers/edac/zynq_edac.c     | 504 +++++++++++++++++++++++++++++++++++
 5 files changed, 547 insertions(+), 239 deletions(-)
 create mode 100644 drivers/edac/zynq_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 17f23f810ee4..27b6bb41e401 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3094,6 +3094,7 @@ F:	arch/arm/mach-zynq/
 F:	drivers/clocksource/timer-cadence-ttc.c
 F:	drivers/cpuidle/cpuidle-zynq.c
 F:	drivers/edac/synopsys_edac.c
+F:	drivers/edac/zynq_edac.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/i2c/busses/i2c-xiic.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 17562cf1fe97..98bcdadf4143 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -486,7 +486,7 @@ config EDAC_ARMADA_XP
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || ARCH_MXC
+	depends on ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || ARCH_MXC
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
@@ -541,4 +541,11 @@ config EDAC_DMC520
 	  Support for error detection and correction on the
 	  SoCs with ARM DMC-520 DRAM controller.
 
+config EDAC_ZYNQ
+	tristate "Xilinx Zynq A05 DDR Memory Controller"
+	depends on ARCH_ZYNQ
+	help
+	  Support for error detection and correction on the Xilinx Zynq A05
+	  DDR memory controller.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 2d1641a27a28..83e063f53b22 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -84,3 +84,4 @@ obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
 obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
+obj-$(CONFIG_EDAC_ZYNQ)			+= zynq_edac.o
diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 379a668295cc..0cb84f183aed 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -30,68 +30,16 @@
 #define SYNPS_EDAC_MOD_STRING		"synps_edac"
 #define SYNPS_EDAC_MOD_VER		"1"
 
-/* Synopsys DDR memory controller registers that are relevant to ECC */
-#define CTRL_OFST			0x0
-#define T_ZQ_OFST			0xA4
-
-/* ECC control register */
-#define ECC_CTRL_OFST			0xC4
-/* ECC log register */
-#define CE_LOG_OFST			0xC8
-/* ECC address register */
-#define CE_ADDR_OFST			0xCC
-/* ECC data[31:0] register */
-#define CE_DATA_31_0_OFST		0xD0
-
-/* Uncorrectable error info registers */
-#define UE_LOG_OFST			0xDC
-#define UE_ADDR_OFST			0xE0
-#define UE_DATA_31_0_OFST		0xE4
-
-#define STAT_OFST			0xF0
-#define SCRUB_OFST			0xF4
-
-/* Control register bit field definitions */
-#define CTRL_BW_MASK			0xC
-#define CTRL_BW_SHIFT			2
-
-#define DDRCTL_WDTH_16			1
-#define DDRCTL_WDTH_32			0
-
-/* ZQ register bit field definitions */
-#define T_ZQ_DDRMODE_MASK		0x2
-
-/* ECC control register bit field definitions */
-#define ECC_CTRL_CLR_CE_ERR		0x2
-#define ECC_CTRL_CLR_UE_ERR		0x1
-
-/* ECC correctable/uncorrectable error log register definitions */
-#define LOG_VALID			0x1
-#define CE_LOG_BITPOS_MASK		0xFE
-#define CE_LOG_BITPOS_SHIFT		1
-
-/* ECC correctable/uncorrectable error address register definitions */
-#define ADDR_COL_MASK			0xFFF
-#define ADDR_ROW_MASK			0xFFFF000
-#define ADDR_ROW_SHIFT			12
-#define ADDR_BANK_MASK			0x70000000
-#define ADDR_BANK_SHIFT			28
-
-/* ECC statistic register definitions */
-#define STAT_UECNT_MASK			0xFF
-#define STAT_CECNT_MASK			0xFF00
-#define STAT_CECNT_SHIFT		8
-
-/* ECC scrub register definitions */
-#define SCRUB_MODE_MASK			0x7
-#define SCRUB_MODE_SECDED		0x4
-
 /* DDR ECC Quirks */
 #define DDR_ECC_INTR_SUPPORT		BIT(0)
 #define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
 #define SYNPS_ZYNQMP_IRQ_REGS		BIT(2)
 
-/* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
+/* Synopsys DDR memory controller registers that are relevant to ECC */
+
+/* DDRC master0 Register */
+#define DDR_MSTR_OFST			0x0
+
 /* ECC Configuration Registers */
 #define ECC_CFG0_OFST			0x70
 #define ECC_CFG1_OFST			0x74
@@ -132,15 +80,11 @@
 #define ECC_POISON0_OFST		0xB8
 #define ECC_POISON1_OFST		0xBC
 
-#define ECC_ADDRMAP0_OFFSET		0x200
+/* DDR Address map0 Registers */
+#define ECC_ADDRMAP0_OFST		0x200
 
-/* ECC control/clear register definitions */
-#define ECC_CTRL_BUSWIDTH_MASK		0x3000
-#define ECC_CTRL_BUSWIDTH_SHIFT		12
-#define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
-#define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
-#define ECC_CTRL_EN_CE_IRQ		BIT(8)
-#define ECC_CTRL_EN_UE_IRQ		BIT(9)
+/* DDR Software control register */
+#define DDR_SWCTL			0x320
 
 /* DDR Master Register 0 definitions */
 #define DDR_MSTR_DEV_CFG_MASK		GENMASK(31, 30)
@@ -148,10 +92,16 @@
 #define DDR_MSTR_DEV_X8			0x1
 #define DDR_MSTR_DEV_X16		0x2
 #define DDR_MSTR_DEV_X32		0x3
+#define DDR_MSTR_BUSWIDTH_MASK		0x3000
+#define DDR_MSTR_BUSWIDTH_SHIFT		12
 #define DDRCTL_EWDTH_16			2
 #define DDRCTL_EWDTH_32			1
 #define DDRCTL_EWDTH_64			0
 
+/* ECC CFG0 register definitions */
+#define ECC_CFG0_MODE_MASK		0x7
+#define ECC_CFG0_MODE_SECDED		0x4
+
 /* ECC status register definitions */
 #define ECC_STAT_UECNT_MASK		0xF0000
 #define ECC_STAT_UECNT_SHIFT		16
@@ -159,6 +109,14 @@
 #define ECC_STAT_CECNT_SHIFT		8
 #define ECC_STAT_BITNUM_MASK		0x7F
 
+/* ECC control/clear register definitions */
+#define ECC_CTRL_CLR_CE_ERR		BIT(0)
+#define ECC_CTRL_CLR_UE_ERR		BIT(1)
+#define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
+#define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
+#define ECC_CTRL_EN_CE_IRQ		BIT(8)
+#define ECC_CTRL_EN_UE_IRQ		BIT(9)
+
 /* ECC error count register definitions */
 #define ECC_ERRCNT_UECNT_MASK		0xFFFF0000
 #define ECC_ERRCNT_UECNT_SHIFT		16
@@ -200,21 +158,11 @@
 #define MEM_TYPE_DDR4			0x10
 #define MEM_TYPE_LPDDR4			0x20
 
-/* DDRC Software control register */
-#define DDRC_SWCTL			0x320
-
 /* DDRC ECC CE & UE poison mask */
 #define ECC_CEPOISON_MASK		0x3
 #define ECC_UEPOISON_MASK		0x1
 
-/* DDRC Device config masks */
-#define DDRC_MSTR_CFG_MASK		0xC0000000
-#define DDRC_MSTR_CFG_SHIFT		30
-#define DDRC_MSTR_CFG_X4_MASK		0x0
-#define DDRC_MSTR_CFG_X8_MASK		0x1
-#define DDRC_MSTR_CFG_X16_MASK		0x2
-#define DDRC_MSTR_CFG_X32_MASK		0x3
-
+/* DDRC Device config shifts/masks */
 #define DDR_MAX_ROW_SHIFT		18
 #define DDR_MAX_COL_SHIFT		14
 #define DDR_MAX_BANK_SHIFT		3
@@ -345,61 +293,6 @@ struct synps_platform_data {
 	int quirks;
 };
 
-/**
- * zynq_get_error_info - Get the current ECC error info.
- * @priv:	DDR memory controller private instance data.
- *
- * Return: one if there is no error, otherwise zero.
- */
-static int zynq_get_error_info(struct synps_edac_priv *priv)
-{
-	struct synps_ecc_status *p;
-	u32 regval, clearval = 0;
-	void __iomem *base;
-
-	base = priv->baseaddr;
-	p = &priv->stat;
-
-	regval = readl(base + STAT_OFST);
-	if (!regval)
-		return 1;
-
-	p->ce_cnt = (regval & STAT_CECNT_MASK) >> STAT_CECNT_SHIFT;
-	p->ue_cnt = regval & STAT_UECNT_MASK;
-
-	regval = readl(base + CE_LOG_OFST);
-	if (!(p->ce_cnt && (regval & LOG_VALID)))
-		goto ue_err;
-
-	p->ceinfo.bitpos = (regval & CE_LOG_BITPOS_MASK) >> CE_LOG_BITPOS_SHIFT;
-	regval = readl(base + CE_ADDR_OFST);
-	p->ceinfo.row = (regval & ADDR_ROW_MASK) >> ADDR_ROW_SHIFT;
-	p->ceinfo.col = regval & ADDR_COL_MASK;
-	p->ceinfo.bank = (regval & ADDR_BANK_MASK) >> ADDR_BANK_SHIFT;
-	p->ceinfo.data = readl(base + CE_DATA_31_0_OFST);
-	edac_dbg(3, "CE bit position: %d data: %d\n", p->ceinfo.bitpos,
-		 p->ceinfo.data);
-	clearval = ECC_CTRL_CLR_CE_ERR;
-
-ue_err:
-	regval = readl(base + UE_LOG_OFST);
-	if (!(p->ue_cnt && (regval & LOG_VALID)))
-		goto out;
-
-	regval = readl(base + UE_ADDR_OFST);
-	p->ueinfo.row = (regval & ADDR_ROW_MASK) >> ADDR_ROW_SHIFT;
-	p->ueinfo.col = regval & ADDR_COL_MASK;
-	p->ueinfo.bank = (regval & ADDR_BANK_MASK) >> ADDR_BANK_SHIFT;
-	p->ueinfo.data = readl(base + UE_DATA_31_0_OFST);
-	clearval |= ECC_CTRL_CLR_UE_ERR;
-
-out:
-	writel(clearval, base + ECC_CTRL_OFST);
-	writel(0x0, base + ECC_CTRL_OFST);
-
-	return 0;
-}
-
 /**
  * zynqmp_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
@@ -622,37 +515,6 @@ static void check_errors(struct mem_ctl_info *mci)
 		 priv->ce_cnt, priv->ue_cnt);
 }
 
-/**
- * zynq_get_dtype - Return the controller memory width.
- * @base:	DDR memory controller base address.
- *
- * Get the EDAC device type width appropriate for the current controller
- * configuration.
- *
- * Return: a device type width enumeration.
- */
-static enum dev_type zynq_get_dtype(const void __iomem *base)
-{
-	enum dev_type dt;
-	u32 width;
-
-	width = readl(base + CTRL_OFST);
-	width = (width & CTRL_BW_MASK) >> CTRL_BW_SHIFT;
-
-	switch (width) {
-	case DDRCTL_WDTH_16:
-		dt = DEV_X2;
-		break;
-	case DDRCTL_WDTH_32:
-		dt = DEV_X4;
-		break;
-	default:
-		dt = DEV_UNKNOWN;
-	}
-
-	return dt;
-}
-
 /**
  * zynqmp_get_dtype - Return the controller memory width.
  * @base:	DDR memory controller base address.
@@ -685,30 +547,6 @@ static enum dev_type zynqmp_get_dtype(const void __iomem *base)
 	return DEV_UNKNOWN;
 }
 
-/**
- * zynq_get_ecc_state - Return the controller ECC enable/disable status.
- * @base:	DDR memory controller base address.
- *
- * Get the ECC enable/disable status of the controller.
- *
- * Return: true if enabled, otherwise false.
- */
-static bool zynq_get_ecc_state(void __iomem *base)
-{
-	enum dev_type dt;
-	u32 ecctype;
-
-	dt = zynq_get_dtype(base);
-	if (dt == DEV_UNKNOWN)
-		return false;
-
-	ecctype = readl(base + SCRUB_OFST) & SCRUB_MODE_MASK;
-	if ((ecctype == SCRUB_MODE_SECDED) && (dt == DEV_X2))
-		return true;
-
-	return false;
-}
-
 /**
  * zynqmp_get_ecc_state - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
@@ -721,9 +559,9 @@ static bool zynqmp_get_ecc_state(void __iomem *base)
 {
 	u32 regval;
 
-	regval = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
+	regval = readl(base + ECC_CFG0_OFST) & ECC_CFG0_MODE_MASK;
 
-	return (regval == SCRUB_MODE_SECDED);
+	return (regval == ECC_CFG0_MODE_SECDED);
 }
 
 /**
@@ -740,30 +578,6 @@ static u32 get_memsize(void)
 	return inf.totalram * inf.mem_unit;
 }
 
-/**
- * zynq_get_mtype - Return the controller memory type.
- * @base:	Synopsys ECC status structure.
- *
- * Get the EDAC memory type appropriate for the current controller
- * configuration.
- *
- * Return: a memory type enumeration.
- */
-static enum mem_type zynq_get_mtype(const void __iomem *base)
-{
-	enum mem_type mt;
-	u32 memtype;
-
-	memtype = readl(base + T_ZQ_OFST);
-
-	if (memtype & T_ZQ_DDRMODE_MASK)
-		mt = MEM_DDR3;
-	else
-		mt = MEM_DDR2;
-
-	return mt;
-}
-
 /**
  * zynqmp_get_mtype - Returns controller memory type.
  * @base:	Synopsys ECC status structure.
@@ -778,7 +592,7 @@ static enum mem_type zynqmp_get_mtype(const void __iomem *base)
 	enum mem_type mt;
 	u32 memtype;
 
-	memtype = readl(base + CTRL_OFST);
+	memtype = readl(base + DDR_MSTR_OFST);
 
 	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
 		mt = MEM_DDR3;
@@ -890,14 +704,6 @@ static int setup_irq(struct mem_ctl_info *mci,
 	return 0;
 }
 
-static const struct synps_platform_data zynq_edac_def = {
-	.get_error_info	= zynq_get_error_info,
-	.get_mtype	= zynq_get_mtype,
-	.get_dtype	= zynq_get_dtype,
-	.get_ecc_state	= zynq_get_ecc_state,
-	.quirks		= 0,
-};
-
 static const struct synps_platform_data zynqmp_edac_def = {
 	.get_error_info	= zynqmp_get_error_info,
 	.get_mtype	= zynqmp_get_mtype,
@@ -924,10 +730,6 @@ static const struct synps_platform_data synopsys_edac_def = {
 
 
 static const struct of_device_id synps_edac_match[] = {
-	{
-		.compatible = "xlnx,zynq-ddrc-a05",
-		.data = (void *)&zynq_edac_def
-	},
 	{
 		.compatible = "xlnx,zynqmp-ddrc-2.40a",
 		.data = (void *)&zynqmp_edac_def
@@ -1053,12 +855,12 @@ static ssize_t inject_data_poison_store(struct device *dev,
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct synps_edac_priv *priv = mci->pvt_info;
 
-	writel(0, priv->baseaddr + DDRC_SWCTL);
+	writel(0, priv->baseaddr + DDR_SWCTL);
 	if (strncmp(data, "CE", 2) == 0)
 		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
 	else
 		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
-	writel(1, priv->baseaddr + DDRC_SWCTL);
+	writel(1, priv->baseaddr + DDR_SWCTL);
 
 	return count;
 }
@@ -1149,8 +951,8 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 	u32 width, memtype;
 	int index;
 
-	memtype = readl(priv->baseaddr + CTRL_OFST);
-	width = (memtype & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
+	memtype = readl(priv->baseaddr + DDR_MSTR_OFST);
+	width = (memtype & DDR_MSTR_BUSWIDTH_MASK) >> DDR_MSTR_BUSWIDTH_SHIFT;
 
 	priv->col_shift[0] = 0;
 	priv->col_shift[1] = 1;
@@ -1291,7 +1093,7 @@ static void setup_address_map(struct synps_edac_priv *priv)
 	for (index = 0; index < 12; index++) {
 		u32 addrmap_offset;
 
-		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
+		addrmap_offset = ECC_ADDRMAP0_OFST + (index * 4);
 		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
 	}
 
@@ -1345,7 +1147,7 @@ static int mc_probe(struct platform_device *pdev)
 	layers[1].size = SYNPS_EDAC_NR_CHANS;
 	layers[1].is_virt_csrow = false;
 
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
+	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers,
 			    sizeof(struct synps_edac_priv));
 	if (!mci) {
 		edac_printk(KERN_ERR, EDAC_MC,
@@ -1387,13 +1189,6 @@ static int mc_probe(struct platform_device *pdev)
 		setup_address_map(priv);
 #endif
 
-	/*
-	 * Start capturing the correctable and uncorrectable errors. A write of
-	 * 0 starts the counters.
-	 */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
-		writel(0x0, baseaddr + ECC_CTRL_OFST);
-
 	return rc;
 
 free_edac_mc:
diff --git a/drivers/edac/zynq_edac.c b/drivers/edac/zynq_edac.c
new file mode 100644
index 000000000000..66a2dedddfef
--- /dev/null
+++ b/drivers/edac/zynq_edac.c
@@ -0,0 +1,504 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Zynq DDR ECC Driver
+ * This driver is based on ppc4xx_edac.c drivers
+ *
+ * Copyright (C) 2012 - 2014 Xilinx, Inc.
+ */
+
+#include <linux/edac.h>
+#include <linux/interrupt.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "edac_module.h"
+
+/* Number of cs_rows needed per memory controller */
+#define ZYNQ_EDAC_NR_CSROWS		1
+
+/* Number of channels per memory controller */
+#define ZYNQ_EDAC_NR_CHANS		1
+
+/* Granularity of reported error in bytes */
+#define ZYNQ_EDAC_ERR_GRAIN		1
+
+#define ZYNQ_EDAC_MSG_SIZE		256
+
+#define ZYNQ_EDAC_MOD_STRING		"zynq_edac"
+#define ZYNQ_EDAC_MOD_VER		"1"
+
+/* Zynq DDR memory controller ECC registers */
+#define ZYNQ_CTRL_OFST			0x0
+#define ZYNQ_T_ZQ_OFST			0xA4
+
+/* ECC control register */
+#define ZYNQ_ECC_CTRL_OFST		0xC4
+/* ECC log register */
+#define ZYNQ_CE_LOG_OFST		0xC8
+/* ECC address register */
+#define ZYNQ_CE_ADDR_OFST		0xCC
+/* ECC data[31:0] register */
+#define ZYNQ_CE_DATA_31_0_OFST		0xD0
+
+/* Uncorrectable error info registers */
+#define ZYNQ_UE_LOG_OFST		0xDC
+#define ZYNQ_UE_ADDR_OFST		0xE0
+#define ZYNQ_UE_DATA_31_0_OFST		0xE4
+
+#define ZYNQ_STAT_OFST			0xF0
+#define ZYNQ_SCRUB_OFST			0xF4
+
+/* Control register bit field definitions */
+#define ZYNQ_CTRL_BW_MASK		0xC
+#define ZYNQ_CTRL_BW_SHIFT		2
+
+#define ZYNQ_DDRCTL_WDTH_16		1
+#define ZYNQ_DDRCTL_WDTH_32		0
+
+/* ZQ register bit field definitions */
+#define ZYNQ_T_ZQ_DDRMODE_MASK		0x2
+
+/* ECC control register bit field definitions */
+#define ZYNQ_ECC_CTRL_CLR_CE_ERR	0x2
+#define ZYNQ_ECC_CTRL_CLR_UE_ERR	0x1
+
+/* ECC correctable/uncorrectable error log register definitions */
+#define ZYNQ_LOG_VALID			0x1
+#define ZYNQ_CE_LOG_BITPOS_MASK		0xFE
+#define ZYNQ_CE_LOG_BITPOS_SHIFT	1
+
+/* ECC correctable/uncorrectable error address register definitions */
+#define ZYNQ_ADDR_COL_MASK		0xFFF
+#define ZYNQ_ADDR_ROW_MASK		0xFFFF000
+#define ZYNQ_ADDR_ROW_SHIFT		12
+#define ZYNQ_ADDR_BANK_MASK		0x70000000
+#define ZYNQ_ADDR_BANK_SHIFT		28
+
+/* ECC statistic register definitions */
+#define ZYNQ_STAT_UECNT_MASK		0xFF
+#define ZYNQ_STAT_CECNT_MASK		0xFF00
+#define ZYNQ_STAT_CECNT_SHIFT		8
+
+/* ECC scrub register definitions */
+#define ZYNQ_SCRUB_MODE_MASK		0x7
+#define ZYNQ_SCRUB_MODE_SECDED		0x4
+
+/**
+ * struct zynq_ecc_error_info - ECC error log information.
+ * @row:	Row number.
+ * @col:	Column number.
+ * @bank:	Bank number.
+ * @bitpos:	Bit position.
+ * @data:	Data causing the error.
+ */
+struct zynq_ecc_error_info {
+	u32 row;
+	u32 col;
+	u32 bank;
+	u32 bitpos;
+	u32 data;
+};
+
+/**
+ * struct zynq_ecc_status - ECC status information to report.
+ * @ce_cnt:	Correctable error count.
+ * @ue_cnt:	Uncorrectable error count.
+ * @ceinfo:	Correctable error log information.
+ * @ueinfo:	Uncorrectable error log information.
+ */
+struct zynq_ecc_status {
+	u32 ce_cnt;
+	u32 ue_cnt;
+	struct zynq_ecc_error_info ceinfo;
+	struct zynq_ecc_error_info ueinfo;
+};
+
+/**
+ * struct zynq_edac_priv - DDR memory controller private instance data.
+ * @baseaddr:	Base address of the DDR controller.
+ * @message:	Buffer for framing the event specific info.
+ * @stat:	ECC status information.
+ */
+struct zynq_edac_priv {
+	void __iomem *baseaddr;
+	char message[ZYNQ_EDAC_MSG_SIZE];
+	struct zynq_ecc_status stat;
+};
+
+/**
+ * zynq_get_error_info - Get the current ECC error info.
+ * @priv:	DDR memory controller private instance data.
+ *
+ * Return: one if there is no error, otherwise zero.
+ */
+static int zynq_get_error_info(struct zynq_edac_priv *priv)
+{
+	struct zynq_ecc_status *p;
+	u32 regval, clearval = 0;
+	void __iomem *base;
+
+	base = priv->baseaddr;
+	p = &priv->stat;
+
+	regval = readl(base + ZYNQ_STAT_OFST);
+	if (!regval)
+		return 1;
+
+	p->ce_cnt = (regval & ZYNQ_STAT_CECNT_MASK) >> ZYNQ_STAT_CECNT_SHIFT;
+	p->ue_cnt = regval & ZYNQ_STAT_UECNT_MASK;
+
+	regval = readl(base + ZYNQ_CE_LOG_OFST);
+	if (!(p->ce_cnt && (regval & ZYNQ_LOG_VALID)))
+		goto ue_err;
+
+	p->ceinfo.bitpos = (regval & ZYNQ_CE_LOG_BITPOS_MASK) >> ZYNQ_CE_LOG_BITPOS_SHIFT;
+	regval = readl(base + ZYNQ_CE_ADDR_OFST);
+	p->ceinfo.row = (regval & ZYNQ_ADDR_ROW_MASK) >> ZYNQ_ADDR_ROW_SHIFT;
+	p->ceinfo.col = regval & ZYNQ_ADDR_COL_MASK;
+	p->ceinfo.bank = (regval & ZYNQ_ADDR_BANK_MASK) >> ZYNQ_ADDR_BANK_SHIFT;
+	p->ceinfo.data = readl(base + ZYNQ_CE_DATA_31_0_OFST);
+	edac_dbg(3, "CE bit position: %d data: %d\n", p->ceinfo.bitpos,
+		 p->ceinfo.data);
+	clearval = ZYNQ_ECC_CTRL_CLR_CE_ERR;
+
+ue_err:
+	regval = readl(base + ZYNQ_UE_LOG_OFST);
+	if (!(p->ue_cnt && (regval & ZYNQ_LOG_VALID)))
+		goto out;
+
+	regval = readl(base + ZYNQ_UE_ADDR_OFST);
+	p->ueinfo.row = (regval & ZYNQ_ADDR_ROW_MASK) >> ZYNQ_ADDR_ROW_SHIFT;
+	p->ueinfo.col = regval & ZYNQ_ADDR_COL_MASK;
+	p->ueinfo.bank = (regval & ZYNQ_ADDR_BANK_MASK) >> ZYNQ_ADDR_BANK_SHIFT;
+	p->ueinfo.data = readl(base + ZYNQ_UE_DATA_31_0_OFST);
+	clearval |= ZYNQ_ECC_CTRL_CLR_UE_ERR;
+
+out:
+	writel(clearval, base + ZYNQ_ECC_CTRL_OFST);
+	writel(0x0, base + ZYNQ_ECC_CTRL_OFST);
+
+	return 0;
+}
+
+/**
+ * handle_error - Handle Correctable and Uncorrectable errors.
+ * @mci:	EDAC memory controller instance.
+ * @p:		Zynq ECC status structure.
+ *
+ * Handles ECC correctable and uncorrectable errors.
+ */
+static void zynq_handle_error(struct mem_ctl_info *mci, struct zynq_ecc_status *p)
+{
+	struct zynq_edac_priv *priv = mci->pvt_info;
+	struct zynq_ecc_error_info *pinf;
+
+	if (p->ce_cnt) {
+		pinf = &p->ceinfo;
+
+		snprintf(priv->message, ZYNQ_EDAC_MSG_SIZE,
+			 "Row %d Bank %d Col %d Bit %d Data 0x%08x",
+			 pinf->row, pinf->bank, pinf->col,
+			 pinf->bitpos, pinf->data);
+
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
+				     priv->message, "");
+	}
+
+	if (p->ue_cnt) {
+		pinf = &p->ueinfo;
+
+		snprintf(priv->message, ZYNQ_EDAC_MSG_SIZE,
+			 "Row %d Bank %d Col %d",
+			 pinf->row, pinf->bank, pinf->col);
+
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
+				     priv->message, "");
+	}
+
+	memset(p, 0, sizeof(*p));
+}
+
+/**
+ * check_errors - Check controller for ECC errors.
+ * @mci:	EDAC memory controller instance.
+ *
+ * Check and post ECC errors. Called by the polling thread.
+ */
+static void zynq_check_errors(struct mem_ctl_info *mci)
+{
+	struct zynq_edac_priv *priv = mci->pvt_info;
+	int status;
+
+	status = zynq_get_error_info(priv);
+	if (status)
+		return;
+
+	zynq_handle_error(mci, &priv->stat);
+}
+
+/**
+ * zynq_get_dtype - Return the controller memory width.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the EDAC device type width appropriate for the current controller
+ * configuration.
+ *
+ * Return: a device type width enumeration.
+ */
+static enum dev_type zynq_get_dtype(const void __iomem *base)
+{
+	enum dev_type dt;
+	u32 width;
+
+	width = readl(base + ZYNQ_CTRL_OFST);
+	width = (width & ZYNQ_CTRL_BW_MASK) >> ZYNQ_CTRL_BW_SHIFT;
+
+	switch (width) {
+	case ZYNQ_DDRCTL_WDTH_16:
+		dt = DEV_X2;
+		break;
+	case ZYNQ_DDRCTL_WDTH_32:
+		dt = DEV_X4;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
+
+	return dt;
+}
+
+/**
+ * zynq_get_ecc_state - Return the controller ECC enable/disable status.
+ * @base:	DDR memory controller base address.
+ *
+ * Get the ECC enable/disable status of the controller.
+ *
+ * Return: true if enabled, otherwise false.
+ */
+static bool zynq_get_ecc_state(void __iomem *base)
+{
+	enum dev_type dt;
+	u32 ecctype;
+
+	dt = zynq_get_dtype(base);
+	if (dt == DEV_UNKNOWN)
+		return false;
+
+	ecctype = readl(base + ZYNQ_SCRUB_OFST) & ZYNQ_SCRUB_MODE_MASK;
+	if ((ecctype == ZYNQ_SCRUB_MODE_SECDED) && (dt == DEV_X2))
+		return true;
+
+	return false;
+}
+
+/**
+ * zynq_get_memsize - Read the size of the attached memory device.
+ *
+ * Return: the memory size in bytes.
+ */
+static u32 zynq_get_memsize(void)
+{
+	struct sysinfo inf;
+
+	si_meminfo(&inf);
+
+	return inf.totalram * inf.mem_unit;
+}
+
+/**
+ * zynq_get_mtype - Return the controller memory type.
+ * @base:	Zynq ECC status structure.
+ *
+ * Get the EDAC memory type appropriate for the current controller
+ * configuration.
+ *
+ * Return: a memory type enumeration.
+ */
+static enum mem_type zynq_get_mtype(const void __iomem *base)
+{
+	enum mem_type mt;
+	u32 memtype;
+
+	memtype = readl(base + ZYNQ_T_ZQ_OFST);
+
+	if (memtype & ZYNQ_T_ZQ_DDRMODE_MASK)
+		mt = MEM_DDR3;
+	else
+		mt = MEM_DDR2;
+
+	return mt;
+}
+
+/**
+ * zynq_init_csrows - Initialize the csrow data.
+ * @mci:	EDAC memory controller instance.
+ *
+ * Initialize the chip select rows associated with the EDAC memory
+ * controller instance.
+ */
+static void zynq_init_csrows(struct mem_ctl_info *mci)
+{
+	struct zynq_edac_priv *priv = mci->pvt_info;
+	struct csrow_info *csi;
+	struct dimm_info *dimm;
+	u32 size, row;
+	int j;
+
+	for (row = 0; row < mci->nr_csrows; row++) {
+		csi = mci->csrows[row];
+		size = zynq_get_memsize();
+
+		for (j = 0; j < csi->nr_channels; j++) {
+			dimm		= csi->channels[j]->dimm;
+			dimm->edac_mode	= EDAC_SECDED;
+			dimm->mtype	= zynq_get_mtype(priv->baseaddr);
+			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
+			dimm->grain	= ZYNQ_EDAC_ERR_GRAIN;
+			dimm->dtype	= zynq_get_dtype(priv->baseaddr);
+		}
+	}
+}
+
+/**
+ * zynq_mc_init - Initialize one driver instance.
+ * @mci:	EDAC memory controller instance.
+ * @pdev:	platform device.
+ *
+ * Perform initialization of the EDAC memory controller instance and
+ * related driver-private data associated with the memory controller the
+ * instance is bound to.
+ */
+static void zynq_mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
+{
+	struct zynq_edac_priv *priv;
+
+	mci->pdev = &pdev->dev;
+	priv = mci->pvt_info;
+	platform_set_drvdata(pdev, mci);
+
+	/* Initialize controller capabilities and configuration */
+	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
+	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
+	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
+	mci->scrub_mode = SCRUB_NONE;
+
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->ctl_name = "zynq_ddr_controller";
+	mci->dev_name = ZYNQ_EDAC_MOD_STRING;
+	mci->mod_name = ZYNQ_EDAC_MOD_VER;
+
+	edac_op_state = EDAC_OPSTATE_POLL;
+	mci->edac_check = zynq_check_errors;
+
+	mci->ctl_page_to_phys = NULL;
+
+	zynq_init_csrows(mci);
+}
+
+/**
+ * zynq_mc_probe - Check controller and bind driver.
+ * @pdev:	platform device.
+ *
+ * Probe a specific controller instance for binding with the driver.
+ *
+ * Return: 0 if the controller instance was successfully bound to the
+ * driver; otherwise, < 0 on error.
+ */
+static int zynq_mc_probe(struct platform_device *pdev)
+{
+	struct edac_mc_layer layers[2];
+	struct zynq_edac_priv *priv;
+	struct mem_ctl_info *mci;
+	void __iomem *baseaddr;
+	int rc;
+
+	baseaddr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(baseaddr))
+		return PTR_ERR(baseaddr);
+
+	if (!zynq_get_ecc_state(baseaddr)) {
+		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
+		return -ENXIO;
+	}
+
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = ZYNQ_EDAC_NR_CSROWS;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = ZYNQ_EDAC_NR_CHANS;
+	layers[1].is_virt_csrow = false;
+
+	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers,
+			    sizeof(struct zynq_edac_priv));
+	if (!mci) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Failed memory allocation for mc instance\n");
+		return -ENOMEM;
+	}
+
+	priv = mci->pvt_info;
+	priv->baseaddr = baseaddr;
+
+	zynq_mc_init(mci, pdev);
+
+	rc = edac_mc_add_mc(mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC,
+			    "Failed to register with EDAC core\n");
+		goto free_edac_mc;
+	}
+
+	/*
+	 * Start capturing the correctable and uncorrectable errors. A write of
+	 * 0 starts the counters.
+	 */
+	writel(0x0, baseaddr + ZYNQ_ECC_CTRL_OFST);
+
+	return 0;
+
+free_edac_mc:
+	edac_mc_free(mci);
+
+	return rc;
+}
+
+/**
+ * zynq_mc_remove - Unbind driver from controller.
+ * @pdev:	Platform device.
+ *
+ * Return: Unconditionally 0
+ */
+static int zynq_mc_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+
+	return 0;
+}
+
+static const struct of_device_id zynq_edac_match[] = {
+	{ .compatible = "xlnx,zynq-ddrc-a05" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, zynq_edac_match);
+
+static struct platform_driver zynq_edac_mc_driver = {
+	.driver = {
+		   .name = "zynq-edac",
+		   .of_match_table = zynq_edac_match,
+		   },
+	.probe = zynq_mc_probe,
+	.remove = zynq_mc_remove,
+};
+module_platform_driver(zynq_edac_mc_driver);
+
+MODULE_AUTHOR("Xilinx Inc");
+MODULE_DESCRIPTION("Zynq DDR ECC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.35.1

