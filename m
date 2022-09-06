Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660555ADCF7
	for <lists+linux-edac@lfdr.de>; Tue,  6 Sep 2022 03:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiIFBiZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 21:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiIFBiY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 21:38:24 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EEC41D17;
        Mon,  5 Sep 2022 18:38:23 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id g1so2146783iob.13;
        Mon, 05 Sep 2022 18:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=GJEP/iVPvYxmtbWHaBUVoD5GwAJSKprJOAI/GNdvJWQ=;
        b=W15Ev3r0KlGw/5uuAOSgYh0lZOVrDoqyQzbu0Lv4ZC8FjdoAJM9yjz9xKqfKuri+ot
         PkBfO/ogqR1JPNpRlxUutJ1xTMUejyeQLaUYwlnwb+SV8+dh06kUoPPwBP0RnT+d7Gp3
         ox0hrBjbI97Z1gcCEMTYLZfarWhAL/M7HcPZpAto7qqEHuZxgRanEmILuIDoe6eNG2gm
         u0xsuGoNbpkqqZGNA9XHaeQcqHqyD0TGR8q3dWBhNAQt2CXpOYTV/T55h0asX9nKlGUR
         1UtAQqGPM39sl+naY/oqbBWff5pxdbttwzzcwHmIp23XdabbcT1n+oalhEkQGXLC8bVm
         zMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GJEP/iVPvYxmtbWHaBUVoD5GwAJSKprJOAI/GNdvJWQ=;
        b=ULJIqXIbq2NCWkp6ITL2eVQgruo7d/e9paw7IjLxIuLJJ72V64QflwhLS0asN8v5ZG
         jLXo0PVXQYXNZd/xFDViGftjmM1g7SuBxpsgpOJ5cJxzMw6OQrF3U1NPWkBz7Q7/6XNA
         2FCNocnEbTSIqPvVfpChOwDmStXyOKTqbqVsQW1CSKQcQqPxdkfr1K8P1SxBECyRGEp4
         fvL8bS1oHg/ZAmr1zHQ5lXKjwKWtPV0gQ4eun6/hVwKLF0JHVzsZIDRcKwaT9kpKIqoC
         THwerusquZYKXtRmebOBzz15dqY9Vd4XLdEM44PnL1N0z4Fc0ngv0jrt2uZ2LYcXlQVU
         Lsyw==
X-Gm-Message-State: ACgBeo0QQpIiFyv/41NowNNiNslxgfd4/ulCPvPP4kXr9GOeRfXB8sH7
        QM7izDRB/SXr26BBs0b9i6q2ljlsswPHlWQiA6KAHGMS
X-Google-Smtp-Source: AA6agR4V2e1Ge5uXhw4Ptpim3ZA2pdfnnYdoi0fxbpqfbRDsSMT/0wAqhWFa96iFfjT0GY8Qkw32NhdzXFc0fuW+rNE=
X-Received: by 2002:a05:6638:3047:b0:341:de2b:e489 with SMTP id
 u7-20020a056638304700b00341de2be489mr27895263jak.273.1662428302536; Mon, 05
 Sep 2022 18:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220905083125.29426-1-zong.li@sifive.com> <20220905083125.29426-6-zong.li@sifive.com>
 <74571708-be33-bee2-fdc2-01492f121cda@microchip.com>
In-Reply-To: <74571708-be33-bee2-fdc2-01492f121cda@microchip.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Tue, 6 Sep 2022 09:38:10 +0800
Message-ID: <CA+ZOyahFAQGPb4Ffqb_6NcaoxNLCdyBEeoY=ySJ4zLK8bhqWkg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] soc: sifive: ccache: use pr_fmt() to remove
 CCACHE: prefixes
To:     Conor.Dooley@microchip.com
Cc:     zong.li@sifive.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        greentime.hu@sifive.com, ben.dooks@sifive.com, bp@alien8.de,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

<Conor.Dooley@microchip.com> =E6=96=BC 2022=E5=B9=B49=E6=9C=886=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E5=87=8C=E6=99=A82:47=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 05/09/2022 09:31, Zong Li wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >
> > From: Ben Dooks <ben.dooks@sifive.com>
> >
> > Use the pr_fmt() macro to prefix all the output with "CCACHE:"
> > to avoid having to write it out each time, or make a large diff
> > when the next change comes along.
> >
> > Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>
> Missing your SoB again here Zong Li btw, other than that:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks, I would add it in V3.

>
> > ---
> >  drivers/soc/sifive/sifive_ccache.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/si=
five_ccache.c
> > index 401c67a485e2..d749600c0bf8 100644
> > --- a/drivers/soc/sifive/sifive_ccache.c
> > +++ b/drivers/soc/sifive/sifive_ccache.c
> > @@ -5,6 +5,9 @@
> >   * Copyright (C) 2018-2022 SiFive, Inc.
> >   *
> >   */
> > +
> > +#define pr_fmt(fmt) "CCACHE: " fmt
> > +
> >  #include <linux/debugfs.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/of_irq.h>
> > @@ -85,13 +88,13 @@ static void ccache_config_read(void)
> >
> >         cfg =3D readl(ccache_base + SIFIVE_CCACHE_CONFIG);
> >
> > -       pr_info("CCACHE: %u banks, %u ways, sets/bank=3D%llu, bytes/blo=
ck=3D%llu\n",
> > +       pr_info("%u banks, %u ways, sets/bank=3D%llu, bytes/block=3D%ll=
u\n",
> >                 (cfg & 0xff), (cfg >> 8) & 0xff,
> >                 BIT_ULL((cfg >> 16) & 0xff),
> >                 BIT_ULL((cfg >> 24) & 0xff));
> >
> >         cfg =3D readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
> > -       pr_info("CCACHE: Index of the largest way enabled: %d\n", cfg);
> > +       pr_info("Index of the largest way enabled: %d\n", cfg);
> >  }
> >
> >  static const struct of_device_id sifive_ccache_ids[] =3D {
> > @@ -154,7 +157,7 @@ static irqreturn_t ccache_int_handler(int irq, void=
 *device)
> >         if (irq =3D=3D g_irq[DIR_CORR]) {
> >                 add_h =3D readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_H=
IGH);
> >                 add_l =3D readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_L=
OW);
> > -               pr_err("CCACHE: DirError @ 0x%08X.%08X\n", add_h, add_l=
);
> > +               pr_err("DirError @ 0x%08X.%08X\n", add_h, add_l);
> >                 /* Reading this register clears the DirError interrupt =
sig */
> >                 readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_COUNT);
> >                 atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CC=
ACHE_ERR_TYPE_CE,
> > @@ -172,7 +175,7 @@ static irqreturn_t ccache_int_handler(int irq, void=
 *device)
> >         if (irq =3D=3D g_irq[DATA_CORR]) {
> >                 add_h =3D readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_H=
IGH);
> >                 add_l =3D readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_L=
OW);
> > -               pr_err("CCACHE: DataError @ 0x%08X.%08X\n", add_h, add_=
l);
> > +               pr_err("DataError @ 0x%08X.%08X\n", add_h, add_l);
> >                 /* Reading this register clears the DataError interrupt=
 sig */
> >                 readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_COUNT);
> >                 atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CC=
ACHE_ERR_TYPE_CE,
> > @@ -181,7 +184,7 @@ static irqreturn_t ccache_int_handler(int irq, void=
 *device)
> >         if (irq =3D=3D g_irq[DATA_UNCORR]) {
> >                 add_h =3D readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_=
HIGH);
> >                 add_l =3D readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_=
LOW);
> > -               pr_err("CCACHE: DataFail @ 0x%08X.%08X\n", add_h, add_l=
);
> > +               pr_err("DataFail @ 0x%08X.%08X\n", add_h, add_l);
> >                 /* Reading this register clears the DataFail interrupt =
sig */
> >                 readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_COUNT);
> >                 atomic_notifier_call_chain(&ccache_err_chain, SIFIVE_CC=
ACHE_ERR_TYPE_UE,
> > @@ -221,7 +224,7 @@ static int __init sifive_ccache_init(void)
> >                 g_irq[i] =3D irq_of_parse_and_map(np, i);
> >                 rc =3D request_irq(g_irq[i], ccache_int_handler, 0, "cc=
ache_ecc", NULL);
> >                 if (rc) {
> > -                       pr_err("CCACHE: Could not request IRQ %d\n", g_=
irq[i]);
> > +                       pr_err("Could not request IRQ %d\n", g_irq[i]);
> >                         return rc;
> >                 }
> >         }
> > --
> > 2.17.1
> >
>
