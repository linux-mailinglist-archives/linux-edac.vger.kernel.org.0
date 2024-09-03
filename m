Return-Path: <linux-edac+bounces-1769-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B8B96922B
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 05:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6EE1F23676
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 03:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212611D4170;
	Tue,  3 Sep 2024 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="e6FaBhz/"
X-Original-To: linux-edac@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FF1CDFCB;
	Tue,  3 Sep 2024 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725334287; cv=none; b=T25KPWLS+xVCH8DEk7x8AwwOHql3LAST6jL8jLnriNhPDDHb3M9zbatRC8A7ozJp1tumrpQ8QO08GjfFbEw7h/IaUW5rId8jRZaHpLvGex49/fC79LVpeYMS9MFGTY62rsEI7bwi3Qkja9Twf6q2ykonmvBkUtpfXyUfJUL8ppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725334287; c=relaxed/simple;
	bh=14QtBDtfghec4HEM/LUgRn9f4YyDibH6F7XuTpcrjQw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=CYXKC3Li45X+kwVf/GBDdY2hcpkAJwi0B+CZqbXMmE2iG0phSjtu0XKubIDUH/47Vd9KrL9uDQhkQNIMZCRvu86yk4ZvZWsPDq9PVIoIiFJ7lsqvhEMwjuyryZLnUAvbSpe3z/X0k0IsLuyhjPZGxpkLT9tJAOUUXbkRthuCV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=e6FaBhz/; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [151.80.165.199])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id CE6CB20114;
	Tue,  3 Sep 2024 03:31:16 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id 526673E8AF;
	Tue,  3 Sep 2024 05:31:09 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id F0EE040096;
	Tue,  3 Sep 2024 03:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1725334268; bh=14QtBDtfghec4HEM/LUgRn9f4YyDibH6F7XuTpcrjQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e6FaBhz/nS30yKceeBGKI04obLLUQWe8hbJJUTOPQOOUfhXTctVNNsGnbp4NrjXOV
	 pG4QmwLprBYF31uliNI3+1xgSIGO9237MRRF8m1oF/WHEdr33C5xU0i4oxqjN6+sFC
	 /wxDXCc/0qphanrxgiSw3NWvFHng4C9DJyMrKfkg=
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 780BC40BCF;
	Tue,  3 Sep 2024 03:31:03 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Sep 2024 11:31:03 +0800
From: Mingcong Bai <jeffbai@aosc.io>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Zhao Qunqin <zhaoqunqin@loongson.cn>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-edac@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@xen0n.name,
 bp@alien8.de, tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v2 2/2] Loongarch: EDAC driver for loongson memory
 controller
In-Reply-To: <CAAhV-H7mL2-heGLXyUGC4zF+qcL=66AgkJvasUdEsV7RXZDdQg@mail.gmail.com>
References: <20240903015354.9443-1-zhaoqunqin@loongson.cn>
 <20240903015354.9443-3-zhaoqunqin@loongson.cn>
 <CAAhV-H7mL2-heGLXyUGC4zF+qcL=66AgkJvasUdEsV7RXZDdQg@mail.gmail.com>
Message-ID: <60ec0516f0e33efa4a53aa76d8ccbba7@aosc.io>
X-Sender: jeffbai@aosc.io
Organization: Anthon Open Source Community
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: F0EE040096
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.10 / 10.00];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-0.30)[75.00%];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_EQ_ENVFROM(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[]

Greetings all,

在 2024-09-03 10:39，Huacai Chen 写道：
> Hi, Qunqin,
> 
> On Tue, Sep 3, 2024 at 9:53 AM Zhao Qunqin <zhaoqunqin@loongson.cn> 
> wrote:
>> 
>> Report single bit errors (CE) only.
>> 
>> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
>> ---
>>  MAINTAINERS                  |   1 +
>>  arch/loongarch/Kconfig       |   1 +
>>  drivers/edac/Kconfig         |   8 ++
>>  drivers/edac/Makefile        |   1 +
>>  drivers/edac/ls3a5000_edac.c | 187 
>> +++++++++++++++++++++++++++++++++++
>>  5 files changed, 198 insertions(+)
>>  create mode 100644 drivers/edac/ls3a5000_edac.c
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6cc8cfc8f..b43f82279 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13242,6 +13242,7 @@ M:      Zhao Qunqin <zhaoqunqin@loongson.cn>
>>  L:     linux-edac@vger.kernel.org
>>  S:     Maintained
>>  F:     
>> Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml
>> +F:     drivers/edac/ls3a5000_edac.c
>> 
>>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>>  M:     Sathya Prakash <sathya.prakash@broadcom.com>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 70f169210..348030c24 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -182,6 +182,7 @@ config LOONGARCH
>>         select PCI_QUIRKS
>>         select PERF_USE_VMALLOC
>>         select RTC_LIB
>> +       select EDAC_SUPPORT
>>         select SPARSE_IRQ
>>         select SYSCTL_ARCH_UNALIGN_ALLOW
>>         select SYSCTL_ARCH_UNALIGN_NO_WARN
>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>> index 16c8de505..2d10256f0 100644
>> --- a/drivers/edac/Kconfig
>> +++ b/drivers/edac/Kconfig
>> @@ -573,5 +573,13 @@ config EDAC_VERSAL
>>           Support injecting both correctable and uncorrectable errors
>>           for debugging purposes.
>> 
>> +config EDAC_LS3A5000
>> +       tristate "Ls3a5000 Memory Controller"
>> +       depends on LOONGARCH || COMPILE_TEST
>> +       help
>> +         Support for error detection and correction on the ls3a5000 
>> memory
>> +         controller. This driver report single bit errors (CE) only.
>> +         Ls3c5000l, ls3c5000, ls3d5000, ls3a6000 and ls3c6000 are 
>> compatible
>> +         with ls3a5000.
> Here can be improved as:
> 
> config EDAC_LOONGSON3
>        tristate "Loonson-3 Memory Controller"
>        depends on LOONGARCH || COMPILE_TEST
>        help
>          Support for error detection and correction on the Loongson-3 
> family
>          memory controller. This driver reports single bit errors (CE) 
> only.
>          Loongson-3A5000/3C5000/3C5000L/3A6000/3C6000 are compatible.
> 

Huacai,

This looks much better, minus a typo - it should be Loongson-3, not 
Loonson-3. Also, what about 3B/D5000 and potentially 3A6000, 3B6000, and 
3D6000, etc.?

My suggestion would be to list them as a family, say: "All members of 
the Loongson-3 family of processors are compatible." If there are 
exceptions, then I would list them more explicitly, something like "all 
members... except the... series."

What do you think?

>> 
>>  endif # EDAC
>> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
>> index 4edfb83ff..0974e3fa6 100644
>> --- a/drivers/edac/Makefile
>> +++ b/drivers/edac/Makefile
>> @@ -89,3 +89,4 @@ obj-$(CONFIG_EDAC_DMC520)             += 
>> dmc520_edac.o
>>  obj-$(CONFIG_EDAC_NPCM)                        += npcm_edac.o
>>  obj-$(CONFIG_EDAC_ZYNQMP)              += zynqmp_edac.o
>>  obj-$(CONFIG_EDAC_VERSAL)              += versal_edac.o
>> +obj-$(CONFIG_EDAC_LS3A5000)            += ls3a5000_edac.o
>> diff --git a/drivers/edac/ls3a5000_edac.c 
>> b/drivers/edac/ls3a5000_edac.c
>> new file mode 100644
>> index 000000000..c68fd7c5f
>> --- /dev/null
>> +++ b/drivers/edac/ls3a5000_edac.c
>> @@ -0,0 +1,187 @@
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
>> +       ECC_SET = 0,
>> +       ECC_RESERVED,
>> +       ECC_COUNT,
>> +       ECC_CS_COUNT,
>> +       ECC_CODE,
>> +       ECC_ADDR,
>> +       ECC_DATA0,
>> +       ECC_DATA1,
>> +       ECC_DATA2,
>> +       ECC_DATA3,
>> +};
>> +
>> +struct loongson_edac_pvt {
>> +       u64 *ecc_base;
>> +       int last_ce_count;
>> +};
>> +
>> +static void loongson_update_ce_count(struct mem_ctl_info *mci,
>> +                                       int chan,
>> +                                       int new)
>> +{
>> +       int add;
>> +       struct loongson_edac_pvt *pvt = mci->pvt_info;
>> +
>> +       add = new - pvt->last_ce_count;
>> +
>> +       /* Store the new value */
>> +       pvt->last_ce_count = new;
>> +
>> +       /* device resume or any other exceptions*/
>> +       if (add < 0)
>> +               return;
>> +
>> +       /*updated the edac core */
>> +       if (add != 0) {
>> +               edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, add,
>> +                                       0, 0, 0,
>> +                                       chan, 0, -1, "error", "");
>> +               edac_mc_printk(mci, KERN_INFO, "add: %d", add);
>> +       }
>> +}
>> +
>> +static int loongson_read_ecc(struct mem_ctl_info *mci)
>> +{
>> +       u64 ecc;
>> +       int cs = 0;
>> +       struct loongson_edac_pvt *pvt = mci->pvt_info;
>> +
>> +       if (!pvt->ecc_base)
>> +               return pvt->last_ce_count;
>> +
>> +       ecc = pvt->ecc_base[ECC_CS_COUNT];
>> +       cs += ecc & 0xff;               // cs0
>> +       cs += (ecc >> 8) & 0xff;        // cs1
>> +       cs += (ecc >> 16) & 0xff;       // cs2
>> +       cs += (ecc >> 24) & 0xff;       // cs3
>> +
>> +       return cs;
>> +}
>> +
>> +static void loongson_edac_check(struct mem_ctl_info *mci)
>> +{
>> +       loongson_update_ce_count(mci, 0, loongson_read_ecc(mci));
>> +}
>> +
>> +static int get_dimm_config(struct mem_ctl_info *mci)
>> +{
>> +       u32 size, npages;
>> +       struct dimm_info *dimm;
>> +
>> +       /* size not used */
>> +       size = -1;
>> +       npages = MiB_TO_PAGES(size);
>> +
>> +       dimm = edac_get_dimm(mci, 0, 0, 0);
>> +       dimm->nr_pages = npages;
>> +       snprintf(dimm->label, sizeof(dimm->label),
>> +                       "MC#%uChannel#%u_DIMM#%u",
>> +                       mci->mc_idx, 0, 0);
>> +       dimm->grain = 8;
>> +
>> +       return 0;
>> +}
>> +
>> +static void loongson_pvt_init(struct mem_ctl_info *mci, u64 *vbase)
>> +{
>> +       struct loongson_edac_pvt *pvt = mci->pvt_info;
>> +
>> +       pvt->ecc_base = vbase;
>> +       pvt->last_ce_count = loongson_read_ecc(mci);
>> +}
>> +
>> +static int loongson_edac_probe(struct platform_device *pdev)
>> +{
>> +       struct resource *rs;
>> +       struct mem_ctl_info *mci;
>> +       struct edac_mc_layer layers[2];
>> +       struct loongson_edac_pvt *pvt;
>> +       u64 *vbase = NULL;
>> +
>> +       rs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       /* not return if can not find resource or resource start 
>> equals NULL */
>> +       if (rs && rs->start) {
>> +               vbase = devm_ioremap_resource(&pdev->dev, rs);
>> +               if (IS_ERR(vbase))
>> +                       return PTR_ERR(vbase);
>> +       }
>> +
>> +       /* allocate a new MC control structure */
>> +       layers[0].type = EDAC_MC_LAYER_CHANNEL;
>> +       layers[0].size = 1;
>> +       layers[0].is_virt_csrow = false;
>> +       layers[1].type = EDAC_MC_LAYER_SLOT;
>> +       layers[1].size = 1;
>> +       layers[1].is_virt_csrow = true;
>> +       mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 
>> sizeof(*pvt));
>> +       if (mci == NULL)
>> +               return -ENOMEM;
>> +
>> +       edac_dbg(0, "MC: mci = %p\n", mci);
>> +
>> +       mci->mc_idx = edac_device_alloc_index();
>> +       mci->mtype_cap = MEM_FLAG_RDDR4;
>> +       mci->edac_ctl_cap = EDAC_FLAG_NONE;
>> +       mci->edac_cap = EDAC_FLAG_NONE;
>> +       mci->mod_name = "loongson_edac.c";
>> +       mci->ctl_name = "loongson_edac_ctl";
>> +       mci->dev_name = "loongson_edac_dev";
>> +       mci->ctl_page_to_phys = NULL;
>> +       mci->pdev = &pdev->dev;
>> +       mci->error_desc.grain = 8;
>> +       /* Set the function pointer to an actual operation function */
>> +       mci->edac_check = loongson_edac_check;
>> +
>> +       loongson_pvt_init(mci, vbase);
>> +       get_dimm_config(mci);
>> +
>> +       if (edac_mc_add_mc(mci)) {
>> +               edac_dbg(0, "MC: failed edac_mc_add_mc()\n");
>> +               edac_mc_free(mci);
>> +       }
>> +       edac_op_state = EDAC_OPSTATE_POLL;
>> +
>> +       return 0;
>> +}
>> +
>> +static void loongson_edac_remove(struct platform_device *pdev)
>> +{
>> +       struct mem_ctl_info *mci = edac_mc_del_mc(&pdev->dev);
>> +
>> +       if (mci)
>> +               edac_mc_free(mci);
>> +}
>> +
>> +static const struct of_device_id loongson_edac_of_match[] = {
>> +       { .compatible = "loongson,ls3a5000-mc-edac", },
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(of, loongson_edac_of_match);
>> +
>> +static struct platform_driver loongson_edac_driver = {
>> +       .probe          = loongson_edac_probe,
>> +       .remove         = loongson_edac_remove,
>> +       .driver         = {
>> +               .name   = "ls-mc-edac",
> The name can be better as loongson-mc-edac.
> 
> Huacai
> 
>> +               .of_match_table = loongson_edac_of_match,
>> +       },
>> +};
>> +
>> +module_platform_driver(loongson_edac_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Zhao Qunqin <zhaoqunqin@loongson.cn>\n");
>> +MODULE_DESCRIPTION("EDAC driver for loongson memory controller");
>> --
>> 2.43.0
>> 

Best Regards,
Mingcong Bai

