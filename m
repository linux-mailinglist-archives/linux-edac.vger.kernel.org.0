Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59DCE1400B6
	for <lists+linux-edac@lfdr.de>; Fri, 17 Jan 2020 01:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgAQAS5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Jan 2020 19:18:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42224 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbgAQAS5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Jan 2020 19:18:57 -0500
Received: from zn.tnic (p200300EC2F0B23003D0DC5C907B4D929.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2300:3d0d:c5c9:7b4:d929])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DCBF51EC0C8A;
        Fri, 17 Jan 2020 01:18:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579220335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gL2yCyFLL3EJc+r9BfPHVAsvwRkfSr4JQ1I0u9DTnuo=;
        b=Bn2YKVyGwx5uIKXmwKOMACqaQZiaFLw1/S/gSGlbIb4tACejUtxvxx2lsj+DxfQRnIOJ6W
        Tc5VF6ycMpSl+xcMcmcRQePhRStVWbTCQRjOXDSOwAdH8TPLUOoXczDlAPyTlurZVRZq7l
        g+mcDXQdGk23iDrvJmNO/yLTuiJQZ7M=
Date:   Fri, 17 Jan 2020 01:18:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     James Morse <james.morse@arm.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        sashal@kernel.org, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, shji@microsoft.com,
        ruizhao@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        wangglei@gmail.com
Subject: Re: [PATCH v9 2/2] EDAC: add EDAC driver for DMC520
Message-ID: <20200117001843.GJ27148@zn.tnic>
References: <6a462190-0af2-094a-daa8-f480d54a1fbf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a462190-0af2-094a-daa8-f480d54a1fbf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 15, 2020 at 06:32:33AM -0800, Shiping Ji wrote:
> New driver supports error detection and correction on the devices with ARM
> DMC-520 memory controller.
> 
> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> ---
>      Changes in v9:
>          - Removed interrupt-config and replaced with an interrupt map where names and masks are predefined
>          - Only one ISR function is defined, mask is retrieved from the interrupt map
>          - "dram_ecc_errc" and "dram_ecc_errd" are implemented
> 
> ---
>  MAINTAINERS                |   6 +
>  drivers/edac/Kconfig       |   7 +
>  drivers/edac/Makefile      |   1 +
>  drivers/edac/dmc520_edac.c | 670 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 684 insertions(+)
>  create mode 100644 drivers/edac/dmc520_edac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd5847e802de..386195a019c6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5914,6 +5914,12 @@ F:	Documentation/driver-api/edac.rst
>  F:	drivers/edac/
>  F:	include/linux/edac.h
>  
> +EDAC-DMC520
> +M:	Lei Wang <lewan@microsoft.com>
> +L:	linux-edac@vger.kernel.org
> +S:	Supported
> +F:	drivers/edac/dmc520_edac.c
> +
>  EDAC-E752X
>  M:	Mark Gross <mark.gross@intel.com>
>  L:	linux-edac@vger.kernel.org
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 37027c298323..7305bd1ec80e 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -523,4 +523,11 @@ config EDAC_BLUEFIELD
>  	  Support for error detection and correction on the
>  	  Mellanox BlueField SoCs.
>  
> +config EDAC_DMC520
> +	tristate "ARM DMC-520 ECC"
> +	depends on ARM64
> +	help
> +	  Support for error detection and correction on the
> +	  SoCs with ARM DMC-520 DRAM controller.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index d77200c9680b..269e15118cea 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -87,3 +87,4 @@ obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
>  obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
>  obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
>  obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
> +obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
> diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
> new file mode 100644
> index 000000000000..55237c5c522c
> --- /dev/null
> +++ b/drivers/edac/dmc520_edac.c
> @@ -0,0 +1,670 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * EDAC driver for DMC-520 memory controller.
> + *
> + * The driver supports 10 interrupt lines,
> + * though only dram_ecc_errc and dram_ecc_errd are currently handled.
> + *
> + * Authors:	Rui Zhao <ruizhao@microsoft.com>
> + *		Lei Wang <lewan@microsoft.com>
> + *		Shiping Ji <shji@microsoft.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/edac.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include "edac_mc.h"
> +
> +/* DMC-520 registers */
> +#define REG_OFFSET_FEATURE_CONFIG		0x130
> +#define REG_OFFSET_ECC_ERRC_COUNT_31_00		0x158
> +#define REG_OFFSET_ECC_ERRC_COUNT_63_32		0x15C
> +#define REG_OFFSET_ECC_ERRD_COUNT_31_00		0x160
> +#define REG_OFFSET_ECC_ERRD_COUNT_63_32		0x164
> +#define REG_OFFSET_INTERRUPT_CONTROL		0x500
> +#define REG_OFFSET_INTERRUPT_CLR		0x508
> +#define REG_OFFSET_INTERRUPT_STATUS		0x510
> +#define REG_OFFSET_DRAM_ECC_ERRC_INT_INFO_31_00	0x528
> +#define REG_OFFSET_DRAM_ECC_ERRC_INT_INFO_63_32	0x52C
> +#define REG_OFFSET_DRAM_ECC_ERRD_INT_INFO_31_00	0x530
> +#define REG_OFFSET_DRAM_ECC_ERRD_INT_INFO_63_32	0x534
> +#define REG_OFFSET_ADDRESS_CONTROL_NOW		0x1010
> +#define REG_OFFSET_MEMORY_TYPE_NOW		0x1128
> +#define REG_OFFSET_SCRUB_CONTROL0_NOW		0x1170
> +#define REG_OFFSET_FORMAT_CONTROL		0x18
> +
> +/* DMC-520 types, masks and bitfields */
> +#define RAM_ECC_INT_CE_BIT			BIT(0)
> +#define RAM_ECC_INT_UE_BIT			BIT(1)
> +#define DRAM_ECC_INT_CE_BIT			BIT(2)
> +#define DRAM_ECC_INT_UE_BIT			BIT(3)
> +#define FAILED_ACCESS_INT_BIT		BIT(4)
> +#define FAILED_PROG_INT_BIT			BIT(5)
> +#define LINK_ERR_INT_BIT			BIT(6)
> +#define TEMPERATURE_EVENT_INT_BIT	BIT(7)

Align values vertically.

> +#define ARCH_FSM_INT_BIT			BIT(8)
> +#define PHY_REQUEST_INT_BIT			BIT(9)
> +#define MEMORY_WIDTH_MASK			GENMASK(1, 0)
> +#define SCRUB_TRIGGER0_NEXT_MASK		GENMASK(1, 0)
> +#define REG_FIELD_DRAM_ECC_ENABLED		GENMASK(1, 0)
> +#define REG_FIELD_MEMORY_TYPE			GENMASK(2, 0)
> +#define REG_FIELD_DEVICE_WIDTH			GENMASK(9, 8)
> +#define REG_FIELD_ADDRESS_CONTROL_COL		GENMASK(2,  0)
> +#define REG_FIELD_ADDRESS_CONTROL_ROW		GENMASK(10, 8)
> +#define REG_FIELD_ADDRESS_CONTROL_BANK		GENMASK(18, 16)
> +#define REG_FIELD_ADDRESS_CONTROL_RANK		GENMASK(25, 24)
> +#define REG_FIELD_ERR_INFO_LOW_VALID		BIT(0)
> +#define REG_FIELD_ERR_INFO_LOW_COL		GENMASK(10, 1)
> +#define REG_FIELD_ERR_INFO_LOW_ROW		GENMASK(28, 11)
> +#define REG_FIELD_ERR_INFO_LOW_RANK		GENMASK(31, 29)
> +#define REG_FIELD_ERR_INFO_HIGH_BANK		GENMASK(3, 0)
> +#define REG_FIELD_ERR_INFO_HIGH_VALID		BIT(31)
> +
> +#define DRAM_ADDRESS_CONTROL_MIN_COL_BITS	8
> +#define DRAM_ADDRESS_CONTROL_MIN_ROW_BITS	11
> +
> +#define DMC520_SCRUB_TRIGGER_ERR_DETECT		2
> +#define DMC520_SCRUB_TRIGGER_IDLE		3
> +
> +/* Driver settings */
> +/*
> + * The max-length message would be: "rank:7 bank:15 row:262143 col:1023".
> + * Max length is 34. Using a 40-size buffer is enough.
> + */
> +#define DMC520_MSG_BUF_SIZE			40
> +#define EDAC_MOD_NAME				"dmc520-edac"
> +#define EDAC_CTL_NAME				"dmc520"
> +
> +/* the data bus width for the attached memory chips. */
> +enum dmc520_mem_width {
> +	MEM_WIDTH_X32 = 2,
> +	MEM_WIDTH_X64 = 3
> +};
> +
> +/* memory type */
> +enum dmc520_mem_type {
> +	MEM_TYPE_DDR3 = 1,
> +	MEM_TYPE_DDR4 = 2
> +};
> +
> +/* memory device width */
> +enum dmc520_dev_width {
> +	DEV_WIDTH_X4 = 0,
> +	DEV_WIDTH_X8 = 1,
> +	DEV_WIDTH_X16 = 2
> +};
> +
> +struct ecc_error_info {
> +	u32 col;
> +	u32 row;
> +	u32 bank;
> +	u32 rank;
> +};
> +
> +/* The interrupt config */
> +struct dmc520_irq_config {
> +	char *name;
> +	int mask;
> +};
> +
> +/* The interrupt mappings */
> +static struct dmc520_irq_config dmc520_irq_configs[] = {
> +	{ 

Just a nit:

ERROR: trailing whitespace
#209: FILE: drivers/edac/dmc520_edac.c:119:
+^I{ $

IOW, before you send next time, do:

$ git log -p -1 | ./scripts/checkpatch.pl

to verify you've caught them all.

> +		.name = "ram_ecc_errc",
> +		.mask = RAM_ECC_INT_CE_BIT
> +	},
> +	{
> +		.name = "ram_ecc_errd",
> +		.mask = RAM_ECC_INT_UE_BIT
> +	},
> +	{
> +		.name = "dram_ecc_errc",
> +		.mask = DRAM_ECC_INT_CE_BIT
> +	},
> +	{
> +		.name = "dram_ecc_errd",
> +		.mask = DRAM_ECC_INT_UE_BIT
> +	},
> +	{
> +		.name = "failed_access",
> +		.mask = FAILED_ACCESS_INT_BIT
> +	},
> +	{
> +		.name = "failed_prog",
> +		.mask = FAILED_PROG_INT_BIT
> +	},
> +	{
> +		.name = "link_err",
> +		.mask = LINK_ERR_INT_BIT
> +	},
> +	{
> +		.name = "temperature_event",
> +		.mask = TEMPERATURE_EVENT_INT_BIT
> +	},
> +	{
> +		.name = "arch_fsm",
> +		.mask = ARCH_FSM_INT_BIT
> +	},
> +	{
> +		.name = "phy_request",
> +		.mask = PHY_REQUEST_INT_BIT
> +	}
> +};
> +
> +#define NUMBER_OF_IRQS 				ARRAY_SIZE(dmc520_irq_configs)

WARNING: please, no space before tabs
#251: FILE: drivers/edac/dmc520_edac.c:161:
+#define NUMBER_OF_IRQS ^I^I^I^IARRAY_SIZE(dmc520_irq_configs)$

> +
> +/* The EDAC driver private data */
> +struct dmc520_edac {
> +	void __iomem *reg_base;
> +	spinlock_t ecc_lock;

What does that spinlock protect? Also, its name is not very optimal.

> +	int irqs[NUMBER_OF_IRQS];
> +	int masks[NUMBER_OF_IRQS];
> +};
> +
> +static int dmc520_mc_idx;
> +
> +static irqreturn_t
> +dmc520_edac_dram_all_isr(int irq, struct mem_ctl_info *mci, u32 irq_mask);

Move the ISR under dmc520_edac_dram_all_isr() and get rid of that
forward declaration.

> +
> +static irqreturn_t dmc520_isr(int irq, void *data)
> +{
> +	struct mem_ctl_info *mci;
> +	struct dmc520_edac *edac;
> +	int idx;
> +	u32 mask = 0;
> +	mci = data;

WARNING: Missing a blank line after declarations
#272: FILE: drivers/edac/dmc520_edac.c:182:
+	u32 mask = 0;
+	mci = data;

> +	edac = mci->pvt_info;

Also, do this:

        struct mem_ctl_info *mci = data;
        struct dmc520_edac  *pvt = mci->pvt_info;
        u32 mask = 0;
        int idx;


> +
> +	for (idx = 0; idx < NUMBER_OF_IRQS; idx++) {
> +		if (edac->irqs[idx] == irq) {
> +			mask = edac->masks[idx];
> +			break;
> +		}
> +	}
> +	return dmc520_edac_dram_all_isr(irq, mci, mask);
> +}
> +
> +static u32 dmc520_read_reg(struct dmc520_edac *edac, u32 offset)
> +{
> +	return readl(edac->reg_base + offset);
> +}
> +
> +static void dmc520_write_reg(struct dmc520_edac *edac, u32 val, u32 offset)
> +{
> +	writel(val, edac->reg_base + offset);
> +}
> +
> +static u32 dmc520_calc_dram_ecc_error(u32 value)
> +{
> +	u32 total = 0;
> +
> +	/* Each rank's error counter takes one byte. */
> +	while (value > 0) {
> +		total += (value & 0xFF);
> +		value >>= 8;
> +	}
> +	return total;
> +}
> +
> +static u32 dmc520_get_dram_ecc_error_count(struct dmc520_edac *edac,
> +					   bool is_ce)
> +{
> +	u32 reg_offset_low, reg_offset_high;
> +	u32 err_low, err_high;
> +	u32 err_count;
> +
> +	reg_offset_low = is_ce ? REG_OFFSET_ECC_ERRC_COUNT_31_00 :
> +				 REG_OFFSET_ECC_ERRD_COUNT_31_00;
> +	reg_offset_high = is_ce ? REG_OFFSET_ECC_ERRC_COUNT_63_32 :
> +				  REG_OFFSET_ECC_ERRD_COUNT_63_32;
> +
> +	err_low = dmc520_read_reg(edac, reg_offset_low);
> +	err_high = dmc520_read_reg(edac, reg_offset_high);
> +	/* Reset error counters */
> +	dmc520_write_reg(edac, 0, reg_offset_low);
> +	dmc520_write_reg(edac, 0, reg_offset_high);
> +
> +	err_count = dmc520_calc_dram_ecc_error(err_low) +
> +		   dmc520_calc_dram_ecc_error(err_high);
> +
> +	return err_count;
> +}
> +
> +static void dmc520_get_dram_ecc_error_info(struct dmc520_edac *edac,
> +					   bool is_ce,
> +					   struct ecc_error_info *info)
> +{
> +	u32 reg_offset_low, reg_offset_high;
> +	u32 reg_val_low, reg_val_high;
> +	bool valid;
> +
> +	reg_offset_low = is_ce ? REG_OFFSET_DRAM_ECC_ERRC_INT_INFO_31_00 :
> +				 REG_OFFSET_DRAM_ECC_ERRD_INT_INFO_31_00;
> +	reg_offset_high = is_ce ? REG_OFFSET_DRAM_ECC_ERRC_INT_INFO_63_32 :
> +				  REG_OFFSET_DRAM_ECC_ERRD_INT_INFO_63_32;

Those define names could be shorter.

> +
> +	reg_val_low = dmc520_read_reg(edac, reg_offset_low);
> +	reg_val_high = dmc520_read_reg(edac, reg_offset_high);
> +
> +	valid = (FIELD_GET(REG_FIELD_ERR_INFO_LOW_VALID, reg_val_low) != 0) &&
> +		(FIELD_GET(REG_FIELD_ERR_INFO_HIGH_VALID, reg_val_high) != 0);
> +
> +	if (valid) {
> +		info->col =
> +			FIELD_GET(REG_FIELD_ERR_INFO_LOW_COL, reg_val_low);
> +		info->row =
> +			FIELD_GET(REG_FIELD_ERR_INFO_LOW_ROW, reg_val_low);
> +		info->rank =
> +			FIELD_GET(REG_FIELD_ERR_INFO_LOW_RANK, reg_val_low);
> +		info->bank =
> +			FIELD_GET(REG_FIELD_ERR_INFO_HIGH_BANK, reg_val_high);

Those too.

And let those stick out - the 80 cols rule is not an absolute one.

> +	} else {
> +		memset(info, 0, sizeof(struct ecc_error_info));
> +	}
> +}
> +
> +static bool dmc520_is_ecc_enabled(void __iomem *reg_base)
> +{
> +	u32 reg_val = readl(reg_base + REG_OFFSET_FEATURE_CONFIG);
> +
> +	return FIELD_GET(REG_FIELD_DRAM_ECC_ENABLED, reg_val);
> +}
> +
> +static enum scrub_type dmc520_get_scrub_type(struct dmc520_edac *edac)
> +{
> +	enum scrub_type type = SCRUB_NONE;
> +	u32 reg_val, scrub_cfg;
> +
> +	reg_val = dmc520_read_reg(edac, REG_OFFSET_SCRUB_CONTROL0_NOW);
> +	scrub_cfg = FIELD_GET(SCRUB_TRIGGER0_NEXT_MASK, reg_val);
> +
> +	if (scrub_cfg == DMC520_SCRUB_TRIGGER_ERR_DETECT ||
> +	    scrub_cfg == DMC520_SCRUB_TRIGGER_IDLE)
> +		type = SCRUB_HW_PROG;
> +
> +	return type;
> +}
> +
> +/* Get the memory data bus width, in number of bytes. */
> +static u32 dmc520_get_memory_width(struct dmc520_edac *edac)
> +{
> +	enum dmc520_mem_width mem_width_field;
> +	static u32 mem_width_in_bytes;
> +	u32 reg_val;
> +
> +	if (mem_width_in_bytes)
> +		return mem_width_in_bytes;

This looks like the memory width in bytes is the same for the whole
device so you can do this determination in the probe function and make
that mem_width_in_bytes variable global and define it at the beginning
of this file.

> +	reg_val = dmc520_read_reg(edac, REG_OFFSET_FORMAT_CONTROL);
> +	mem_width_field = FIELD_GET(MEMORY_WIDTH_MASK, reg_val);
> +
> +	if (mem_width_field == MEM_WIDTH_X32)
> +		mem_width_in_bytes = 4;
> +	else if (mem_width_field == MEM_WIDTH_X64)
> +		mem_width_in_bytes = 8;
> +	return mem_width_in_bytes;
> +}

...

> +
> +static int dmc520_edac_probe(struct platform_device *pdev)
> +{
> +	bool registered[NUMBER_OF_IRQS] = {false};
> +	int irqs[NUMBER_OF_IRQS] = {-ENXIO};
> +	int masks[NUMBER_OF_IRQS] = {0};

Add spaces around those initializers. E.g., { -ENXIO }; etc.

> +	struct mem_ctl_info *mci = NULL;

Useless initialization.

> +	struct edac_mc_layer layers[1];
> +	struct dmc520_edac *edac;

drivers/edac/dmc520_edac.c: In function ‘dmc520_edac_probe’:
drivers/edac/dmc520_edac.c:493:22: warning: ‘edac’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  struct dmc520_edac *edac;
                      ^~~~

Also, that variable name is a bad choice. Most drivers call it "pvt" or
so to mean, driver's "private data".

> +	void __iomem *reg_base;
> +	u32 irq_mask_all = 0;
> +	int ret, idx, irq;
> +	struct resource *res;
> +	struct device *dev;
> +	u32 reg_val;
> +
> +	/* Parse the device node */
> +	dev = &pdev->dev;
> +
> +	for (idx = 0; idx < NUMBER_OF_IRQS; idx++) {
> +		irq = platform_get_irq_byname(pdev, dmc520_irq_configs[idx].name);
> +		irqs[idx] = irq;
> +		masks[idx] = dmc520_irq_configs[idx].mask;
> +		if (irq >= 0) {
> +			irq_mask_all |= dmc520_irq_configs[idx].mask;
> +			edac_printk(KERN_INFO, EDAC_MOD_NAME,
> +				"Discovered %s, irq: %d.\n", dmc520_irq_configs[idx].name, irq);

Is that something you really wanna say on driver load? I.e., should it
be edac_dbg() ?

> +		}
> +	}
> +
> +	if (irq_mask_all == 0) {

	if (!irq_mask_all)

> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +				"At least one valid interrupt line is expected.\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Initialize dmc520 edac */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(reg_base))
> +		return PTR_ERR(reg_base);
> +
> +	if (!dmc520_is_ecc_enabled(reg_base))
> +		return -ENXIO;
> +
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = dmc520_get_rank_count(reg_base);
> +	layers[0].is_virt_csrow = true;
> +
> +	mci = edac_mc_alloc(dmc520_mc_idx++, ARRAY_SIZE(layers), layers,
> +				sizeof(struct dmc520_edac));
> +	if (!mci) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +				"Failed to allocate memory for mc instance\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	edac = mci->pvt_info;
> +
> +	edac->reg_base = reg_base;
> +	spin_lock_init(&edac->ecc_lock);
> +	memcpy(edac->irqs, irqs, sizeof(irqs));
> +	memcpy(edac->masks, masks, sizeof(masks));
> +
> +	platform_set_drvdata(pdev, mci);
> +
> +	mci->pdev = dev;
> +	mci->mtype_cap		= MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
> +	mci->edac_ctl_cap	= EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
> +	mci->edac_cap		= EDAC_FLAG_SECDED;
> +	mci->scrub_cap		= SCRUB_FLAG_HW_SRC;
> +	mci->scrub_mode		= dmc520_get_scrub_type(edac);
> +	mci->ctl_name		= EDAC_CTL_NAME;
> +	mci->dev_name		= dev_name(mci->pdev);
> +	mci->mod_name		= EDAC_MOD_NAME;
> +
> +	edac_op_state = EDAC_OPSTATE_INT;
> +
> +	dmc520_init_csrow(mci);
> +
> +	/* Clear interrupts, not affecting other unrelated interrupts */
> +	reg_val = dmc520_read_reg(edac, REG_OFFSET_INTERRUPT_CONTROL);
> +	dmc520_write_reg(edac, reg_val & (~irq_mask_all),
> +			 REG_OFFSET_INTERRUPT_CONTROL);
> +	dmc520_write_reg(edac, irq_mask_all, REG_OFFSET_INTERRUPT_CLR);
> +
> +	for (idx = 0; idx < NUMBER_OF_IRQS; idx++) {
> +		irq = irqs[idx];
> +		if (irq >= 0) {
> +			ret = devm_request_irq(&pdev->dev, irq,
> +							dmc520_isr, IRQF_SHARED,
> +							dev_name(&pdev->dev), mci);

Align arguments on the opening brace.

> +			if (ret < 0) {
> +				edac_printk(KERN_ERR, EDAC_MC,
> +						"Failed to request irq %d\n", irq);

Ditto.

> +				goto err;
> +			}
> +			registered[idx] = true;
> +		}
> +	}
> +
> +	/* Reset DRAM CE/UE counters */
> +	if (irq_mask_all & DRAM_ECC_INT_CE_BIT)
> +		dmc520_get_dram_ecc_error_count(edac, true);
> +
> +	if (irq_mask_all & DRAM_ECC_INT_UE_BIT)
> +		dmc520_get_dram_ecc_error_count(edac, false);
> +
> +	ret = edac_mc_add_mc(mci);
> +	if (ret) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			"Failed to register with EDAC core\n");
> +		goto err;
> +	}
> +
> +	/* Enable interrupts, not affecting other unrelated interrupts */
> +	dmc520_write_reg(edac, reg_val | irq_mask_all,
> +			 REG_OFFSET_INTERRUPT_CONTROL);
> +
> +	return 0;
> +
> +err:
> +	for (idx = 0; idx < NUMBER_OF_IRQS; idx++) {
> +		if (registered[idx]) {
> +			devm_free_irq(&pdev->dev, edac->irqs[idx], mci);
> +		}

WARNING: braces {} are not necessary for single statement blocks
#699: FILE: drivers/edac/dmc520_edac.c:609:
+		if (registered[idx]) {
+			devm_free_irq(&pdev->dev, edac->irqs[idx], mci);
+		}

> +	}
> +	if (mci)
> +		edac_mc_free(mci);
> +
> +	return ret;
> +}
> +
> +static int dmc520_edac_remove(struct platform_device *pdev)
> +{
> +	struct dmc520_edac *edac;
> +	struct mem_ctl_info *mci;
> +	u32 reg_val, idx, irq_mask_all = 0;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

> +
> +	mci = platform_get_drvdata(pdev);
> +	edac = mci->pvt_info;
> +
> +	/* free irq's */
> +	for (idx = 0; idx < NUMBER_OF_IRQS; idx++) {
> +		if (edac->irqs[idx] >= 0) {
> +			irq_mask_all |= edac->masks[idx];
> +			devm_free_irq(&pdev->dev, edac->irqs[idx], mci);
> +		}
> +	}
> +
> +	/* Disable interrupts */
> +	reg_val = dmc520_read_reg(edac, REG_OFFSET_INTERRUPT_CONTROL);
> +	dmc520_write_reg(edac, reg_val & (~irq_mask_all),
> +			 REG_OFFSET_INTERRUPT_CONTROL);

Huh, aren't you supposed to disable the interrupts and *then* free the
IRQs?

> +
> +	edac_mc_del_mc(&pdev->dev);
> +	edac_mc_free(mci);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dmc520_edac_driver_id[] = {
> +	{ .compatible = "arm,dmc-520", },
> +	{ /* end of table */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, dmc520_edac_driver_id);
> +
> +static struct platform_driver dmc520_edac_driver = {
> +	.driver = {
> +		.name = "dmc520",
> +		.of_match_table = dmc520_edac_driver_id,
> +	},
> +
> +	.probe = dmc520_edac_probe,
> +	.remove = dmc520_edac_remove
> +};
> +
> +module_platform_driver(dmc520_edac_driver);
> +
> +MODULE_AUTHOR("Rui Zhao <ruizhao@microsoft.com>");
> +MODULE_AUTHOR("Lei Wang <lewan@microsoft.com>");
> +MODULE_AUTHOR("Shiping Ji <shji@microsoft.com>");
> +MODULE_DESCRIPTION("DMC-520 ECC driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
