Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC16532036
	for <lists+linux-edac@lfdr.de>; Tue, 24 May 2022 03:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbiEXBQH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 May 2022 21:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiEXBQF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 23 May 2022 21:16:05 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C4AE37;
        Mon, 23 May 2022 18:16:03 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id i23so19183473ljb.4;
        Mon, 23 May 2022 18:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xfZDqs28oyhSqhq27xEhsDuOI5suqfnf7ndJ0VongrY=;
        b=V9WvkSLF3IrBDVZuHj1fncXQbS4UZP8Bl4vGoQ4cP40GscD6acASvvt3KvV3y2kJbT
         YRvKI1ek80h6KhZw+b+gzPB6B8GXVuEoXFrqSifxHKEspJKZw7sxwx4Gzoji8uY0Df0M
         bOvd2jeiBvUM5bbTVTV8eZM2lk/AsAhU/EGkgD3Wh7WUffY6jyjRizHUgtPxZlDyGtsE
         RiTWo0/o9HaUPCnfFmONEty2uj/HVqALZZwQfzAH1xSY6o44XeVndcsckzs1j7iIbytz
         4H4DyEiZYzHZCud6z92NKr0NeOT3ij5at8mzNzN6v8DFQ+ZGtsBS69occFDvNVFcII5r
         hZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xfZDqs28oyhSqhq27xEhsDuOI5suqfnf7ndJ0VongrY=;
        b=GbbXOXTXAbvHDUvPw5EJe/x/1KvFxHsDcFL7jdECN4Vq2i9FYyRqLdTwlh/TpzmLgW
         q1TtCS8lIxt4uGsCwSjEsfgKxH53r5PSWGuX21/XRHwSBTjYPKucPU6P512OhJSntCfY
         y8y8/9nC5K4qO0wA8hP5AGDezO4l170/xM6fBSt2IG7iD0tf/IJXsfqaxPFzacLWz00x
         YisEQnwAMqowzBu4G+KrA9OvmmBRvMuzlk3h2PK8/m+I/u5cEb5hIkzd4INC7/4wE8yq
         3ZvtLDSQuc4UT6y/MoU8MiS/ZSEE4uKsVzKt8kTu2jUux3oceAHY9DmkHvWuN2c4LHDv
         E3Mw==
X-Gm-Message-State: AOAM531DGFcnnQGRh5dROH9LQhBW7TdRDKA0VH5nsXTIHKggoKpnf7CF
        M7r4+otIjceUWNhPbioA5YzlG+pCxex9pxW33LlXZJKHIKRSmg==
X-Google-Smtp-Source: ABdhPJyMUAWa9cyvBzye0KjjHaKA88ye8dYHy9GbuVdYLtpagId1ddjvvlKbtYqmSMfU8sIThkAM9ZCbSrzqE3dTMAc=
X-Received: by 2002:a2e:a602:0:b0:253:d7e2:4d8a with SMTP id
 v2-20020a2ea602000000b00253d7e24d8amr12468397ljp.284.1653354961223; Mon, 23
 May 2022 18:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220510031056.1657-1-ctcchien@nuvoton.com> <20220510031056.1657-2-ctcchien@nuvoton.com>
 <YoUwe6Tj4Uh6ukc8@zn.tnic> <CAHpyw9fjThEP4NuU08aNJ_raHpq9-j9KgBb8YuZ_shXTjhm3JA@mail.gmail.com>
 <YoYPGWreQuF9QZzc@zn.tnic> <CAHpyw9es-n+bW9SsGBmmr3ghBFk8Q8E6ZTbE42BpU-6p8LfHtw@mail.gmail.com>
 <YoeE8cBhUkF3K44/@zn.tnic> <CAHpyw9fAfNf8j++JtLhuudSWj6N1-KAxA_fxEGL998WNVXTPdQ@mail.gmail.com>
 <YotVJ+ExcrQshM4A@zn.tnic>
In-Reply-To: <YotVJ+ExcrQshM4A@zn.tnic>
From:   Medad Young <medadyoung@gmail.com>
Date:   Tue, 24 May 2022 09:15:50 +0800
Message-ID: <CAHpyw9eALo=39N15omAFLA28LySBfPom7ejCfOgW9aS5gTa3Lg@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] ARM: dts: nuvoton: Add memory controller node
To:     Borislav Petkov <bp@alien8.de>
Cc:     rric@kernel.org, James Morse <james.morse@arm.com>,
        tony.luck@intel.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
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

Dear Borislav,

thanks for your help.

Borislav Petkov <bp@alien8.de> =E6=96=BC 2022=E5=B9=B45=E6=9C=8823=E6=97=A5=
 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, May 23, 2022 at 05:06:07PM +0800, Medad Young wrote:
> > I did do "git commit --amend",
> > I beleve the issue is about the mail server I used,
> > I use gmail to send the mail due to the mail server of my company
> > does't support smtp
> > so now I should sign the commit with my gmail account.
>
> No, you should supply --author too - I had forgotten about that.
>
> commit 0876b99e4aa2bf7113070c9c0f5d0ade7ad91697 (HEAD -> refs/heads/test)
> Author: Medad CChien <medadyoung@gmail.com>
> Date:   Tue May 10 11:10:54 2022 +0800
>
>     ARM: dts: nuvoton: Add memory controller node
>
>     ECC must be configured in the BootBlock header.
>     Then, you can read error counts via the EDAC kernel framework.
>
>     Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
>
> $  git commit --amend --author=3D"Medad CChien <ctcchien@nuvoton.com>"
> [test 5d6cd85171d1] ARM: dts: nuvoton: Add memory controller node
>  Author: Medad CChien <ctcchien@nuvoton.com>
>  Date: Tue May 10 11:10:54 2022 +0800
>  1 file changed, 7 insertions(+)
> $ git log -p -1
> commit 5d6cd85171d14e67840e672e2f96a16981243424 (HEAD -> refs/heads/test)
> Author: Medad CChien <ctcchien@nuvoton.com>
> Date:   Tue May 10 11:10:54 2022 +0800
>
>     ARM: dts: nuvoton: Add memory controller node
>
>     ECC must be configured in the BootBlock header.
>     Then, you can read error counts via the EDAC kernel framework.
>
>     Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
>
> $ git format-patch -1 -o /tmp/
> /tmp/0001-ARM-dts-nuvoton-Add-memory-controller-node.patch
>
> $ head /tmp/0001-ARM-dts-nuvoton-Add-memory-controller-node.patch
> From 5d6cd85171d14e67840e672e2f96a16981243424 Mon Sep 17 00:00:00 2001
> From: Medad CChien <ctcchien@nuvoton.com>
>                     ^^^^^^^^^^^^^^^^^^^^^^
>
>
> Don't hesitate to look at the manpages if a tool doesn't do what you
> expect it to do.

OK, I will try to supply --author with my original mail server

>
> HTH.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

B.R.
Medad
