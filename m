Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320575ADD07
	for <lists+linux-edac@lfdr.de>; Tue,  6 Sep 2022 03:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiIFBoP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 21:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIFBoO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 21:44:14 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9B76B16D;
        Mon,  5 Sep 2022 18:44:13 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id q81so7846696iod.9;
        Mon, 05 Sep 2022 18:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=e08D4SbYcUhaLYKlJn1NPNEeQS9ZOdXgn69FJxpJUWU=;
        b=aSf23VvqYq9Z9jdxRlZRJnEDJ7mvD/LHSdN8oA/u47qteegSQ8x0ao1esHDGm4oa2C
         k+Dvbmdxt4429HmYjGNYHNbMjVa5CqcDHeMYlS5YiX4Y/RNeIfYnazKP7CCcKpzO6m1B
         bq/tkOXVBPUmE4dMXlE6r/L96eop3rSNYx0TCPDvJeibI3ol0i+lyQCTxv64UVhq7hJk
         cHVHMwzGYpwtoJtc9vGXnxL8zK0m48T+eDHXBYjmkP5/eB818ZK5eOT+7ovgZS9mNSHN
         yekuhVwAYg598tep+YJ++aQU/Dlbrd18IzF5iXb9sWesBBQxxTlJ/AjtM9cE1sTgxTyw
         d7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=e08D4SbYcUhaLYKlJn1NPNEeQS9ZOdXgn69FJxpJUWU=;
        b=XoPJF87Su9j79iTIL/PJ73mSYmXzb9ePaB9ZT6FBnEhuMuIfFVq9DVSuXUsUJfZSB0
         sVerqnMfYm6A5RwLqBhMcWPsp2az24z/dnEk2vo0r6IPRLgEpQ6p2px2o9Yohe/bcbQB
         YUNwXb+nap3MTE4yQHAfvNcwGY2C47BxNwL9x+Gi/GYGYZVKHkQcuUz7QzKrsb9aysJ5
         HevJ7FsNiPwqV+rEZUGuP5Iyqvo3OiLQvTGoixyZv4KZxfHQxp/Wc9Sx8HIGau9LNZj6
         bmYBOtTPlSvia0OOrBe4WyklLOydRYka38BjMOwerN4JQneqCHJy+ctiyMLMei+GbCgI
         CHvA==
X-Gm-Message-State: ACgBeo1bbbdpjbShfgMBa5jCw14PTRIcoVYDXCHy2Zs8pC2QEBI9je1u
        ZQw9wVrngZCWeeilSpv6g0n4LoMaiktMZ4MeMr4=
X-Google-Smtp-Source: AA6agR7xh1vB2jFhH2LWVWFGJ55z+0Yj4EDaWMZotdc41OWc9x+Bg1vM4mSD3IyJX4nRCXIrG/8QekXPK7zob+GxIfI=
X-Received: by 2002:a05:6602:1482:b0:688:d06b:223e with SMTP id
 a2-20020a056602148200b00688d06b223emr23881601iow.3.1662428653335; Mon, 05 Sep
 2022 18:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220905083125.29426-1-zong.li@sifive.com> <20220905083125.29426-3-zong.li@sifive.com>
 <2a22c6ac-dc0e-7066-8f5f-04c428c77ee2@microchip.com>
In-Reply-To: <2a22c6ac-dc0e-7066-8f5f-04c428c77ee2@microchip.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Tue, 6 Sep 2022 09:44:01 +0800
Message-ID: <CA+ZOyah199Vsa9haepO=uizymy947aLv3tMoO=5ye=FHqhkYCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] soc: sifive: ccache: Rename SiFive L2 cache to
 Composable cache.
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
=E9=80=B1=E4=BA=8C =E5=87=8C=E6=99=A82:48=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Noticed a another thing, sorry..
>
> On 05/09/2022 09:31, Zong Li wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >
> > From: Greentime Hu <greentime.hu@sifive.com>
> >
> > Since composable cache may be L3 cache if pL2 cache exists, we should u=
se
> > its original name composable cache to prevent confusion.
> >
> > Apart from renaming, we also add the compatible "sifive,ccache0" into I=
D
> > table.
> >
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/soc/sifive/Kconfig                    |   6 +-
> >  drivers/soc/sifive/Makefile                   |   2 +-
> >  .../{sifive_l2_cache.c =3D> sifive_ccache.c}    | 163 +++++++++-------=
--
> >  .../{sifive_l2_cache.h =3D> sifive_ccache.h}    |  16 +-
> >  4 files changed, 94 insertions(+), 93 deletions(-)
> >  rename drivers/soc/sifive/{sifive_l2_cache.c =3D> sifive_ccache.c} (35=
%)
> >  rename include/soc/sifive/{sifive_l2_cache.h =3D> sifive_ccache.h} (12=
%)
> >
>
> > -static ssize_t l2_write(struct file *file, const char __user *data,
> > +static ssize_t ccache_write(struct file *file, const char __user *data=
,
> >                         size_t count, loff_t *ppos)
>
> You need to fix the alignment here as per checkpatch:
> CHECK: Alignment should match open parenthesis
> #112: FILE: drivers/soc/sifive/sifive_ccache.c:53:
> +static ssize_t ccache_write(struct file *file, const char __user *data,
> +                       size_t count, loff_t *ppos)
>

I'm not sure why I don't see that by checkpatch, but it looks that it
is actually misalignment there, I would re-check all indents in
source. Thanks.

> >  {
> >         unsigned int val;
> > @@ -57,75 +57,76 @@ static ssize_t l2_write(struct file *file, const ch=
ar __user *data,
> >         if (kstrtouint_from_user(data, count, 0, &val))
> >                 return -EINVAL;
> >         if ((val < 0xFF) || (val >=3D 0x10000 && val < 0x100FF))
> > -               writel(val, l2_base + SIFIVE_L2_ECCINJECTERR);
> > +               writel(val, ccache_base + SIFIVE_CCACHE_ECCINJECTERR);
> >         else
> >                 return -EINVAL;
> >         return count;
> >  }
> >
