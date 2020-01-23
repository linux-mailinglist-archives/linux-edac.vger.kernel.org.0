Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7D5145FF2
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2020 01:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgAWAbR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Jan 2020 19:31:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41747 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgAWAbR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 22 Jan 2020 19:31:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id x8so417802pgk.8;
        Wed, 22 Jan 2020 16:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Y313XH7TVLHuODzoYPw9QLNPLxKQSMDd+2Fs5z3zq24=;
        b=ULFNz3G7aK/oapl59BXP3xJsA9ASxRYtAZptC7b/gJCpBktRMnXeAdxqZ085f2XCvC
         fVQKAKCaepis1R21QYo6j2FpJ1iq1D1CCRUOxk1rcsMKyqiHfUdXrq0b3i6h/qsxV3LZ
         O72Pa/gtSzRtchsHN9TZIISijAgnBJoqlh3/GnPxDETU/cR3axtJrh5GGJkrF8a/Aw/j
         x7wNBNuw0mJ8auyy4rXYVPr2GUlfoje64TAvgAACcWDE7bSiUki/7Y/5uH2GtUL6Sz1n
         HNDiMQ2cse3GwqN+p8ZBVmUY3+vE82nx1oBcc3kM0j+Pn6cItO1mduAMCZD6z0dCuR2/
         V/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Y313XH7TVLHuODzoYPw9QLNPLxKQSMDd+2Fs5z3zq24=;
        b=l7flbL3UOLQNcHUBbD3HBpsXY3En/cadU5AQA3vNBkfyGZkBTKB1Tainmrj0uNbudh
         SegLL8Ea10Ax7f6iwOkJWv835cvtw5/dACCwZVsNURCsyfDBYqHnhI6KwtBaSqhaI2/C
         XiW0Zii0TtyVKis1qPDyVI1IUbfXbDiavqNQv4HTrbP52xBDJ7628lF7FXUm6McOwU3a
         GqvrqF4n0ySpzhwGlkBLQQhas935fz11sSlaKQI7BQtujSak6i/ZcyrbO7YCMGu6Y6K/
         +pjKc/XiI5ShNTG3BQqLpkBTE2QVE9CATGFYnRl/CSfqtPMieSToIWi3BuAO3+fbXDdP
         xtZQ==
X-Gm-Message-State: APjAAAWJj64IZUcXT85j6fl4AcSqjFSr6zMDWMBVIfziV3Jpqar5ZSmf
        6FMkI2zDxpDDAeLnjiyLZL0=
X-Google-Smtp-Source: APXvYqyzoYNqFk1iwkW01KgK+4ljHfCpnoftBCkhgoI8afxOfuZB1DsXiYo1Po1qC2z6RbtvDaZXlQ==
X-Received: by 2002:a65:68ca:: with SMTP id k10mr1048407pgt.222.1579739476029;
        Wed, 22 Jan 2020 16:31:16 -0800 (PST)
Received: from ?IPv6:2001:4898:d8:28:140e:bf9b:65a6:dd72? ([2001:4898:80e8:a:941b:bf9b:65a6:dd72])
        by smtp.gmail.com with ESMTPSA id l186sm223661pge.31.2020.01.22.16.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 16:31:15 -0800 (PST)
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, shji@microsoft.com,
        ruizhao@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>
From:   Shiping Ji <shiping.linux@gmail.com>
Subject: [PATCH v10 2/2] EDAC: add EDAC driver for DMC520
Message-ID: <83b48c70-dc06-d0d4-cae9-a2187fca628b@gmail.com>
Date:   Wed, 22 Jan 2020 16:31:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

New driver supports error detection and correction on the devices with ARM
DMC-520 memory controller.

From: Lei Wang <leiwang_git@outlook.com>

Signed-off-by: Lei Wang <leiwang_git@outlook.com>
Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
Reviewed-by: James Morse <james.morse@arm.com>

---
     Changes in v10:
         - Fixed issues during V9 review
         - Fixed memory width variable in the device specific scope

---
 MAINTAINERS                |   6 +
 drivers/edac/Kconfig       |   7 +
 drivers/edac/Makefile      |   1 +
 drivers/edac/dmc520_edac.c | 656 +++++++++++++++++++++++++++++++++++++
 4 files changed, 670 insertions(+)
 create mode 100644 drivers/edac/dmc520_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bd5847e802de..386195a019c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5914,6 +5914,12 @@ F:	Documentation/driver-api/edac.rst
 F:	drivers/edac/
 F:	include/linux/edac.h
 
+EDAC-DMC520
+M:	Lei Wang <lewan@microsoft.com>
+L:	linux-edac@vger.kernel.org
+S:	Supported
+F:	drivers/edac/dmc520_edac.c
+
 EDAC-E752X
 M:	Mark Gross <mark.gross@intel.com>
 L:	linux-edac@vger.kernel.org
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 37027c298323..7305bd1ec80e 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -523,4 +523,11 @@ config EDAC_BLUEFIELD
 	  Support for error detection and correction on the
 	  Mellanox BlueField SoCs.
 
+config EDAC_DMC520
+	tristate "ARM DMC-520 ECC"
+	depends on ARM64
+	help
+	  Support for error detection and correction on the
+	  SoCs with ARM DMC-520 DRAM controller.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index d77200c9680b..269e15118cea 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -87,3 +87,4 @@ obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
 obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
+obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
new file mode 100644
index 000000000000..fc1153ab1ebb
--- /dev/null
+++ b/drivers/edac/dmc520_edac.c
@@ -0,0 +1,656 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * EDAC driver for DMC-520 memory controller.
+ *
+ * The driver supports 10 interrupt lines,
+ * though only dram_ecc_errc and dram_ecc_errd are currently handled.
+ *
+ * Authors:	Rui Zhao <ruizhao@microsoft.com>
+ *		Lei Wang <lewan@microsoft.com>
+ *		Shiping Ji <shji@microsoft.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/edac.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include "edac_mc.h"
+
+/* DMC-520 registers */
+#define REG_OFFSET_FEATURE_CONFIG			0x130
+#define REG_OFFSET_ECC_ERRC_COUNT_31_00		0x158
+#define REG_OFFSET_ECC_ERRC_COUNT_63_32		0x15C
+#define REG_OFFSET_ECC_ERRD_COUNT_31_00		0x160
+#define REG_OFFSET_ECC_ERRD_COUNT_63_32		0x164
+#define REG_OFFSET_INTERRUPT_CONTROL			0x500
+#define REG_OFFSET_INTERRUPT_CLR			0x508
+#define REG_OFFSET_INTERRUPT_STATUS			0x510
+#define REG_OFFSET_DRAM_ECC_ERRC_INT_INFO_31_00	0x528
+#define REG_OFFSET_DRAM_ECC_ERRC_INT_INFO_63_32	0x52C
+#define REG_OFFSET_DRAM_ECC_ERRD_INT_INFO_31_00	0x530
+#define REG_OFFSET_DRAM_ECC_ERRD_INT_INFO_63_32	0x534
+#define REG_OFFSET_ADDRESS_CONTROL_NOW			0x1010
+#define REG_OFFSET_MEMORY_TYPE_NOW			0x1128
+#define REG_OFFSET_SCRUB_CONTROL0_NOW			0x1170
+#define REG_OFFSET_FORMAT_CONTROL			0x18
+
+/* DMC-520 types, masks and bitfields */
+#define RAM_ECC_INT_CE_BIT			BIT(0)
+#define RAM_ECC_INT_UE_BIT			BIT(1)
+#define DRAM_ECC_INT_CE_BIT			BIT(2)
+#define DRAM_ECC_INT_UE_BIT			BIT(3)
+#define FAILED_ACCESS_INT_BIT			BIT(4)
+#define FAILED_PROG_INT_BIT			BIT(5)
+#define LINK_ERR_INT_BIT			BIT(6)
+#define TEMPERATURE_EVENT_INT_BIT		BIT(7)
+#define ARCH_FSM_INT_BIT			BIT(8)
+#define PHY_REQUEST_INT_BIT			BIT(9)
+#define MEMORY_WIDTH_MASK			GENMASK(1, 0)
+#define SCRUB_TRIGGER0_NEXT_MASK		GENMASK(1, 0)
+#define REG_FIELD_DRAM_ECC_ENABLED		GENMASK(1, 0)
+#define REG_FIELD_MEMORY_TYPE			GENMASK(2, 0)
+#define REG_FIELD_DEVICE_WIDTH			GENMASK(9, 8)
+#define REG_FIELD_ADDRESS_CONTROL_COL		GENMASK(2,  0)
+#define REG_FIELD_ADDRESS_CONTROL_ROW		GENMASK(10, 8)
+#define REG_FIELD_ADDRESS_CONTROL_BANK		GENMASK(18, 16)
+#define REG_FIELD_ADDRESS_CONTROL_RANK		GENMASK(25, 24)
+#define REG_FIELD_ERR_INFO_LOW_VALID		BIT(0)
+#define REG_FIELD_ERR_INFO_LOW_COL		GENMASK(10, 1)
+#define REG_FIELD_ERR_INFO_LOW_ROW		GENMASK(28, 11)
+#define REG_FIELD_ERR_INFO_LOW_RANK		GENMASK(31, 29)
+#define REG_FIELD_ERR_INFO_HIGH_BANK		GENMASK(3, 0)
+#define REG_FIELD_ERR_INFO_HIGH_VALID		BIT(31)
+
+#define DRAM_ADDRESS_CONTROL_MIN_COL_BITS	8
+#define DRAM_ADDRESS_CONTROL_MIN_ROW_BITS	11
+
+#define DMC520_SCRUB_TRIGGER_ERR_DETECT	2
+#define DMC520_SCRUB_TRIGGER_IDLE		3
+
+/* Driver settings */
+/*
+ * The max-length message would be: "rank:7 bank:15 row:262143 col:1023".
+ * Max length is 34. Using a 40-size buffer is enough.
+ */
+#define DMC520_MSG_BUF_SIZE			40
+#define EDAC_MOD_NAME				"dmc520-edac"
+#define EDAC_CTL_NAME				"dmc520"
+
+/* the data bus width for the attached memory chips. */
+enum dmc520_mem_width {
+	MEM_WIDTH_X32 = 2,
+	MEM_WIDTH_X64 = 3
+};
+
+/* memory type */
+enum dmc520_mem_type {
+	MEM_TYPE_DDR3 = 1,
+	MEM_TYPE_DDR4 = 2
+};
+
+/* memory device width */
+enum dmc520_dev_width {
+	DEV_WIDTH_X4 = 0,
+	DEV_WIDTH_X8 = 1,
+	DEV_WIDTH_X16 = 2
+};
+
+struct ecc_error_info {
+	u32 col;
+	u32 row;
+	u32 bank;
+	u32 rank;
+};
+
+/* The interrupt config */
+struct dmc520_irq_config {
+	char *name;
+	int mask;
+};
+
+/* The interrupt mappings */
+static struct dmc520_irq_config dmc520_irq_configs[] = {
+	{
+		.name = "ram_ecc_errc",
+		.mask = RAM_ECC_INT_CE_BIT
+	},
+	{
+		.name = "ram_ecc_errd",
+		.mask = RAM_ECC_INT_UE_BIT
+	},
+	{
+		.name = "dram_ecc_errc",
+		.mask = DRAM_ECC_INT_CE_BIT
+	},
+	{
+		.name = "dram_ecc_errd",
+		.mask = DRAM_ECC_INT_UE_BIT
+	},
+	{
+		.name = "failed_access",
+		.mask = FAILED_ACCESS_INT_BIT
+	},
+	{
+		.name = "failed_prog",
+		.mask = FAILED_PROG_INT_BIT
+	},
+	{
+		.name = "link_err",
+		.mask = LINK_ERR_INT_BIT
+	},
+	{
+		.name = "temperature_event",
+		.mask = TEMPERATURE_EVENT_INT_BIT
+	},
+	{
+		.name = "arch_fsm",
+		.mask = ARCH_FSM_INT_BIT
+	},
+	{
+		.name = "phy_request",
+		.mask = PHY_REQUEST_INT_BIT
+	}
+};
+
+#define NUMBER_OF_IRQS				ARRAY_SIZE(dmc520_irq_configs)
+
+/*
+ * The EDAC driver private data.
+ * error_lock is to protect concurrent writes to the mci->error_desc through
+ * edac_mc_handle_error().
+ */
+struct dmc520_edac {
+	void __iomem *reg_base;
+	spinlock_t error_lock;
+	u32 mem_width_in_bytes;
+	int irqs[NUMBER_OF_IRQS];
+	int masks[NUMBER_OF_IRQS];
+};
+
+static int dmc520_mc_idx;
+
+static u32 dmc520_read_reg(struct dmc520_edac *pvt, u32 offset)
+{
+	return readl(pvt->reg_base + offset);
+}
+
+static void dmc520_write_reg(struct dmc520_edac *pvt, u32 val, u32 offset)
+{
+	writel(val, pvt->reg_base + offset);
+}
+
+static u32 dmc520_calc_dram_ecc_error(u32 value)
+{
+	u32 total = 0;
+
+	/* Each rank's error counter takes one byte. */
+	while (value > 0) {
+		total += (value & 0xFF);
+		value >>= 8;
+	}
+	return total;
+}
+
+static u32 dmc520_get_dram_ecc_error_count(struct dmc520_edac *pvt,
+					    bool is_ce)
+{
+	u32 reg_offset_low, reg_offset_high;
+	u32 err_low, err_high;
+	u32 err_count;
+
+	reg_offset_low = is_ce ? REG_OFFSET_ECC_ERRC_COUNT_31_00 :
+				 REG_OFFSET_ECC_ERRD_COUNT_31_00;
+	reg_offset_high = is_ce ? REG_OFFSET_ECC_ERRC_COUNT_63_32 :
+				  REG_OFFSET_ECC_ERRD_COUNT_63_32;
+
+	err_low = dmc520_read_reg(pvt, reg_offset_low);
+	err_high = dmc520_read_reg(pvt, reg_offset_high);
+	/* Reset error counters */
+	dmc520_write_reg(pvt, 0, reg_offset_low);
+	dmc520_write_reg(pvt, 0, reg_offset_high);
+
+	err_count = dmc520_calc_dram_ecc_error(err_low) +
+		   dmc520_calc_dram_ecc_error(err_high);
+
+	return err_count;
+}
+
+static void dmc520_get_dram_ecc_error_info(struct dmc520_edac *pvt,
+					    bool is_ce,
+					    struct ecc_error_info *info)
+{
+	u32 reg_offset_low, reg_offset_high;
+	u32 reg_val_low, reg_val_high;
+	bool valid;
+
+	reg_offset_low = is_ce ? REG_OFFSET_DRAM_ECC_ERRC_INT_INFO_31_00 :
+				 REG_OFFSET_DRAM_ECC_ERRD_INT_INFO_31_00;
+	reg_offset_high = is_ce ? REG_OFFSET_DRAM_ECC_ERRC_INT_INFO_63_32 :
+				  REG_OFFSET_DRAM_ECC_ERRD_INT_INFO_63_32;
+
+	reg_val_low = dmc520_read_reg(pvt, reg_offset_low);
+	reg_val_high = dmc520_read_reg(pvt, reg_offset_high);
+
+	valid = (FIELD_GET(REG_FIELD_ERR_INFO_LOW_VALID, reg_val_low) != 0) &&
+		(FIELD_GET(REG_FIELD_ERR_INFO_HIGH_VALID, reg_val_high) != 0);
+
+	if (valid) {
+		info->col = FIELD_GET(REG_FIELD_ERR_INFO_LOW_COL, reg_val_low);
+		info->row = FIELD_GET(REG_FIELD_ERR_INFO_LOW_ROW, reg_val_low);
+		info->rank = FIELD_GET(REG_FIELD_ERR_INFO_LOW_RANK, reg_val_low);
+		info->bank = FIELD_GET(REG_FIELD_ERR_INFO_HIGH_BANK, reg_val_high);
+	} else {
+		memset(info, 0, sizeof(*info));
+	}
+}
+
+static bool dmc520_is_ecc_enabled(void __iomem *reg_base)
+{
+	u32 reg_val = readl(reg_base + REG_OFFSET_FEATURE_CONFIG);
+
+	return FIELD_GET(REG_FIELD_DRAM_ECC_ENABLED, reg_val);
+}
+
+static enum scrub_type dmc520_get_scrub_type(struct dmc520_edac *pvt)
+{
+	enum scrub_type type = SCRUB_NONE;
+	u32 reg_val, scrub_cfg;
+
+	reg_val = dmc520_read_reg(pvt, REG_OFFSET_SCRUB_CONTROL0_NOW);
+	scrub_cfg = FIELD_GET(SCRUB_TRIGGER0_NEXT_MASK, reg_val);
+
+	if (scrub_cfg == DMC520_SCRUB_TRIGGER_ERR_DETECT ||
+	    scrub_cfg == DMC520_SCRUB_TRIGGER_IDLE)
+		type = SCRUB_HW_PROG;
+
+	return type;
+}
+
+/* Get the memory data bus width, in number of bytes. */
+static u32 dmc520_get_memory_width(struct dmc520_edac *pvt)
+{
+	enum dmc520_mem_width mem_width_field;
+	u32 mem_width_in_bytes = 0;
+	u32 reg_val;
+
+	reg_val = dmc520_read_reg(pvt, REG_OFFSET_FORMAT_CONTROL);
+	mem_width_field = FIELD_GET(MEMORY_WIDTH_MASK, reg_val);
+
+	if (mem_width_field == MEM_WIDTH_X32)
+		mem_width_in_bytes = 4;
+	else if (mem_width_field == MEM_WIDTH_X64)
+		mem_width_in_bytes = 8;
+	return mem_width_in_bytes;
+}
+
+static enum mem_type dmc520_get_mtype(struct dmc520_edac *pvt)
+{
+	enum mem_type mt = MEM_UNKNOWN;
+	enum dmc520_mem_type type;
+	u32 reg_val;
+
+	reg_val = dmc520_read_reg(pvt, REG_OFFSET_MEMORY_TYPE_NOW);
+	type = FIELD_GET(REG_FIELD_MEMORY_TYPE, reg_val);
+
+	switch (type) {
+	case MEM_TYPE_DDR3:
+		mt = MEM_DDR3;
+		break;
+
+	case MEM_TYPE_DDR4:
+		mt = MEM_DDR4;
+		break;
+	}
+
+	return mt;
+}
+
+static enum dev_type dmc520_get_dtype(struct dmc520_edac *pvt)
+{
+	enum dmc520_dev_width device_width;
+	enum dev_type dt = DEV_UNKNOWN;
+	u32 reg_val;
+
+	reg_val = dmc520_read_reg(pvt, REG_OFFSET_MEMORY_TYPE_NOW);
+	device_width = FIELD_GET(REG_FIELD_DEVICE_WIDTH, reg_val);
+
+	switch (device_width) {
+	case DEV_WIDTH_X4:
+		dt = DEV_X4;
+		break;
+
+	case DEV_WIDTH_X8:
+		dt = DEV_X8;
+		break;
+
+	case DEV_WIDTH_X16:
+		dt = DEV_X16;
+		break;
+	}
+
+	return dt;
+}
+
+static u32 dmc520_get_rank_count(void __iomem *reg_base)
+{
+	u32 reg_val, rank_bits;
+
+	reg_val = readl(reg_base + REG_OFFSET_ADDRESS_CONTROL_NOW);
+	rank_bits = FIELD_GET(REG_FIELD_ADDRESS_CONTROL_RANK, reg_val);
+
+	return BIT(rank_bits);
+}
+
+static u64 dmc520_get_rank_size(struct dmc520_edac *pvt)
+{
+	u32 reg_val, col_bits, row_bits, bank_bits;
+
+	reg_val = dmc520_read_reg(pvt, REG_OFFSET_ADDRESS_CONTROL_NOW);
+
+	col_bits = FIELD_GET(REG_FIELD_ADDRESS_CONTROL_COL, reg_val) +
+		   DRAM_ADDRESS_CONTROL_MIN_COL_BITS;
+	row_bits = FIELD_GET(REG_FIELD_ADDRESS_CONTROL_ROW, reg_val) +
+		   DRAM_ADDRESS_CONTROL_MIN_ROW_BITS;
+	bank_bits = FIELD_GET(REG_FIELD_ADDRESS_CONTROL_BANK, reg_val);
+
+	return (u64)pvt->mem_width_in_bytes << (col_bits + row_bits + bank_bits);
+}
+
+static void dmc520_handle_dram_ecc_errors(struct mem_ctl_info *mci,
+					   bool is_ce)
+{
+	struct dmc520_edac *pvt = mci->pvt_info;
+	char message[DMC520_MSG_BUF_SIZE];
+	struct ecc_error_info info;
+	u32 cnt;
+
+	dmc520_get_dram_ecc_error_info(pvt, is_ce, &info);
+
+	cnt = dmc520_get_dram_ecc_error_count(pvt, is_ce);
+	if (!cnt)
+		return;
+
+	snprintf(message, ARRAY_SIZE(message),
+		 "rank:%d bank:%d row:%d col:%d",
+		 info.rank, info.bank,
+		 info.row, info.col);
+
+	spin_lock(&pvt->error_lock);
+	edac_mc_handle_error((is_ce ? HW_EVENT_ERR_CORRECTED :
+			     HW_EVENT_ERR_UNCORRECTED),
+			     mci, cnt, 0, 0, 0, info.rank, -1, -1,
+			     message, "");
+	spin_unlock(&pvt->error_lock);
+}
+
+static irqreturn_t dmc520_edac_dram_ecc_isr(int irq, struct mem_ctl_info *mci,
+					     bool is_ce)
+{
+	struct dmc520_edac *pvt = mci->pvt_info;
+	u32 i_mask;
+
+	i_mask = is_ce ? DRAM_ECC_INT_CE_BIT : DRAM_ECC_INT_UE_BIT;
+
+	dmc520_handle_dram_ecc_errors(mci, is_ce);
+
+	dmc520_write_reg(pvt, i_mask, REG_OFFSET_INTERRUPT_CLR);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t dmc520_edac_dram_all_isr(int irq, struct mem_ctl_info *mci,
+					     u32 irq_mask)
+{
+	struct dmc520_edac *pvt = mci->pvt_info;
+	irqreturn_t irq_ret = IRQ_NONE;
+	u32 status;
+
+	status = dmc520_read_reg(pvt, REG_OFFSET_INTERRUPT_STATUS);
+
+	if ((irq_mask & DRAM_ECC_INT_CE_BIT) &&
+		(status & DRAM_ECC_INT_CE_BIT))
+		irq_ret = dmc520_edac_dram_ecc_isr(irq, mci, true);
+
+	if ((irq_mask & DRAM_ECC_INT_UE_BIT) &&
+		(status & DRAM_ECC_INT_UE_BIT))
+		irq_ret = dmc520_edac_dram_ecc_isr(irq, mci, false);
+
+	return irq_ret;
+}
+
+static irqreturn_t dmc520_isr(int irq, void *data)
+{
+	struct mem_ctl_info *mci = data;
+	struct dmc520_edac *pvt = mci->pvt_info;
+	u32 mask = 0;
+	int idx;
+
+	for (idx = 0; idx < NUMBER_OF_IRQS; idx++) {
+		if (pvt->irqs[idx] == irq) {
+			mask = pvt->masks[idx];
+			break;
+		}
+	}
+	return dmc520_edac_dram_all_isr(irq, mci, mask);
+}
+
+static void dmc520_init_csrow(struct mem_ctl_info *mci)
+{
+	struct dmc520_edac *pvt = mci->pvt_info;
+	struct csrow_info *csi;
+	struct dimm_info *dimm;
+	u32 pages_per_rank;
+	enum dev_type dt;
+	enum mem_type mt;
+	int row, ch;
+	u64 rs;
+
+	dt = dmc520_get_dtype(pvt);
+	mt = dmc520_get_mtype(pvt);
+	rs = dmc520_get_rank_size(pvt);
+	pages_per_rank = rs >> PAGE_SHIFT;
+
+	for (row = 0; row < mci->nr_csrows; row++) {
+		csi = mci->csrows[row];
+
+		for (ch = 0; ch < csi->nr_channels; ch++) {
+			dimm		= csi->channels[ch]->dimm;
+			dimm->grain	= pvt->mem_width_in_bytes;
+			dimm->dtype	= dt;
+			dimm->mtype	= mt;
+			dimm->edac_mode	= EDAC_FLAG_SECDED;
+			dimm->nr_pages	= pages_per_rank / csi->nr_channels;
+		}
+	}
+}
+
+static int dmc520_edac_probe(struct platform_device *pdev)
+{
+	bool registered[NUMBER_OF_IRQS] = { false };
+	int irqs[NUMBER_OF_IRQS] = { -ENXIO };
+	int masks[NUMBER_OF_IRQS] = { 0 };
+	struct edac_mc_layer layers[1];
+	struct dmc520_edac *pvt = NULL;
+	struct mem_ctl_info *mci;
+	void __iomem *reg_base;
+	u32 irq_mask_all = 0;
+	struct resource *res;
+	struct device *dev;
+	int ret, idx, irq;
+	u32 reg_val;
+
+	/* Parse the device node */
+	dev = &pdev->dev;
+
+	for (idx = 0; idx < NUMBER_OF_IRQS; idx++) {
+		irq = platform_get_irq_byname(pdev, dmc520_irq_configs[idx].name);
+		irqs[idx] = irq;
+		masks[idx] = dmc520_irq_configs[idx].mask;
+		if (irq >= 0) {
+			irq_mask_all |= dmc520_irq_configs[idx].mask;
+			edac_dbg(0, "Discovered %s, irq: %d.\n", dmc520_irq_configs[idx].name, irq);
+		}
+	}
+
+	if (!irq_mask_all) {
+		edac_printk(KERN_ERR, EDAC_MOD_NAME,
+			    "At least one valid interrupt line is expected.\n");
+		return -EINVAL;
+	}
+
+	/* Initialize dmc520 edac */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(reg_base))
+		return PTR_ERR(reg_base);
+
+	if (!dmc520_is_ecc_enabled(reg_base))
+		return -ENXIO;
+
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = dmc520_get_rank_count(reg_base);
+	layers[0].is_virt_csrow = true;
+
+	mci = edac_mc_alloc(dmc520_mc_idx++, ARRAY_SIZE(layers), layers, sizeof(*pvt));
+	if (!mci) {
+		edac_printk(KERN_ERR, EDAC_MOD_NAME,
+			    "Failed to allocate memory for mc instance\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	pvt = mci->pvt_info;
+
+	pvt->reg_base = reg_base;
+	spin_lock_init(&pvt->error_lock);
+	memcpy(pvt->irqs, irqs, sizeof(irqs));
+	memcpy(pvt->masks, masks, sizeof(masks));
+
+	platform_set_drvdata(pdev, mci);
+
+	mci->pdev = dev;
+	mci->mtype_cap		= MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
+	mci->edac_ctl_cap	= EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
+	mci->edac_cap		= EDAC_FLAG_SECDED;
+	mci->scrub_cap		= SCRUB_FLAG_HW_SRC;
+	mci->scrub_mode		= dmc520_get_scrub_type(pvt);
+	mci->ctl_name		= EDAC_CTL_NAME;
+	mci->dev_name		= dev_name(mci->pdev);
+	mci->mod_name		= EDAC_MOD_NAME;
+
+	edac_op_state = EDAC_OPSTATE_INT;
+
+	pvt->mem_width_in_bytes = dmc520_get_memory_width(pvt);
+
+	dmc520_init_csrow(mci);
+
+	/* Clear interrupts, not affecting other unrelated interrupts */
+	reg_val = dmc520_read_reg(pvt, REG_OFFSET_INTERRUPT_CONTROL);
+	dmc520_write_reg(pvt, reg_val & (~irq_mask_all),
+			 REG_OFFSET_INTERRUPT_CONTROL);
+	dmc520_write_reg(pvt, irq_mask_all, REG_OFFSET_INTERRUPT_CLR);
+
+	for (idx = 0; idx < NUMBER_OF_IRQS; idx++) {
+		irq = irqs[idx];
+		if (irq >= 0) {
+			ret = devm_request_irq(&pdev->dev, irq,
+					       dmc520_isr, IRQF_SHARED,
+					       dev_name(&pdev->dev), mci);
+			if (ret < 0) {
+				edac_printk(KERN_ERR, EDAC_MC,
+					    "Failed to request irq %d\n", irq);
+				goto err;
+			}
+			registered[idx] = true;
+		}
+	}
+
+	/* Reset DRAM CE/UE counters */
+	if (irq_mask_all & DRAM_ECC_INT_CE_BIT)
+		dmc520_get_dram_ecc_error_count(pvt, true);
+
+	if (irq_mask_all & DRAM_ECC_INT_UE_BIT)
+		dmc520_get_dram_ecc_error_count(pvt, false);
+
+	ret = edac_mc_add_mc(mci);
+	if (ret) {
+		edac_printk(KERN_ERR, EDAC_MOD_NAME,
+			    "Failed to register with EDAC core\n");
+		goto err;
+	}
+
+	/* Enable interrupts, not affecting other unrelated interrupts */
+	dmc520_write_reg(pvt, reg_val | irq_mask_all,
+			 REG_OFFSET_INTERRUPT_CONTROL);
+
+	return 0;
+
+err:
+	for (idx = 0; idx < NUMBER_OF_IRQS; idx++) {
+		if (registered[idx])
+			devm_free_irq(&pdev->dev, pvt->irqs[idx], mci);
+	}
+	if (mci)
+		edac_mc_free(mci);
+
+	return ret;
+}
+
+static int dmc520_edac_remove(struct platform_device *pdev)
+{
+	u32 reg_val, idx, irq_mask_all = 0;
+	struct mem_ctl_info *mci;
+	struct dmc520_edac *pvt;
+
+	mci = platform_get_drvdata(pdev);
+	pvt = mci->pvt_info;
+
+	/* Disable interrupts */
+	reg_val = dmc520_read_reg(pvt, REG_OFFSET_INTERRUPT_CONTROL);
+	dmc520_write_reg(pvt, reg_val & (~irq_mask_all),
+			 REG_OFFSET_INTERRUPT_CONTROL);
+
+	/* free irq's */
+	for (idx = 0; idx < NUMBER_OF_IRQS; idx++) {
+		if (pvt->irqs[idx] >= 0) {
+			irq_mask_all |= pvt->masks[idx];
+			devm_free_irq(&pdev->dev, pvt->irqs[idx], mci);
+		}
+	}
+
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
+
+	return 0;
+}
+
+static const struct of_device_id dmc520_edac_driver_id[] = {
+	{ .compatible = "arm,dmc-520", },
+	{ /* end of table */ }
+};
+
+MODULE_DEVICE_TABLE(of, dmc520_edac_driver_id);
+
+static struct platform_driver dmc520_edac_driver = {
+	.driver = {
+		.name = "dmc520",
+		.of_match_table = dmc520_edac_driver_id,
+	},
+
+	.probe = dmc520_edac_probe,
+	.remove = dmc520_edac_remove
+};
+
+module_platform_driver(dmc520_edac_driver);
+
+MODULE_AUTHOR("Rui Zhao <ruizhao@microsoft.com>");
+MODULE_AUTHOR("Lei Wang <lewan@microsoft.com>");
+MODULE_AUTHOR("Shiping Ji <shji@microsoft.com>");
+MODULE_DESCRIPTION("DMC-520 ECC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1


