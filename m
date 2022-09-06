Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF5E5ADD10
	for <lists+linux-edac@lfdr.de>; Tue,  6 Sep 2022 03:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiIFBwT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 21:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIFBwS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 21:52:18 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACD36555D;
        Mon,  5 Sep 2022 18:52:18 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z72so7837861iof.12;
        Mon, 05 Sep 2022 18:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=qJmkGipThwGzIFiU+LRn5B9WXocUD44Aq+0ge6lB0Lc=;
        b=Uq+vlrBKD7CNndPYkoO/ekKoQ8VutFkcj2rOCG7dFGMSfegzTOeU/fCcEbpeatbnXm
         i9HlZnAbpcMY3VVo6UHEVocFs/GJOhZHc3QykcFP2/mV/4tPKw4HTeWSgcCsxifc2mcz
         l5IcUAC7I6AUfVH+bSTBZNSqfAIwxsViLeU/zoO9icV2uitqiKA3zWZCnw3K4/5WBf6a
         Xmp3wKN65fRl2N/oTBJVNpXVr8TxBqcApYcMGGotDl8YKI7axTY/QYWcmJfEuJxx8Err
         5PwwjXNK8gG7KCQ2EQ+8+NFvbeBcxZ89yB8bEl1qOU7pMLg06g2xZh5aXXrSen9n9TBN
         Mzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qJmkGipThwGzIFiU+LRn5B9WXocUD44Aq+0ge6lB0Lc=;
        b=cLrQZlO4PBi7WCQJawDCyrlRTJmOuAY+EV6AcaGt5F5rMzg+UoiRlid15aaMG1VUel
         q0VvcLPKj184inkgiZTij8hbTLkcpzioiyZRO+NFQRurM6B4AWj8s+daQ2TRGHZaIjE2
         S6VXeyu0PGdd3oHIf/7+WkdrCH21HbqOr0U3aciDZA1bTpzcVlclh+G5Sq6xNTuDFfuF
         4v8djjlLobbLmPu3bPLv4HtEHH9wI4JTgoPD03Fl+8yICbcwdmo5/f+uN6Xhp07Ymcb9
         ml1K5LqDZRYaxD7BqQal8p/qsIurJpzkOQFWaQdYqRhG13MfsJ1IttOyHTdPdOM9dxzN
         BoAA==
X-Gm-Message-State: ACgBeo2E+p6wM3B9WfGqAzP90yRfeN7+cXILkQEy4lAGoAa90DZqzoGn
        5SivPl4HxKm3yKmLj81nyT3iDOBEAghRfpAjntU=
X-Google-Smtp-Source: AA6agR5WNaJa2yCRJ3xsKiXdF7U/oiPzlvI/p72iLAy/RV9nQ3e4J9BYJMa99Fve//Mgf2N7CBsafxHEt95UWMQdGQ8=
X-Received: by 2002:a05:6638:3047:b0:341:de2b:e489 with SMTP id
 u7-20020a056638304700b00341de2be489mr27916981jak.273.1662429137540; Mon, 05
 Sep 2022 18:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220905083125.29426-1-zong.li@sifive.com> <20220905083125.29426-3-zong.li@sifive.com>
 <26246d03-a0dc-8f36-2ac1-daa60d47a057@microchip.com>
In-Reply-To: <26246d03-a0dc-8f36-2ac1-daa60d47a057@microchip.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Tue, 6 Sep 2022 09:52:05 +0800
Message-ID: <CA+ZOyaip+HFQiyHmX5fF+aMWtUK-kKnjhN-1VMk96DiXaQjQrA@mail.gmail.com>
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
=E9=80=B1=E4=BA=8C =E5=87=8C=E6=99=A82:46=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hey Zong Li,
> Couple comments on this patch.
>
> On 05/09/2022 09:31, Zong Li wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >
> > From: Greentime Hu <greentime.hu@sifive.com>
> >
> > Since composable cache may be L3 cache if pL2 cache exists, we should u=
se
>
> What is a pL2 cache?

The pL2 is stand for private L2 cache, it is a L2 cache in our system.
Perhaps I should change the pL2 to L2 in the description for more
generic.

>
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
>
> If you're going to rename the header, you need to update all references t=
o
> it too, otherwise the other user (the EDAC) is going to have build issues=
,
> i.e. patch 6 needs to get squashed into this one.
>

Ok, let me merge these two patches, as you mentioned, we probably
don't want to see the build is broken in git bisect as well.

>
> > diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/=
sifive_ccache.c
> > similarity index 35%
> > rename from drivers/soc/sifive/sifive_l2_cache.c
> > rename to drivers/soc/sifive/sifive_ccache.c
> > index 59640a1d0b28..1b16a196547f 100644
> > --- a/drivers/soc/sifive/sifive_l2_cache.c
> > +++ b/drivers/soc/sifive/sifive_ccache.c
>
> > -static const struct of_device_id sifive_l2_ids[] =3D {
> > +static const struct of_device_id sifive_ccache_ids[] =3D {
> >         { .compatible =3D "sifive,fu540-c000-ccache" },
> >         { .compatible =3D "sifive,fu740-c000-ccache" },
> > +       { .compatible =3D "sifive,ccache0" },
> >         { /* end of table */ },
>
> For v3, I think you should drop the , from the end of the table while
> we are already editing it.

Thanks, I will remove it.

> Thanks,
> Conor.
>
> >  };
> >
>
