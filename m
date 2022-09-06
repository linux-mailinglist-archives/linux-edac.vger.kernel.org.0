Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25DE5ADCFB
	for <lists+linux-edac@lfdr.de>; Tue,  6 Sep 2022 03:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiIFBkX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 21:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIFBkW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 21:40:22 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9975B53D33;
        Mon,  5 Sep 2022 18:40:21 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id m16so2297593ilg.3;
        Mon, 05 Sep 2022 18:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=BLCIYXFzxz6s1/j3ZB3Rou7Ui9yNjgppVcQ6BAlU/1M=;
        b=iN5/LTKj7WXSBoAPfOm+dizqeEH3nd3bz8F9PsnSjjQLO/p85YuXMHNlLSMsjUhY0o
         BzFK4uN56yXTXp6yJSvBhTJNI5TW8TeoF76QkeXZP9yY/1gdf1hqej9TQQgSlarAdNKS
         0b+/hMzE2O9+c8SaMMaauZim7mlPpkwwKGJM3qy+3N7tGi5cs4N0sQpdMTCZiT7ctRvD
         rOyLo89XGsThjyv57I3y/gyf/ZBrDNVGITxxVwj+5FSnZm7bCHwePiA4u9CgJWd/RERv
         3LttJiXM8CO8tCpO6LElOPIpoGA8XpmrPxo2x+fPsUieIrSOd/qmD1qBSOv2MkmMF5R/
         M6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BLCIYXFzxz6s1/j3ZB3Rou7Ui9yNjgppVcQ6BAlU/1M=;
        b=8IJzkhAkK57IqRqgoSN7Sn2ESYqnwDlK/VuCZiMBqKl9Ci/5ubmNK0je5h4JTGtNPx
         IjMm6Gzmiu5afVFEHrRKBqcX0LVaWVhvaq14cbQcMxV7/LoiuL8U4nfQxhcnzF9p53a+
         pmaHvRAHoRVUd+k3rjX7oFQvoqzm+D43gAokh+vw+zFDnlcKgZIxuOhAjQyumQW2vkLO
         NCRcD/Q4+TNiKQZBTIY2F9yzylgdEgz2fxlaAfCHO5ckEil7eCsUQXw2uSyueRA44Gsi
         t2cx7VBVXJtqTUqB2SXRF2PXMVq6OfVY6wqGZl7KtnpaDGM+4TEq9TUE7J9xWKmz9YcQ
         epAQ==
X-Gm-Message-State: ACgBeo3sBZ/sDAKVbrydvoYDSHEYOAnZWBt2EVG8RegICLH6Ueei6QVU
        9bUpxaFDwn6DGSNcKp1w+h09F+mWv7Ua4aZhsNo=
X-Google-Smtp-Source: AA6agR4eBl0Sp41QNwnOSoe9ia/irlsn0OpEr0CLRY8Gg8i8RT5dVJIdLkrElwQcDzWSvKyr6N+dmyy34ht87oRs1+Q=
X-Received: by 2002:a05:6e02:1645:b0:2f1:574e:a862 with SMTP id
 v5-20020a056e02164500b002f1574ea862mr4544828ilu.163.1662428420973; Mon, 05
 Sep 2022 18:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220905083125.29426-1-zong.li@sifive.com> <20220905083125.29426-5-zong.li@sifive.com>
 <490336f2-5028-499f-d78f-620e083b3c61@microchip.com>
In-Reply-To: <490336f2-5028-499f-d78f-620e083b3c61@microchip.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Tue, 6 Sep 2022 09:40:09 +0800
Message-ID: <CA+ZOyah2Sw4vO5nDbOGHr_cP+VDh6JWH8A-82YBFkDnM5ks3+A@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] soc: sifive: ccache: reduce printing on init
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
=E9=80=B1=E4=BA=8C =E5=87=8C=E6=99=A83:18=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 05/09/2022 09:31, Zong Li wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >
> > From: Ben Dooks <ben.dooks@sifive.com>
> >
> > The driver prints out 6 lines on startup, which can easily be redcued
> > to two lines without losing any information.
> >
> > Note, to make the types work better, uint64_t has been replaced with
> > ULL to make the unsigned long long match the format in the print
> > statement.
> >
> > Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>
> Hey Zong,
> Missing your SoB after Ben's here btw.
>

Ok, I would add it in V3.

> > ---
> >  drivers/soc/sifive/sifive_ccache.c | 25 +++++++++++--------------
> >  1 file changed, 11 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/si=
five_ccache.c
> > index 0e0eb85c94d8..401c67a485e2 100644
> > --- a/drivers/soc/sifive/sifive_ccache.c
> > +++ b/drivers/soc/sifive/sifive_ccache.c
> > @@ -81,20 +81,17 @@ static void setup_sifive_debug(void)
> >
> >  static void ccache_config_read(void)
> >  {
> > -       u32 regval, val;
> > -
> > -       regval =3D readl(ccache_base + SIFIVE_CCACHE_CONFIG);
> > -       val =3D regval & 0xFF;
> > -       pr_info("CCACHE: No. of Banks in the cache: %d\n", val);
> > -       val =3D (regval & 0xFF00) >> 8;
> > -       pr_info("CCACHE: No. of ways per bank: %d\n", val);
> > -       val =3D (regval & 0xFF0000) >> 16;
> > -       pr_info("CCACHE: Sets per bank: %llu\n", (uint64_t)1 << val);
> > -       val =3D (regval & 0xFF000000) >> 24;
> > -       pr_info("CCACHE: Bytes per cache block: %llu\n", (uint64_t)1 <<=
 val);
> > -
> > -       regval =3D readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
> > -       pr_info("CCACHE: Index of the largest way enabled: %d\n", regva=
l);
> > +       u32 cfg;
> > +
> > +       cfg =3D readl(ccache_base + SIFIVE_CCACHE_CONFIG);
> > +
> > +       pr_info("CCACHE: %u banks, %u ways, sets/bank=3D%llu, bytes/blo=
ck=3D%llu\n",
> > +               (cfg & 0xff), (cfg >> 8) & 0xff,
> > +               BIT_ULL((cfg >> 16) & 0xff),
> > +               BIT_ULL((cfg >> 24) & 0xff));
>
> Could we use defines please for the register shifts please?
>

Yes, let me define them in V3

> > +
> > +       cfg =3D readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
> > +       pr_info("CCACHE: Index of the largest way enabled: %d\n", cfg);
>
> %u here no?

Thanks for point it out. I would change it in V3.

> Thanks,
> Conor.
>
> >  }
> >
> >  static const struct of_device_id sifive_ccache_ids[] =3D {
> > --
> > 2.17.1
> >
>
