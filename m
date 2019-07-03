Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 728A65E0D9
	for <lists+linux-edac@lfdr.de>; Wed,  3 Jul 2019 11:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfGCJS7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 Jul 2019 05:18:59 -0400
Received: from foss.arm.com ([217.140.110.172]:42242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfGCJS6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 3 Jul 2019 05:18:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A12DB344;
        Wed,  3 Jul 2019 02:18:57 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D23B3F246;
        Wed,  3 Jul 2019 02:18:56 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] EDAC: add EDAC driver for DMC520
To:     Lei Wang <leiwang_git@outlook.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     "bp@alien8.de" <bp@alien8.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        "ruizhao@microsoft.com" <ruizhao@microsoft.com>
References: <BN6PR04MB11075E9070EE1A263E099A7386E60@BN6PR04MB1107.namprd04.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <65439e51-5356-ae93-dffb-5a87279f6c8b@arm.com>
Date:   Wed, 3 Jul 2019 10:18:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BN6PR04MB11075E9070EE1A263E099A7386E60@BN6PR04MB1107.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi!

On 22/06/2019 07:38, Lei Wang wrote:
> New driver supports error detection and correction on the devices with ARM
> DMC-520 memory controller.

> diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
> new file mode 100644
> index 000000000000..c23734c13933
> --- /dev/null
> +++ b/drivers/edac/dmc520_edac.c
> @@ -0,0 +1,604 @@

> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/edac.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/interrupt.h>
> +#include <linux/bitfield.h>

#include <linux/spinlock.h> ?

It's best to keep this list sorted, it makes it easier for the maintainer to resolve
conflicts when header files get split/moved-around.

> +#include "edac_mc.h"

[...]

> +#define REG_OFFSET_FEATURE_CONTROL_NEXT		0x1F0

Nothing uses this, do we need it?

[...]

> +#define REG_OFFSET_DECODE_CONTROL_NOW		0x1014

Nothing uses this, do we need it?
[...]

> +/* DMC-520 types, masks and bitfields */
> +#define DRAM_ECC_INT_CE_MASK			BIT(2)
> +#define DRAM_ECC_INT_UE_MASK			BIT(3)

(The 'MASK' suffix isn't really needed for a single bit, you can't confuse it with the value.)

[...]

> +#define SCRUB_CONTROL_MASK			GENMASK(1, 0)

Isn't this field called TRIGGER0_NEXT? It would be good to use the names from the
datasheet[0] as it makes it much easier for someone else to debug.


> +#define DMC520_EDAC_ERR_GRAIN			1

> +#define DMC520_BUS_WIDTH	8  /* Data bus width is 64bits/8Bytes */

Can you point me to where this comes from in the datasheet[0]?
I see it talk in "1.3 Features" of "either a 32-bit wide data SDRAM interface or a 64-bit
wide data SDRAM interface".

If this is a choice that was made on your platform it needs to be described in the DT.

(I may be confused between SDRAM/DDR/DRAM, as 2.3.3. "PHY interface" seems to describe one
connecting to the other.)



> +/* memory type */
> +enum dmc520_mem_type {
> +	mem_type_ddr3 = 1,
> +	mem_type_ddr4 = 2
> +};
> +
> +/* memory device width */
> +enum dmc520_dev_width {
> +	dev_width_x4 = 0,
> +	dev_width_x8 = 1,
> +	dev_width_x16 = 2
> +};

(Nit: the convention for enums members is all-caps. e.g. include/linux/edac.h)

[...]

> +static irqreturn_t
> +dmc520_edac_dram_all_isr(int irq, void *data, u32 interrupt_mask);

(You could avoid this by moving the user after definition of this function)

[...]

> +static bool dmc520_get_dram_ecc_error_info(struct dmc520_edac *edac,
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

> +	if (valid) {
> +		info->col = FIELD_GET(REG_FIELD_ERR_INFO_LOW_COL, reg_val_low);
> +		info->row = FIELD_GET(REG_FIELD_ERR_INFO_LOW_ROW, reg_val_low);
> +		info->rank = FIELD_GET(REG_FIELD_ERR_INFO_LOW_RANK, reg_val_low);
> +		info->bank = FIELD_GET(REG_FIELD_ERR_INFO_HIGH_BANK, reg_val_high);
> +	} else {
> +		memset(info, 0, sizeof(struct ecc_error_info));
> +	}

> +	return valid;

Nothing checks this return value.

> +}

> +static bool dmc520_get_scrub_type(struct dmc520_edac *edac)

This function returns enum scrub_type, not bool.

> +{
> +	enum scrub_type type = SCRUB_NONE;
> +	u32 reg_val, scrub_cfg;
> +
> +	reg_val = dmc520_read_reg(edac, REG_OFFSET_SCRUB_CONTROL0_NOW);
> +	scrub_cfg = FIELD_GET(SCRUB_CONTROL_MASK, reg_val);
> +
> +	if (DMC520_SCRUB_TRIGGER_ERR_DETECT == scrub_cfg ||
> +		DMC520_SCRUB_TRIGGER_IDLE == scrub_cfg)
> +		type = SCRUB_HW_PROG;
> +
> +	return type;
> +}


> +static void dmc520_handle_dram_ecc_errors(struct mem_ctl_info *mci,
> +					  bool is_ce)
> +{
> +	struct ecc_error_info info;
> +	struct dmc520_edac *edac;
> +	u32 cnt;
> +	char message[EDAC_MSG_BUF_SIZE];
> +	unsigned long flags;
> +
> +	edac = mci->pvt_info;
> +	dmc520_get_dram_ecc_error_info(edac, is_ce, &info);
> +
> +	cnt = dmc520_get_dram_ecc_error_count(edac, is_ce);
> +
> +	if (cnt > 0) {
> +		snprintf(message, ARRAY_SIZE(message),
> +			 "rank:%d bank:%d row:%d col:%d",
> +			 info.rank, info.bank,
> +			 info.row, info.col);
> +
> +		spin_lock_irqsave(&edac->ecc_lock, flags);

irqsave/irqrestore is overkill as this function is only called from an interrupt handler.
There is no way for this to be called with interrupts unmasked.


> +		edac_mc_handle_error((is_ce ? HW_EVENT_ERR_CORRECTED :
> +				     HW_EVENT_ERR_UNCORRECTED),
> +				     mci, cnt, 0, 0, 0, info.rank, -1, -1,
> +				     message, "");
> +		spin_unlock_irqrestore(&edac->ecc_lock, flags);
> +	}
> +}
> +
> +static irqreturn_t dmc520_edac_dram_ecc_isr(int irq, void *data, bool is_ce)

data here could be struct mem_ctl_info *, as it only has one caller.

> +{
> +	u32 i_mask;
> +	struct mem_ctl_info *mci;
> +	struct dmc520_edac *edac;
> +
> +	mci = data;
> +	edac = mci->pvt_info;
> +
> +	i_mask = is_ce ? DRAM_ECC_INT_CE_MASK : DRAM_ECC_INT_UE_MASK;

(The mask/bit here could be passed in directly, its the value you need most often)


> +	dmc520_handle_dram_ecc_errors(mci, is_ce);
> +
> +	dmc520_write_reg(edac, i_mask, REG_OFFSET_INTERRUPT_CLR);
> +
> +	return IRQ_HANDLED;
> +}

[...]


> +static int dmc520_edac_probe(struct platform_device *pdev)
> +{

[...]

> +	if (nintr > ARRAY_SIZE(dmc520_isr_array)) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			"Invalid device node configuration: # of interrupt config "
> +			"elements (%d) can not exeed %ld.\n",

(Nit: exceed)

> +			nintr, ARRAY_SIZE(dmc520_isr_array));
> +		return -EINVAL;
> +	}

[...]

> +	ret = of_property_read_u32_array(dev->of_node, "interrupt-config",
> +			edac->interrupt_masks, nintr);
> +	if (ret) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			"Failed to get interrupt-config arrays.\n");
> +		goto err_free_mc;
> +	}

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

Ah, so the driver doesn't support overlapping masks... but wasn't this the reason for
describing the interrupts with these masks in the first place?
(It looks like the DT-folk want this as named interrupts)

lore.kernel.org/r/BYAPR21MB1319BC4D079B918AB038A4D590010@BYAPR21MB1319.namprd21.prod.outlook.com

Would this driver support the configuration you gave there?


> +	edac->interrupt_mask_all &= ALL_INT_MASK;

This is to removed invalid interrupt fields? Shouldn't we print a warning instead? Either
the DT is invalid, or its some future hardware that has an extra interrupt that this
driver won't enable.


[...]

> +	/* Clear interrupts */
> +	reg_val = dmc520_read_reg(edac, REG_OFFSET_INTERRUPT_CONTROL);
> +	dmc520_write_reg(edac, reg_val & (~(edac->interrupt_mask_all)),
> +			REG_OFFSET_INTERRUPT_CONTROL);
> +	dmc520_write_reg(edac, edac->interrupt_mask_all, REG_OFFSET_INTERRUPT_CLR);

[...]

> +	/* Enable interrupts */
> +	dmc520_write_reg(edac, edac->interrupt_mask_all, REG_OFFSET_INTERRUPT_CONTROL);

Won't this disable any interrupts we weren't told about? You did a read-modify write
above. Can we do the same here?


> +	return 0;
> +
> +err_free_irq:
> +	for (intr_index = 0; intr_index < nintr_registered; ++intr_index) {
> +		int irq_id = platform_get_irq(pdev, intr_index);
> +		devm_free_irq(&pdev->dev, irq_id, mci);
> +	}
> +	edac_mc_del_mc(&pdev->dev);
> +err_free_mc:
> +	edac_mc_free(mci);
> +
> +	return ret;
> +}
> +

[...]

> +static const struct of_device_id dmc520_edac_driver_id[] = {
> +	{ .compatible = "brcm,dmc-520", },
> +	{ .compatible = "arm,dmc-520", },

You should only need the "arm,dmc-520" entry here. The additional compatible values are
for quirking the driver when integration issues are discovered.
The 'brcm' version should be in the DT from day-one, but the kernel only needs to pick it
up when it needs to treat the brcm version differently.


> +	{ /* end of table */ }
> +};


With the bool/enum and interrupt-disabling things fixed:
Reviewed-by: James Morse <james.morse@arm.com>



Thanks,

James

[0] https://static.docs.arm.com/100000/0200/corelink_dmc520_trm_100000_0200_01_en.pdf
