Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8485119B48
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2019 12:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfEJKPr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 May 2019 06:15:47 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47708 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbfEJKPq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 May 2019 06:15:46 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2A6FC891B1;
        Fri, 10 May 2019 22:15:41 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1557483342;
        bh=TnA3fP0yvecUxe44Z376Gy1OFNIrd2c/e+H1EAU3/mY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KBhr1gM6W1uwQ3F8eiCuIfya6VYqMKT8L3H2gFqPfFbBM6kDXnpyCKmZXXqKD2R8f
         BzZxpmXPOrXe9LBvTnHRBmGjm5500CCToGJZSnpWeNevrPWxpbVANQywNQUCgw1rBZ
         Hp+DTTtpsqisXb/b0COYXwdOP88X0LcKYqkd92s0YDGaFmtoRToCa1zViDYuE/uVVp
         ykuZjr6p2kMb00/dXa/X4rP0T4nzyKoT/ogNcDspg5LH+1GsC1RIFCKLq88dSBQ9qC
         0fNyUh/wF4fucnsnQ4X4N6eLp0iGIxjqV/i7VE1cyPKnDpzRbcy+n+Ptxu012VkKPX
         Fk7oB57r0Ft9g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cd54f4d0002>; Fri, 10 May 2019 22:15:41 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id AF95F13EFA5;
        Fri, 10 May 2019 22:15:40 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 446711E1D5B; Fri, 10 May 2019 22:15:40 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, mark.rutland@arm.com,
        robh+dt@kernel.org, mchehab@kernel.org, james.morse@arm.com,
        jlu@pengutronix.de, gregory.clement@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v8 8/9] EDAC: Add driver for the Marvell Armada XP SDRAM and L2 cache ECC
Date:   Fri, 10 May 2019 22:15:35 +1200
Message-Id: <20190510101536.6724-9-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190510101536.6724-1-chris.packham@alliedtelesis.co.nz>
References: <20190510101536.6724-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Jan Luebbe <jlu@pengutronix.de>

Add support for the ECC functionality as found in the DDR RAM and L2
cache controllers on the MV78230/MV78x60 SoCs. This driver has been
tested on the MV78460 (on a custom board with a DDR3 ECC DIMM).

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
[cp use SPDX license]
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 MAINTAINERS                   |   6 +
 drivers/edac/Kconfig          |   7 +
 drivers/edac/Makefile         |   1 +
 drivers/edac/armada_xp_edac.c | 630 ++++++++++++++++++++++++++++++++++
 4 files changed, 644 insertions(+)
 create mode 100644 drivers/edac/armada_xp_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 960070e36bd9..191ddd9c7765 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5626,6 +5626,12 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/amd64_edac*
=20
+EDAC-ARMADA
+M:	Jan Luebbe <jlu@pengutronix.de>
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	drivers/edac/armada_xp_*
+
 EDAC-AST2500
 M:	Stefan Schaeckeler <sschaeck@cisco.com>
 S:	Supported
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 47eb4d13ed5f..6c45e2c8692c 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -460,6 +460,13 @@ config EDAC_ALTERA_SDMMC
 	  Support for error detection and correction on the
 	  Altera SDMMC FIFO Memory for Altera SoCs.
=20
+config EDAC_ARMADA_XP
+	bool "Marvell Armada XP DDR and L2 Cache ECC"
+	depends on MACH_MVEBU_V7
+	help
+	  Support for error correction and detection on the Marvell Aramada XP
+	  DDR RAM and L2 cache controllers.
+
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
 	depends on ARCH_ZYNQ || ARCH_ZYNQMP
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 89ad4a84a0f6..178987a7836d 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_EDAC_OCTEON_PCI)		+=3D octeon_edac-pci.o
 obj-$(CONFIG_EDAC_THUNDERX)		+=3D thunderx_edac.o
=20
 obj-$(CONFIG_EDAC_ALTERA)		+=3D altera_edac.o
+obj-$(CONFIG_EDAC_ARMADA_XP)		+=3D armada_xp_edac.o
 obj-$(CONFIG_EDAC_SYNOPSYS)		+=3D synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+=3D xgene_edac.o
 obj-$(CONFIG_EDAC_TI)			+=3D ti_edac.o
diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.=
c
new file mode 100644
index 000000000000..3759a4fbbdee
--- /dev/null
+++ b/drivers/edac/armada_xp_edac.c
@@ -0,0 +1,630 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017 Pengutronix, Jan Luebbe <kernel@pengutronix.de>
+ */
+
+#include <linux/kernel.h>
+#include <linux/edac.h>
+#include <linux/of_platform.h>
+
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/cache-aurora-l2.h>
+
+#include "edac_mc.h"
+#include "edac_device.h"
+#include "edac_module.h"
+
+/************************ EDAC MC (DDR RAM) ****************************=
****/
+
+#define SDRAM_NUM_CS 4
+
+#define SDRAM_CONFIG_REG        0x0
+#define SDRAM_CONFIG_ECC_MASK         BIT(18)
+#define SDRAM_CONFIG_REGISTERED_MASK  BIT(17)
+#define SDRAM_CONFIG_BUS_WIDTH_MASK   BIT(15)
+
+#define SDRAM_ADDR_CTRL_REG     0x10
+#define SDRAM_ADDR_CTRL_SIZE_HIGH_OFFSET(cs) (20+cs)
+#define SDRAM_ADDR_CTRL_SIZE_HIGH_MASK(cs)   (0x1 << SDRAM_ADDR_CTRL_SIZ=
E_HIGH_OFFSET(cs))
+#define SDRAM_ADDR_CTRL_ADDR_SEL_MASK(cs)    BIT(16+cs)
+#define SDRAM_ADDR_CTRL_SIZE_LOW_OFFSET(cs)  (cs*4+2)
+#define SDRAM_ADDR_CTRL_SIZE_LOW_MASK(cs)    (0x3 << SDRAM_ADDR_CTRL_SIZ=
E_LOW_OFFSET(cs))
+#define SDRAM_ADDR_CTRL_STRUCT_OFFSET(cs)    (cs*4)
+#define SDRAM_ADDR_CTRL_STRUCT_MASK(cs)      (0x3 << SDRAM_ADDR_CTRL_STR=
UCT_OFFSET(cs))
+
+#define SDRAM_ERR_DATA_H_REG    0x40
+#define SDRAM_ERR_DATA_L_REG    0x44
+
+#define SDRAM_ERR_RECV_ECC_REG  0x48
+#define SDRAM_ERR_RECV_ECC_VALUE_MASK 0xff
+
+#define SDRAM_ERR_CALC_ECC_REG  0x4c
+#define SDRAM_ERR_CALC_ECC_ROW_OFFSET 8
+#define SDRAM_ERR_CALC_ECC_ROW_MASK   (0xffff << SDRAM_ERR_CALC_ECC_ROW_=
OFFSET)
+#define SDRAM_ERR_CALC_ECC_VALUE_MASK 0xff
+
+#define SDRAM_ERR_ADDR_REG      0x50
+#define SDRAM_ERR_ADDR_BANK_OFFSET    23
+#define SDRAM_ERR_ADDR_BANK_MASK      (0x7 << SDRAM_ERR_ADDR_BANK_OFFSET=
)
+#define SDRAM_ERR_ADDR_COL_OFFSET     8
+#define SDRAM_ERR_ADDR_COL_MASK       (0x7fff << SDRAM_ERR_ADDR_COL_OFFS=
ET)
+#define SDRAM_ERR_ADDR_CS_OFFSET      1
+#define SDRAM_ERR_ADDR_CS_MASK        (0x3 << SDRAM_ERR_ADDR_CS_OFFSET)
+#define SDRAM_ERR_ADDR_TYPE_MASK      BIT(0)
+
+#define SDRAM_ERR_CTRL_REG      0x54
+#define SDRAM_ERR_CTRL_THR_OFFSET     16
+#define SDRAM_ERR_CTRL_THR_MASK       (0xff << SDRAM_ERR_CTRL_THR_OFFSET=
)
+#define SDRAM_ERR_CTRL_PROP_MASK      BIT(9)
+
+#define SDRAM_ERR_SBE_COUNT_REG 0x58
+#define SDRAM_ERR_DBE_COUNT_REG 0x5c
+
+#define SDRAM_ERR_CAUSE_ERR_REG 0xd0
+#define SDRAM_ERR_CAUSE_MSG_REG 0xd8
+#define SDRAM_ERR_CAUSE_DBE_MASK      BIT(1)
+#define SDRAM_ERR_CAUSE_SBE_MASK      BIT(0)
+
+#define SDRAM_RANK_CTRL_REG 0x1e0
+#define SDRAM_RANK_CTRL_EXIST_MASK(cs) BIT(cs)
+
+struct axp_mc_drvdata {
+	void __iomem *base;
+	/* width in bytes */
+	unsigned int width;
+	/* bank interleaving */
+	bool cs_addr_sel[SDRAM_NUM_CS];
+
+	char msg[128];
+};
+
+/* derived from "DRAM Address Multiplexing" in the ARAMDA XP Functional =
Spec */
+static uint32_t axp_mc_calc_address(struct axp_mc_drvdata *drvdata,
+				    uint8_t cs, uint8_t bank, uint16_t row,
+				    uint16_t col)
+{
+	if (drvdata->width =3D=3D 8) {
+		/* 64 bit */
+		if (drvdata->cs_addr_sel[cs])
+			/* bank interleaved */
+			return (((row & 0xfff8) << 16) |
+				((bank & 0x7) << 16) |
+				((row & 0x7) << 13) |
+				((col & 0x3ff) << 3));
+		else
+			return (((row & 0xffff << 16) |
+				 ((bank & 0x7) << 13) |
+				 ((col & 0x3ff)) << 3));
+	} else if (drvdata->width =3D=3D 4) {
+		/* 32 bit */
+		if (drvdata->cs_addr_sel[cs])
+			/* bank interleaved */
+			return (((row & 0xfff0) << 15) |
+				((bank & 0x7) << 16) |
+				((row & 0xf) << 12) |
+				((col & 0x3ff) << 2));
+		else
+			return (((row & 0xffff << 15) |
+				 ((bank & 0x7) << 12) |
+				 ((col & 0x3ff)) << 2));
+	} else {
+		/* 16 bit */
+		if (drvdata->cs_addr_sel[cs])
+			/* bank interleaved */
+			return (((row & 0xffe0) << 14) |
+				((bank & 0x7) << 16) |
+				((row & 0x1f) << 11) |
+				((col & 0x3ff) << 1));
+		else
+			return (((row & 0xffff << 14) |
+				 ((bank & 0x7) << 11) |
+				 ((col & 0x3ff)) << 1));
+	}
+}
+
+static void axp_mc_check(struct mem_ctl_info *mci)
+{
+	struct axp_mc_drvdata *drvdata =3D mci->pvt_info;
+	uint32_t data_h, data_l, recv_ecc, calc_ecc, addr;
+	uint32_t cnt_sbe, cnt_dbe, cause_err, cause_msg;
+	uint32_t row_val, col_val, bank_val, addr_val;
+	uint8_t syndrome_val, cs_val;
+	char *msg =3D drvdata->msg;
+
+	data_h    =3D readl(drvdata->base + SDRAM_ERR_DATA_H_REG);
+	data_l    =3D readl(drvdata->base + SDRAM_ERR_DATA_L_REG);
+	recv_ecc  =3D readl(drvdata->base + SDRAM_ERR_RECV_ECC_REG);
+	calc_ecc  =3D readl(drvdata->base + SDRAM_ERR_CALC_ECC_REG);
+	addr      =3D readl(drvdata->base + SDRAM_ERR_ADDR_REG);
+	cnt_sbe   =3D readl(drvdata->base + SDRAM_ERR_SBE_COUNT_REG);
+	cnt_dbe   =3D readl(drvdata->base + SDRAM_ERR_DBE_COUNT_REG);
+	cause_err =3D readl(drvdata->base + SDRAM_ERR_CAUSE_ERR_REG);
+	cause_msg =3D readl(drvdata->base + SDRAM_ERR_CAUSE_MSG_REG);
+
+	/* clear cause registers */
+	writel(~(SDRAM_ERR_CAUSE_DBE_MASK | SDRAM_ERR_CAUSE_SBE_MASK),
+	       drvdata->base + SDRAM_ERR_CAUSE_ERR_REG);
+	writel(~(SDRAM_ERR_CAUSE_DBE_MASK | SDRAM_ERR_CAUSE_SBE_MASK),
+	       drvdata->base + SDRAM_ERR_CAUSE_MSG_REG);
+
+	/* clear error counter registers */
+	if (cnt_sbe)
+		writel(0, drvdata->base + SDRAM_ERR_SBE_COUNT_REG);
+	if (cnt_dbe)
+		writel(0, drvdata->base + SDRAM_ERR_DBE_COUNT_REG);
+
+	if (!cnt_sbe && !cnt_dbe)
+		return;
+
+	if (!(addr & SDRAM_ERR_ADDR_TYPE_MASK)) {
+		if (cnt_sbe)
+			cnt_sbe--;
+		else
+			dev_warn(mci->pdev, "inconsistent SBE count detected");
+	} else {
+		if (cnt_dbe)
+			cnt_dbe--;
+		else
+			dev_warn(mci->pdev, "inconsistent DBE count detected");
+	}
+
+	/* report earlier errors */
+	if (cnt_sbe)
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+				     cnt_sbe, /* error count */
+				     0, 0, 0, /* pfn, offset, syndrome */
+				     -1, -1, -1, /* top, mid, low layer */
+				     mci->ctl_name,
+				     "details unavailable (multiple errors)");
+	if (cnt_dbe)
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+				     cnt_sbe, /* error count */
+				     0, 0, 0, /* pfn, offset, syndrome */
+				     -1, -1, -1, /* top, mid, low layer */
+				     mci->ctl_name,
+				     "details unavailable (multiple errors)");
+
+	/* report details for most recent error */
+	cs_val   =3D (addr & SDRAM_ERR_ADDR_CS_MASK) >> SDRAM_ERR_ADDR_CS_OFFSE=
T;
+	bank_val =3D (addr & SDRAM_ERR_ADDR_BANK_MASK) >> SDRAM_ERR_ADDR_BANK_O=
FFSET;
+	row_val  =3D (calc_ecc & SDRAM_ERR_CALC_ECC_ROW_MASK) >> SDRAM_ERR_CALC=
_ECC_ROW_OFFSET;
+	col_val  =3D (addr & SDRAM_ERR_ADDR_COL_MASK) >> SDRAM_ERR_ADDR_COL_OFF=
SET;
+	syndrome_val =3D (recv_ecc ^ calc_ecc) & 0xff;
+	addr_val =3D axp_mc_calc_address(drvdata, cs_val, bank_val, row_val,
+				       col_val);
+	msg +=3D sprintf(msg, "row=3D0x%04x ", row_val); /* 11 chars */
+	msg +=3D sprintf(msg, "bank=3D0x%x ", bank_val); /*  9 chars */
+	msg +=3D sprintf(msg, "col=3D0x%04x ", col_val); /* 11 chars */
+	msg +=3D sprintf(msg, "cs=3D%d", cs_val);	     /*  4 chars */
+
+	if (!(addr & SDRAM_ERR_ADDR_TYPE_MASK)) {
+		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+				     1,	/* error count */
+				     addr_val >> PAGE_SHIFT,
+				     addr_val & ~PAGE_MASK,
+				     syndrome_val,
+				     cs_val, -1, -1, /* top, mid, low layer */
+				     mci->ctl_name, drvdata->msg);
+	} else {
+		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+				     1,	/* error count */
+				     addr_val >> PAGE_SHIFT,
+				     addr_val & ~PAGE_MASK,
+				     syndrome_val,
+				     cs_val, -1, -1, /* top, mid, low layer */
+				     mci->ctl_name, drvdata->msg);
+	}
+}
+
+static void axp_mc_read_config(struct mem_ctl_info *mci)
+{
+	struct axp_mc_drvdata *drvdata =3D mci->pvt_info;
+	uint32_t config, addr_ctrl, rank_ctrl;
+	unsigned int i, cs_struct, cs_size;
+	struct dimm_info *dimm;
+
+	config =3D readl(drvdata->base + SDRAM_CONFIG_REG);
+	if (config & SDRAM_CONFIG_BUS_WIDTH_MASK)
+		/* 64 bit */
+		drvdata->width =3D 8;
+	else
+		/* 32 bit */
+		drvdata->width =3D 4;
+
+	addr_ctrl =3D readl(drvdata->base + SDRAM_ADDR_CTRL_REG);
+	rank_ctrl =3D readl(drvdata->base + SDRAM_RANK_CTRL_REG);
+	for (i =3D 0; i < SDRAM_NUM_CS; i++) {
+		dimm =3D mci->dimms[i];
+
+		if (!(rank_ctrl & SDRAM_RANK_CTRL_EXIST_MASK(i)))
+			continue;
+
+		drvdata->cs_addr_sel[i] =3D
+			!!(addr_ctrl & SDRAM_ADDR_CTRL_ADDR_SEL_MASK(i));
+
+		cs_struct =3D (addr_ctrl & SDRAM_ADDR_CTRL_STRUCT_MASK(i)) >> SDRAM_AD=
DR_CTRL_STRUCT_OFFSET(i);
+		cs_size   =3D ((addr_ctrl & SDRAM_ADDR_CTRL_SIZE_HIGH_MASK(i)) >> (SDR=
AM_ADDR_CTRL_SIZE_HIGH_OFFSET(i) - 2) |
+			    ((addr_ctrl & SDRAM_ADDR_CTRL_SIZE_LOW_MASK(i)) >> SDRAM_ADDR_CTR=
L_SIZE_LOW_OFFSET(i)));
+
+		switch (cs_size) {
+		case 0: /* 2GBit */
+			dimm->nr_pages =3D 524288;
+			break;
+		case 1: /* 256MBit */
+			dimm->nr_pages =3D 65536;
+			break;
+		case 2: /* 512MBit */
+			dimm->nr_pages =3D 131072;
+			break;
+		case 3: /* 1GBit */
+			dimm->nr_pages =3D 262144;
+			break;
+		case 4: /* 4GBit */
+			dimm->nr_pages =3D 1048576;
+			break;
+		case 5: /* 8GBit */
+			dimm->nr_pages =3D 2097152;
+			break;
+		}
+		dimm->grain =3D 8;
+		dimm->dtype =3D cs_struct ? DEV_X16 : DEV_X8;
+		dimm->mtype =3D (config & SDRAM_CONFIG_REGISTERED_MASK) ?
+			MEM_RDDR3 : MEM_DDR3;
+		dimm->edac_mode =3D EDAC_SECDED;
+	}
+}
+
+static const struct of_device_id axp_mc_of_match[] =3D {
+	{.compatible =3D "marvell,armada-xp-sdram-controller",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, axp_mc_of_match);
+
+static int axp_mc_probe(struct platform_device *pdev)
+{
+	struct axp_mc_drvdata *drvdata;
+	struct edac_mc_layer layers[1];
+	const struct of_device_id *id;
+	struct mem_ctl_info *mci;
+	struct resource *r;
+	void __iomem *base;
+	uint32_t config;
+
+	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		dev_err(&pdev->dev, "Unable to get mem resource\n");
+		return -ENODEV;
+	}
+
+	base =3D devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(base)) {
+		dev_err(&pdev->dev, "Unable to map regs\n");
+		return PTR_ERR(base);
+	}
+
+	config =3D readl(base + SDRAM_CONFIG_REG);
+	if (!(config & SDRAM_CONFIG_ECC_MASK)) {
+		dev_warn(&pdev->dev, "SDRAM ECC is not enabled");
+		return -EINVAL;
+	}
+
+	layers[0].type =3D EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size =3D SDRAM_NUM_CS;
+	layers[0].is_virt_csrow =3D true;
+
+	mci =3D edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*drvdata));
+	if (!mci)
+		return -ENOMEM;
+
+	drvdata =3D mci->pvt_info;
+	drvdata->base =3D base;
+	mci->pdev =3D &pdev->dev;
+	platform_set_drvdata(pdev, mci);
+
+	id =3D of_match_device(axp_mc_of_match, &pdev->dev);
+	mci->edac_check =3D axp_mc_check;
+	mci->mtype_cap =3D MEM_FLAG_DDR3;
+	mci->edac_cap =3D EDAC_FLAG_SECDED;
+	mci->mod_name =3D pdev->dev.driver->name;
+	mci->ctl_name =3D id ? id->compatible : "unknown";
+	mci->dev_name =3D dev_name(&pdev->dev);
+	mci->scrub_mode =3D SCRUB_NONE;
+
+	axp_mc_read_config(mci);
+
+	/* configure SBE threshold */
+	/* it seems that SBEs are not captured otherwise */
+	writel(1 << SDRAM_ERR_CTRL_THR_OFFSET, drvdata->base + SDRAM_ERR_CTRL_R=
EG);
+
+	/* clear cause registers */
+	writel(~(SDRAM_ERR_CAUSE_DBE_MASK | SDRAM_ERR_CAUSE_SBE_MASK), drvdata-=
>base + SDRAM_ERR_CAUSE_ERR_REG);
+	writel(~(SDRAM_ERR_CAUSE_DBE_MASK | SDRAM_ERR_CAUSE_SBE_MASK), drvdata-=
>base + SDRAM_ERR_CAUSE_MSG_REG);
+
+	/* clear counter registers */
+	writel(0, drvdata->base + SDRAM_ERR_SBE_COUNT_REG);
+	writel(0, drvdata->base + SDRAM_ERR_DBE_COUNT_REG);
+
+	if (edac_mc_add_mc(mci)) {
+		edac_mc_free(mci);
+		return -EINVAL;
+	}
+	edac_op_state =3D EDAC_OPSTATE_POLL;
+
+	return 0;
+}
+
+static int axp_mc_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci =3D platform_get_drvdata(pdev);
+
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver axp_mc_driver =3D {
+	.probe =3D axp_mc_probe,
+	.remove =3D axp_mc_remove,
+	.driver =3D {
+		.name =3D "armada_xp_mc_edac",
+		.of_match_table =3D of_match_ptr(axp_mc_of_match),
+	},
+};
+
+/************************ EDAC Device (L2 Cache) ***********************=
****/
+
+struct aurora_l2_drvdata {
+	void __iomem *base;
+
+	char msg[128];
+
+	/* error injection via debugfs */
+	uint32_t inject_addr;
+	uint32_t inject_mask;
+	uint8_t inject_ctl;
+
+	struct dentry *debugfs;
+};
+
+#ifdef CONFIG_EDAC_DEBUG
+static void aurora_l2_inject(struct aurora_l2_drvdata *drvdata)
+{
+	drvdata->inject_addr &=3D AURORA_ERR_INJECT_CTL_ADDR_MASK;
+	drvdata->inject_ctl &=3D AURORA_ERR_INJECT_CTL_EN_MASK;
+	writel(0, drvdata->base + AURORA_ERR_INJECT_CTL_REG);
+	writel(drvdata->inject_mask, drvdata->base + AURORA_ERR_INJECT_MASK_REG=
);
+	writel(drvdata->inject_addr | drvdata->inject_ctl, drvdata->base + AURO=
RA_ERR_INJECT_CTL_REG);
+}
+#endif
+
+static void aurora_l2_check(struct edac_device_ctl_info *dci)
+{
+	struct aurora_l2_drvdata *drvdata =3D dci->pvt_info;
+	uint32_t cnt, src, txn, err, attr_cap, addr_cap, way_cap;
+	unsigned int cnt_ce, cnt_ue;
+	char *msg =3D drvdata->msg;
+	size_t size =3D sizeof(drvdata->msg);
+	size_t len =3D 0;
+
+	cnt =3D readl(drvdata->base + AURORA_ERR_CNT_REG);
+	attr_cap =3D readl(drvdata->base + AURORA_ERR_ATTR_CAP_REG);
+	addr_cap =3D readl(drvdata->base + AURORA_ERR_ADDR_CAP_REG);
+	way_cap =3D readl(drvdata->base + AURORA_ERR_WAY_CAP_REG);
+
+	cnt_ce =3D (cnt & AURORA_ERR_CNT_CE_MASK) >> AURORA_ERR_CNT_CE_OFFSET;
+	cnt_ue =3D (cnt & AURORA_ERR_CNT_UE_MASK) >> AURORA_ERR_CNT_UE_OFFSET;
+	/* clear error counter registers */
+	if (cnt_ce || cnt_ue)
+		writel(AURORA_ERR_CNT_CLR, drvdata->base + AURORA_ERR_CNT_REG);
+
+	if (!(attr_cap & AURORA_ERR_ATTR_CAP_VALID))
+		goto clear_remaining;
+
+	src =3D (attr_cap & AURORA_ERR_ATTR_SRC_MSK) >> AURORA_ERR_ATTR_SRC_OFF=
;
+	if (src <=3D 3)
+		len +=3D snprintf(msg+len, size-len, "src=3DCPU%d ", src);
+	else
+		len +=3D snprintf(msg+len, size-len, "src=3DIO ");
+
+	txn =3D  (attr_cap & AURORA_ERR_ATTR_TXN_MSK) >> AURORA_ERR_ATTR_TXN_OF=
F;
+	switch (txn) {
+	case 0:
+		len +=3D snprintf(msg+len, size-len, "txn=3DData-Read ");
+		break;
+	case 1:
+		len +=3D snprintf(msg+len, size-len, "txn=3DIsn-Read ");
+		break;
+	case 2:
+		len +=3D snprintf(msg+len, size-len, "txn=3DClean-Flush ");
+		break;
+	case 3:
+		len +=3D snprintf(msg+len, size-len, "txn=3DEviction ");
+		break;
+	case 4:
+		len +=3D snprintf(msg+len, size-len,
+				"txn=3DRead-Modify-Write ");
+		break;
+	}
+
+	err =3D (attr_cap & AURORA_ERR_ATTR_ERR_MSK) >> AURORA_ERR_ATTR_ERR_OFF=
;
+	switch (err) {
+	case 0:
+		len +=3D snprintf(msg+len, size-len, "err=3DCorrECC ");
+		break;
+	case 1:
+		len +=3D snprintf(msg+len, size-len, "err=3DUnCorrECC ");
+		break;
+	case 2:
+		len +=3D snprintf(msg+len, size-len, "err=3DTagParity ");
+		break;
+	}
+
+	len +=3D snprintf(msg+len, size-len, "addr=3D0x%x ", addr_cap & AURORA_=
ERR_ADDR_CAP_ADDR_MASK);
+	len +=3D snprintf(msg+len, size-len, "index=3D0x%x ", (way_cap & AURORA=
_ERR_WAY_IDX_MSK) >> AURORA_ERR_WAY_IDX_OFF);
+	len +=3D snprintf(msg+len, size-len, "way=3D0x%x", (way_cap & AURORA_ER=
R_WAY_CAP_WAY_MASK) >> AURORA_ERR_WAY_CAP_WAY_OFFSET);
+
+	/* clear error capture registers */
+	writel(AURORA_ERR_ATTR_CAP_VALID, drvdata->base + AURORA_ERR_ATTR_CAP_R=
EG);
+	if (err) {
+		/* UnCorrECC or TagParity */
+		if (cnt_ue)
+			cnt_ue--;
+		edac_device_handle_ue(dci, 0, 0, drvdata->msg);
+	} else {
+		if (cnt_ce)
+			cnt_ce--;
+		edac_device_handle_ce(dci, 0, 0, drvdata->msg);
+	}
+
+clear_remaining:
+	/* report remaining errors */
+	while (cnt_ue--)
+		edac_device_handle_ue(dci, 0, 0, "details unavailable (multiple errors=
)");
+	while (cnt_ce--)
+		edac_device_handle_ue(dci, 0, 0, "details unavailable (multiple errors=
)");
+}
+
+static void aurora_l2_poll(struct edac_device_ctl_info *dci)
+{
+#ifdef CONFIG_EDAC_DEBUG
+	struct aurora_l2_drvdata *drvdata =3D dci->pvt_info;
+#endif
+
+	aurora_l2_check(dci);
+#ifdef CONFIG_EDAC_DEBUG
+	aurora_l2_inject(drvdata);
+#endif
+}
+
+static const struct of_device_id aurora_l2_of_match[] =3D {
+	{.compatible =3D "marvell,aurora-system-cache",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, aurora_l2_of_match);
+
+static int aurora_l2_probe(struct platform_device *pdev)
+{
+	struct aurora_l2_drvdata *drvdata;
+	struct edac_device_ctl_info *dci;
+	const struct of_device_id *id;
+	uint32_t l2x0_aux_ctrl;
+	void __iomem *base;
+	struct resource *r;
+
+	r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r) {
+		dev_err(&pdev->dev, "Unable to get mem resource\n");
+		return -ENODEV;
+	}
+
+	base =3D devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(base)) {
+		dev_err(&pdev->dev, "Unable to map regs\n");
+		return PTR_ERR(base);
+	}
+
+	l2x0_aux_ctrl =3D readl(base + L2X0_AUX_CTRL);
+	if (!(l2x0_aux_ctrl & AURORA_ACR_PARITY_EN))
+		dev_warn(&pdev->dev, "tag parity is not enabled");
+	if (!(l2x0_aux_ctrl & AURORA_ACR_ECC_EN))
+		dev_warn(&pdev->dev, "data ECC is not enabled");
+
+	dci =3D edac_device_alloc_ctl_info(sizeof(*drvdata),
+					 "cpu", 1, "L", 1, 2, NULL, 0, 0);
+	if (!dci)
+		return -ENOMEM;
+
+	drvdata =3D dci->pvt_info;
+	drvdata->base =3D base;
+	dci->dev =3D &pdev->dev;
+	platform_set_drvdata(pdev, dci);
+
+	id =3D of_match_device(aurora_l2_of_match, &pdev->dev);
+	dci->edac_check =3D aurora_l2_poll;
+	dci->mod_name =3D pdev->dev.driver->name;
+	dci->ctl_name =3D id ? id->compatible : "unknown";
+	dci->dev_name =3D dev_name(&pdev->dev);
+
+	/* clear registers */
+	writel(AURORA_ERR_CNT_CLR, drvdata->base + AURORA_ERR_CNT_REG);
+	writel(AURORA_ERR_ATTR_CAP_VALID, drvdata->base + AURORA_ERR_ATTR_CAP_R=
EG);
+
+	if (edac_device_add_device(dci)) {
+		edac_device_free_ctl_info(dci);
+		return -EINVAL;
+	}
+
+#ifdef CONFIG_EDAC_DEBUG
+	drvdata->debugfs =3D edac_debugfs_create_dir(dev_name(&pdev->dev));
+	if (drvdata->debugfs) {
+		edac_debugfs_create_x32("inject_addr", 0644,
+					drvdata->debugfs,
+					&drvdata->inject_addr);
+		edac_debugfs_create_x32("inject_mask", 0644,
+					drvdata->debugfs,
+					&drvdata->inject_mask);
+		edac_debugfs_create_x8("inject_ctl", 0644,
+				       drvdata->debugfs, &drvdata->inject_ctl);
+	}
+#endif
+
+	return 0;
+}
+
+static int aurora_l2_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *dci =3D platform_get_drvdata(pdev);
+#ifdef CONFIG_EDAC_DEBUG
+	struct aurora_l2_drvdata *drvdata =3D dci->pvt_info;
+
+	edac_debugfs_remove_recursive(drvdata->debugfs);
+#endif
+	edac_device_del_device(&pdev->dev);
+	edac_device_free_ctl_info(dci);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver aurora_l2_driver =3D {
+	.probe =3D aurora_l2_probe,
+	.remove =3D aurora_l2_remove,
+	.driver =3D {
+		.name =3D "aurora_l2_edac",
+		.of_match_table =3D of_match_ptr(aurora_l2_of_match),
+	},
+};
+
+/************************ Driver registration **************************=
****/
+
+static struct platform_driver * const drivers[] =3D {
+	&axp_mc_driver,
+	&aurora_l2_driver,
+};
+
+static int __init armada_xp_edac_init(void)
+{
+	int res;
+
+	/* only polling is supported */
+	edac_op_state =3D EDAC_OPSTATE_POLL;
+
+	res =3D platform_register_drivers(drivers, ARRAY_SIZE(drivers));
+	if (res)
+		pr_warn("Aramda XP EDAC drivers fail to register\n");
+
+	return 0;
+}
+module_init(armada_xp_edac_init);
+
+static void __exit armada_xp_edac_exit(void)
+{
+	platform_unregister_drivers(drivers, ARRAY_SIZE(drivers));
+}
+module_exit(armada_xp_edac_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Pengutronix");
+MODULE_DESCRIPTION("EDAC Drivers for Marvell Armada XP SDRAM and L2 Cach=
e Controller");
--=20
2.21.0

