Return-Path: <linux-edac+bounces-1922-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 506B398521F
	for <lists+linux-edac@lfdr.de>; Wed, 25 Sep 2024 06:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F5BB20FD6
	for <lists+linux-edac@lfdr.de>; Wed, 25 Sep 2024 04:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C40714F9FF;
	Wed, 25 Sep 2024 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1El/+qQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07CC14A4DD;
	Wed, 25 Sep 2024 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727239626; cv=none; b=QgOArvskv/HUM7vqmOt1DHeFMA7SKUSST9FCXxggvTOq07T8NvuM8+dRnLAw1UCrye+2pzefNWbA931W4mdlSSmLy+YY15qPc//9TCQdodDn1SnlOxNJd09SJPTBZR8RgNMYMCYoylbbcmSu3rdx9NO3YdM60zmT9ubogmN/TJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727239626; c=relaxed/simple;
	bh=xLlbnEHc7wxS5xFncSqo0VRoTuUPV+ChEsO1zrVTDaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJf3bIJSaJlRyuwoyXOtlm5TwKByvgMyUDAMZSbmJAAVVnHIVilzeQOgSDJfSu5zMU6bcwPy9SV5KOyaWKhOX/1G2bWamz5MByFwAr6xb90nbusRC6Tf6JQLgxZxFHwoXd0yjjhbz1XOV7Dr7z8la5geRLTqgdW/fUk2JRp2ues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1El/+qQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2B4C4CECE;
	Wed, 25 Sep 2024 04:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727239626;
	bh=xLlbnEHc7wxS5xFncSqo0VRoTuUPV+ChEsO1zrVTDaA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S1El/+qQLjXOzPvrp55FNWcwQKZQJkXldj6qMNEUhztAUaG1+i0a7jDWD3KNbXOaw
	 xDCiAMcQWZ+jDQet1+mdfClfej72zVmE3T3fg8tGolPZJixl3Uw+vpaMSkDylyXfrN
	 FvezevPkN3rU2fpEUa3WqKkM3YGbCoRsjuFGGdwjPd7FaYg7c4EJQN5gsoiMLS2sUU
	 Bz0SRAgtfFKvUqs/x+MTws+sDO7+XoUbT/f3dNdDQEgQZ6sqJvdwcOTNBTnhNL93pc
	 CU/Au5uadJiqf6U0ifpw6ql1M5E9RxiuOi2bO7MhET4sRCjDXXAXKTAYTtHm0U6Q2F
	 Dtu/S8PFFm23Q==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so923713666b.3;
        Tue, 24 Sep 2024 21:47:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAGb9I0z4G9ndaFsXGVT0xZrBjx20wPJbIFQhBLBRfWpujK3EYP48T00LuifGbvGK9BuId/cqKJNB3fw==@vger.kernel.org, AJvYcCWPwhXF3lKB8LAtzRDpOojq6dASk2ZLMUHApnyYfaSMrPz3LxzNOvp1AulxlFe+nCYjgmxYjqB/aXaBJhYr@vger.kernel.org, AJvYcCX49HvPXG2iq9fTw4D3/7MQNf/ZHCbcocyovsUH1zcYmeQCRh8PaQYu6LiTdvyZTDb+2fx0utlB/2qj@vger.kernel.org
X-Gm-Message-State: AOJu0YzFM2fRkovAfAzPh1jQwAz5IWPqDtGuxaE3yOwCpz+S+WoTE9LU
	8U4YorV6ehqQjMXAqbFUzXT615e/EcViLXFhUDiCeMPW2zUQXXFPpwHjKhRWvBa05ofkBxiNto6
	f0JBXvDl5cnmkA/ANnosafaxLJOE=
X-Google-Smtp-Source: AGHT+IGvXfw+xeGWiI32npRjyuj4MRFiLlupX5c+r0qkQWWziHI4VjhpJu32uZwIaSG4a8uSnTauWRVgQgoCDfrCytE=
X-Received: by 2002:a17:907:7e88:b0:a8a:8dd1:b2d1 with SMTP id
 a640c23a62f3a-a93a06bbfa7mr130659266b.55.1727239624827; Tue, 24 Sep 2024
 21:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925024038.9844-1-zhaoqunqin@loongson.cn> <20240925024038.9844-3-zhaoqunqin@loongson.cn>
In-Reply-To: <20240925024038.9844-3-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 25 Sep 2024 12:46:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5e4TxqeZtSRjKUVs7=U=EZsGu8+TLVxv+qCknYkNCBFQ@mail.gmail.com>
Message-ID: <CAAhV-H5e4TxqeZtSRjKUVs7=U=EZsGu8+TLVxv+qCknYkNCBFQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] Loongarch: EDAC driver for loongson memory controller
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, bp@alien8.de, 
	tony.luck@intel.com, linux-edac@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@xen0n.name, james.morse@arm.com, 
	mchehab@kernel.org, rric@kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Qunqin,

The title should be "EDAC: Add EDAC driver for loongson memory controller"

On Wed, Sep 25, 2024 at 10:40=E2=80=AFAM Zhao Qunqin <zhaoqunqin@loongson.c=
n> wrote:
>
> Reports single bit errors (CE) only.
>
> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
> ---
> Changes in v5:
>         - Drop the loongson_ prefix from all static functions.
>         - Align function arguments on the opening brace.
>         - Drop useless comments and useless wrapper. Drop side comments.
>         - Reorder variable declarations.
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
> @@ -13242,6 +13242,7 @@ M:      Zhao Qunqin <zhaoqunqin@loongson.cn>
>  L:     linux-edac@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.=
yaml
> +F:     drivers/edac/loongson_edac.c
>
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:     Sathya Prakash <sathya.prakash@broadcom.com>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 70f169210..9c135f1a2 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -181,6 +181,7 @@ config LOONGARCH
>         select PCI_MSI_ARCH_FALLBACKS
>         select PCI_QUIRKS
>         select PERF_USE_VMALLOC
> +       select EDAC_SUPPORT
>         select RTC_LIB
>         select SPARSE_IRQ
>         select SYSCTL_ARCH_UNALIGN_ALLOW
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 81af6c344..719bb6ca7 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -564,5 +564,13 @@ config EDAC_VERSAL
>           Support injecting both correctable and uncorrectable errors
>           for debugging purposes.
>
> +config EDAC_LOONGSON3
> +       tristate "Loongson-3 Memory Controller"
> +       depends on LOONGARCH || COMPILE_TEST
> +       help
> +         Support for error detection and correction on the Loongson-3
> +         family memory controller. This driver reports single bit
> +         errors (CE) only. Loongson-3A5000/3C5000/3D5000/3C5000L/3A6000/=
3C6000
> +         are compatible.
>
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index faf310eec..e72ca1be4 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_DMC520)             +=3D dmc520_edac.=
o
>  obj-$(CONFIG_EDAC_NPCM)                        +=3D npcm_edac.o
>  obj-$(CONFIG_EDAC_ZYNQMP)              +=3D zynqmp_edac.o
>  obj-$(CONFIG_EDAC_VERSAL)              +=3D versal_edac.o
> +obj-$(CONFIG_EDAC_LOONGSON3)           +=3D loongson_edac.o
Change the Kconfig name to CONFIG_EDAC_LOONGSON, or change the file
name to loongson3_edac.c may be a little better.

Huacai

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
> +static int read_ecc(struct mem_ctl_info *mci)
> +{
> +       struct loongson_edac_pvt *pvt =3D mci->pvt_info;
> +       u64 ecc;
> +       int cs;
> +
> +       if (!pvt->ecc_base)
> +               return pvt->last_ce_count;
> +
> +       ecc =3D pvt->ecc_base[ECC_CS_COUNT];
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
> +static int get_dimm_config(struct mem_ctl_info *mci)
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
> +
> +       return 0;
> +}
> +
> +static void pvt_init(struct mem_ctl_info *mci, u64 *vbase)
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
> +       struct loongson_edac_pvt *pvt;
> +       struct mem_ctl_info *mci;
> +       u64 *vbase;
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
> +       mci =3D edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt)=
);
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
> +       get_dimm_config(mci);
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
> +static const struct of_device_id loongson_edac_of_match[] =3D {
> +       { .compatible =3D "loongson,ls3a5000-mc-edac", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, loongson_edac_of_match);
> +
> +static struct platform_driver loongson_edac_driver =3D {
> +       .probe          =3D edac_probe,
> +       .remove         =3D edac_remove,
> +       .driver         =3D {
> +               .name   =3D "loongson-mc-edac",
> +               .of_match_table =3D loongson_edac_of_match,
> +       },
> +};
> +module_platform_driver(loongson_edac_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zhao Qunqin <zhaoqunqin@loongson.cn>");
> +MODULE_DESCRIPTION("EDAC driver for loongson memory controller");
> --
> 2.43.0
>
>

