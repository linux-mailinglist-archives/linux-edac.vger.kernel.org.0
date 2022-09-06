Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF235AE042
	for <lists+linux-edac@lfdr.de>; Tue,  6 Sep 2022 08:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbiIFGwP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Sep 2022 02:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbiIFGwO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Sep 2022 02:52:14 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88D772B6F
        for <linux-edac@vger.kernel.org>; Mon,  5 Sep 2022 23:52:10 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id z23so11271432ljk.1
        for <linux-edac@vger.kernel.org>; Mon, 05 Sep 2022 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=pg/k2BKeuoUb9BSQqMtaRqCPumr70GT5UhAxF2oEgQM=;
        b=HktmtzseBu9APk/Y/0Enxh3WilmA1qFkbnVK6HrsFvBI/HALpUtAkYwHtx1e7KFdPQ
         CiTKoCDCTqznqfPoHCO8+XHDjN1Ls11iNAR+BgyxUwha3cDk+lhoYnnsFKqxI6IdDdkg
         ZkLfVNZoG+ej2R9DEI3nVjBEkVZoN1FyOOYpuThHUFlBbGpvXxmTaNNzf6f+ONeIrLwO
         yQN0miPVnzPMZvNpEveAgbZMHtZnXxAaATZDMXI3PtJEljUS71gnCywFBYB0u7r7xlYP
         VbWMSFEAgJdONFa/du8UGDM1XUT+WYICUb0DeGauyMd/lcoeS8bHzT/Cvm4o3/ZqbUhc
         4frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pg/k2BKeuoUb9BSQqMtaRqCPumr70GT5UhAxF2oEgQM=;
        b=L4W8novAeCV+qjFcIUZw54sBU8L7Ps1TDHrJYqlDJJCsDeMXhGKRBiA9+tzy9+0ikl
         W7Y85OKkkq2Gy6ViCM7Sr0r+0IyTl+FfKMSttLDZi2xmnSnHOvWf4xQZYxvVg3s0cU2f
         SgDwrzUhQ6kcMsEUopSxhAa6le9twu2JrxsTgbXnfkAA5ZBd5OkxTjm+obYu5O7H8s8c
         wvitIJFJC1v4rj3T/Ywk0HH6qvuIqJ8iHNRg6CucdFZn0+DznnKIvuDD3WQpXX3LvK/y
         qqc/cVb7cfv5rB3R0IeuyEWzA1+Mryvt/Ka6/Qn6D0uMLw9zJkHfLMNHHkbWicnHB01l
         Dsmw==
X-Gm-Message-State: ACgBeo0DV7Ux/YrOLowK4o+iE1rvOt+Rlz2HfP//bWK5HHhoSMzk6gUa
        MAVjbEyr+AWt3mCG87HfsB0sd0xMaf+JzIoN4Uh54x2EyQg=
X-Google-Smtp-Source: AA6agR6AVqVzW2ydtHH70ol33I0L7Cv0YvSK+JMvHBhL0OMazBsLyNbNZkfG0NYuQjNFPFGxqBsRHGebHlq4QT18KF4=
X-Received: by 2002:a05:651c:1047:b0:264:f7bb:7b6 with SMTP id
 x7-20020a05651c104700b00264f7bb07b6mr12695077ljm.275.1662447129027; Mon, 05
 Sep 2022 23:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220905083125.29426-1-zong.li@sifive.com> <20220905083125.29426-3-zong.li@sifive.com>
 <2a22c6ac-dc0e-7066-8f5f-04c428c77ee2@microchip.com> <CA+ZOyah199Vsa9haepO=uizymy947aLv3tMoO=5ye=FHqhkYCA@mail.gmail.com>
 <048bb217-e91e-b727-fcd1-e55755a87d0d@microchip.com>
In-Reply-To: <048bb217-e91e-b727-fcd1-e55755a87d0d@microchip.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Tue, 6 Sep 2022 14:51:57 +0800
Message-ID: <CANXhq0prxrXYOson4pQBq6_cWSTcZ5CZs7JyOfsFuQE8oc2pwA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] soc: sifive: ccache: Rename SiFive L2 cache to
 Composable cache.
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Zong Li <zongbox@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>, bp@alien8.de,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-edac@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 6, 2022 at 2:23 PM <Conor.Dooley@microchip.com> wrote:
>
> On 06/09/2022 02:44, Zong Li wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >
> > <Conor.Dooley@microchip.com> =E6=96=BC 2022=E5=B9=B49=E6=9C=886=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E5=87=8C=E6=99=A82:48=E5=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> Noticed a another thing, sorry..
> >>
> >> On 05/09/2022 09:31, Zong Li wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> >>>
> >>> From: Greentime Hu <greentime.hu@sifive.com>
> >>>
> >>> Since composable cache may be L3 cache if pL2 cache exists, we should=
 use
> >>> its original name composable cache to prevent confusion.
> >>>
> >>> Apart from renaming, we also add the compatible "sifive,ccache0" into=
 ID
> >>> table.
> >>>
> >>> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> >>> Signed-off-by: Zong Li <zong.li@sifive.com>
> >>> ---
> >>>   drivers/soc/sifive/Kconfig                    |   6 +-
> >>>   drivers/soc/sifive/Makefile                   |   2 +-
> >>>   .../{sifive_l2_cache.c =3D> sifive_ccache.c}    | 163 +++++++++----=
-----
> >>>   .../{sifive_l2_cache.h =3D> sifive_ccache.h}    |  16 +-
> >>>   4 files changed, 94 insertions(+), 93 deletions(-)
> >>>   rename drivers/soc/sifive/{sifive_l2_cache.c =3D> sifive_ccache.c} =
(35%)
> >>>   rename include/soc/sifive/{sifive_l2_cache.h =3D> sifive_ccache.h} =
(12%)
> >>>
> >>
> >>> -static ssize_t l2_write(struct file *file, const char __user *data,
> >>> +static ssize_t ccache_write(struct file *file, const char __user *da=
ta,
> >>>                          size_t count, loff_t *ppos)
> >>
> >> You need to fix the alignment here as per checkpatch:
> >> CHECK: Alignment should match open parenthesis
> >> #112: FILE: drivers/soc/sifive/sifive_ccache.c:53:
> >> +static ssize_t ccache_write(struct file *file, const char __user *dat=
a,
> >> +                       size_t count, loff_t *ppos)
> >>
> >
> > I'm not sure why I don't see that by checkpatch, but it looks that it
> > is actually misalignment there, I would re-check all indents in
> > source. Thanks.
>
> You need to pass --strict to checkpatch to see it.

Many thanks for the tip, I can see the message after applying the option.

>
> >
> >>>   {
> >>>          unsigned int val;
> >>> @@ -57,75 +57,76 @@ static ssize_t l2_write(struct file *file, const =
char __user *data,
> >>>          if (kstrtouint_from_user(data, count, 0, &val))
> >>>                  return -EINVAL;
> >>>          if ((val < 0xFF) || (val >=3D 0x10000 && val < 0x100FF))
> >>> -               writel(val, l2_base + SIFIVE_L2_ECCINJECTERR);
> >>> +               writel(val, ccache_base + SIFIVE_CCACHE_ECCINJECTERR)=
;
> >>>          else
> >>>                  return -EINVAL;
> >>>          return count;
> >>>   }
> >>>
>
