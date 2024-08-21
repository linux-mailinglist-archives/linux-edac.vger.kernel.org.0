Return-Path: <linux-edac+bounces-1711-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA88295973D
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 11:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2796F28104E
	for <lists+linux-edac@lfdr.de>; Wed, 21 Aug 2024 09:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F491ACDFD;
	Wed, 21 Aug 2024 08:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOmYCkbe"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBFC1B3B14;
	Wed, 21 Aug 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228658; cv=none; b=QYBNRHDVI8bN/rLo6Lq5clQfGPTDj+HYxmK/pyNBnQpIN495Ls81HvQ7X8hWC7WettrbvG9yLXiD/GcbERZxD3z6zp7HV+iXszRJFf47o2trTPJqHsCKL+WANkOasm4qv7032eNzVhDPoCXQEfiXBfRd90U6kd+NkjyyRQ+MowQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228658; c=relaxed/simple;
	bh=193S5yUTNX6z575L8AiMh2Frj7BOFYNe0j58eTMe0ns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvXDtGglTCMuJRC9vqeZh9lm022BKqxU7TCx3D8cLrb9grycWSs//NWZCMwsIUEwKskMT/BEYjxRtOeUlbODAdJroftHRnO6tpc8E4Csdo5TIjsg1UJcczGXJjg95QO32P2xMj+ljoD7vVh0asKHNedhAaC2COaOk+7SDb6kBBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOmYCkbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EA2C32782;
	Wed, 21 Aug 2024 08:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724228657;
	bh=193S5yUTNX6z575L8AiMh2Frj7BOFYNe0j58eTMe0ns=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eOmYCkbekE8TDnXY7tJ63g8hozNAivgXyv8Qg+XW9917iPkq4X+DiZtH0sGJvJ1rH
	 Oi0WeMxs7gg0GbCcf68A3InCa7kqXjJ7wKDBaYF9I2iM5tecdrMcgS2kBRHVvgnatU
	 spvPbhzOgvr6YDFkiqd9k2/WjJ+i9zFX3KgpHMWKR0YO5wbcoa69+R7dbhhiOZ2Roa
	 Z9BpGb6wj+rWuXqAX+sjsuzPDEd01x3ywe9NUiTGuCfJderp8ezzWgSEMP60TRNujQ
	 uvFyBKj43CmnF5Dz/OBaIdFWwgkAwdUhZ8fQ2qVpg7Kg3cCTmsQtz0HTcyyHLsYyVx
	 dCNCFRa5yHDXA==
Message-ID: <2e7daf48-b09d-4336-af3a-af5233eab769@kernel.org>
Date: Wed, 21 Aug 2024 10:24:09 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Loongarch: EDAC driver for loongson memory
 controller
To: Zhao Qunqin <zhaoqunqin@loongson.cn>, chenhuacai@kernel.org,
 kernel@xen0n.name, bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
 mchehab@kernel.org, rric@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, devicetree@vger.kernel.org
References: <20240821064728.8642-1-zhaoqunqin@loongson.cn>
 <20240821064728.8642-2-zhaoqunqin@loongson.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240821064728.8642-2-zhaoqunqin@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2024 08:47, Zhao Qunqin wrote:
> From: zhaoqunqin <zhaoqunqin@loongson.cn>
> 
> Report single bit errors (CE) only
> 
> Signed-off-by: zhaoqunqin <zhaoqunqin@loongson.cn>
> ---
>  arch/loongarch/Kconfig       |   2 +
>  drivers/edac/Kconfig         |  10 ++
>  drivers/edac/Makefile        |   1 +
>  drivers/edac/loongson_edac.c | 208 +++++++++++++++++++++++++++++++++++
>  4 files changed, 221 insertions(+)
>  create mode 100644 drivers/edac/loongson_edac.c
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index ddc042895..59d47053f 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -179,6 +179,8 @@ config LOONGARCH
>  	select PCI_QUIRKS
>  	select PERF_USE_VMALLOC
>  	select RTC_LIB
> +	select EDAC_SUPPORT
> +	select EDAC

Nope, you should not select user-visible sumbols.

>  	select SPARSE_IRQ
>  	select SYSCTL_ARCH_UNALIGN_ALLOW
>  	select SYSCTL_ARCH_UNALIGN_NO_WARN
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 16c8de505..60b1997f0 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -573,5 +573,15 @@ config EDAC_VERSAL
>  	  Support injecting both correctable and uncorrectable errors
>  	  for debugging purposes.
>  
> +config EDAC_LOONGSON
> +	tristate "Loongson EDAC"
> +	depends on LOONGARCH

Missing compile test

> +	default m
> +	help
> +	  Support for error detection and correction on the loongson memory
> +	  controller.
> +
> +	  Report single bit errors (CE) only.
> +

Why double line? Drop

>  
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 4edfb83ff..d6f2cfe7e 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -89,3 +89,4 @@ obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
>  obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
>  obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
>  obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
> +obj-$(CONFIG_EDAC_LOONGSON)		+= loongson_edac.o
> diff --git a/drivers/edac/loongson_edac.c b/drivers/edac/loongson_edac.c
> new file mode 100644
> index 000000000..c639c11ed
> --- /dev/null
> +++ b/drivers/edac/loongson_edac.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Loongson Technology Corporation Limited.
> + */
> +
> +#include <linux/edac.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +
> +#include "edac_module.h"
> +
> +enum ecc_index {
> +	ECC_SET = 0,
> +	ECC_RESERVED,
> +	ECC_COUNT,
> +	ECC_CS_COUNT,
> +	ECC_CODE,
> +	ECC_ADDR,
> +	ECC_DATA0,
> +	ECC_DATA1,
> +	ECC_DATA2,
> +	ECC_DATA3,
> +};
> +
> +static long idx;

Drop, racy and useless. If you need ID, then use IDR but first explain
what purpose does it serve.

> +
> +struct loongson_edac_pvt {
> +	volatile u64 *ecc_base;
> +	int last_ce_count;
> +};
> +
> +static void loongson_update_ce_count(struct mem_ctl_info *mci,
> +					int chan,
> +					int new)
> +{
> +	int add;
> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
> +
> +	add = new - pvt->last_ce_count;
> +
> +	/* Store the new values */
> +	pvt->last_ce_count = new;
> +
> +	/* device resume or any other exceptions*/
> +	if (add < 0)
> +		return;
> +
> +	/*updated the edac core */
> +	if (add != 0) {
> +		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, add,
> +					0, 0, 0,
> +					chan, 0, -1, "error", "");
> +		edac_mc_printk(mci, KERN_INFO, "add: %d", add);
> +	}
> +}
> +
> +static int loongson_read_ecc(struct mem_ctl_info *mci)
> +{
> +	u64 ecc;
> +	int cs = 0;
> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
> +
> +	if (!pvt->ecc_base)
> +		return pvt->last_ce_count;
> +
> +	ecc = pvt->ecc_base[ECC_CS_COUNT];
> +	cs += ecc & 0xff;		// cs0
> +	cs += (ecc >> 8) & 0xff;	// cs1
> +	cs += (ecc >> 16) & 0xff;	// cs2
> +	cs += (ecc >> 24) & 0xff;	// cs3
> +
> +	return cs;
> +}
> +
> +static void loongson_edac_check(struct mem_ctl_info *mci)
> +{
> +	loongson_update_ce_count(mci, 0, loongson_read_ecc(mci));
> +}
> +
> +static int get_dimm_config(struct mem_ctl_info *mci)
> +{
> +	u32 size, npages;
> +	struct dimm_info *dimm;
> +
> +	/* size not used */
> +	size = -1;
> +	npages = MiB_TO_PAGES(size);
> +
> +	dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
> +			0, 0, 0);
> +	dimm->nr_pages = npages;
> +	snprintf(dimm->label, sizeof(dimm->label),
> +			"MC#%uChannel#%u_DIMM#%u",
> +			mci->mc_idx, 0, 0);
> +	dimm->grain = 8;
> +
> +	return 0;
> +}
> +
> +static void loongson_pvt_init(struct mem_ctl_info *mci, u64 *vbase)
> +{
> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
> +
> +	pvt->ecc_base = vbase;
> +	pvt->last_ce_count = loongson_read_ecc(mci);
> +}
> +
> +static int loongson_edac_probe(struct platform_device *pdev)
> +{
> +	struct resource *rs;
> +	struct mem_ctl_info *mci;
> +	struct edac_mc_layer layers[2];
> +	struct loongson_edac_pvt *pvt;
> +	u64 *vbase = NULL;
> +
> +	rs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!rs)
> +		return -EINVAL;
> +	if (rs->start) {
> +		vbase = devm_ioremap(&pdev->dev, rs->start, resource_size(rs));

Why you cannot use wrapper over these two calls - devm_ioremap_resource?

> +		if (!vbase)
> +			return -ENOMEM;
> +	}
> +
> +	/* allocate a new MC control structure */
> +	layers[0].type = EDAC_MC_LAYER_CHANNEL;
> +	layers[0].size = 1;
> +	layers[0].is_virt_csrow = false;
> +	layers[1].type = EDAC_MC_LAYER_SLOT;
> +	layers[1].size = 1;
> +	layers[1].is_virt_csrow = true;
> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt));
> +	if (mci == NULL)
> +		return -ENOMEM;
> +
> +	edac_dbg(0, "MC: mci = %p\n", mci);
> +
> +	mci->mc_idx = idx++;
> +	mci->mtype_cap = MEM_FLAG_RDDR4;
> +	mci->edac_ctl_cap = EDAC_FLAG_NONE;
> +	mci->edac_cap = EDAC_FLAG_NONE;
> +	mci->mod_name = "loongson_edac.c";
> +	mci->ctl_name = "loongson_edac_ctl";
> +	mci->dev_name = "loongson_edac_dev";
> +	mci->ctl_page_to_phys = NULL;
> +	mci->pdev = &pdev->dev;
> +	mci->error_desc.grain = 8;
> +	/* Set the function pointer to an actual operation function */
> +	mci->edac_check = loongson_edac_check;
> +
> +	loongson_pvt_init(mci, vbase);
> +	get_dimm_config(mci);
> +
> +	if (edac_mc_add_mc(mci)) {
> +		edac_dbg(0, "MC: failed edac_mc_add_mc()\n");
> +		edac_mc_free(mci);
> +	}
> +	return 0;
> +}
> +
> +static int loongson_edac_remove(struct platform_device *pdev)
> +{
> +	struct mem_ctl_info *mci = edac_mc_del_mc(&pdev->dev);
> +
> +	if (mci) {
> +		edac_mc_free(mci);
> +		return 0;
> +	}
> +	return -ENODEV;
> +}
> +
> +static const struct of_device_id loongson_edac_of_match[] = {
> +	{ .compatible = "loongson,ls-mc-edac", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, loongson_edac_of_match);
> +
> +static struct platform_driver loongson_edac_driver = {
> +	.probe		= loongson_edac_probe,
> +	.remove		= loongson_edac_remove,
> +	.driver		= {
> +		.name	= "ls-mc-edac",
> +		.owner = THIS_MODULE,

Drop... that's ancient code.

> +		.of_match_table = loongson_edac_of_match,
> +	},
> +};
> +
> +static int __init loongson_edac_init(void)
> +{
> +	/* poll only */
> +	edac_op_state = EDAC_OPSTATE_POLL;

Drop, unused. Clean your driver before posting it.

> +
> +	return platform_driver_register(&loongson_edac_driver);
> +}
> +
> +static void __exit loongson_edac_exit(void)
> +{
> +	platform_driver_unregister(&loongson_edac_driver);
> +}
> +
> +module_init(loongson_edac_init);
> +module_exit(loongson_edac_exit);

module_platform_driver

> +module_param(edac_op_state, int, 0444);

Drop

> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zhao Qunqin <zhaoqunqin@loongson.cn>\n");
> +MODULE_DESCRIPTION("EDAC driver for loongson memory controller");

Best regards,
Krzysztof


