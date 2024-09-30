Return-Path: <linux-edac+bounces-1930-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF1298996F
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 05:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FF3B2223A
	for <lists+linux-edac@lfdr.de>; Mon, 30 Sep 2024 03:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66F2EAE5;
	Mon, 30 Sep 2024 03:25:04 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FED438396;
	Mon, 30 Sep 2024 03:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727666704; cv=none; b=eJ60PdMjJ/anM1u08Pkrw5+lYcqhd9UFHVrlu7890Xtz43G3ekZ6ow08hIkdtP9+5jL8xJC3NATb/xeFE6oFhwOJVbQmQLWmJbRmqu9BO/1NhXeRXCx++sCrT69foOzuE9ZSb8lXFYdiP8q/lPLPZvPOotz1NzsT0qy5VooCiUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727666704; c=relaxed/simple;
	bh=L74EFNmBJ+BoRuTlV9M9pl97yZnpubHkwY2PpjTKtvo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PwpCCooCfSavKspt+sCxQbt2DaAUE7kn5zOZ0IPVAkoAjGL0C8YqiKYQP8fTjTht1NLx6bS3BnI9bvzzzpMHGEykXm95DOZhJVYQoZnVo2w80N8B31A05TDbGk/Y0/tyIfYtyrztgUG7vbMou7hgximVrFy7w0Nj4iJg5LGQgdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8DxxrAJGvpmDl8EAA--.4294S3;
	Mon, 30 Sep 2024 11:24:57 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front2 (Coremail) with SMTP id qciowMBxOsYGGvpmLtcYAA--.22697S2;
	Mon, 30 Sep 2024 11:24:54 +0800 (CST)
Subject: Re: [PATCH v5 2/2] Loongarch: EDAC driver for loongson memory
 controller
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 chenhuacai@kernel.org, bp@alien8.de, tony.luck@intel.com,
 linux-edac@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@xen0n.name, james.morse@arm.com,
 mchehab@kernel.org, rric@kernel.org, loongarch@lists.linux.dev
References: <20240925024038.9844-1-zhaoqunqin@loongson.cn>
 <20240925024038.9844-3-zhaoqunqin@loongson.cn>
 <20240925101331.00000e63@Huawei.com>
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
Message-ID: <2b8b6384-4c6b-b49d-b88e-93c1390017e4@loongson.cn>
Date: Mon, 30 Sep 2024 11:24:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240925101331.00000e63@Huawei.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qciowMBxOsYGGvpmLtcYAA--.22697S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3AryrCF1kWF48Xry7ZFykXrc_yoWfAF43pF
	98Aa15Cr48tr17AwsYvryUuF1Yvws7KF12k3y3tay29r9Fyrykur9Yqry2kFn7CryDGrW0
	va4rKwsruF4YkrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0mhrUUU
	UU=


ÔÚ 2024/9/25 ÏÂÎç5:13, Jonathan Cameron Ð´µÀ:
> On Wed, 25 Sep 2024 10:40:38 +0800
> Zhao Qunqin <zhaoqunqin@loongson.cn> wrote:
>
>> Reports single bit errors (CE) only.
>>
>> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
> Hi. A few quick comments inline
>
> Jonathan
>
>> ---
>> Changes in v5:
>> 	- Drop the loongson_ prefix from all static functions.
>> 	- Align function arguments on the opening brace.
>> 	- Drop useless comments and useless wrapper. Drop side comments.
>> 	- Reorder variable declarations.
>>
>> Changes in v4:
>> 	- None
>>
>> Changes in v3:
>> 	- Addressed review comments raised by Krzysztof and Huacai
>>
>> Changes in v2:
>> 	- Addressed review comments raised by Krzysztof
>>
>>   MAINTAINERS                  |   1 +
>>   arch/loongarch/Kconfig       |   1 +
>>   drivers/edac/Kconfig         |   8 ++
>>   drivers/edac/Makefile        |   1 +
>>   drivers/edac/loongson_edac.c | 168 +++++++++++++++++++++++++++++++++++
>>   5 files changed, 179 insertions(+)
>>   create mode 100644 drivers/edac/loongson_edac.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6cc8cfc8f..5b4526638 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13242,6 +13242,7 @@ M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
>>   L:	linux-edac@vger.kernel.org
>>   S:	Maintained
>>   F:	Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml
>> +F:	drivers/edac/loongson_edac.c
>>   
>>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>>   M:	Sathya Prakash <sathya.prakash@broadcom.com>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 70f169210..9c135f1a2 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -181,6 +181,7 @@ config LOONGARCH
>>   	select PCI_MSI_ARCH_FALLBACKS
>>   	select PCI_QUIRKS
>>   	select PERF_USE_VMALLOC
>> +	select EDAC_SUPPORT
>>   	select RTC_LIB
>>   	select SPARSE_IRQ
>>   	select SYSCTL_ARCH_UNALIGN_ALLOW
>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>> index 81af6c344..719bb6ca7 100644
>> --- a/drivers/edac/Kconfig
>> +++ b/drivers/edac/Kconfig
>> @@ -564,5 +564,13 @@ config EDAC_VERSAL
>>   	  Support injecting both correctable and uncorrectable errors
>>   	  for debugging purposes.
>>   
>> +config EDAC_LOONGSON3
>> +	tristate "Loongson-3 Memory Controller"
>> +	depends on LOONGARCH || COMPILE_TEST
>> +	help
>> +	  Support for error detection and correction on the Loongson-3
>> +	  family memory controller. This driver reports single bit
>> +	  errors (CE) only. Loongson-3A5000/3C5000/3D5000/3C5000L/3A6000/3C6000
>> +	  are compatible.
>>   
>>   endif # EDAC
>> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
>> index faf310eec..e72ca1be4 100644
>> --- a/drivers/edac/Makefile
>> +++ b/drivers/edac/Makefile
>> @@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
>>   obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
>>   obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
>>   obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
>> +obj-$(CONFIG_EDAC_LOONGSON3)		+= loongson_edac.o
>> diff --git a/drivers/edac/loongson_edac.c b/drivers/edac/loongson_edac.c
>> new file mode 100644
>> index 000000000..2721dfba5
>> --- /dev/null
>> +++ b/drivers/edac/loongson_edac.c
>> @@ -0,0 +1,168 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2024 Loongson Technology Corporation Limited.
>> + */
>> +
>> +#include <linux/edac.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "edac_module.h"
>> +
>> +enum ecc_index {
>> +	ECC_SET = 0,
>> +	ECC_RESERVED,
>> +	ECC_COUNT,
>> +	ECC_CS_COUNT,
>> +	ECC_CODE,
>> +	ECC_ADDR,
>> +	ECC_DATA0,
>> +	ECC_DATA1,
>> +	ECC_DATA2,
>> +	ECC_DATA3,
>> +};
>> +
>> +struct loongson_edac_pvt {
>> +	u64 *ecc_base;
>> +	int last_ce_count;
>> +};
>> +
>> +static int read_ecc(struct mem_ctl_info *mci)
>> +{
>> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
>> +	u64 ecc;
>> +	int cs;
>> +
>> +	if (!pvt->ecc_base)
>> +		return pvt->last_ce_count;
>> +
>> +	ecc = pvt->ecc_base[ECC_CS_COUNT];
>> +	/* cs0 -- cs3 */
>> +	cs = ecc & 0xff;
>> +	cs += (ecc >> 8) & 0xff;
>> +	cs += (ecc >> 16) & 0xff;
>> +	cs += (ecc >> 24) & 0xff;
> This smells like an endian swap.
> swab32() or is this fixing a wrong endian register?
> In which case b32_to_cpu()
Not an endian swap. Just add up the values of the lowest four bytes.
>
>> +
>> +	return cs;
>> +}
>> +
>> +static void edac_check(struct mem_ctl_info *mci)
>> +{
>> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
>> +	int new, add;
>> +
>> +	new = read_ecc(mci);
>> +	add = new - pvt->last_ce_count;
>> +	pvt->last_ce_count = new;
>> +	if (add <= 0)
> This has be a little confused. Either this counter can
> wrap in which case why drop out here, or it can't in which case
> does < occur?
The ce count of loongson memory controller should only increase.
>
>> +		return;
>> +
>> +	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, add,
>> +			     0, 0, 0, 0, 0, -1, "error", "");
>> +	edac_mc_printk(mci, KERN_INFO, "add: %d", add);
>> +}
>> +
>> +static int get_dimm_config(struct mem_ctl_info *mci)
>> +{
>> +	struct dimm_info *dimm;
>> +	u32 size, npages;
>> +
>> +	/* size not used */
>> +	size = -1;
>> +	npages = MiB_TO_PAGES(size);
>> +
>> +	dimm = edac_get_dimm(mci, 0, 0, 0);
>> +	dimm->nr_pages = npages;
>> +	snprintf(dimm->label, sizeof(dimm->label),
>> +		 "MC#%uChannel#%u_DIMM#%u", mci->mc_idx, 0, 0);
>> +	dimm->grain = 8;
>> +
>> +	return 0;
>> +}
>> +
>> +static void pvt_init(struct mem_ctl_info *mci, u64 *vbase)
>> +{
>> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
>> +
>> +	pvt->ecc_base = vbase;
>> +	pvt->last_ce_count = read_ecc(mci);
>> +}
>> +
>> +static int edac_probe(struct platform_device *pdev)
>> +{
>> +	struct edac_mc_layer layers[2];
>> +	struct loongson_edac_pvt *pvt;
>> +	struct mem_ctl_info *mci;
>> +	u64 *vbase;
>> +	int ret;
>> +
>> +	vbase = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(vbase))
>> +		return PTR_ERR(vbase);
>> +
>> +	/* allocate a new MC control structure */
>> +	layers[0].type = EDAC_MC_LAYER_CHANNEL;
>> +	layers[0].size = 1;
>> +	layers[0].is_virt_csrow = false;
>> +	layers[1].type = EDAC_MC_LAYER_SLOT;
>> +	layers[1].size = 1;
>> +	layers[1].is_virt_csrow = true;
> Could move this to a c99 style
>
> 	struct edac_mc_layer layers[2] = {
> 		{
> 			.type = EDAC_MC_LAYER_CHANNEL,
> 			.size = 1,
> 			.is_virt_csrow = false,
> 		}, {
> 			.type = EDAC_MC_LAYER_SLOT,
> 			.size = 1,
> 			is_virt_csrow = true,
> 		}
> 	};
> Not particularly important though.
>
>> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt));
>> +	if (mci == NULL)
> Probably !mci is sufficient but I'm not sure on local edac style.
>
>> +		return -ENOMEM;
>> +
>> +	mci->mc_idx = edac_device_alloc_index();
>> +	mci->mtype_cap = MEM_FLAG_RDDR4;
>> +	mci->edac_ctl_cap = EDAC_FLAG_NONE;
>> +	mci->edac_cap = EDAC_FLAG_NONE;
>> +	mci->mod_name = "loongson_edac.c";
>> +	mci->ctl_name = "loongson_edac_ctl";
>> +	mci->dev_name = "loongson_edac_dev";
>> +	mci->ctl_page_to_phys = NULL;
>> +	mci->pdev = &pdev->dev;
>> +	mci->error_desc.grain = 8;
>> +	/* Set the function pointer to an actual operation function */
>> +	mci->edac_check = edac_check;
> Similar to above, can initialize this structure more cleanly
> using
>
> 	*mci = (struct mem_ctl_info) {
> 		.mc_idx = edac_device_alloc_index,
> 	...
> 	};
>> +
>> +	pvt_init(mci, vbase);
>> +	get_dimm_config(mci);
>> +
>> +	ret = edac_mc_add_mc(mci);
> I'd be tempted to use devm_add_action_or_cleanup() for this and the
> alloc above, but not common in edac but it is done in al_mc_edac.c if
> you want an example.
Your idea is great, but I don't think it's necessary to make things so 
complicated
>> +	if (ret) {
>> +		edac_dbg(0, "MC: failed edac_mc_add_mc()\n");
>> +		edac_mc_free(mci);
>> +		return ret;
>> +	}
>> +	edac_op_state = EDAC_OPSTATE_POLL;
>> +
>> +	return 0;
>> +}
>> +
>> +static void edac_remove(struct platform_device *pdev)
>> +{
>> +	struct mem_ctl_info *mci = edac_mc_del_mc(&pdev->dev);
>> +
>> +	if (mci)
>> +		edac_mc_free(mci);
> Very odd if you got to remove and edac_mc_del_mc() failed.
> Do we need this check?  At least some drivers (I checked a few
> at random) don't check this.

Yes, odd if edac_mc_del_mc() failed. Dose it better to add a check just 
in case

edac_mc_del_mc() failed ?


Thanks,

Zhao Qunqin

>
>> +}
>> +
>> +static const struct of_device_id loongson_edac_of_match[] = {
>> +	{ .compatible = "loongson,ls3a5000-mc-edac", },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, loongson_edac_of_match);
>> +
>> +static struct platform_driver loongson_edac_driver = {
>> +	.probe		= edac_probe,
>> +	.remove		= edac_remove,
>> +	.driver		= {
>> +		.name	= "loongson-mc-edac",
>> +		.of_match_table = loongson_edac_of_match,
>> +	},
>> +};
>> +module_platform_driver(loongson_edac_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Zhao Qunqin <zhaoqunqin@loongson.cn>");
>> +MODULE_DESCRIPTION("EDAC driver for loongson memory controller");


