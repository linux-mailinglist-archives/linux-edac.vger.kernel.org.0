Return-Path: <linux-edac+bounces-1924-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AA7985620
	for <lists+linux-edac@lfdr.de>; Wed, 25 Sep 2024 11:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE75328624F
	for <lists+linux-edac@lfdr.de>; Wed, 25 Sep 2024 09:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C7215B111;
	Wed, 25 Sep 2024 09:13:39 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F095156257;
	Wed, 25 Sep 2024 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727255619; cv=none; b=tcfjHd7IjCINhWxqxrIfhohmHLv8qtjcdzQkAOnIX4J0IbUkjG/MBMpBxjTKivwIKWK6Rm0E1D3rD48JhUd1XRK2xmGjmuoLwxvq03EqaTfrJpduJXGaJUDggB7fnL2hypkiuB57DyXSh5rZjBw79A4VIQHC9EZmjBgJZn4LqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727255619; c=relaxed/simple;
	bh=d6JLoUbDwBjIKDx20ZTHvHtdpUWvWpheRHW6XLbj/t0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFVnZpjLGVlIzLKcl015yAts3mTwKblmtxZwK+iAU2s/z+x3iR24idtkoMsDUYfn2gc9lpwyP+sHUwto+aSKcxori9b94YViiQKCAksfmCJ1sgjjiS48gnKJkpWSWK2NZKxPoJDgfKW/SjNldamJK0+R/WmMUHfw9p8JONH2M5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XD9xV3L9jz6GBkj;
	Wed, 25 Sep 2024 17:13:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CBD0E140EDF;
	Wed, 25 Sep 2024 17:13:33 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Sep
 2024 11:13:33 +0200
Date: Wed, 25 Sep 2024 10:13:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<chenhuacai@kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<linux-edac@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kernel@xen0n.name>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v5 2/2] Loongarch: EDAC driver for loongson memory
 controller
Message-ID: <20240925101331.00000e63@Huawei.com>
In-Reply-To: <20240925024038.9844-3-zhaoqunqin@loongson.cn>
References: <20240925024038.9844-1-zhaoqunqin@loongson.cn>
	<20240925024038.9844-3-zhaoqunqin@loongson.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 25 Sep 2024 10:40:38 +0800
Zhao Qunqin <zhaoqunqin@loongson.cn> wrote:

> Reports single bit errors (CE) only.
> 
> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
Hi. A few quick comments inline

Jonathan

> ---
> Changes in v5:
> 	- Drop the loongson_ prefix from all static functions.
> 	- Align function arguments on the opening brace.
> 	- Drop useless comments and useless wrapper. Drop side comments.
> 	- Reorder variable declarations.
> 
> Changes in v4:
> 	- None
> 
> Changes in v3:
> 	- Addressed review comments raised by Krzysztof and Huacai
> 
> Changes in v2:
> 	- Addressed review comments raised by Krzysztof
> 
>  MAINTAINERS                  |   1 +
>  arch/loongarch/Kconfig       |   1 +
>  drivers/edac/Kconfig         |   8 ++
>  drivers/edac/Makefile        |   1 +
>  drivers/edac/loongson_edac.c | 168 +++++++++++++++++++++++++++++++++++
>  5 files changed, 179 insertions(+)
>  create mode 100644 drivers/edac/loongson_edac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6cc8cfc8f..5b4526638 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13242,6 +13242,7 @@ M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
>  L:	linux-edac@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml
> +F:	drivers/edac/loongson_edac.c
>  
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:	Sathya Prakash <sathya.prakash@broadcom.com>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 70f169210..9c135f1a2 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -181,6 +181,7 @@ config LOONGARCH
>  	select PCI_MSI_ARCH_FALLBACKS
>  	select PCI_QUIRKS
>  	select PERF_USE_VMALLOC
> +	select EDAC_SUPPORT
>  	select RTC_LIB
>  	select SPARSE_IRQ
>  	select SYSCTL_ARCH_UNALIGN_ALLOW
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 81af6c344..719bb6ca7 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -564,5 +564,13 @@ config EDAC_VERSAL
>  	  Support injecting both correctable and uncorrectable errors
>  	  for debugging purposes.
>  
> +config EDAC_LOONGSON3
> +	tristate "Loongson-3 Memory Controller"
> +	depends on LOONGARCH || COMPILE_TEST
> +	help
> +	  Support for error detection and correction on the Loongson-3
> +	  family memory controller. This driver reports single bit
> +	  errors (CE) only. Loongson-3A5000/3C5000/3D5000/3C5000L/3A6000/3C6000
> +	  are compatible.
>  
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index faf310eec..e72ca1be4 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
>  obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
>  obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
>  obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
> +obj-$(CONFIG_EDAC_LOONGSON3)		+= loongson_edac.o
> diff --git a/drivers/edac/loongson_edac.c b/drivers/edac/loongson_edac.c
> new file mode 100644
> index 000000000..2721dfba5
> --- /dev/null
> +++ b/drivers/edac/loongson_edac.c
> @@ -0,0 +1,168 @@
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
> +struct loongson_edac_pvt {
> +	u64 *ecc_base;
> +	int last_ce_count;
> +};
> +
> +static int read_ecc(struct mem_ctl_info *mci)
> +{
> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
> +	u64 ecc;
> +	int cs;
> +
> +	if (!pvt->ecc_base)
> +		return pvt->last_ce_count;
> +
> +	ecc = pvt->ecc_base[ECC_CS_COUNT];
> +	/* cs0 -- cs3 */
> +	cs = ecc & 0xff;
> +	cs += (ecc >> 8) & 0xff;
> +	cs += (ecc >> 16) & 0xff;
> +	cs += (ecc >> 24) & 0xff;

This smells like an endian swap.
swab32() or is this fixing a wrong endian register?
In which case b32_to_cpu()

> +
> +	return cs;
> +}
> +
> +static void edac_check(struct mem_ctl_info *mci)
> +{
> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
> +	int new, add;
> +
> +	new = read_ecc(mci);
> +	add = new - pvt->last_ce_count;
> +	pvt->last_ce_count = new;
> +	if (add <= 0)

This has be a little confused. Either this counter can
wrap in which case why drop out here, or it can't in which case
does < occur?

> +		return;
> +
> +	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, add,
> +			     0, 0, 0, 0, 0, -1, "error", "");
> +	edac_mc_printk(mci, KERN_INFO, "add: %d", add);
> +}
> +
> +static int get_dimm_config(struct mem_ctl_info *mci)
> +{
> +	struct dimm_info *dimm;
> +	u32 size, npages;
> +
> +	/* size not used */
> +	size = -1;
> +	npages = MiB_TO_PAGES(size);
> +
> +	dimm = edac_get_dimm(mci, 0, 0, 0);
> +	dimm->nr_pages = npages;
> +	snprintf(dimm->label, sizeof(dimm->label),
> +		 "MC#%uChannel#%u_DIMM#%u", mci->mc_idx, 0, 0);
> +	dimm->grain = 8;
> +
> +	return 0;
> +}
> +
> +static void pvt_init(struct mem_ctl_info *mci, u64 *vbase)
> +{
> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
> +
> +	pvt->ecc_base = vbase;
> +	pvt->last_ce_count = read_ecc(mci);
> +}
> +
> +static int edac_probe(struct platform_device *pdev)
> +{
> +	struct edac_mc_layer layers[2];
> +	struct loongson_edac_pvt *pvt;
> +	struct mem_ctl_info *mci;
> +	u64 *vbase;
> +	int ret;
> +
> +	vbase = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(vbase))
> +		return PTR_ERR(vbase);
> +
> +	/* allocate a new MC control structure */
> +	layers[0].type = EDAC_MC_LAYER_CHANNEL;
> +	layers[0].size = 1;
> +	layers[0].is_virt_csrow = false;
> +	layers[1].type = EDAC_MC_LAYER_SLOT;
> +	layers[1].size = 1;
> +	layers[1].is_virt_csrow = true;
Could move this to a c99 style

	struct edac_mc_layer layers[2] = {
		{
			.type = EDAC_MC_LAYER_CHANNEL,
			.size = 1,
			.is_virt_csrow = false,
		}, {
			.type = EDAC_MC_LAYER_SLOT,
			.size = 1,
			is_virt_csrow = true,
		}
	};
Not particularly important though.

> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt));
> +	if (mci == NULL)

Probably !mci is sufficient but I'm not sure on local edac style.

> +		return -ENOMEM;
> +
> +	mci->mc_idx = edac_device_alloc_index();
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
> +	mci->edac_check = edac_check;

Similar to above, can initialize this structure more cleanly
using 

	*mci = (struct mem_ctl_info) {
		.mc_idx = edac_device_alloc_index,
	...
	};
> +
> +	pvt_init(mci, vbase);
> +	get_dimm_config(mci);
> +
> +	ret = edac_mc_add_mc(mci);

I'd be tempted to use devm_add_action_or_cleanup() for this and the
alloc above, but not common in edac but it is done in al_mc_edac.c if
you want an example.

> +	if (ret) {
> +		edac_dbg(0, "MC: failed edac_mc_add_mc()\n");
> +		edac_mc_free(mci);
> +		return ret;
> +	}
> +	edac_op_state = EDAC_OPSTATE_POLL;
> +
> +	return 0;
> +}
> +
> +static void edac_remove(struct platform_device *pdev)
> +{
> +	struct mem_ctl_info *mci = edac_mc_del_mc(&pdev->dev);
> +
> +	if (mci)
> +		edac_mc_free(mci);

Very odd if you got to remove and edac_mc_del_mc() failed.
Do we need this check?  At least some drivers (I checked a few
at random) don't check this.


> +}
> +
> +static const struct of_device_id loongson_edac_of_match[] = {
> +	{ .compatible = "loongson,ls3a5000-mc-edac", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, loongson_edac_of_match);
> +
> +static struct platform_driver loongson_edac_driver = {
> +	.probe		= edac_probe,
> +	.remove		= edac_remove,
> +	.driver		= {
> +		.name	= "loongson-mc-edac",
> +		.of_match_table = loongson_edac_of_match,
> +	},
> +};
> +module_platform_driver(loongson_edac_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zhao Qunqin <zhaoqunqin@loongson.cn>");
> +MODULE_DESCRIPTION("EDAC driver for loongson memory controller");


