Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C257A74AA90
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jul 2023 07:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGGFaz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jul 2023 01:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGGFai (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 7 Jul 2023 01:30:38 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD411FDA
        for <linux-edac@vger.kernel.org>; Thu,  6 Jul 2023 22:30:34 -0700 (PDT)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 034F13F364
        for <linux-edac@vger.kernel.org>; Fri,  7 Jul 2023 05:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688707832;
        bh=Rcvw69QpLn6Gnwox1zY9qG81innFRLv6d+U/MX8p2CU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=dexyhdMBYGEj3rMqzJpB5jaDDyrZnxPEPIYTlas8SGLOemEhA6Dr+Ko2BJdRvBohy
         y+GawsaEEZRAVOBsh+Vd3bPzkb9vWMGTe042jM9ScquBD51a0j4m3PjzZoUDoZMehX
         4FmKWr9MDXhNT1S8XHj6kDmEgsucDBdf55uKM0YzpKcDEliXncaITMVHYKROzjbE/2
         FoSxqcJMqSk2268tpIUVGTPNSO/IYJ7G90TzZ8UxXUcE5F5tVadYvebWj1K9eqLHgB
         WCWsxcT/fSMxrWXyiScjKshxaWYY5q9J6jP0w7jWfdLURVtj8VhE28oLV9IVCVkHQL
         XNnydn7diizOw==
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-39c872c8da4so1357433b6e.2
        for <linux-edac@vger.kernel.org>; Thu, 06 Jul 2023 22:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688707831; x=1691299831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rcvw69QpLn6Gnwox1zY9qG81innFRLv6d+U/MX8p2CU=;
        b=U5e9WtL8weBXnapXQ9PgKwBSljhpOErK7AaUbFQkSCoMBpkbNklzwyZijlpw1m3nnO
         cXlNUkv7wpF1lM9fdU9UWBhL5pxImw95mGTLQGERL03lrTmuYgIGMa+8BuE7kyq3ljlA
         JMknvxbbmqnPQNJoHPhMy5/hYzi/Mp2yeBJFbfMFuIQ1Ak6PbP14l5qglb2GgIBvRbFh
         K32DOkp9OAuYi7yzXeu0qzTjWamMnDUwOZtAHwpw0H7AYZmzwbicHiOX0CQrRHN+wATP
         smn1goaUbadT+eb/qktKGCyItb1DRu+AL6FUF6jQLkfohNP6WBdkPeUlufPiHcLFxS6P
         3qGQ==
X-Gm-Message-State: ABy/qLYT9fnq5MfAYHuUa1WSdaomiCEn2iwjd63/4dT94SUmZgPlcwyO
        kcGx14hc259Ui/ruPUyYlVFzszYbgMpu8lzJD58kUUAvgfD0eBIBv0OWUXUJrD8N7CEX+uMCRbq
        os7kEcxmizqTVQizpv7NWxYYRuiMaPkbt/cgA3d8myynCc9hVrmiPeJ0=
X-Received: by 2002:aca:2101:0:b0:3a1:c979:e6b6 with SMTP id 1-20020aca2101000000b003a1c979e6b6mr3778698oiz.34.1688707830898;
        Thu, 06 Jul 2023 22:30:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGANcQ+6cwpZDQUzeDPnNHqyhUxe+A1xYrTFEwyXL6qko+HQGwi0lLef2baL2jjnyPJ35H6QR+Oh4fHfNk9bMQ=
X-Received: by 2002:aca:2101:0:b0:3a1:c979:e6b6 with SMTP id
 1-20020aca2101000000b003a1c979e6b6mr3778685oiz.34.1688707830664; Thu, 06 Jul
 2023 22:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230706134216.37044-1-qiuxu.zhuo@intel.com>
In-Reply-To: <20230706134216.37044-1-qiuxu.zhuo@intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 7 Jul 2023 13:30:19 +0800
Message-ID: <CAAd53p6J8usSi+rHnd9+714mUqZ2zTdhFSEWUtiK7aNzcAZ8CA@mail.gmail.com>
Subject: Re: [PATCH 1/1] EDAC/i10nm: Skip the absent memory controllers
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Koba Ko <koba.ko@canonical.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jul 6, 2023 at 9:46=E2=80=AFPM Qiuxu Zhuo <qiuxu.zhuo@intel.com> wr=
ote:
>
> Some Sapphire Rapids workstations' absent memory controllers
> still appear as PCIe devices that fool the i10nm_edac driver
> and result in "shift exponet -66 is negative" call traces
> from skx_get_dimm_info().
>
> Skip the absent memory controllers to avoid the call traces.
>
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Closes: https://lore.kernel.org/linux-edac/CAAd53p41Ku1m1rapeqb1xtD+kKuk+=
BaUW=3DdumuoF0ZO3GhFjFA@mail.gmail.com/T/#m5de16dce60a8c836ec235868c7c16e3f=
efad0cc2
> Reported-by: Koba Ko <koba.ko@canonical.com>
> Closes: https://lore.kernel.org/linux-edac/SA1PR11MB71305B71CCCC3D9305835=
202892AA@SA1PR11MB7130.namprd11.prod.outlook.com/T/#t
> Fixes: d4dc89d069aa ("EDAC, i10nm: Add a driver for Intel 10nm server pro=
cessors")
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>  drivers/edac/i10nm_base.c | 54 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 49 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
> index a897b6aff368..349ff6cfb379 100644
> --- a/drivers/edac/i10nm_base.c
> +++ b/drivers/edac/i10nm_base.c
> @@ -658,13 +658,49 @@ static struct pci_dev *get_ddr_munit(struct skx_dev=
 *d, int i, u32 *offset, unsi
>         return mdev;
>  }
>
> +/**
> + * i10nm_imc_absent() - Check whether the memory controller @imc is abse=
nt
> + *
> + * @imc    : The pointer to the structure of memory controller EDAC devi=
ce.
> + *
> + * RETURNS : true if the memory controller EDAC device is absent, false =
otherwise.
> + */
> +static bool i10nm_imc_absent(struct skx_imc *imc)
> +{
> +       u32 mcmtr;
> +       int i;
> +
> +       switch (res_cfg->type) {
> +       case SPR:
> +               for (i =3D 0; i < res_cfg->ddr_chan_num; i++) {
> +                       mcmtr =3D I10NM_GET_MCMTR(imc, i);
> +                       edac_dbg(1, "ch%d mcmtr reg %x\n", i, mcmtr);
> +                       if (mcmtr !=3D ~0)
> +                               return false;
> +               }
> +
> +               /*
> +                * Some workstations' absent memory controllers still
> +                * appear as PCIe devices, misleading the EDAC driver.
> +                * By observing that the MMIO registers of these absent
> +                * memory controllers consistently hold the value of ~0.
> +                *
> +                * We identify a memory controller as absent by checking
> +                * if its MMIO register "mcmtr" =3D=3D ~0 in all its chan=
nels.
> +                */
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  static int i10nm_get_ddr_munits(void)
>  {
>         struct pci_dev *mdev;
>         void __iomem *mbase;
>         unsigned long size;
>         struct skx_dev *d;
> -       int i, j =3D 0;
> +       int i, lmc, j =3D 0;
>         u32 reg, off;
>         u64 base;
>
> @@ -690,7 +726,7 @@ static int i10nm_get_ddr_munits(void)
>                 edac_dbg(2, "socket%d mmio base 0x%llx (reg 0x%x)\n",
>                          j++, base, reg);
>
> -               for (i =3D 0; i < res_cfg->ddr_imc_num; i++) {
> +               for (lmc =3D 0, i =3D 0; i < res_cfg->ddr_imc_num; i++) {
>                         mdev =3D get_ddr_munit(d, i, &off, &size);
>
>                         if (i =3D=3D 0 && !mdev) {
> @@ -700,8 +736,6 @@ static int i10nm_get_ddr_munits(void)
>                         if (!mdev)
>                                 continue;
>
> -                       d->imc[i].mdev =3D mdev;
> -
>                         edac_dbg(2, "mc%d mmio base 0x%llx size 0x%lx (re=
g 0x%x)\n",
>                                  i, base + off, size, reg);
>
> @@ -712,7 +746,17 @@ static int i10nm_get_ddr_munits(void)
>                                 return -ENODEV;
>                         }
>
> -                       d->imc[i].mbase =3D mbase;
> +                       d->imc[lmc].mbase =3D mbase;
> +                       if (i10nm_imc_absent(&d->imc[lmc])) {
> +                               pci_dev_put(mdev);
> +                               iounmap(mbase);
> +                               d->imc[lmc].mbase =3D NULL;
> +                               edac_dbg(2, "Skip absent mc%d\n", i);
> +                               continue;
> +                       } else {
> +                               d->imc[lmc].mdev =3D mdev;
> +                               lmc++;
> +                       }
>                 }
>         }
>
> --
> 2.17.1
>
