Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DA86550B3
	for <lists+linux-edac@lfdr.de>; Fri, 23 Dec 2022 14:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiLWNF3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Dec 2022 08:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbiLWNFY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Dec 2022 08:05:24 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0FD12D17;
        Fri, 23 Dec 2022 05:05:21 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C5BB1EC0716;
        Fri, 23 Dec 2022 14:05:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671800719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ci2S/KkDjHi/arFt0HZu7tRxbP/f+F0KF5JX6cAx0c0=;
        b=L2d1lSQdrZYqVjM+Jng06RLloh4Xb/MbJp/yQlrO84YBf7sHfvkTH+FgbmAhkIDNSRc0/A
        xPxc3taIfS8+W/Y/IYhZJ8ANoDKrTiwKrIaeCF/5JzH3sVfvUWPcVZnv3iQPBLwuq1Z6Wx
        jbzIEd7XIFmTENwD2L1GRHc8UXbuSRs=
Date:   Fri, 23 Dec 2022 14:05:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Marvin Lin <milkfafa@gmail.com>
Cc:     krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, benjaminfair@google.com, yuenn@google.com,
        venture@google.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        ctcchien@nuvoton.com, kflin@nuvoton.com
Subject: Re: [PATCH v17 3/3] EDAC/npcm: Add NPCM memory controller driver
Message-ID: <Y6WniKjA6BHLknP6@zn.tnic>
References: <20221223032859.3055638-1-milkfafa@gmail.com>
 <20221223032859.3055638-4-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221223032859.3055638-4-milkfafa@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Dec 23, 2022 at 11:28:59AM +0800, Marvin Lin wrote:
> +static void handle_ce(struct mem_ctl_info *mci)
> +{
> +	struct priv_data *priv = mci->pvt_info;
> +	const struct npcm_platform_data *pdata = priv->pdata;
> +	u64 addr = 0;
> +	u64 data = 0;
> +	u32 val_h = 0;
> +	u32 val_l, id, synd;

        u32 val_h = 0, val_l, id, synd;
        u64 addr = 0, data = 0;

Also, for all your functions:

The EDAC tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

> +	regmap_read(npcm_regmap, pdata->ctl_ce_addr_l, &val_l);
> +	if (pdata->chip == NPCM8XX_CHIP) {
> +		regmap_read(npcm_regmap, pdata->ctl_ce_addr_h, &val_h);
> +		val_h &= pdata->ce_addr_h_mask;
> +	}
> +	addr = ((addr | val_h) << 32) | val_l;
> +
> +	regmap_read(npcm_regmap, pdata->ctl_ce_data_l, &val_l);
> +	if (pdata->chip == NPCM8XX_CHIP)
> +		regmap_read(npcm_regmap, pdata->ctl_ce_data_h, &val_h);
> +	data = ((data | val_h) << 32) | val_l;
> +
> +	regmap_read(npcm_regmap, pdata->ctl_source_id, &id);
> +	id = (id & pdata->source_id_ce_mask) >> pdata->source_id_ce_shift;
> +
> +	regmap_read(npcm_regmap, pdata->ctl_ce_synd, &synd);
> +	synd = (synd & pdata->ce_synd_mask) >> pdata->ce_synd_shift;
> +
> +	snprintf(priv->message, EDAC_MSG_SIZE,
> +		 "addr = 0x%llx, data = 0x%llx, id = 0x%x", addr, data, id);
> +
> +	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1, addr >> PAGE_SHIFT,
> +			     addr & ~PAGE_MASK, synd, 0, 0, -1, priv->message,

No need for that linebreak with the trailing piece.

> +			     "");
> +}
> +
> +static void handle_ue(struct mem_ctl_info *mci)
> +{
> +	struct priv_data *priv = mci->pvt_info;
> +	const struct npcm_platform_data *pdata = priv->pdata;
> +	u64 addr = 0;
> +	u64 data = 0;
> +	u32 val_h = 0;
> +	u32 val_l, id, synd;

As above.

> +
> +	regmap_read(npcm_regmap, pdata->ctl_ue_addr_l, &val_l);
> +	if (pdata->chip == NPCM8XX_CHIP) {
> +		regmap_read(npcm_regmap, pdata->ctl_ue_addr_h, &val_h);
> +		val_h &= pdata->ue_addr_h_mask;
> +	}
> +	addr = ((addr | val_h) << 32) | val_l;
> +
> +	regmap_read(npcm_regmap, pdata->ctl_ue_data_l, &val_l);
> +	if (pdata->chip == NPCM8XX_CHIP)
> +		regmap_read(npcm_regmap, pdata->ctl_ue_data_h, &val_h);
> +	data = ((data | val_h) << 32) | val_l;
> +
> +	regmap_read(npcm_regmap, pdata->ctl_source_id, &id);
> +	id = (id & pdata->source_id_ue_mask) >> pdata->source_id_ue_shift;
> +
> +	regmap_read(npcm_regmap, pdata->ctl_ue_synd, &synd);
> +	synd = (synd & pdata->ue_synd_mask) >> pdata->ue_synd_shift;
> +
> +	snprintf(priv->message, EDAC_MSG_SIZE,
> +		 "addr = 0x%llx, data = 0x%llx, id = 0x%x", addr, data, id);
> +
> +	edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
> +			     addr >> PAGE_SHIFT, addr & ~PAGE_MASK, synd, 0, 0,
> +			     -1, priv->message, "");
> +}
> +
> +static irqreturn_t edac_ecc_isr(int irq, void *dev_id)
> +{
> +	struct mem_ctl_info *mci = dev_id;
> +	struct priv_data *priv = mci->pvt_info;
> +	const struct npcm_platform_data *pdata = priv->pdata;
> +	u32 status;
> +
> +	regmap_read(npcm_regmap, pdata->ctl_int_status, &status);
> +	if (status & pdata->int_status_ce_mask) {
> +		handle_ce(mci);
> +
> +		/* acknowledge the CE interrupt */
> +		regmap_write(npcm_regmap, pdata->ctl_int_ack,
> +			     pdata->int_ack_ce_mask);
> +		return IRQ_HANDLED;
> +	} else if (status & pdata->int_status_ue_mask) {
> +		handle_ue(mci);
> +
> +		/* acknowledge the UE interrupt */
> +		regmap_write(npcm_regmap, pdata->ctl_int_ack,
> +			     pdata->int_ack_ue_mask);
> +		return IRQ_HANDLED;
> +	}

	WARN_ON_ONCE(1);

to catch weird cases.

> +
> +	return IRQ_NONE;
> +}
> +
> +static ssize_t force_ecc_error(struct file *file, const char __user *data,
> +			       size_t count, loff_t *ppos)
> +{
> +	struct device *dev = file->private_data;
> +	struct mem_ctl_info *mci = to_mci(dev);
> +	struct priv_data *priv = mci->pvt_info;
> +	const struct npcm_platform_data *pdata = priv->pdata;
> +	int ret;
> +	u32 val, syndrome;
> +
> +	/*
> +	 * error_type - 0: CE, 1: UE
> +	 * location   - 0: data, 1: checkcode
> +	 * bit        - 0 ~ 63 for data and 0 ~ 7 for checkcode
> +	 */
> +	edac_printk(KERN_INFO, EDAC_MOD_NAME,
> +		    "force an ECC error, type = %d, location = %d, bit = %d\n",
> +		    priv->error_type, priv->location, priv->bit);
> +
> +	/* ensure no pending writes */
> +	ret = regmap_read_poll_timeout(npcm_regmap, pdata->ctl_controller_busy,
> +				       val, !(val & pdata->controller_busy_mask),
> +				       1000, 10000);
> +	if (ret) {
> +		edac_printk(KERN_INFO, EDAC_MOD_NAME,
> +			    "wait pending writes timeout\n");
> +		return count;
> +	}
> +
> +	regmap_read(npcm_regmap, pdata->ctl_xor_check_bits, &val);
> +	val &= ~pdata->xor_check_bits_mask;
> +
> +	/* write syndrome to XOR_CHECK_BITS */
> +	if (priv->error_type == 0) {

	if (priv->error_type == ERROR_TYPE_CORRECTABLE

Use defines. Below too.

> +		if (priv->location == 0 && priv->bit > 63) {


> +			edac_printk(KERN_INFO, EDAC_MOD_NAME,
> +				    "data bit should not exceed 63\n");

				"data bit should not exceed 63 (%d)\n", priv->bit...)

Below too.

> +			return count;
> +		}
> +
> +		if (priv->location == 1 && priv->bit > 7) {
> +			edac_printk(KERN_INFO, EDAC_MOD_NAME,
> +				    "checkcode bit should not exceed 7\n");
> +			return count;
> +		}
> +
> +		syndrome = priv->location ? 1 << priv->bit :
> +			   data_synd[priv->bit];

		syndrome = priv->location ? 1 << priv->bit
					  : data_synd[priv->bit];


> +		regmap_write(npcm_regmap, pdata->ctl_xor_check_bits,
> +			     val | (syndrome << pdata->xor_check_bits_shift) |
> +			     pdata->writeback_en_mask);
> +	} else if (priv->error_type == 1) {
> +		regmap_write(npcm_regmap, pdata->ctl_xor_check_bits,
> +			     val | (UE_SYNDROME << pdata->xor_check_bits_shift));
> +	}
> +
> +	/* force write check */
> +	regmap_update_bits(npcm_regmap, pdata->ctl_xor_check_bits,
> +			   pdata->fwc_mask, pdata->fwc_mask);
> +
> +	return count;
> +}
> +
> +static const struct file_operations force_ecc_error_fops = {
> +	.open = simple_open,
> +	.write = force_ecc_error,
> +	.llseek = generic_file_llseek,
> +};
> +

I'd find it helpful if there were a short recipe in a comment here
explaining how the injection should be done...

> +static void setup_debugfs(struct mem_ctl_info *mci)
> +{
> +	struct priv_data *priv = mci->pvt_info;
> +
> +	priv->debugfs = edac_debugfs_create_dir(mci->mod_name);
> +	if (!priv->debugfs)
> +		return;
> +
> +	edac_debugfs_create_x8("error_type", 0644, priv->debugfs,
> +			       &priv->error_type);
> +	edac_debugfs_create_x8("location", 0644, priv->debugfs,
> +			       &priv->location);
> +	edac_debugfs_create_x8("bit", 0644, priv->debugfs, &priv->bit);
> +	edac_debugfs_create_file("force_ecc_error", 0200, priv->debugfs,
> +				 &mci->dev, &force_ecc_error_fops);
> +}
> +
> +static int setup_irq(struct mem_ctl_info *mci, struct platform_device *pdev)
> +{
> +	struct priv_data *priv = mci->pvt_info;
> +	const struct npcm_platform_data *pdata = priv->pdata;
> +	int ret, irq;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME, "IRQ not defined in DTS\n");
> +		return irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq, edac_ecc_isr, 0,
> +			       dev_name(&pdev->dev), mci);
> +	if (ret < 0) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME, "failed to request IRQ\n");
> +		return ret;
> +	}
> +
> +	/* enable the functional group of ECC and mask the others */
> +	regmap_write(npcm_regmap, pdata->ctl_int_mask_master,
> +		     pdata->int_mask_master_non_ecc_mask);
> +
> +	if (pdata->chip == NPCM8XX_CHIP)
> +		regmap_write(npcm_regmap, pdata->ctl_int_mask_ecc,
> +			     pdata->int_mask_ecc_non_event_mask);
> +
> +	return 0;
> +}
> +
> +static const struct regmap_config npcm_regmap_cfg = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
> +};
> +
> +static int edac_probe(struct platform_device *pdev)
> +{
> +	const struct npcm_platform_data *pdata;
> +	struct device *dev = &pdev->dev;
> +	struct edac_mc_layer layers[1];
> +	struct mem_ctl_info *mci;
> +	struct priv_data *priv;
> +	void __iomem *reg;
> +	int rc;
> +	u32 val;
> +
> +	reg = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +
> +	npcm_regmap = devm_regmap_init_mmio(dev, reg, &npcm_regmap_cfg);
> +	if (IS_ERR(npcm_regmap))
> +		return PTR_ERR(npcm_regmap);
> +
> +	pdata = of_device_get_match_data(dev);
> +	if (!pdata)
> +		return -EINVAL;
> +
> +	/* bail out if ECC is not enabled */
> +	regmap_read(npcm_regmap, pdata->ctl_ecc_en, &val);
> +	if (!(val & pdata->ecc_en_mask)) {
> +		edac_printk(KERN_ERR, EDAC_MOD_NAME, "ECC is not enabled\n");
> +		return -EPERM;
> +	}
> +
> +	edac_op_state = EDAC_OPSTATE_INT;
> +
> +	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
> +	layers[0].size = 1;
> +
> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
> +			    sizeof(struct priv_data));
> +	if (!mci)
> +		return -ENOMEM;
> +
> +	mci->pdev = &pdev->dev;
> +	priv = mci->pvt_info;
> +	priv->reg = reg;
> +	priv->pdata = pdata;
> +	platform_set_drvdata(pdev, mci);
> +
> +	mci->mtype_cap = MEM_FLAG_DDR4;
> +	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
> +	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
> +	mci->scrub_mode = SCRUB_HW_SRC;
> +	mci->edac_cap = EDAC_FLAG_SECDED;
> +	mci->ctl_name = "npcm_ddr_controller";
> +	mci->dev_name = dev_name(&pdev->dev);
> +	mci->mod_name = EDAC_MOD_NAME;
> +	mci->ctl_page_to_phys = NULL;
> +
> +	rc = setup_irq(mci, pdev);
> +	if (rc)
> +		goto free_edac_mc;
> +
> +	rc = edac_mc_add_mc(mci);
> +	if (rc)
> +		goto free_edac_mc;
> +
> +	if (IS_ENABLED(CONFIG_EDAC_DEBUG) && pdata->chip == NPCM8XX_CHIP)
> +		setup_debugfs(mci);
> +
> +	return rc;
> +
> +free_edac_mc:
> +	edac_mc_free(mci);
> +	return rc;
> +}
> +
> +static int edac_remove(struct platform_device *pdev)
> +{
> +	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +	struct priv_data *priv = mci->pvt_info;
> +	const struct npcm_platform_data *pdata = priv->pdata;
> +
> +	regmap_write(npcm_regmap, pdata->ctl_int_mask_master,
> +		     pdata->int_mask_master_global_mask);
> +	regmap_update_bits(npcm_regmap, pdata->ctl_ecc_en, pdata->ecc_en_mask,
> +			   0);

You have a bunch of those things: the 80 cols rule is not a rigid and a
static one - you should rather apply common sense. As in:

Does it make sense to have this ugly linebreak with only the 0 argument there?

	regmap_update_bits(npcm_regmap, pdata->ctl_ecc_en, pdata->ecc_en_mask,
			   0);

or should I simply let it stick out:

	regmap_update_bits(npcm_regmap, pdata->ctl_ecc_en, pdata->ecc_en_mask, 0);

and have much more readable code?

Please apply common sense to all your linebreaks above.

> +
> +	edac_mc_del_mc(&pdev->dev);
> +	edac_mc_free(mci);

<--- What happens if someone tries to inject errors right at this
moment, when you've freed the mci?

Hint: you should destroy resources in the opposite order you've
allocated them.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
