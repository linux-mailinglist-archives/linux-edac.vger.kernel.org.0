Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A803283AD
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2019 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbfEWQbz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 May 2019 12:31:55 -0400
Received: from foss.arm.com ([217.140.101.70]:50454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730904AbfEWQbz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 May 2019 12:31:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4D41341;
        Thu, 23 May 2019 09:31:54 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D470D3F5AF;
        Thu, 23 May 2019 09:31:52 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] EDAC: add EDAC driver for DMC520
To:     Lei Wang <leiwang_git@outlook.com>
Cc:     "bp@alien8.de" <bp@alien8.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        Rui Zhao <ruizhao@outlook.com>,
        Rui Zhao <ruizhao@microsoft.com>
References: <CY1PR0401MB1244FDD9E720C9D9C1F41FEE860A0@CY1PR0401MB1244.namprd04.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <b1e360bc-2329-3f8b-3c93-65380f62d6fd@arm.com>
Date:   Thu, 23 May 2019 17:31:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CY1PR0401MB1244FDD9E720C9D9C1F41FEE860A0@CY1PR0401MB1244.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Lei,

(CC: +Rui Zhao)

On 16/05/2019 03:55, Lei Wang wrote:
> New driver supports error detection and correction on the devices with ARM DMC-520 memory controller.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7d1246b..23894ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5573,6 +5573,12 @@ F:	Documentation/driver-api/edac.rst
>  F:	drivers/edac/
>  F:	include/linux/edac.h
>  
> +EDAC-DMC520
> +M:	Rui Zhao <ruizhao@microsoft.com>
> +L:	linux-edac@vger.kernel.org
> +S:	Supported
> +F:	drivers/edac/dmc520_edac.c

Hmm, you're listing someone else as maintainer of this driver.
I think we'd need to see an Ack from Rui Zhao...

This patch was previously posted by Rui Zhao, this version has your changes and you as
author. (But how you arrange the attribution is up to the two of you...)


> diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
> new file mode 100644
> index 0000000..c81bfcc
> --- /dev/null
> +++ b/drivers/edac/dmc520_edac.c

> +static irqreturn_t dmc520_edac_dram_all_isr(int irq, void *data, u32 interrupt_mask);
> +
> +#define DECLARE_ISR(index) \
> +static irqreturn_t dmc520_isr_##index (int irq, void *data) \
> +{ \
> +	struct mem_ctl_info *mci; \
> +	struct dmc520_edac *edac; \
> +	mci = data; \
> +	edac = mci->pvt_info; \
> +	return dmc520_edac_dram_all_isr(irq, data, edac->interrupt_masks[index]); \
> +}
> +
> +DECLARE_ISR(0)
> +DECLARE_ISR(1)

(Generating functions like this makes them hard to find when they appear in a backtrace)


> +/* More DECLARE_ISR(index) can be added to support more interrupt lines. */
> +
> +irq_handler_t dmc520_isr_array[] = {
> +	dmc520_isr_0,
> +	dmc520_isr_1
> +	/* More dmc520_isr_index can be added to support more interrupt lines. */
> +};

(I'd prefer it if this allocated memory for a 'struct edac_dmc520_interrupt' that held the
interrupt_mask and mci pointer. This would be runtime-allocation of memory, instead of
compile-time generation of these templates... But its just a matter of taste, and this works.)


> +static u32 dmc520_get_dram_ecc_error_count(struct dmc520_edac *edac,
> +					   bool is_ce)
> +{
> +	u32 reg_offset_low, reg_offset_high;
> +	u32 err_low, err_high;
> +	u32 ce_count;
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
> +	ce_count = dmc520_calc_dram_ecc_error(err_low) +
> +		   dmc520_calc_dram_ecc_error(err_high);

(Nit: its a little odd to call this 'ce_count' when !is_ce)


> +
> +	return ce_count;
> +}
> +
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
> +
> +	if (info) {

This has one caller, which passes info as &info. You don't need to test for NULL here.


> +		if (valid) {
> +			info->col = FIELD_GET(REG_FIELD_ERR_INFO_LOW_COL,
> +					      reg_val_low);
> +			info->row = FIELD_GET(REG_FIELD_ERR_INFO_LOW_ROW,
> +					      reg_val_low);
> +			info->rank = FIELD_GET(REG_FIELD_ERR_INFO_LOW_RANK,
> +					       reg_val_low);
> +			info->bank = FIELD_GET(REG_FIELD_ERR_INFO_HIGH_BANK,
> +					       reg_val_high);
> +		} else {
> +			memset(info, 0, sizeof(struct ecc_error_info));
> +		}
> +	}
> +
> +	return valid;


> +static bool dmc520_is_scrub_configured(struct dmc520_edac *edac)
> +{
> +	int chan;
> +	u32 scrub_control_offsets[] = {
> +		REG_OFFSET_SCRUB_CONTROL0_NOW,
> +		REG_OFFSET_SCRUB_CONTROL1_NOW,
> +		REG_OFFSET_SCRUB_CONTROL2_NOW,
> +		REG_OFFSET_SCRUB_CONTROL3_NOW,
> +		REG_OFFSET_SCRUB_CONTROL4_NOW,
> +		REG_OFFSET_SCRUB_CONTROL5_NOW,
> +		REG_OFFSET_SCRUB_CONTROL6_NOW,
> +		REG_OFFSET_SCRUB_CONTROL7_NOW
> +	};
> +
> +	for (chan = 0; chan < ARRAY_SIZE(scrub_control_offsets); chan++) {
> +		u32 val = dmc520_read_reg(edac, scrub_control_offsets[chan]);
> +		if ((val & SCRUB_CONTROL_MASK) != 0)

| #define SCRUB_CONTROL_MASK			GENMASK(12, 0)

So if any of the bottom twelve bits in this register are set, scrubbing is enabled?

3.3.245 scrub_control0_now of [0] has reserved/unused bits in there, they could be
set/clear based on something else...

Can we use the mask to test the trigger0_now field, as that looks most likely:
I think 'err_detect' and 'idle' are the two modes we know will work. 'activate' and 'none'
(cough: irq), would require something else in the system to be triggering the scrub...


> +			return true;
> +	}
> +
> +	return false;
> +}


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
> +	return (u64)DMC520_BUS_WIDTH << (col_bits + row_bits + bank_bits);
> +}

Should the device_width returned by dmc520_get_dtype() be relevant here?
(has it been hardcoded as DMC520_BUS_WIDTH for your platform?)


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
> +		snprintf(message, ARRAY_SIZE(message),
> +			 "rank:%d bank:%d row:%d col:%d",
> +			 info.rank, info.bank,
> +			 info.row, info.col);
> +
> +		edac_mc_handle_error((is_ce ? HW_EVENT_ERR_CORRECTED :
> +				     HW_EVENT_ERR_UNCORRECTED),
> +				     mci, cnt, 0, 0, 0, info.rank, -1, -1,
> +				     message, "");

Because you have multiple interrupts, you can be calling edac_mc_handle_error() in
parallel on different CPUs, for the same mci.

edac_mc_handle_error() packs all these arguments into mci->error_desc, so two CPUs will
stomp over each other's values.

Please add a spinlock in 'struct dmc520_edac' to prevent this.


> +	}
> +}
> +
> +static irqreturn_t dmc520_edac_dram_ecc_isr(int irq, void *data, bool is_ce)
> +{
> +	u32 i_mask, status;
> +	struct mem_ctl_info *mci;
> +	struct dmc520_edac *edac;
> +
> +	mci = data;
> +	edac = mci->pvt_info;
> +

> +	i_mask = is_ce ? DRAM_ECC_INT_CE_MASK : DRAM_ECC_INT_UE_MASK;

> +	status = dmc520_read_reg(edac, REG_OFFSET_INTERRUPT_STATUS);

What do you need this for? The caller just read status.
Leftover code from v2?


> +	dmc520_handle_dram_ecc_errors(mci, is_ce);
> +
> +	dmc520_write_reg(edac, i_mask, REG_OFFSET_INTERRUPT_CLR);
> +
> +	return IRQ_HANDLED;
> +}


> +static irqreturn_t dmc520_edac_dram_ce_isr(int irq, void *data)
> +{
> +	return dmc520_edac_dram_ecc_isr(irq, data, true);
> +}
> +
> +static irqreturn_t dmc520_edac_dram_ue_isr(int irq, void *data)
> +{
> +	return dmc520_edac_dram_ecc_isr(irq, data, false);
> +}

Nit: These two one-liners each only have one caller, are they really needed?
(If you're doing this for readability you could create an enum for UE/CE to name the
true/false values passed to dmc520_edac_dram_ecc_isr()).


> +static int dmc520_edac_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	struct dmc520_edac *edac;
> +	struct mem_ctl_info *mci;
> +	struct edac_mc_layer layers[1];
> +	int ret, irq, nintr;
> +	struct resource *res;
> +	void __iomem *reg_base;
> +	u32 interrupt_masks[DMC520_MAX_INTERRUPT_LINES] = {0};
> +	u32 interrupt_mask_all = 0;
> +
> +	/* Parsing the device node */
> +	dev = &pdev->dev;
> +	if (!dev->of_node) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			"Invalid device node in device tree.\n");
> +		return -EINVAL;
> +	}

Can this happen? Surely the node must exist if we matched a compatible.


> +	nintr = of_property_count_u32_elems(dev->of_node, "interrupt-config");
> +	if (nintr <= 0) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			"Invalid device node configuration: at least one interrupt line & config is expected.\n");
> +		return -EINVAL;
> +	}
> +
> +	edac_printk(KERN_INFO, EDAC_MOD_NAME,
> +		"Interrupt lines: %d.\n",
> +		nintr);

Leftover debug? I think drivers should stay quiet until something goes wrong.


> +	ret = of_property_read_u32_array(dev->of_node,
> +									 "interrupt-config",
> +									 interrupt_masks,
> +									 nintr);

What happened to the whitespace here?

Wasn't the point of calculating the size of nintr first so that you could check it would
fit in interrupt_masks? If its greater than DMC520_MAX_INTERRUPT_LINES, you overflow here
because you told of_property_read_u32_array() there is enough space.

If you juggled the order, you could probably read it into edac->interrupt_masks directly
once its allocated.


> +	if (ret) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME,
> +			"Failed to get interrupt-config arrays.\n");
> +		return ret;
> +	}
> +
> +	/* Initialize dmc520 edac */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(reg_base))
> +		return PTR_ERR(reg_base);
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
> +	memcpy(edac->interrupt_masks, interrupt_masks, sizeof(u32) * nintr);


> +	if (!dmc520_is_ecc_enabled(edac)) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME, "ECC not enabled\n");

(Do we need to print this? Its going to be perfectly normal on some platforms.)


> +		ret = -ENXIO;
> +		goto err_free_mc;
> +	}

(If dmc520_is_ecc_enabled() took reg_base like dmc520_get_rank_count() does, you could
avoid the edac_mc_alloc()/edac_mc_free() if this driver isn't needed).


> +	platform_set_drvdata(pdev, mci);
> +
> +	mci->pdev = dev;
> +	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
> +	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
> +	mci->edac_cap = EDAC_FLAG_SECDED;
> +	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
> +	mci->scrub_mode = dmc520_is_scrub_configured(edac) ?
> +			  SCRUB_HW_SRC : SCRUB_NONE;
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
> +	/* Clear interrupts */
> +	dmc520_write_reg(edac, 0, REG_OFFSET_INTERRUPT_CONTROL);

Could we read-modify-write this, for the interrupts we know about.
If there is an enabled 'temperature_event_int' we weren't told about, we just disabled it.

You could generate 'interrupt_mask_all' for the interrupts we're taking ownership of
earlier and use that here.

(admittedly this would be the platforms problem for giving linux access to this in the
first place!)


> +	dmc520_write_reg(edac, ALL_INT_MASK, REG_OFFSET_INTERRUPT_CLR);

Again, could we only clear the interrupts we're going to be using?


> +	for (irq = 0; irq < nintr; ++irq) {

Nit: could we keep the variable name 'irq' reserved for a variable that is the irq number?
This is the index in the firwmare tables...


> +		int irq_id = platform_get_irq(pdev, irq);
> +
> +		if (irq_id < 0) {
> +			edac_printk(KERN_ERR, EDAC_MC,
> +				    "Failed to get irq #%d\n", irq);
> +			ret = -ENODEV;
> +			goto err_del_mc;
> +		}
> +
> +		ret = devm_request_irq(&pdev->dev,
> +				       irq_id,
> +				       dmc520_isr_array[irq],
> +				       IRQF_SHARED,
> +				       dev_name(&pdev->dev),
> +				       mci);

Coding-style would like this on fewer lines.


> +		if (ret < 0) {
> +			edac_printk(KERN_ERR, EDAC_MC,
> +				    "Failed to request irq %d\n", irq_id);
> +			goto err_del_mc;
> +		}

> +		edac_printk(KERN_INFO, EDAC_MOD_NAME,
> +			"Interrupt line #%d, mask 0x%x, allocated irq_id %d.\n",
> +			irq, interrupt_masks[irq], irq_id);

Leftover debug?


> +		interrupt_mask_all |= interrupt_masks[irq];

Could we check the masks don't overlap? If these are level-triggered interrupts sampled
twice, we don't want two interrupt handlers trying to access the same registers...


> +	}
> +
> +	interrupt_mask_all &= ALL_INT_MASK;
> +
> +	/* Reset DRAM CE/UE counters */
> +	if (interrupt_mask_all & DRAM_ECC_INT_CE_MASK)
> +		dmc520_get_dram_ecc_error_count(edac, true);
> +
> +	if (interrupt_mask_all & DRAM_ECC_INT_UE_MASK)
> +		dmc520_get_dram_ecc_error_count(edac, false);
> +
> +	/* Enable interrupts */
> +	dmc520_write_reg(edac, interrupt_mask_all, REG_OFFSET_INTERRUPT_CONTROL);
> +
> +	return 0;
> +
> +err_del_mc:
> +	edac_mc_del_mc(&pdev->dev);
> +err_free_mc:
> +	edac_mc_free(mci);
> +
> +	return ret;
> +}


> +static int dmc520_edac_remove(struct platform_device *pdev)
> +{
> +	struct dmc520_edac *edac;
> +	struct mem_ctl_info *mci;
> +
> +	mci = platform_get_drvdata(pdev);
> +	edac = mci->pvt_info;
> +
> +	/* Disable interrupts */
> +	dmc520_write_reg(edac, 0, REG_OFFSET_INTERRUPT_CONTROL);

Could we only disable the interrupts we know about?

This stops the hardware generating new ones, but there my be one in-progress on another
CPU. Do you need to unregister them too? Otherwise you are freeing data structures the irq
hadnler may be using!


> +	edac_mc_del_mc(&pdev->dev);
> +	edac_mc_free(mci);
> +
> +	return 0;
> +}


Thanks,

James

[0] https://static.docs.arm.com/100000/0200/corelink_dmc520_trm_100000_0200_01_en.pdf
