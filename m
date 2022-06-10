Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBEB545F8B
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jun 2022 10:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243975AbiFJIoM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Jun 2022 04:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348046AbiFJIoG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 Jun 2022 04:44:06 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30861377E3;
        Fri, 10 Jun 2022 01:44:04 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o6so17181921plg.2;
        Fri, 10 Jun 2022 01:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=19JpDsicrfEz1QujCEZPNRVyZqH2pBsjTbJYM9o18UQ=;
        b=az02qZ8qjO6qduvxOY6xgAmO1MQj2Lj5JdOc2SeewAC1KrqVytY8qGJW8sem+ZB50h
         9B21l8Flafnhj9NRzUSqxzgW1AzmxMiVjEBqfvU0oBd7/sNopaJ5JeSjmCWjaTnKeX2c
         74okcqgyzA4l5NkzjAKA9CM0yIFqKFAzu+E7vx7wOAJ3NP7jhKYkaL6NMqSHtJl9brSu
         CxuJmi4KrLRStjA5m21nNk1Kuyb3P4JSDIuk7xknX2dG+X6Mxbw0++P5u8V/fsnHVl2P
         sAklG6AS86buz6QMotVxMMsTPkxmNVyllyw/l04WvogydtlaPN6enVN7kw0Lmev+BYdQ
         9jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19JpDsicrfEz1QujCEZPNRVyZqH2pBsjTbJYM9o18UQ=;
        b=5doUK06Hcn96RYIT6o0AYbRsvY8Via4HT2pv4q+IVkhrbH7skp53CXSaToL4ceQocy
         qYGY1HZ6S+05DXNjSZHTqqIkQa5yjASpezUXVlFwR+i5rpjqtyCaQSmqFhjmfrBv2KY8
         bYeXPPe2fckEiXFxyz6mGrs0SU2tcMQVASKnwEht/wleVYVU3Y1GVLYxhMM2RHiYRu5X
         O/bDg80tsY2IKv8BatHcUs3E88OhXfSaeSSuivdygVPmHsEvHWzq4iPCcpnL7gXRMUWW
         HTDNpwbNWYH3IR8P4VIHQWY+Zu5Rv7js9lSKslS7qZIaf1xZe5qacUfRqj3m+bbYyNOI
         JotA==
X-Gm-Message-State: AOAM53343XHg1NH461Q/wVXxAidwmQPWPRH6Wnr/16di+OIVhLTYREJA
        eiVZskradZmxEsGPnx6IOO0=
X-Google-Smtp-Source: ABdhPJwgfacozvtL3R5xb2W4+F9fXVShDolNbA5Ie6hzAIpmdE4BCDSsMell5ubHTIbYca40TWbp5g==
X-Received: by 2002:a17:902:a9c6:b0:15e:fe5d:cf67 with SMTP id b6-20020a170902a9c600b0015efe5dcf67mr43811878plr.74.1654850643483;
        Fri, 10 Jun 2022 01:44:03 -0700 (PDT)
Received: from localhost.localdomain ([1.200.147.12])
        by smtp.gmail.com with ESMTPSA id c28-20020aa7953c000000b0051c01aa7d31sm11703568pfp.46.2022.06.10.01.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:44:02 -0700 (PDT)
From:   medadyoung@gmail.com
X-Google-Original-From: ctcchien@nuvoton.com
To:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v12 3/3] EDAC: nuvoton: Add NPCM memory controller driver
Date:   Fri, 10 Jun 2022 16:43:40 +0800
Message-Id: <20220610084340.2268-4-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220610084340.2268-1-ctcchien@nuvoton.com>
References: <20220610084340.2268-1-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Medad CChien <ctcchien@nuvoton.com>

Add memory controller support for Nuvoton NPCM SoC.

Note:
    you can force an ecc event by writing a string to edac sysfs node
    and remember to define CONFIG_EDAC_DEBUG to enable this feature
    example: force a correctable event on checkcode bit 0
    echo "CE checkcode 0" to below path
    /sys/devices/system/edac/mc/mc0/forced_ecc_error

Datasheet:
    Cadence DDR Controller Register Reference Manual For DDR4 Memories
    Chapter 2: Detailed Register Map

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
---
 MAINTAINERS              |   2 +-
 drivers/edac/Kconfig     |  17 +
 drivers/edac/Makefile    |   1 +
 drivers/edac/npcm_edac.c | 680 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 699 insertions(+), 1 deletion(-)
 create mode 100644 drivers/edac/npcm_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f832e6ed4e5..8919fb83f485 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2372,9 +2372,9 @@ F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
 F:	drivers/*/*npcm*
 F:	drivers/*/*/*npcm*
+F:	drivers/edac/npcm_edac.c b/drivers/edac/npcm_edac.c
 F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
 
-
 ARM/NUVOTON WPCM450 ARCHITECTURE
 M:	Jonathan Neuschäfer <j.neuschaefer@gmx.net>
 L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 58ab63642e72..aab7ba6c0d15 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -539,4 +539,21 @@ config EDAC_DMC520
 	  Support for error detection and correction on the
 	  SoCs with ARM DMC-520 DRAM controller.
 
+config EDAC_NPCM
+	tristate "Nuvoton NPCM DDR Memory Controller"
+	depends on (ARCH_NPCM || COMPILE_TEST)
+	help
+	  Support for error detection and correction on the Nuvoton NPCM DDR
+	  memory controller.
+
+	  The Nuvoton BMC SoC supports DDR4 memory with and without ECC (error
+	  correction check).
+
+	  The memory controller supports single bit error correction, double bit
+	  error detection (in-line ECC in which a section (1/8th) of the memory
+	  device used to store data is used for ECC storage).
+
+	  First, ECC must be configured in the BootBlock header. Then, this driver
+	  will expose error counters via the EDAC kernel framework.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 2d1641a27a28..db3c59d3ad84 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -84,3 +84,4 @@ obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
 obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
+obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
diff --git a/drivers/edac/npcm_edac.c b/drivers/edac/npcm_edac.c
new file mode 100644
index 000000000000..3eb522c75646
--- /dev/null
+++ b/drivers/edac/npcm_edac.c
@@ -0,0 +1,680 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2022 Nuvoton Technology Corporation
+
+#include <linux/delay.h>
+#include <linux/of_device.h>
+
+#include "edac_module.h"
+
+#define NPCM_EDAC_MOD_NAME "npcm-edac"
+#define FORCED_ECC_ERR_EVENT_SUPPORT		BIT(1)
+#define EDAC_MSG_SIZE						256
+/* Granularity of reported error in bytes */
+#define NPCM_EDAC_ERR_GRAIN				1
+
+#define MEM_TYPE_DDR4						0xA
+
+#define NPCM7XX_CHIP						0x700
+#define NPCM8XX_CHIP						0x800
+
+/* Control register width definitions */
+#define WDTH_16								(2)
+#define WDTH_32								(1)
+#define WDTH_64								(0)
+#define CTL_MEM_MAX_WIDTH_MASK			GENMASK(4, 0)
+#define CTL_REG_WIDTH_SHIFT					(32)
+#define XOR_CHECK_BIT_SPLIT_WIDTH			(16)
+#define CTL_CONTROLLER_BUSY_FLAG			BIT(0)
+#define NPCM_ECC_CTL_FORCE_WC				BIT(8)
+#define NPCM_ECC_CTL_AUTO_WRITEBACK_EN	BIT(24)
+#define NPCM_ECC_CTL_XOR_BITS_MASK			GENMASK(23, 16)
+#define NPCM_ECC_CTL_MTYPE_MASK			GENMASK(11, 8)
+#define NPCM_ECC_CTL_GLOBAL_INT_DISABLE		BIT(31)
+
+/* Syndrome values */
+#define ECC_DOUBLE_MULTI_ERR_SYND			0x03
+
+static char data_synd[] = {
+	0xf4, 0xf1, 0xec, 0xea, 0xe9, 0xe6, 0xe5, 0xe3,
+	0xdc, 0xda, 0xd9, 0xd6, 0xd5, 0xd3, 0xce, 0xcb,
+	0xb5, 0xb0, 0xad, 0xab, 0xa8, 0xa7, 0xa4, 0xa2,
+	0x9d, 0x9b, 0x98, 0x97, 0x94, 0x92, 0x8f, 0x8a,
+	0x75, 0x70, 0x6d, 0x6b, 0x68, 0x67, 0x64, 0x62,
+	0x5e, 0x5b, 0x58, 0x57, 0x54, 0x52, 0x4f, 0x4a,
+	0x34, 0x31, 0x2c, 0x2a, 0x29, 0x26, 0x25, 0x23,
+	0x1c, 0x1a, 0x19, 0x16, 0x15, 0x13, 0x0e, 0x0b
+};
+
+static char check_synd[] = { 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80 };
+
+struct npcm_edac_platform_data {
+	/* force ECC event */
+	u32 ip_features;
+	u32 ddr_ctl_controller_busy_reg;
+	u32 ecc_ctl_xor_check_bits_reg;
+
+	u32 chip;
+
+	/* DDR4 Controller Registers */
+	u32 ddr_ctl_mem_type_reg;
+	u32 ddr_ctl_mem_width_reg;
+
+	u32 ecc_ctl_en_reg;
+	u32 ecc_ctl_int_mask;
+	u32 ecc_ctl_int_status;
+	u32 ecc_ctl_int_ack;
+	u32 ecc_ctl_int_mask_master;
+	u32 ecc_ctl_int_mask_ecc;
+
+	u32 ecc_sig_c_addr_l;
+	u32 ecc_sig_c_addr_h;
+	u32 ecc_sig_c_data_l;
+	u32 ecc_sig_c_data_h;
+	u32 ecc_sig_c_id;
+	u32 ecc_sig_c_synd;
+
+	u32 ecc_sig_u_addr_l;
+	u32 ecc_sig_u_addr_h;
+	u32 ecc_sig_u_data_l;
+	u32 ecc_sig_u_data_h;
+	u32 ecc_sig_u_id;
+	u32 ecc_sig_u_synd;
+
+	/* MASK */
+	u32 ecc_ctl_ecc_enable_mask;
+	u32 ecc_ctl_en_int_master_mask;
+	u32 ecc_ctl_en_int_ecc_mask;
+
+	/* ECC IRQ Macros */
+	u32 ecc_int_ce_event;
+	u32 ecc_int_second_ce_event;
+	u32 ecc_int_ue_event;
+	u32 ecc_int_second_ue_event;
+	u32 ecc_int_ce_ue_mask;
+	u32 ecc_ce_intr_mask;
+	u32 ecc_ue_intr_mask;
+
+	/* ECC Signature Macros */
+	u32 ecc_sig_c_id_shift;
+	u32 ecc_sig_c_synd_shift;
+	u32 ecc_sig_c_addr_h_mask;
+	u32 ecc_sig_c_id_mask;
+	u32 ecc_sig_c_synd_mask;
+
+	u32 ecc_sig_u_id_shift;
+	u32 ecc_sig_u_synd_shift;
+	u32 ecc_sig_u_addr_h_mask;
+	u32 ecc_sig_u_id_mask;
+	u32 ecc_sig_u_synd_mask;
+};
+
+struct priv_data {
+	void __iomem *reg;
+	u32 ce_cnt;
+	u32 ue_cnt;
+	char message[EDAC_MSG_SIZE];
+	const struct npcm_edac_platform_data *npcm_chip;
+};
+
+
+static void init_mem_layout(struct mem_ctl_info *mci)
+{
+	struct priv_data *priv = mci->pvt_info;
+	const struct npcm_edac_platform_data *npcm_chip = priv->npcm_chip;
+	struct csrow_info *csi;
+	struct dimm_info *dimm;
+	struct sysinfo info;
+	enum mem_type mtype;
+	u32 val, width;
+	u32 size, row;
+	int j;
+
+	dimm = edac_get_dimm(mci, 0, 0, 0);
+
+	if (dimm)
+		return;
+
+	si_meminfo(&info);
+	size = info.totalram * info.mem_unit;
+	for (row = 0; row < mci->nr_csrows; row++) {
+		csi = mci->csrows[row];
+
+		for (j = 0; j < csi->nr_channels; j++) {
+			dimm            = csi->channels[j]->dimm;
+			dimm->edac_mode = EDAC_FLAG_SECDED;
+			/* Get memory type by reading hw registers */
+			val = readl(priv->reg + npcm_chip->ddr_ctl_mem_type_reg);
+
+			mtype = val & NPCM_ECC_CTL_MTYPE_MASK;
+			if (mtype == MEM_TYPE_DDR4)
+				dimm->mtype = MEM_DDR4;
+			else
+				dimm->mtype = MEM_EMPTY;
+
+			/* Get EDAC devtype width for the current mc */
+			width = readl(priv->reg + npcm_chip->ddr_ctl_mem_width_reg)
+				      & CTL_MEM_MAX_WIDTH_MASK;
+			switch (width) {
+			case WDTH_16:
+				dimm->dtype = DEV_X2;
+				break;
+			case WDTH_32:
+				dimm->dtype = DEV_X4;
+				break;
+			case WDTH_64:
+				dimm->dtype = DEV_X8;
+				break;
+			default:
+				dimm->dtype = DEV_UNKNOWN;
+			}
+
+			dimm->nr_pages = (size >> PAGE_SHIFT) /
+				csi->nr_channels;
+			dimm->grain = NPCM_EDAC_ERR_GRAIN;
+		}
+	}
+}
+
+
+static void handle_correctable_error(struct mem_ctl_info *mci)
+{
+	struct priv_data *priv = mci->pvt_info;
+	const struct npcm_edac_platform_data *npcm_chip = priv->npcm_chip;
+	u64 err_c_addr = 0x0;
+	u64 err_c_data = 0x0;
+	u32 err_c_synd, err_c_id;
+	u32 sig_val_l, sig_val_h = 0x0;
+
+	sig_val_l = readl(priv->reg + npcm_chip->ecc_sig_c_addr_l);
+
+	if (npcm_chip->chip == NPCM8XX_CHIP)
+		sig_val_h = (readl(priv->reg + npcm_chip->ecc_sig_c_addr_h) &
+				npcm_chip->ecc_sig_c_addr_h_mask);
+
+	err_c_addr = (((err_c_addr | sig_val_h) <<
+				CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+	sig_val_l = readl(priv->reg + npcm_chip->ecc_sig_c_data_l);
+
+	if (npcm_chip->chip == NPCM8XX_CHIP)
+		sig_val_h = readl(priv->reg + npcm_chip->ecc_sig_c_data_h);
+
+	err_c_data = (((err_c_data | sig_val_h) <<
+				CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+	err_c_id = ((readl(priv->reg + npcm_chip->ecc_sig_c_id) &
+				npcm_chip->ecc_sig_c_id_mask) >>
+				npcm_chip->ecc_sig_c_id_shift);
+
+	err_c_synd = ((readl(priv->reg + npcm_chip->ecc_sig_c_synd) &
+				npcm_chip->ecc_sig_c_synd_mask) >>
+				npcm_chip->ecc_sig_c_synd_shift);
+
+	priv->ce_cnt += 1;
+
+	snprintf(priv->message,
+		 EDAC_MSG_SIZE, "DDR ECC %s: data=0x%llx source_id=%#08x",
+		 mci->ctl_name, err_c_data, err_c_id);
+
+	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
+			     priv->ce_cnt,
+			     err_c_addr >> PAGE_SHIFT,
+			     err_c_addr & ~PAGE_MASK,
+			     err_c_synd, 0, 0, -1,
+			     priv->message, "");
+}
+
+static void handle_ue(struct mem_ctl_info *mci)
+{
+	struct priv_data *priv = mci->pvt_info;
+	const struct npcm_edac_platform_data *npcm_chip = priv->npcm_chip;
+	u64 err_u_addr = 0x0;
+	u64 err_u_data = 0x0;
+	u32 err_u_synd, err_u_id;
+	u32 sig_val_l, sig_val_h = 0x0;
+
+	sig_val_l = readl(priv->reg + npcm_chip->ecc_sig_u_addr_l);
+
+	if (npcm_chip->chip == NPCM8XX_CHIP)
+		sig_val_h = (readl(priv->reg + npcm_chip->ecc_sig_u_addr_h) &
+				npcm_chip->ecc_sig_u_addr_h_mask);
+
+	err_u_addr = (((err_u_addr | sig_val_h) <<
+				CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+	sig_val_l = readl(priv->reg + npcm_chip->ecc_sig_u_data_l);
+
+	if (npcm_chip->chip == NPCM8XX_CHIP)
+		sig_val_h = readl(priv->reg + npcm_chip->ecc_sig_u_data_h);
+
+	err_u_data = (((err_u_data | sig_val_h) <<
+				CTL_REG_WIDTH_SHIFT) | sig_val_l);
+
+	err_u_id = ((readl(priv->reg + npcm_chip->ecc_sig_u_id) &
+				npcm_chip->ecc_sig_u_id_mask) >>
+			npcm_chip->ecc_sig_u_id_shift);
+
+	err_u_synd = ((readl(priv->reg + npcm_chip->ecc_sig_u_synd) &
+				npcm_chip->ecc_sig_u_synd_mask) >>
+			npcm_chip->ecc_sig_u_synd_shift);
+	priv->ue_cnt += 1;
+
+	snprintf(priv->message, EDAC_MSG_SIZE,
+		 "DDR ECC %s: addr=0x%llx data=0x%llx source_id=%#08x",
+		 mci->ctl_name, err_u_addr, err_u_data, err_u_id);
+
+	edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
+			     priv->ue_cnt,
+			     err_u_addr >> PAGE_SHIFT,
+			     err_u_addr & ~PAGE_MASK,
+			     err_u_synd, 0, 0, -1,
+			     priv->message, "");
+}
+
+static irqreturn_t edac_ecc_isr(int irq, void *dev_id)
+{
+	struct mem_ctl_info *mci = dev_id;
+	struct priv_data *priv = mci->pvt_info;
+	const struct npcm_edac_platform_data *npcm_chip = priv->npcm_chip;
+	u32 intr_status;
+	u32 val;
+
+	/* Check the intr status and confirm ECC error intr */
+	intr_status = readl(priv->reg + npcm_chip->ecc_ctl_int_status);
+
+	edac_dbg(3, "dev: %s, id: %s: IRQ: %d, interrupt status: 0x%x\n",
+		 mci->dev_name, mci->ctl_name, irq, intr_status);
+
+	val = intr_status & npcm_chip->ecc_int_ce_ue_mask;
+	if (!((val & npcm_chip->ecc_ce_intr_mask) || (val & npcm_chip->ecc_ue_intr_mask)))
+		return IRQ_NONE;
+
+	if (val & npcm_chip->ecc_ce_intr_mask) {
+		handle_correctable_error(mci);
+
+		/* Clear the interrupt source */
+		if (val & npcm_chip->ecc_int_ce_event)
+			writel(npcm_chip->ecc_int_ce_event, priv->reg + npcm_chip->ecc_ctl_int_ack);
+		else if (val & npcm_chip->ecc_int_second_ce_event)
+			writel(npcm_chip->ecc_int_second_ce_event,
+			       priv->reg + npcm_chip->ecc_ctl_int_ack);
+		else
+			edac_printk(KERN_ERR, NPCM_EDAC_MOD_NAME, "Failed to clear CE IRQ\n");
+	}
+
+	if (val & npcm_chip->ecc_ue_intr_mask) {
+		handle_ue(mci);
+
+		/* Clear the interrupt source */
+		if (val & npcm_chip->ecc_int_ue_event)
+			writel(npcm_chip->ecc_int_ue_event, priv->reg + npcm_chip->ecc_ctl_int_ack);
+		else if (val & npcm_chip->ecc_int_second_ue_event)
+			writel(npcm_chip->ecc_int_second_ue_event,
+			       priv->reg + npcm_chip->ecc_ctl_int_ack);
+		else
+			edac_printk(KERN_ERR, NPCM_EDAC_MOD_NAME, "Failed to clear UE IRQ\n");
+	}
+
+	edac_dbg(3, "Total error count CE %d UE %d\n",
+		 priv->ce_cnt, priv->ue_cnt);
+
+	return IRQ_HANDLED;
+}
+
+static ssize_t forced_ecc_error_show(struct device *dev,
+				     struct device_attribute *mattr,
+				     char *data)
+{
+	return sprintf(data, "CDNS-DDR4 Force Injection Help:\n"
+		       "Example:\n"
+		       "echo \"CE checkcode 0\" > /sys/devices/system/edac/mc/mc0/forced_ecc_error\n"
+		       "CE: Corrected\n"
+		       "UE: Uncorrected\n"
+		       "checkcode/data:source\n"
+		       "bit [0-63] for data [0-7] for checkcode:bit number\n");
+}
+
+static ssize_t forced_ecc_error_store(struct device *dev,
+				      struct device_attribute *mattr,
+				      const char *data, size_t count)
+{
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct priv_data *priv = mci->pvt_info;
+	const struct npcm_edac_platform_data *npcm_chip = priv->npcm_chip;
+	int	args_cnt;
+	int	ret;
+	char	**args;
+	u32	regval;
+	u8	bit_no;
+
+	/* Check ecc enabled */
+	if (!(readl(priv->reg + npcm_chip->ecc_ctl_en_reg) & npcm_chip->ecc_ctl_ecc_enable_mask))
+		return count;
+
+	/* Check no write operation pending to controller */
+	while (readl(priv->reg + npcm_chip->ddr_ctl_controller_busy_reg) &
+			CTL_CONTROLLER_BUSY_FLAG) {
+		usleep_range(1000, 10000);
+	}
+
+	/* Split string buffer into separate parameters */
+	args = argv_split(GFP_KERNEL, data, &args_cnt);
+
+	/* Write appropriate syndrome to xor_check_bit */
+	if (!strcmp(args[0], "CE") && args_cnt == 3) {
+		ret = kstrtou8(args[2], 0, &bit_no);
+		if (ret)
+			return ret;
+		if (!strcmp(args[1], "checkcode")) {
+			if (bit_no > 7) {
+				edac_printk(KERN_INFO, NPCM_EDAC_MOD_NAME, "bit_no for checkcode must be 0~7\n");
+				return count;
+			}
+			regval = readl(priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
+			regval = (regval & ~(NPCM_ECC_CTL_XOR_BITS_MASK)) |
+				(check_synd[bit_no] << XOR_CHECK_BIT_SPLIT_WIDTH);
+			writel(regval, priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
+		} else if (!strcmp(args[1], "data")) {
+			if (bit_no > 63) {
+				edac_printk(KERN_INFO, NPCM_EDAC_MOD_NAME, "bit_no for data must be 0~63\n");
+				return count;
+			}
+			regval = readl(priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
+			regval = (regval & ~(NPCM_ECC_CTL_XOR_BITS_MASK)) |
+					 (data_synd[bit_no] << XOR_CHECK_BIT_SPLIT_WIDTH);
+			writel(regval, priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
+		}
+		/* Enable the ECC writeback_en for corrected error */
+		regval = readl(priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
+		writel((regval | NPCM_ECC_CTL_AUTO_WRITEBACK_EN),
+		       priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
+	} else if (!strcmp(args[0], "UE")) {
+		regval = readl(priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
+		regval = (regval & ~(NPCM_ECC_CTL_XOR_BITS_MASK)) |
+				 (ECC_DOUBLE_MULTI_ERR_SYND << XOR_CHECK_BIT_SPLIT_WIDTH);
+		writel(regval, priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
+	}
+
+	/* Assert fwc */
+	writel((NPCM_ECC_CTL_FORCE_WC | readl(priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg)),
+	       priv->reg + npcm_chip->ecc_ctl_xor_check_bits_reg);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(forced_ecc_error);
+static int create_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	int rc;
+
+	rc = device_create_file(&mci->dev, &dev_attr_forced_ecc_error);
+	if (rc < 0)
+		return rc;
+	return 0;
+}
+
+static void remove_sysfs_attributes(struct mem_ctl_info *mci)
+{
+	device_remove_file(&mci->dev, &dev_attr_forced_ecc_error);
+}
+
+static const struct npcm_edac_platform_data npcm7xx_edac = {
+	.chip = NPCM7XX_CHIP,
+
+	/* CDNS DDR4 Controller Registers */
+	.ecc_ctl_en_reg = 0x174,
+	.ecc_ctl_int_status = 0x1D0,
+	.ecc_ctl_int_ack = 0x1D4,
+	.ecc_ctl_int_mask_master = 0x1D8,
+
+	.ecc_sig_c_addr_l = 0x188,
+	.ecc_sig_c_data_l = 0x190,
+	.ecc_sig_c_id = 0x194,
+	.ecc_sig_c_synd = 0x18C,
+
+	.ecc_sig_u_addr_l = 0x17C,
+	.ecc_sig_u_data_l = 0x184,
+	.ecc_sig_u_id = 0x194,
+	.ecc_sig_u_synd = 0x180,
+
+	/* MASK */
+	.ecc_ctl_ecc_enable_mask = BIT(24),
+	.ecc_ctl_en_int_master_mask = GENMASK(30, 7) | GENMASK(2, 0),
+
+	/* ECC IRQ Macros */
+	.ecc_int_ce_event = BIT(3),
+	.ecc_int_second_ce_event = BIT(4),
+	.ecc_int_ue_event = BIT(5),
+	.ecc_int_second_ue_event = BIT(6),
+	.ecc_int_ce_ue_mask = GENMASK(6, 3),
+	.ecc_ce_intr_mask = GENMASK(4, 3),
+	.ecc_ue_intr_mask = GENMASK(6, 5),
+
+	/* ECC Signature Macros */
+	.ecc_sig_c_id_shift = 16,
+	.ecc_sig_c_synd_shift = 0,
+
+	.ecc_sig_c_id_mask = GENMASK(29, 16),
+	.ecc_sig_c_synd_mask = GENMASK(6, 0),
+
+	.ecc_sig_u_id_shift = 0,
+	.ecc_sig_u_synd_shift = 0,
+
+	.ecc_sig_u_id_mask = GENMASK(13, 0),
+	.ecc_sig_u_synd_mask = GENMASK(6, 0),
+};
+
+static const struct npcm_edac_platform_data npcm8xx_edac = {
+	.ip_features = FORCED_ECC_ERR_EVENT_SUPPORT,
+	.ddr_ctl_controller_busy_reg = 0x20C,
+	.ecc_ctl_xor_check_bits_reg = 0x174,
+
+	.chip = NPCM8XX_CHIP,
+
+	/* CDNS DDR4 Controller Registers */
+	.ddr_ctl_mem_type_reg = 0x000,
+	.ddr_ctl_mem_width_reg = 0x00c,
+
+	.ecc_ctl_en_reg = 0x16C,
+	.ecc_ctl_int_status = 0x228,
+	.ecc_ctl_int_ack = 0x244,
+	.ecc_ctl_int_mask_master = 0x220,
+	.ecc_ctl_int_mask_ecc = 0x260,
+
+	.ecc_sig_c_addr_l = 0x18C,
+	.ecc_sig_c_addr_h = 0x190,
+	.ecc_sig_c_data_l = 0x194,
+	.ecc_sig_c_data_h = 0x198,
+	.ecc_sig_c_id = 0x19C,
+	.ecc_sig_c_synd = 0x190,
+
+	.ecc_sig_u_addr_l = 0x17C,
+	.ecc_sig_u_addr_h = 0x180,
+	.ecc_sig_u_data_l = 0x184,
+	.ecc_sig_u_data_h = 0x188,
+	.ecc_sig_u_id = 0x19C,
+	.ecc_sig_u_synd = 0x180,
+
+	/* MASK */
+	.ecc_ctl_ecc_enable_mask = GENMASK(17, 16),
+	.ecc_ctl_en_int_master_mask = GENMASK(30, 3) | GENMASK(1, 0),
+	.ecc_ctl_en_int_ecc_mask = GENMASK(8, 4),
+
+	/* ECC IRQ Macros */
+	.ecc_int_ce_event = BIT(0),
+	.ecc_int_second_ce_event = BIT(1),
+	.ecc_int_ue_event = BIT(2),
+	.ecc_int_second_ue_event = BIT(3),
+	.ecc_int_ce_ue_mask = GENMASK(3, 0),
+	.ecc_ce_intr_mask = GENMASK(1, 0),
+	.ecc_ue_intr_mask = GENMASK(3, 2),
+
+	/* ECC Signature Macros */
+	.ecc_sig_c_id_shift = 8,
+	.ecc_sig_c_synd_shift = 8,
+	.ecc_sig_c_addr_h_mask = GENMASK(1, 0),
+	.ecc_sig_c_id_mask = GENMASK(29, 16),
+	.ecc_sig_c_synd_mask = GENMASK(15, 8),
+
+	.ecc_sig_u_id_shift = 0,
+	.ecc_sig_u_synd_shift = 8,
+	.ecc_sig_u_addr_h_mask = GENMASK(1, 0),
+	.ecc_sig_u_id_mask = GENMASK(13, 0),
+	.ecc_sig_u_synd_mask = GENMASK(15, 8),
+};
+
+static const struct of_device_id npcm_edac_of_match[] = {
+	{ .compatible = "nuvoton,npcm750-memory-controller", .data = &npcm7xx_edac },
+	{ .compatible = "nuvoton,npcm845-memory-controller", .data = &npcm8xx_edac },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, npcm_edac_of_match);
+
+static int npcm_edac_mc_probe(struct platform_device *pdev)
+{
+	const struct npcm_edac_platform_data *npcm_chip;
+	struct device *dev = &pdev->dev;
+	struct edac_mc_layer layers[1];
+	const struct of_device_id *id;
+	struct priv_data *priv_data;
+	struct mem_ctl_info *mci;
+	struct resource *res;
+	void __iomem *reg;
+	int ret = -ENODEV;
+	int irq;
+	u32 ecc_en;
+
+	id = of_match_device(npcm_edac_of_match, &pdev->dev);
+
+	npcm_chip = of_device_get_match_data(&pdev->dev);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg = devm_ioremap_resource(dev, res);
+	if (IS_ERR(reg)) {
+		edac_printk(KERN_ERR, NPCM_EDAC_MOD_NAME, "cdns DDR4 mc regs are not defined\n");
+		return PTR_ERR(reg);
+	}
+
+	ecc_en = readl(reg + npcm_chip->ecc_ctl_en_reg);
+
+	if ((ecc_en & npcm_chip->ecc_ctl_ecc_enable_mask) == npcm_chip->ecc_ctl_ecc_enable_mask) {
+		edac_printk(KERN_INFO, NPCM_EDAC_MOD_NAME, "ECC reporting and correcting on. ");
+	} else {
+		edac_printk(KERN_INFO, NPCM_EDAC_MOD_NAME, "ECC disabled\n");
+		return -ENXIO;
+	}
+
+	edac_printk(KERN_INFO, NPCM_EDAC_MOD_NAME, "IO mapped reg addr: %p\n", reg);
+
+	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
+	layers[0].size = 1;
+
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
+			    sizeof(struct priv_data));
+	if (!mci) {
+		edac_printk(KERN_ERR, NPCM_EDAC_MOD_NAME, "Failed memory allocation for mc instance\n");
+		return -ENOMEM;
+	}
+	mci->pdev = &pdev->dev;
+	priv_data = mci->pvt_info;
+	priv_data->reg = reg;
+	priv_data->npcm_chip = npcm_chip;
+	priv_data->ce_cnt = 0;
+	priv_data->ue_cnt = 0;
+	platform_set_drvdata(pdev, mci);
+
+	/* Initialize controller capabilities */
+	mci->mtype_cap = MEM_FLAG_DDR4;
+	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
+	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
+	mci->scrub_mode = SCRUB_HW_SRC;
+	mci->edac_cap = EDAC_FLAG_SECDED;
+	mci->ctl_name = id->compatible;
+	mci->dev_name = dev_name(&pdev->dev);
+	mci->mod_name = NPCM_EDAC_MOD_NAME;
+	mci->ctl_page_to_phys = NULL;
+
+	/* Interrupt feature is supported by cadence mc */
+	edac_op_state = EDAC_OPSTATE_INT;
+	if (IS_ENABLED(CONFIG_EDAC_DEBUG))
+		init_mem_layout(mci);
+
+	/* Set up Interrupt handler for ECC */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		edac_printk(KERN_ERR, NPCM_EDAC_MOD_NAME, "irq number not defined for ECC.\n");
+		goto err;
+	}
+	ret = devm_request_irq(dev, irq, edac_ecc_isr, 0, "cdns-edac-mc-ecc-irq", mci);
+	if (ret) {
+		edac_printk(KERN_ERR, NPCM_EDAC_MOD_NAME, "request_irq fail for NPCM_EDAC irq\n");
+		goto err;
+	}
+	ret = edac_mc_add_mc(mci);
+	if (ret) {
+		edac_printk(KERN_ERR, NPCM_EDAC_MOD_NAME, "Failed to register with EDAC core\n");
+		goto err;
+	}
+
+	if (IS_ENABLED(CONFIG_EDAC_DEBUG) &&
+	   (npcm_chip->ip_features & FORCED_ECC_ERR_EVENT_SUPPORT) &&
+	    npcm_chip->chip == NPCM8XX_CHIP) {
+		if (create_sysfs_attributes(mci))
+			edac_printk(KERN_ERR, NPCM_EDAC_MOD_NAME, "Failed to create sysfs entries\n");
+	}
+
+	/* Only enable MC interrupts with ECC - clear global int mask bit and ecc bit */
+	writel(npcm_chip->ecc_ctl_en_int_master_mask,
+	       priv_data->reg + npcm_chip->ecc_ctl_int_mask_master);
+
+	if (npcm_chip->chip == NPCM8XX_CHIP) {
+		/* clear single and multi for ce and ue */
+		writel(npcm_chip->ecc_ctl_en_int_ecc_mask,
+		       priv_data->reg + npcm_chip->ecc_ctl_int_mask_ecc);
+	}
+
+	return 0;
+
+	edac_mc_del_mc(&pdev->dev);
+
+err:
+	edac_mc_free(mci);
+	return ret;
+}
+
+static int npcm_edac_mc_remove(struct platform_device *pdev)
+{
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
+	struct priv_data *priv = mci->pvt_info;
+	const struct npcm_edac_platform_data *npcm_chip = priv->npcm_chip;
+
+	writel(NPCM_ECC_CTL_GLOBAL_INT_DISABLE, priv->reg + npcm_chip->ecc_ctl_int_mask_master);
+
+	/* Disable ecc feature before removing driver by writing 0 */
+	writel((unsigned int)(~(npcm_chip->ecc_ctl_ecc_enable_mask)),
+	       priv->reg + npcm_chip->ecc_ctl_en_reg);
+
+	if (IS_ENABLED(CONFIG_EDAC_DEBUG))
+		remove_sysfs_attributes(mci);
+
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+
+	return 0;
+}
+
+static struct platform_driver npcm_edac_mc_driver = {
+	.driver = {
+		   .name = "npcm-edac",
+		   .of_match_table = npcm_edac_of_match,
+	},
+	.probe = npcm_edac_mc_probe,
+	.remove = npcm_edac_mc_remove,
+};
+
+module_platform_driver(npcm_edac_mc_driver);
+
+MODULE_AUTHOR("Medad CChien <ctcchien@nuvoton.com>");
+MODULE_DESCRIPTION("Nuvoton NPCM EDAC Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

