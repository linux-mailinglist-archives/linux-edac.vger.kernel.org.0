Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BA05ADD1D
	for <lists+linux-edac@lfdr.de>; Tue,  6 Sep 2022 03:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIFB54 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 21:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiIFB5y (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 21:57:54 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F2F29CA3;
        Mon,  5 Sep 2022 18:57:53 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b142so7851722iof.10;
        Mon, 05 Sep 2022 18:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=EYmJBnNyOnswLgNST6mnKgMxX73HOt+H1Hff9PW99mI=;
        b=l+C32q5yBAxWIBZ79fWNH0JOMzUE1tW4dqHjizDaLcOHME+YjHgF8C27nUJ/7PNS62
         1nlTJDs93oZAAsbVSbtLR34N8/1v1ZJHCb3FKIVMC9lkW3PQe/rWiTtywAEmG/WoAAFU
         C66De/GVhwPtuBnPQ+mr90QmlwIUF//gozYZsCMRPDmPHk1wGmyQuXUNFBZkdDm4mqqd
         AXv8Yj7qa3AHF5aQYzrminPmveSSxb3y4GC04PT2dwxWe4BKsAvE1z8Ojq2Qhl3HYHJ/
         0V2LhbQF0GUKwkFpfokLwHtepv9E2rLJ+uNAgPqFfASjXx04mxh4kbIrwW/HZLuVvm7U
         aO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EYmJBnNyOnswLgNST6mnKgMxX73HOt+H1Hff9PW99mI=;
        b=uVoXCXcV6n8+joKen9tlUf8ZQi28XB28TfH0wRPIwjcHkUYkrkG5+WL7badvN6MlOP
         OdmXc465LXyKM0zMAP5gNRYOBZB8hyAvDrclqoVO0E+2KDO49LjUR8mNtr4EL2wA3N+F
         Dq09+mjnLUMdZFS28+H7HTti2hE9hZdoVz5rM/Oh6XC5DhKihD+KOj+GljBbVrrmaHUu
         L+0qmFnGBbQWUxdQ3sk8EnR2w+RaMrKwfukQP1MADeVN8+JeKKnWK2a87g6ipRJRsm2S
         ouIxklb1s3cthLjiESyhm29/0IHsO8T+V7eC66p7Zv8ui33cgHbVVXPX78i0SvlYh86y
         MuEw==
X-Gm-Message-State: ACgBeo2WHBc0rHQqCEkW/TKaVggmoyAHe4pFjxEIxY8IDp3RaSB1jIlA
        yAOvS5C5kkk8tzeFSfuCLICI2BAZNdrCXH1nxUI=
X-Google-Smtp-Source: AA6agR5qyGZfiGb98GNwxEhPNkC1kZ/sl1ugbTGIO+9cRRKohMNbJAzJVF1UYJ13KDqSpQ8pMM+JjMyyKESnaA/4EG0=
X-Received: by 2002:a05:6602:1482:b0:688:d06b:223e with SMTP id
 a2-20020a056602148200b00688d06b223emr23898832iow.3.1662429472520; Mon, 05 Sep
 2022 18:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220905083125.29426-1-zong.li@sifive.com> <20220905083125.29426-4-zong.li@sifive.com>
 <cf98f606-a392-37e9-be92-cb854afb4951@microchip.com>
In-Reply-To: <cf98f606-a392-37e9-be92-cb854afb4951@microchip.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Tue, 6 Sep 2022 09:57:40 +0800
Message-ID: <CA+ZOyaheXVbETyj6YFMn4sb25Feqm9AV0EuuKDbaRXJjAY+_tQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] soc: sifive: ccache: determine the cache level
 from dts
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
=E9=80=B1=E4=BA=8C =E5=87=8C=E6=99=A82:56=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 05/09/2022 09:31, Zong Li wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >
> > Composable cache could be L2 or L3 cache, use 'cache-level' property of
> > device node to determine the level.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  drivers/soc/sifive/sifive_ccache.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/si=
five_ccache.c
> > index 1b16a196547f..0e0eb85c94d8 100644
> > --- a/drivers/soc/sifive/sifive_ccache.c
> > +++ b/drivers/soc/sifive/sifive_ccache.c
> > @@ -38,6 +38,7 @@
> >  static void __iomem *ccache_base;
> >  static int g_irq[SIFIVE_CCACHE_MAX_ECCINTR];
> >  static struct riscv_cacheinfo_ops ccache_cache_ops;
> > +static int level;
>
> Can you have a system with a composable l2 & l3 cache?

We don't have a system with composable L2 and L3 cache at same time.
But as I mentioned in the thread of second patch, we use another cache
as L2 when the composable cache used for L3.

>
> >
> >  enum {
> >         DIR_CORR =3D 0,
> > @@ -143,7 +144,7 @@ static const struct attribute_group priv_attr_group=
 =3D {
> >  static const struct attribute_group *ccache_get_priv_group(struct cach=
einfo *this_leaf)
> >  {
> >         /* We want to use private group for composable cache only */
> > -       if (this_leaf->level =3D=3D 2)
> > +       if (this_leaf->level =3D=3D level)
> >                 return &priv_attr_group;
> >         else
> >                 return NULL;
> > @@ -210,6 +211,9 @@ static int __init sifive_ccache_init(void)
> >         if (!ccache_base)
> >                 return -ENOMEM;
> >
> > +       if (of_property_read_u32(np, "cache-level", &level))
> > +               return -ENODEV;
> > +
> >         intr_num =3D of_property_count_u32_elems(np, "interrupts");
> >         if (!intr_num) {
> >                 pr_err("CCACHE: no interrupts property\n");
> > --
> > 2.17.1
> >
>
