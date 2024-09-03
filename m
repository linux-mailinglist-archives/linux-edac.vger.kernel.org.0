Return-Path: <linux-edac+bounces-1766-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE396917B
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 04:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4042D1F2333A
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 02:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534DC1CCEE5;
	Tue,  3 Sep 2024 02:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdx7CK5p"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B81A4E6B;
	Tue,  3 Sep 2024 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725331204; cv=none; b=AsvckLaTMeg7vRktRFMpoVRPJv0yxJqZOqLI+BVnxkwIpsHl+2zyo9HqKs25BdCfb+ww6nZ06nQKFg8DbtDN8Dzr4KVljKAPpDsWoiJ8NlNKiSqPGcnT1Vjk+q8uHsbth18tJgD+N+XUUrfdynpQfBveMHH2UuVrDndF2L1nyfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725331204; c=relaxed/simple;
	bh=fAy3e6sJncexJUeTuoDtHL/T6jeKEMfWh43Z8YMZ2Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPIXvSteVbDiUxC8o1BjC/LSRjW+NtonvR9fY/yiVzebnHGFv19AnnOingykujI1A538Mvw/iB7+02BHV/uR8flYAh1FQGeBtpHRFcHo3Gavfz6X+VB9gPnbKog/4F8S2LGSz+/IQo/YBTZ5Jh1RHpnguM/+4bEOIZJYvSHr/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdx7CK5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C01C4CEC8;
	Tue,  3 Sep 2024 02:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725331203;
	bh=fAy3e6sJncexJUeTuoDtHL/T6jeKEMfWh43Z8YMZ2Dw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gdx7CK5pZHoqXdAl1XX3N/uBv28qREe8zp6QmBzW9Yn018SGJLuIuHJZkTH7rKCFp
	 JhvS4xV8+w9FFDEMP9YX7gn2Ex4AZLzEdjl8uK2xJ7WeNpi/OKkdwrO+vZ9tm1S0X+
	 DPob4fhq3UrT32wO4HqUtoHiBbx8Qaep4znez0l8ZYE7jrqvC3P4IwhxiSzhx3EziK
	 KjrfzKuoZkRT0jqc8RA1ZS05gOcTDaVce93h2pIDYiydnMgD5ZxoOcfAM9KloAoYOb
	 UiUb71RnSO9oaCTeUYdeyzXesGNfe6G13w8Hsd3ME/UmIkTXPQeLlNGkTAe0nSV5o/
	 qpXCUur2JTJQQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c0a9f2b967so4465043a12.2;
        Mon, 02 Sep 2024 19:40:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0wTjCXz6PZfXxZ7P+JGW5KNZ/obNvGZn0iekFEKW4Ih9WVnKm9Gw1KcYuGnjI+qvgS17TWriLJdDdYw==@vger.kernel.org, AJvYcCVfCPQ/tg4e6OrWMg9r3DGsjlYm96mXFG97EErg19NpglkLuvGAK2MmjLwbF3dpyar/wk0uuXx+fuBH@vger.kernel.org, AJvYcCXPok0a9rrIawcABS0Y4zyAwv8b+eNktPbUWt6AJ9AxzN6S6aFj7WHI0rsegKYyGJ2c5IkXYzJXxoj7phUG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw77NciD0gwF2fuEqhyVrebduUL5pFCjFiIpA2K7+SNjg9bUaV7
	8QWhxa7KEAHmynAP9flwrW+s0WRiV0fsUtSZ9BgxOlR0c3kxmcKINWqwa3IarPiBwTFuTnKOFYB
	dd3g9W/EaJsW9bJQompwYZ6IFH7s=
X-Google-Smtp-Source: AGHT+IGanICjz3NFJ+Ki8S9WWaNJPyWdoOlq98sh51elwD4/vA8t0AuimV50iUX7clAf4g9S0aD5IAY56hrglj3JCWs=
X-Received: by 2002:a05:6402:5c9:b0:5a2:68a2:ae57 with SMTP id
 4fb4d7f45d1cf-5c243781be8mr6059272a12.31.1725331202145; Mon, 02 Sep 2024
 19:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903015354.9443-1-zhaoqunqin@loongson.cn> <20240903015354.9443-3-zhaoqunqin@loongson.cn>
In-Reply-To: <20240903015354.9443-3-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 3 Sep 2024 10:39:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7mL2-heGLXyUGC4zF+qcL=66AgkJvasUdEsV7RXZDdQg@mail.gmail.com>
Message-ID: <CAAhV-H7mL2-heGLXyUGC4zF+qcL=66AgkJvasUdEsV7RXZDdQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Loongarch: EDAC driver for loongson memory controller
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-edac@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@xen0n.name, bp@alien8.de, 
	tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org, rric@kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qunqin,

On Tue, Sep 3, 2024 at 9:53=E2=80=AFAM Zhao Qunqin <zhaoqunqin@loongson.cn>=
 wrote:
>
> Report single bit errors (CE) only.
>
> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
> ---
>  MAINTAINERS                  |   1 +
>  arch/loongarch/Kconfig       |   1 +
>  drivers/edac/Kconfig         |   8 ++
>  drivers/edac/Makefile        |   1 +
>  drivers/edac/ls3a5000_edac.c | 187 +++++++++++++++++++++++++++++++++++
>  5 files changed, 198 insertions(+)
>  create mode 100644 drivers/edac/ls3a5000_edac.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6cc8cfc8f..b43f82279 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13242,6 +13242,7 @@ M:      Zhao Qunqin <zhaoqunqin@loongson.cn>
>  L:     linux-edac@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.=
yaml
> +F:     drivers/edac/ls3a5000_edac.c
>
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:     Sathya Prakash <sathya.prakash@broadcom.com>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 70f169210..348030c24 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -182,6 +182,7 @@ config LOONGARCH
>         select PCI_QUIRKS
>         select PERF_USE_VMALLOC
>         select RTC_LIB
> +       select EDAC_SUPPORT
>         select SPARSE_IRQ
>         select SYSCTL_ARCH_UNALIGN_ALLOW
>         select SYSCTL_ARCH_UNALIGN_NO_WARN
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 16c8de505..2d10256f0 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -573,5 +573,13 @@ config EDAC_VERSAL
>           Support injecting both correctable and uncorrectable errors
>           for debugging purposes.
>
> +config EDAC_LS3A5000
> +       tristate "Ls3a5000 Memory Controller"
> +       depends on LOONGARCH || COMPILE_TEST
> +       help
> +         Support for error detection and correction on the ls3a5000 memo=
ry
> +         controller. This driver report single bit errors (CE) only.
> +         Ls3c5000l, ls3c5000, ls3d5000, ls3a6000 and ls3c6000 are compat=
ible
> +         with ls3a5000.
Here can be improved as:

config EDAC_LOONGSON3
       tristate "Loonson-3 Memory Controller"
       depends on LOONGARCH || COMPILE_TEST
       help
         Support for error detection and correction on the Loongson-3 famil=
y
         memory controller. This driver reports single bit errors (CE) only=
.
         Loongson-3A5000/3C5000/3C5000L/3A6000/3C6000 are compatible.

>
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 4edfb83ff..0974e3fa6 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -89,3 +89,4 @@ obj-$(CONFIG_EDAC_DMC520)             +=3D dmc520_edac.=
o
>  obj-$(CONFIG_EDAC_NPCM)                        +=3D npcm_edac.o
>  obj-$(CONFIG_EDAC_ZYNQMP)              +=3D zynqmp_edac.o
>  obj-$(CONFIG_EDAC_VERSAL)              +=3D versal_edac.o
> +obj-$(CONFIG_EDAC_LS3A5000)            +=3D ls3a5000_edac.o
> diff --git a/drivers/edac/ls3a5000_edac.c b/drivers/edac/ls3a5000_edac.c
> new file mode 100644
> index 000000000..c68fd7c5f
> --- /dev/null
> +++ b/drivers/edac/ls3a5000_edac.c
> @@ -0,0 +1,187 @@
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
> +       ECC_SET =3D 0,
> +       ECC_RESERVED,
> +       ECC_COUNT,
> +       ECC_CS_COUNT,
> +       ECC_CODE,
> +       ECC_ADDR,
> +       ECC_DATA0,
> +       ECC_DATA1,
> +       ECC_DATA2,
> +       ECC_DATA3,
> +};
> +
> +struct loongson_edac_pvt {
> +       u64 *ecc_base;
> +       int last_ce_count;
> +};
> +
> +static void loongson_update_ce_count(struct mem_ctl_info *mci,
> +                                       int chan,
> +                                       int new)
> +{
> +       int add;
> +       struct loongson_edac_pvt *pvt =3D mci->pvt_info;
> +
> +       add =3D new - pvt->last_ce_count;
> +
> +       /* Store the new value */
> +       pvt->last_ce_count =3D new;
> +
> +       /* device resume or any other exceptions*/
> +       if (add < 0)
> +               return;
> +
> +       /*updated the edac core */
> +       if (add !=3D 0) {
> +               edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, add,
> +                                       0, 0, 0,
> +                                       chan, 0, -1, "error", "");
> +               edac_mc_printk(mci, KERN_INFO, "add: %d", add);
> +       }
> +}
> +
> +static int loongson_read_ecc(struct mem_ctl_info *mci)
> +{
> +       u64 ecc;
> +       int cs =3D 0;
> +       struct loongson_edac_pvt *pvt =3D mci->pvt_info;
> +
> +       if (!pvt->ecc_base)
> +               return pvt->last_ce_count;
> +
> +       ecc =3D pvt->ecc_base[ECC_CS_COUNT];
> +       cs +=3D ecc & 0xff;               // cs0
> +       cs +=3D (ecc >> 8) & 0xff;        // cs1
> +       cs +=3D (ecc >> 16) & 0xff;       // cs2
> +       cs +=3D (ecc >> 24) & 0xff;       // cs3
> +
> +       return cs;
> +}
> +
> +static void loongson_edac_check(struct mem_ctl_info *mci)
> +{
> +       loongson_update_ce_count(mci, 0, loongson_read_ecc(mci));
> +}
> +
> +static int get_dimm_config(struct mem_ctl_info *mci)
> +{
> +       u32 size, npages;
> +       struct dimm_info *dimm;
> +
> +       /* size not used */
> +       size =3D -1;
> +       npages =3D MiB_TO_PAGES(size);
> +
> +       dimm =3D edac_get_dimm(mci, 0, 0, 0);
> +       dimm->nr_pages =3D npages;
> +       snprintf(dimm->label, sizeof(dimm->label),
> +                       "MC#%uChannel#%u_DIMM#%u",
> +                       mci->mc_idx, 0, 0);
> +       dimm->grain =3D 8;
> +
> +       return 0;
> +}
> +
> +static void loongson_pvt_init(struct mem_ctl_info *mci, u64 *vbase)
> +{
> +       struct loongson_edac_pvt *pvt =3D mci->pvt_info;
> +
> +       pvt->ecc_base =3D vbase;
> +       pvt->last_ce_count =3D loongson_read_ecc(mci);
> +}
> +
> +static int loongson_edac_probe(struct platform_device *pdev)
> +{
> +       struct resource *rs;
> +       struct mem_ctl_info *mci;
> +       struct edac_mc_layer layers[2];
> +       struct loongson_edac_pvt *pvt;
> +       u64 *vbase =3D NULL;
> +
> +       rs =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       /* not return if can not find resource or resource start equals N=
ULL */
> +       if (rs && rs->start) {
> +               vbase =3D devm_ioremap_resource(&pdev->dev, rs);
> +               if (IS_ERR(vbase))
> +                       return PTR_ERR(vbase);
> +       }
> +
> +       /* allocate a new MC control structure */
> +       layers[0].type =3D EDAC_MC_LAYER_CHANNEL;
> +       layers[0].size =3D 1;
> +       layers[0].is_virt_csrow =3D false;
> +       layers[1].type =3D EDAC_MC_LAYER_SLOT;
> +       layers[1].size =3D 1;
> +       layers[1].is_virt_csrow =3D true;
> +       mci =3D edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt)=
);
> +       if (mci =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       edac_dbg(0, "MC: mci =3D %p\n", mci);
> +
> +       mci->mc_idx =3D edac_device_alloc_index();
> +       mci->mtype_cap =3D MEM_FLAG_RDDR4;
> +       mci->edac_ctl_cap =3D EDAC_FLAG_NONE;
> +       mci->edac_cap =3D EDAC_FLAG_NONE;
> +       mci->mod_name =3D "loongson_edac.c";
> +       mci->ctl_name =3D "loongson_edac_ctl";
> +       mci->dev_name =3D "loongson_edac_dev";
> +       mci->ctl_page_to_phys =3D NULL;
> +       mci->pdev =3D &pdev->dev;
> +       mci->error_desc.grain =3D 8;
> +       /* Set the function pointer to an actual operation function */
> +       mci->edac_check =3D loongson_edac_check;
> +
> +       loongson_pvt_init(mci, vbase);
> +       get_dimm_config(mci);
> +
> +       if (edac_mc_add_mc(mci)) {
> +               edac_dbg(0, "MC: failed edac_mc_add_mc()\n");
> +               edac_mc_free(mci);
> +       }
> +       edac_op_state =3D EDAC_OPSTATE_POLL;
> +
> +       return 0;
> +}
> +
> +static void loongson_edac_remove(struct platform_device *pdev)
> +{
> +       struct mem_ctl_info *mci =3D edac_mc_del_mc(&pdev->dev);
> +
> +       if (mci)
> +               edac_mc_free(mci);
> +}
> +
> +static const struct of_device_id loongson_edac_of_match[] =3D {
> +       { .compatible =3D "loongson,ls3a5000-mc-edac", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, loongson_edac_of_match);
> +
> +static struct platform_driver loongson_edac_driver =3D {
> +       .probe          =3D loongson_edac_probe,
> +       .remove         =3D loongson_edac_remove,
> +       .driver         =3D {
> +               .name   =3D "ls-mc-edac",
The name can be better as loongson-mc-edac.

Huacai

> +               .of_match_table =3D loongson_edac_of_match,
> +       },
> +};
> +
> +module_platform_driver(loongson_edac_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zhao Qunqin <zhaoqunqin@loongson.cn>\n");
> +MODULE_DESCRIPTION("EDAC driver for loongson memory controller");
> --
> 2.43.0
>

