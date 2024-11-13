Return-Path: <linux-edac+bounces-2520-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F23CB9C6800
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 05:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0631F244FD
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 04:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A072566;
	Wed, 13 Nov 2024 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFNw3vRe"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931FC482EB;
	Wed, 13 Nov 2024 04:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731471280; cv=none; b=K6+23Bm67PDEBCiQsqbaIELl6DB+ZGetcfYwj1ORDoRDZ2jLpS766TwGpjA6DWxI13mgPubDgbnV91hWzBXI7zKZK+Al21Mo+7fVqJb34EqIcgXr2fK4tfIHJnCMsqb4sAPdXZvy8xp2rrrvr13BO+64efDJiTMJBLTh8UVBQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731471280; c=relaxed/simple;
	bh=MoKGjoXqvKMyvJrJHaKRFBOHX9eeZpCGN2QFOA07StA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fw69iBbiiZqdB2JmJGySzYQhdVQw+V+YOKVcabYXTf2BSYa/19ZohATjndmqD7K6JgMh/vTBK0jev3McfOJaQjz/7+4W/DnCXbol3q/hVctbQXcmy9qXQwdylGKbrq/3JOncjdk53n+KxBYRNVmghS75QdtOfTQdPh+SHXIqMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFNw3vRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFCBC4CEDB;
	Wed, 13 Nov 2024 04:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731471280;
	bh=MoKGjoXqvKMyvJrJHaKRFBOHX9eeZpCGN2QFOA07StA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iFNw3vReU/ezlff4oo5WMqcQr9kTZ+QsXjIALpVGwfT/XaY4WQVkwMjwTyUM+dywD
	 pjg/bEVVstFTOWNDAYo7Br2yUWjPr/v7gVE7rWpT/5P4LEIUvI10YoKpWvyxRpn0UT
	 lxzCli6VBHHlIYHS+NKaAOfgbk7XOVwBfzRN/W6P1QkF4zKYtgq0mcUFh25ExwPfix
	 GTyNUZZjrp026vGI9AXXxfLgGt74V1ZsthpykjNDqhUX81TYlUI0cdxL3BWiB2Qule
	 hYizahKHL0MwLoWLUi5Nf7C1s6+T4o4KrdHkDGmG6XOmZNp3z3g/YwswA2Fiy0Paek
	 2l95CWBPlvnXw==
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so5904007f8f.3;
        Tue, 12 Nov 2024 20:14:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUfwLF3ZHnRqmRtOvicGGrhgJa9UwTYpHv3w/i7oSuIe1/pmf37t4rM58LdeFArWK26DL8wRTeBM/roVYmr@vger.kernel.org, AJvYcCVd2I6HomLRF1Zqvx4uQlRBpHPlqCg+9Wo+kqKx1S3Vg5pXrnyIqzvqQSaZy8Ii2aa6VmvcWm5GjLTy@vger.kernel.org
X-Gm-Message-State: AOJu0YybqO8UEj8EJkWqz4i7HTBoa+Xkc5U6/yBpMON1azjIlvwgjxZO
	5VPTtvLb9w4cRCJeGn8GSDwj8OZJ5CzjeNJ6jF5QmhRpRLpP4evJfW7ghaFNjYtNCWcOkIheW6n
	3ecaYNHtWcraw8o0qxaapMcEceKA=
X-Google-Smtp-Source: AGHT+IFnkJp2epERaeNuWbViBVAxUEY19hCrOMD8ca90KiFC56mvt8vHOGRN+r5pGyUeU8Ei4m6oBvyVBU84ASSVbAE=
X-Received: by 2002:a05:6000:1fad:b0:37c:cc4b:d1d6 with SMTP id
 ffacd0b85a97d-381f1872041mr21794112f8f.27.1731471278456; Tue, 12 Nov 2024
 20:14:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113032326.14267-1-zhaoqunqin@loongson.cn>
In-Reply-To: <20241113032326.14267-1-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 13 Nov 2024 12:14:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6+c8sJySdz0QuXWQ_XzXjLZ1WTnN7CimBf-c7U-5JzUQ@mail.gmail.com>
Message-ID: <CAAhV-H6+c8sJySdz0QuXWQ_XzXjLZ1WTnN7CimBf-c7U-5JzUQ@mail.gmail.com>
Subject: Re: [PATCH V8] EDAC: Add EDAC driver for loongson memory controller
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
Cc: kernel@xen0n.name, bp@alien8.de, tony.luck@intel.com, james.morse@arm.com, 
	mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, xry111@xry111.site, 
	Markus.Elfring@web.de, krzk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qunqin

On Wed, Nov 13, 2024 at 11:23=E2=80=AFAM Zhao Qunqin <zhaoqunqin@loongson.c=
n> wrote:
>
> Add ECC support for Loongson SoC DDR controller. This
> driver reports single bit errors (CE) only.
>
> Only ACPI firmware is supported.
Fair enough, if there is only ACPI firmware support EDAC, we don't
need to bother FDT.

>
> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
> ---
> Changes in v8:
>         - Used readl() instead of readq()
>         - Used acpi_device_id instead of of_device_id, then removed
>           dt-bindings
>
> Changes in v7:
>         - Fixed sparse's "incorrect type in assignment"
>         - Cleaned up coding style
>
> Changes in v6:
>         - Changed the Kconfig name to CONFIG_EDAC_LOONGSON
>
> Changes in v5:
>         - Dropepd the loongson_ prefix from all static functions.
>         - Aligned function arguments on the opening brace.
>         - Dropepd useless comments and useless wrapper. Dropped side
>           comments.
>         - Reordered variable declarations.
>
> Changes in v4:
>         - None
>
> Changes in v3:
>         - Addressed review comments raised by Krzysztof and Huacai
>
> Changes in v2:
>         - Addressed review comments raised by Krzysztof
>
>  MAINTAINERS                  |   6 ++
>  arch/loongarch/Kconfig       |   1 +
>  drivers/edac/Kconfig         |   8 ++
>  drivers/edac/Makefile        |   1 +
>  drivers/edac/loongson_edac.c | 155 +++++++++++++++++++++++++++++++++++
>  5 files changed, 171 insertions(+)
>  create mode 100644 drivers/edac/loongson_edac.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e9659a5a7..b36a45051 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13397,6 +13397,12 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.y=
aml
>  F:     drivers/thermal/loongson2_thermal.c
>
> +LOONGSON EDAC DRIVER
> +M:     Zhao Qunqin <zhaoqunqin@loongson.cn>
> +L:     linux-edac@vger.kernel.org
> +S:     Maintained
> +F:     drivers/edac/loongson_edac.c
> +
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:     Sathya Prakash <sathya.prakash@broadcom.com>
>  M:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index bb35c34f8..10b9ba587 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -185,6 +185,7 @@ config LOONGARCH
>         select PCI_MSI_ARCH_FALLBACKS
>         select PCI_QUIRKS
>         select PERF_USE_VMALLOC
> +       select EDAC_SUPPORT
Please use alpha-betical order, which means "select EDAC_SUPPORT"
should be before "select EFI".

>         select RTC_LIB
>         select SPARSE_IRQ
>         select SYSCTL_ARCH_UNALIGN_ALLOW
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 81af6c344..4dce2b92a 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -564,5 +564,13 @@ config EDAC_VERSAL
>           Support injecting both correctable and uncorrectable errors
>           for debugging purposes.
>
> +config EDAC_LOONGSON
> +       tristate "Loongson Memory Controller"
> +       depends on (LOONGARCH && ACPI) || COMPILE_TEST
> +       help
> +         Support for error detection and correction on the Loongson
> +         family memory controller. This driver reports single bit
> +         errors (CE) only. Loongson-3A5000/3C5000/3D5000/3A6000/3C6000
> +         are compatible.
>
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index faf310eec..f8bdbc895 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_DMC520)             +=3D dmc520_edac.=
o
>  obj-$(CONFIG_EDAC_NPCM)                        +=3D npcm_edac.o
>  obj-$(CONFIG_EDAC_ZYNQMP)              +=3D zynqmp_edac.o
>  obj-$(CONFIG_EDAC_VERSAL)              +=3D versal_edac.o
> +obj-$(CONFIG_EDAC_LOONGSON)            +=3D loongson_edac.o
> diff --git a/drivers/edac/loongson_edac.c b/drivers/edac/loongson_edac.c
> new file mode 100644
> index 000000000..340722db1
> --- /dev/null
> +++ b/drivers/edac/loongson_edac.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Loongson Technology Corporation Limited.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/edac.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
Use alpha-betical order too, which means exchange module.h and init.h.

> +#include <linux/platform_device.h>
> +#include "edac_module.h"
> +
> +#define ECC_CS_COUNT_REG       0x18
> +
> +struct loongson_edac_pvt {
> +       void __iomem *ecc_base;
> +       int last_ce_count;
> +};
> +
> +static int read_ecc(struct mem_ctl_info *mci)
> +{
> +       struct loongson_edac_pvt *pvt =3D mci->pvt_info;
> +       u32 ecc;
> +       int cs;
> +
> +       if (!pvt->ecc_base)
> +               return pvt->last_ce_count;
> +
> +       ecc =3D readl(pvt->ecc_base + ECC_CS_COUNT_REG);
If the register is actually 64bit, it is better to use readq, and add
"depends on 64BIT" after config EDAC_LOONGSON.

> +       /* cs0 -- cs3 */
> +       cs =3D ecc & 0xff;
> +       cs +=3D (ecc >> 8) & 0xff;
> +       cs +=3D (ecc >> 16) & 0xff;
> +       cs +=3D (ecc >> 24) & 0xff;
> +
> +       return cs;
> +}
> +
> +static void edac_check(struct mem_ctl_info *mci)
> +{
> +       struct loongson_edac_pvt *pvt =3D mci->pvt_info;
> +       int new, add;
> +
> +       new =3D read_ecc(mci);
> +       add =3D new - pvt->last_ce_count;
> +       pvt->last_ce_count =3D new;
> +       if (add <=3D 0)
> +               return;
> +
> +       edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, add,
> +                            0, 0, 0, 0, 0, -1, "error", "");
> +       edac_mc_printk(mci, KERN_INFO, "add: %d", add);
> +}
> +
> +static void dimm_config_init(struct mem_ctl_info *mci)
> +{
> +       struct dimm_info *dimm;
> +       u32 size, npages;
> +
> +       /* size not used */
> +       size =3D -1;
> +       npages =3D MiB_TO_PAGES(size);
> +
> +       dimm =3D edac_get_dimm(mci, 0, 0, 0);
> +       dimm->nr_pages =3D npages;
> +       snprintf(dimm->label, sizeof(dimm->label),
> +                "MC#%uChannel#%u_DIMM#%u", mci->mc_idx, 0, 0);
> +       dimm->grain =3D 8;
> +}
> +
> +static void pvt_init(struct mem_ctl_info *mci, void __iomem *vbase)
> +{
> +       struct loongson_edac_pvt *pvt =3D mci->pvt_info;
> +
> +       pvt->ecc_base =3D vbase;
> +       pvt->last_ce_count =3D read_ecc(mci);
> +}
> +
> +static int edac_probe(struct platform_device *pdev)
> +{
> +       struct edac_mc_layer layers[2];
> +       struct mem_ctl_info *mci;
> +       void __iomem *vbase;
> +       int ret;
> +
> +       vbase =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(vbase))
> +               return PTR_ERR(vbase);
> +
> +       /* allocate a new MC control structure */
> +       layers[0].type =3D EDAC_MC_LAYER_CHANNEL;
> +       layers[0].size =3D 1;
> +       layers[0].is_virt_csrow =3D false;
> +       layers[1].type =3D EDAC_MC_LAYER_SLOT;
> +       layers[1].size =3D 1;
> +       layers[1].is_virt_csrow =3D true;
> +       mci =3D edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
> +                           sizeof(struct loongson_edac_pvt));
> +       if (mci =3D=3D NULL)
> +               return -ENOMEM;
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
> +       mci->edac_check =3D edac_check;
> +
> +       pvt_init(mci, vbase);
> +       dimm_config_init(mci);
> +
> +       ret =3D edac_mc_add_mc(mci);
> +       if (ret) {
> +               edac_dbg(0, "MC: failed edac_mc_add_mc()\n");
> +               edac_mc_free(mci);
> +               return ret;
> +       }
> +       edac_op_state =3D EDAC_OPSTATE_POLL;
> +
> +       return 0;
> +}
> +
> +static void edac_remove(struct platform_device *pdev)
> +{
> +       struct mem_ctl_info *mci =3D edac_mc_del_mc(&pdev->dev);
> +
> +       if (mci)
> +               edac_mc_free(mci);
> +}
> +
> +static const struct acpi_device_id loongson_edac_acpi_match[] =3D {
> +       {"LOON000G", 0},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, loongson_edac_acpi_match);
> +
> +static struct platform_driver loongson_edac_driver =3D {
> +       .probe          =3D edac_probe,
> +       .remove         =3D edac_remove,
> +       .driver         =3D {
> +               .name   =3D "loongson-mc-edac",
> +               .acpi_match_table =3D loongson_edac_acpi_match,
> +       },
> +};
> +module_platform_driver(loongson_edac_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zhao Qunqin <zhaoqunqin@loongson.cn>");
Family name is usually at last, but still depends on yourself. If you
change the order, please keep consistency in the whole patch.

Others look good to me, and you can add "Reviewed-by: Huacai Chen
<chenhuacai@loongson.cn>" in the next version.

Huacai

> +MODULE_DESCRIPTION("EDAC driver for loongson memory controller");
>
> base-commit: e14232afa94445e03fc3a0291b07a68f3408c120
> --
> 2.43.0
>

