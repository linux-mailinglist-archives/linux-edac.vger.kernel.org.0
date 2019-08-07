Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2098584EEC
	for <lists+linux-edac@lfdr.de>; Wed,  7 Aug 2019 16:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbfHGOje (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Aug 2019 10:39:34 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40980 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388190AbfHGOjd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 7 Aug 2019 10:39:33 -0400
Received: from zn.tnic (p200300EC2F0D500028F05A6F4E0B83B6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5000:28f0:5a6f:4e0b:83b6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD6501EC09A0;
        Wed,  7 Aug 2019 16:39:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565188771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nF6cS8dYCXOzkgCQitn5cIcoXPPja3pzy1FzUBaF/uk=;
        b=czwo4pMgDFc25SHYFvPFRbMvHa9CuLDxUhDgZinKmxrLxpHcULMdco87XYNyzEB+kwJ4Ze
        UK1Fqo+XbHn1mnoij2Iu68joLT4zLA47teYFEnhxd1RBsLEBrun1Nz/AK4qaOD+aq85LVE
        6R98glsx8hGKZyQjzGqUJN5PeQRk564=
Date:   Wed, 7 Aug 2019 16:40:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lei Wang <leiwang_git@outlook.com>
Cc:     "james.morse@arm.com" <james.morse@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        "ruizhao@microsoft.com" <ruizhao@microsoft.com>
Subject: Re: [PATCH v5 2/2] EDAC: add EDAC driver for DMC520
Message-ID: <20190807144016.GA24328@zn.tnic>
References: <BN6PR04MB1107CE3C2D666A806E62851B86C10@BN6PR04MB1107.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR04MB1107CE3C2D666A806E62851B86C10@BN6PR04MB1107.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jul 25, 2019 at 12:49:27AM +0000, Lei Wang wrote:
> New driver supports error detection and correction on the devices with ARM
> DMC-520 memory controller.
> 
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>     Changes in v5:
>         - When enable configured interrupts, do not potentially disable
>           other irrelevant interrupts.
>         - fix return type of dmc520_get_scrub_type to enum scrub_type
>         - Use capital letters for enum
>         - Retrieve memory width from dmc register format_control
>         - use cheaper spin_lock API.
>         - Remove compatible line for "brcm,dmc-520"
>         - Add James' Reviewed-by
> ---
>  MAINTAINERS                |   6 +
>  drivers/edac/Kconfig       |   7 +
>  drivers/edac/Makefile      |   1 +
>  drivers/edac/dmc520_edac.c | 632 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 646 insertions(+)
>  create mode 100644 drivers/edac/dmc520_edac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 77eae44bf5de..7c1ac8bc8ea1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5703,6 +5703,12 @@ F:	Documentation/driver-api/edac.rst
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
> index 200c04ce5b0e..7fde5aea0c1a 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -510,4 +510,11 @@ config EDAC_ASPEED
>  	  First, ECC must be configured in the bootloader. Then, this driver
>  	  will expose error counters via the EDAC kernel framework.
>  
> +config EDAC_DMC520
> +       tristate "ARM DMC-520 ECC"
> +       depends on ARM64
> +       help
> +         Support for error detection and correction on the
> +         SoCs with ARM DMC-520 DRAM controller.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 165ca65e1a3a..e0d98f5b2045 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -85,3 +85,4 @@ obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
>  obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
>  obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
>  obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
> +obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
> diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
> new file mode 100644
> index 000000000000..aeb8d84405cf
> --- /dev/null
> +++ b/drivers/edac/dmc520_edac.c
> @@ -0,0 +1,632 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* EDAC driver for DMC-520 */

That comment is kinda useless.

> +#include <linux/bitfield.h>
> +#include <linux/edac.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
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
> +#define REG_OFFSET_FORMAT_CONTROL	0x18
> +
> +/* DMC-520 types, masks and bitfields */
> +#define DRAM_ECC_INT_CE_BIT			BIT(2)
> +#define DRAM_ECC_INT_UE_BIT			BIT(3)
> +#define ALL_INT_MASK				GENMASK(9, 0)
> +#define MEMORY_WIDTH_MASK			GENMASK(1, 0)
> +#define SCRUB_TRIGGER0_NEXT_MASK		GENMASK(1, 0)
> +#define REG_FIELD_DRAM_ECC_ENABLED		GENMASK(1, 0)
> +#define REG_FIELD_MEMORY_TYPE			GENMASK(2, 0)
> +#define REG_FIELD_DEVICE_WIDTH			GENMASK(9, 8)
> +#define REG_FIELD_ADDRESS_CONTROL_COL		GENMASK(2, 0)
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
> +#define DMC520_SCRUB_TRIGGER_IDLE			3

One tab too many. Keep them all vertically aligned.

> +
> +/* Driver settings */
> +/* The max-length message would be: "rank:7 bank:15 row:262143 col:1023".
> + * Max length is 34. Using a 40-size buffer is enough.
> + */
> +#define EDAC_MSG_BUF_SIZE			40

That define is driver-local only. Prefix it with "DMC520_" or so, not
with "EDAC_".

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
> +/* The EDAC driver private data */
> +struct dmc520_edac {
> +	void __iomem *reg_base;
> +	u32 nintr;
> +	u32 interrupt_mask_all;
> +	spinlock_t ecc_lock;
> +	u32 interrupt_masks[0];
> +};
> +
> +static int dmc520_mc_idx;
> +
> +static irqreturn_t
> +dmc520_edac_dram_all_isr(int irq, struct mem_ctl_info *mci, u32 interrupt_mask);
> +
> +#define DECLARE_ISR(index) \
> +static irqreturn_t dmc520_isr_##index (int irq, void *data) \

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense.

WARNING: space prohibited between function name and open parenthesis '('
#200: FILE: drivers/edac/dmc520_edac.c:108:
+static irqreturn_t dmc520_isr_##index (int irq, void *data) \


> +{ \
> +	struct mem_ctl_info *mci; \
> +	struct dmc520_edac *edac; \
> +	mci = data; \
> +	edac = mci->pvt_info; \
> +	return dmc520_edac_dram_all_isr(irq, mci, edac->interrupt_masks[index]); \
> +}
> +
> +DECLARE_ISR(0)
> +DECLARE_ISR(1)
> +/* More DECLARE_ISR(index) can be added to support more interrupt lines. */
> +
> +irq_handler_t dmc520_isr_array[] = {
> +	dmc520_isr_0,
> +	dmc520_isr_1
> +	/* More dmc520_isr_index can be added to support more interrupt lines. */

What are those comments really for?

> +};
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
> +	/* Each rank's error counter takes one byte */
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
> +
> +	reg_val_low = dmc520_read_reg(edac, reg_offset_low);
> +	reg_val_high = dmc520_read_reg(edac, reg_offset_high);
> +
> +	valid = (FIELD_GET(REG_FIELD_ERR_INFO_LOW_VALID, reg_val_low) != 0) &&
> +		(FIELD_GET(REG_FIELD_ERR_INFO_HIGH_VALID, reg_val_high) != 0);
> +
> +	if (valid) {
> +		info->col = FIELD_GET(REG_FIELD_ERR_INFO_LOW_COL, reg_val_low);
> +		info->row = FIELD_GET(REG_FIELD_ERR_INFO_LOW_ROW, reg_val_low);
> +		info->rank = FIELD_GET(REG_FIELD_ERR_INFO_LOW_RANK, reg_val_low);
> +		info->bank = FIELD_GET(REG_FIELD_ERR_INFO_HIGH_BANK, reg_val_high);
> +	} else {
> +		memset(info, 0, sizeof(struct ecc_error_info));
> +	}
> +}
> +
> +static bool dmc520_is_ecc_enabled(void __iomem *reg_base)
> +{
> +	u32 reg_val = readl(reg_base + REG_OFFSET_FEATURE_CONFIG);
> +
> +	return (FIELD_GET(REG_FIELD_DRAM_ECC_ENABLED, reg_val) != 0);

No need for that " != 0" at the end.

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
> +	if (DMC520_SCRUB_TRIGGER_ERR_DETECT == scrub_cfg ||
> +		DMC520_SCRUB_TRIGGER_IDLE == scrub_cfg)
> +		type = SCRUB_HW_PROG;

More from checkpatch:

WARNING: Comparisons should place the constant on the right side of the test
#309: FILE: drivers/edac/dmc520_edac.c:217:
+       if (DMC520_SCRUB_TRIGGER_ERR_DETECT == scrub_cfg ||

WARNING: Comparisons should place the constant on the right side of the test
#310: FILE: drivers/edac/dmc520_edac.c:218:
+               DMC520_SCRUB_TRIGGER_IDLE == scrub_cfg)


> +
> +	return type;
> +}
> +
> +/* Get the memory data bus width, in number of bytes. */
> +static u32 dmc520_get_memory_width(struct dmc520_edac *edac)
> +{
> +	static u32 mem_width;
> +	u32 reg_val;
> +	enum dmc520_mem_width mem_width_field;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

Here and in the other functions.

> +
> +	if (mem_width == 0) {

Flip that check and save yourself an indentation level:

	if (mem_width)
		return;

	reg_val = ...



> +		reg_val = dmc520_read_reg(edac, REG_OFFSET_FORMAT_CONTROL);
> +		mem_width_field = FIELD_GET(MEMORY_WIDTH_MASK, reg_val);
> +
> +		if (mem_width_field == MEM_WIDTH_X32)
> +			mem_width = 4; /* 32-bits, 4 bytes */
> +		else if (mem_width_field == MEM_WIDTH_X64)
> +			mem_width = 8; /* 64-bits, 8 bytes */

Please no side-comments. And those you can directly remove as they're
useless - your defines and variables should be named properly so that
there is no need for a comment here additionally.

> +	}
> +
> +	return mem_width;
> +}
> +
> +static enum mem_type dmc520_get_mtype(struct dmc520_edac *edac)
> +{
> +	enum mem_type mt = MEM_UNKNOWN;
> +	u32 reg_val;
> +	enum dmc520_mem_type type;
> +
> +	reg_val = dmc520_read_reg(edac, REG_OFFSET_MEMORY_TYPE_NOW);
> +	type = FIELD_GET(REG_FIELD_MEMORY_TYPE, reg_val);
> +
> +	switch (type) {
> +	case MEM_TYPE_DDR3:
> +		mt = MEM_DDR3;
> +		break;
> +
> +	case MEM_TYPE_DDR4:
> +		mt = MEM_DDR4;
> +		break;
> +	}
> +
> +	return mt;
> +}
> +
> +static enum dev_type dmc520_get_dtype(struct dmc520_edac *edac)
> +{
> +	enum dev_type dt = DEV_UNKNOWN;
> +	u32 reg_val;
> +	enum dmc520_dev_width device_width;
> +
> +	reg_val = dmc520_read_reg(edac, REG_OFFSET_MEMORY_TYPE_NOW);
> +	device_width = FIELD_GET(REG_FIELD_DEVICE_WIDTH, reg_val);
> +
> +	switch (device_width) {
> +	case DEV_WIDTH_X4:
> +		dt = DEV_X4;
> +		break;
> +
> +	case DEV_WIDTH_X8:
> +		dt = DEV_X8;
> +		break;
> +
> +	case DEV_WIDTH_X16:
> +		dt = DEV_X16;
> +		break;
> +	}
> +
> +	return dt;
> +}
> +
> +static u32 dmc520_get_rank_count(void __iomem *reg_base)
> +{
> +	u32 reg_val, rank_bits;
> +
> +	reg_val = readl(reg_base + REG_OFFSET_ADDRESS_CONTROL_NOW);
> +	rank_bits = FIELD_GET(REG_FIELD_ADDRESS_CONTROL_RANK, reg_val);
> +
> +	return (1 << rank_bits);

	return BIT(rank_bits);

> +}
> +
> +static u64 dmc520_get_rank_size(struct dmc520_edac *edac)
> +{
> +	u32 reg_val, col_bits, row_bits, bank_bits;
> +
> +	reg_val = dmc520_read_reg(edac, REG_OFFSET_ADDRESS_CONTROL_NOW);
> +
> +	col_bits = FIELD_GET(REG_FIELD_ADDRESS_CONTROL_COL, reg_val) +
> +		   DRAM_ADDRESS_CONTROL_MIN_COL_BITS;
> +	row_bits = FIELD_GET(REG_FIELD_ADDRESS_CONTROL_ROW, reg_val) +
> +		   DRAM_ADDRESS_CONTROL_MIN_ROW_BITS;
> +	bank_bits = FIELD_GET(REG_FIELD_ADDRESS_CONTROL_BANK, reg_val);
> +
> +	return (u64)dmc520_get_memory_width(edac) << (col_bits + row_bits + bank_bits);
> +}
> +
> +static void dmc520_handle_dram_ecc_errors(struct mem_ctl_info *mci,
> +					  bool is_ce)
> +{
> +	struct ecc_error_info info;
> +	struct dmc520_edac *edac;
> +	u32 cnt;
> +	char message[EDAC_MSG_BUF_SIZE];
> +
> +	edac = mci->pvt_info;
> +	dmc520_get_dram_ecc_error_info(edac, is_ce, &info);
> +
> +	cnt = dmc520_get_dram_ecc_error_count(edac, is_ce);
> +
> +	if (cnt > 0) {

Save an indentation level:

	if (!cnt)
		return;

	snprintf...

> +		snprintf(message, ARRAY_SIZE(message),
> +			 "rank:%d bank:%d row:%d col:%d",
> +			 info.rank, info.bank,
> +			 info.row, info.col);
> +
> +		spin_lock(&edac->ecc_lock);
> +		edac_mc_handle_error((is_ce ? HW_EVENT_ERR_CORRECTED :
> +				     HW_EVENT_ERR_UNCORRECTED),
> +				     mci, cnt, 0, 0, 0, info.rank, -1, -1,
> +				     message, "");
> +		spin_unlock(&edac->ecc_lock);
> +	}
> +}
> +
> +static irqreturn_t dmc520_edac_dram_ecc_isr(int irq, struct mem_ctl_info *mci, bool is_ce)
> +{
> +	u32 i_mask;
> +	struct dmc520_edac *edac;
> +
> +	edac = mci->pvt_info;
> +
> +	i_mask = is_ce ? DRAM_ECC_INT_CE_BIT : DRAM_ECC_INT_UE_BIT;
> +
> +	dmc520_handle_dram_ecc_errors(mci, is_ce);
> +
> +	dmc520_write_reg(edac, i_mask, REG_OFFSET_INTERRUPT_CLR);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t
> +dmc520_edac_dram_all_isr(int irq, struct mem_ctl_info *mci, u32 interrupt_mask)
> +{
> +	struct dmc520_edac *edac;
> +	u32 status;
> +	irqreturn_t irq_ret = IRQ_NONE;
> +
> +	edac = mci->pvt_info;
> +
> +	status = dmc520_read_reg(edac, REG_OFFSET_INTERRUPT_STATUS);
> +
> +	if ((interrupt_mask & DRAM_ECC_INT_CE_BIT) &&
> +		(status & DRAM_ECC_INT_CE_BIT))
> +		irq_ret = dmc520_edac_dram_ecc_isr(irq, mci, true);
> +
> +	if ((interrupt_mask & DRAM_ECC_INT_UE_BIT) &&
> +		(status & DRAM_ECC_INT_UE_BIT))
> +		irq_ret = dmc520_edac_dram_ecc_isr(irq, mci, false);
> +
> +	/* If in the future there are more supported interrupts in a different
> +	 * platform, more condition statements can be added here for each
> +	 * interrupt flag, together with its corresponding isr implementations.
> +	 */

This comment above is useless.

Also, kernel comments style is:

	/*
	 * A sentence ending with a full-stop.
	 * Another sentence. ...
	 * More sentences. ...
	 */

> +
> +	return irq_ret;
> +}
> +
> +static void dmc520_init_csrow(struct mem_ctl_info *mci)
> +{
> +	struct csrow_info *csi;
> +	struct dimm_info *dimm;
> +	int row, ch;
> +	enum dev_type dt;
> +	enum mem_type mt;
> +	u64 rs;
> +	u32 pages_per_rank;
> +	struct dmc520_edac *edac = mci->pvt_info;
> +
> +	dt = dmc520_get_dtype(edac);
> +	mt = dmc520_get_mtype(edac);
> +	rs = dmc520_get_rank_size(edac);
> +	pages_per_rank = rs >> PAGE_SHIFT;
> +
> +	for (row = 0; row < mci->nr_csrows; row++) {
> +		csi = mci->csrows[row];
> +
> +		for (ch = 0; ch < csi->nr_channels; ch++) {
> +			dimm		= csi->channels[ch]->dimm;
> +			dimm->grain	= dmc520_get_memory_width(edac);
> +			dimm->dtype	= dt;
> +			dimm->mtype	= mt;
> +			dimm->edac_mode	= EDAC_FLAG_SECDED;
> +			dimm->nr_pages	= pages_per_rank / csi->nr_channels;
> +		}
> +	}
> +}
> +
> +static int dmc520_edac_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	struct dmc520_edac *edac;
> +	struct mem_ctl_info *mci;
> +	struct edac_mc_layer layers[1];
> +	int ret, intr_index, nintr, nintr_registered = 0;
> +	struct resource *res;
> +	void __iomem *reg_base;
> +	u32 reg_val;
> +
> +	/* Parsing the device node */
> +	dev = &pdev->dev;
> +
> +	nintr = of_property_count_u32_elems(dev->of_node, "interrupt-config");
> +	if (nintr <= 0) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			"Invalid device node configuration: at least one interrupt "
> +			"line & config is expected.\n");

More from checkpatch:

WARNING: quoted string split across lines
#528: FILE: drivers/edac/dmc520_edac.c:436:
+                       "Invalid device node configuration: at least one interrupt "
+                       "line & config is expected.\n");

WARNING: quoted string split across lines
#535: FILE: drivers/edac/dmc520_edac.c:443:
+                       "Invalid device node configuration: # of interrupt config "
+                       "elements (%d) can not exceed %ld.\n",

WARNING: quoted string split across lines
#579: FILE: drivers/edac/dmc520_edac.c:487:
+                               "interrupt-config error: "
+                               "element %d's interrupt mask %d has overlap.\n",

WARNING: quoted string split across lines
#590: FILE: drivers/edac/dmc520_edac.c:498:
+                       "interrupt-config warning: "
+                       "interrupt mask (0x%x) is not supported by dmc520 (0x%lx).\n",


> +		return -EINVAL;
> +	}
> +
> +	if (nintr > ARRAY_SIZE(dmc520_isr_array)) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			"Invalid device node configuration: # of interrupt config "
> +			"elements (%d) can not exceed %ld.\n",
> +			nintr, ARRAY_SIZE(dmc520_isr_array));
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
> +			    sizeof(struct dmc520_edac) + sizeof(u32) * nintr);
> +	if (!mci) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			    "Failed to allocate memory for mc instance\n");
> +		return -ENOMEM;
> +	}
> +
> +	edac = mci->pvt_info;
> +	edac->reg_base = reg_base;
> +	edac->nintr = nintr;
> +	edac->interrupt_mask_all = 0;
> +	spin_lock_init(&edac->ecc_lock);

Move that checking...

> +
> +	ret = of_property_read_u32_array(dev->of_node, "interrupt-config",
> +			edac->interrupt_masks, nintr);
> +	if (ret) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			"Failed to get interrupt-config arrays.\n");
> +		goto err_free_mc;
> +	}
> +
> +	for (intr_index = 0; intr_index < nintr; ++intr_index) {
> +		if (edac->interrupt_mask_all & edac->interrupt_masks[intr_index]) {
> +			edac_printk(KERN_ERR, EDAC_MC,
> +				"interrupt-config error: "
> +				"element %d's interrupt mask %d has overlap.\n",
> +				intr_index, edac->interrupt_masks[intr_index]);
> +			goto err_free_mc;
> +		}
> +
> +		edac->interrupt_mask_all |= edac->interrupt_masks[intr_index];
> +	}
> +
> +	if ((edac->interrupt_mask_all | ALL_INT_MASK) != ALL_INT_MASK) {
> +		edac_printk(KERN_WARNING, EDAC_MOD_NAME,
> +			"interrupt-config warning: "
> +			"interrupt mask (0x%x) is not supported by dmc520 (0x%lx).\n",
> +			edac->interrupt_mask_all, ALL_INT_MASK);
> +	}
> +	edac->interrupt_mask_all &= ALL_INT_MASK;
> +
> +	platform_set_drvdata(pdev, mci);

... up-to-here before the edac_mc_alloc() call so that you don't have to
needlessly goto err_free_mc and free the memory you just allocated if
any of those properties reading fails. IOW, do all your hw init first
and then call edac_mc_alloc(), when you have everything needed.

> +
> +	mci->pdev = dev;
> +	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
> +	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
> +	mci->edac_cap = EDAC_FLAG_SECDED;
> +	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
> +	mci->scrub_mode = dmc520_get_scrub_type(edac);
> +	mci->ctl_name = EDAC_CTL_NAME;
> +	mci->dev_name = dev_name(mci->pdev);
> +	mci->mod_name = EDAC_MOD_NAME;
> +	mci->ctl_page_to_phys = NULL;
> +
> +	edac_op_state = EDAC_OPSTATE_INT;
> +
> +	dmc520_init_csrow(mci);
> +
> +	ret = edac_mc_add_mc(mci);
> +	if (ret) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			"Failed to register with EDAC core\n");
> +		goto err_free_mc;
> +	}
> +
> +	/* Clear interrupts, not affecting other unrelated interrupts */
> +	reg_val = dmc520_read_reg(edac, REG_OFFSET_INTERRUPT_CONTROL);
> +	dmc520_write_reg(edac, reg_val & (~(edac->interrupt_mask_all)),
> +			REG_OFFSET_INTERRUPT_CONTROL);
> +	dmc520_write_reg(edac, edac->interrupt_mask_all,
> +			REG_OFFSET_INTERRUPT_CLR);
> +
> +	for (intr_index = 0; intr_index < nintr; ++intr_index) {
> +		int irq_id = platform_get_irq(pdev, intr_index);
> +
> +		if (irq_id < 0) {
> +			edac_printk(KERN_ERR, EDAC_MC,
> +				    "Failed to get irq #%d\n", intr_index);
> +			ret = -ENODEV;
> +			goto err_free_irq;
> +		}
> +
> +		ret = devm_request_irq(&pdev->dev, irq_id,
> +				dmc520_isr_array[intr_index], IRQF_SHARED,
> +				dev_name(&pdev->dev), mci);
> +		if (ret < 0) {
> +			edac_printk(KERN_ERR, EDAC_MC,
> +				    "Failed to request irq %d\n", irq_id);
> +			goto err_free_irq;
> +		}
> +
> +		++nintr_registered;
> +	}

The same with this IRQ requesting and you'll save yourself the err_free_irq too.

> +
> +	/* Reset DRAM CE/UE counters */
> +	if (edac->interrupt_mask_all & DRAM_ECC_INT_CE_BIT)
> +		dmc520_get_dram_ecc_error_count(edac, true);
> +
> +	if (edac->interrupt_mask_all & DRAM_ECC_INT_UE_BIT)
> +		dmc520_get_dram_ecc_error_count(edac, false);
> +
> +	/* Enable interrupts, not affecting other unrelated interrupts */
> +	dmc520_write_reg(edac,
> +		reg_val | edac->interrupt_mask_all,
> +		REG_OFFSET_INTERRUPT_CONTROL);

Align at opening brace:

	dmc520_write_reg(edac, reg_val | edac->interrupt_mask_all,
			 REG_OFFSET_INTERRUPT_CONTROL);

> +
> +	return 0;
> +
> +err_free_irq:
> +	for (intr_index = 0; intr_index < nintr_registered; ++intr_index) {
> +		int irq_id = platform_get_irq(pdev, intr_index);
> +
> +		devm_free_irq(&pdev->dev, irq_id, mci);
> +	}
> +	edac_mc_del_mc(&pdev->dev);
> +err_free_mc:
> +	edac_mc_free(mci);
> +
> +	return ret;
> +}
> +
> +static int dmc520_edac_remove(struct platform_device *pdev)
> +{
> +	struct dmc520_edac *edac;
> +	struct mem_ctl_info *mci;
> +	u32 reg_val, intr_index;
> +
> +	mci = platform_get_drvdata(pdev);
> +	edac = mci->pvt_info;
> +
> +	/* Disable interrupts */
> +	reg_val = dmc520_read_reg(edac, REG_OFFSET_INTERRUPT_CONTROL);
> +	dmc520_write_reg(edac, reg_val & (~(edac->interrupt_mask_all)),
> +			REG_OFFSET_INTERRUPT_CONTROL);
> +
> +	/* free irq's */
> +	for (intr_index = 0; intr_index < edac->nintr; ++intr_index) {
> +		int irq_id = platform_get_irq(pdev, intr_index);
> +
> +		devm_free_irq(&pdev->dev, irq_id, mci);
> +	}
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
> +MODULE_AUTHOR(

No linebreaks like that - let it stick out over 80 cols.

> +	"Rui Zhao <ruizhao@microsoft.com>, Lei Wang <lewan@microsoft.com>");
> +MODULE_DESCRIPTION("DMC-520 ECC driver");
> +MODULE_LICENSE("GPL v2");
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
