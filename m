Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1241F4FB569
	for <lists+linux-edac@lfdr.de>; Mon, 11 Apr 2022 09:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245693AbiDKH6q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Apr 2022 03:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245614AbiDKH6p (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 11 Apr 2022 03:58:45 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E5723148;
        Mon, 11 Apr 2022 00:56:30 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x17so15991073lfa.10;
        Mon, 11 Apr 2022 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QSB6c+wqSkjWB7X1hlshGuzqfkl/JFQbMqvRhf61Ikk=;
        b=cnsb0XDPevnl+CdN2zl7O4FihnoMRRdgozseneDM7/l9auwEHLXVI+XexLoq1sdoZe
         B/LF+GY9t4eykkHFU5vXsK+2gJI5VKXcqwP/qGxcFcgLr0TZssOrEfzLxwTGDRKlYiDo
         w+5z5Oa2PG/5S0y0S5fA70fM94+5HxpKcUakfDAIxX1SHuHx99Pz5/SGPpCcQPx/vsmv
         SNSMEM9p1ImfIPXz40dEjEM1ng9l+3SLEO3NJRVBPdzvFLkM/ZPvDIM/qd0hD2kii+cg
         dK4oX6+55xEiilJf/Rf8dmzR8bf8HdcHElV+3d3HcDd/ZWWl3KHIP+dXTWf4u3SVMQgv
         r5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QSB6c+wqSkjWB7X1hlshGuzqfkl/JFQbMqvRhf61Ikk=;
        b=3uYikEr6U9MsuAvF49oUXmGk8E+PkpObZdq6CJmrhODc8lve++fIs9d5pHcd2Jj2Pq
         YIK/I2R6zN76TQnn06yt8rGTMGgVNH0m7B7IbTIREZPV0fpGsS7COe1Z7pMQmu54tRMz
         ym/7iGDzlaaEBEH2/v1keBiDYVPn0U4gJOb3M8lJ1nCFm8RsN5gu7F/ZnR3WaN8wUVKz
         7fLj7L18S7RzG8ebxpKW9KorDisvxIkU1Y9Q4aHqo5Z93VAjkubkZzDA3o3W/4lHCsdb
         4UWekezuMvKuwnN2dEAiqzkJPB5+YAukZcOsE5SljzgcvbJP4oQiaS1Nkey8OuKUO+vG
         MIXA==
X-Gm-Message-State: AOAM53042+KxhYNV8vYlMzb5IfaNqdWgTKiScZvz2NRlk0kL5QtIBRxU
        0Zrn3IUJM+VYxEgMF5VYN0pM1S/zvZMFIi0UTbI=
X-Google-Smtp-Source: ABdhPJyoSa5YN1edYG0/ySQxYWx6ytJWo+VEosBgI6Mj0Js0n5VKDL2SjoMGrj9+CzPh3R7W7GBQqmhK3OHSZFL/piM=
X-Received: by 2002:a05:6512:3191:b0:45d:cb50:f575 with SMTP id
 i17-20020a056512319100b0045dcb50f575mr20776471lfe.48.1649663788912; Mon, 11
 Apr 2022 00:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220322030152.19018-1-ctcchien@nuvoton.com> <20220322030152.19018-2-ctcchien@nuvoton.com>
 <c73bf178-f5bd-01c6-209d-051706112877@molgen.mpg.de>
In-Reply-To: <c73bf178-f5bd-01c6-209d-051706112877@molgen.mpg.de>
From:   Medad Young <medadyoung@gmail.com>
Date:   Mon, 11 Apr 2022 15:56:17 +0800
Message-ID: <CAHpyw9ckLUNe8biEFSjHBndG_WD-7O-QsHO8Rr0eoXbROH0dUQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] ARM: dts: nuvoton: Add memory controller node
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     rric@kernel.org, James Morse <james.morse@arm.com>,
        tony.luck@intel.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
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

Dear Paul,

thanks for your comments

Paul Menzel <pmenzel@molgen.mpg.de> =E6=96=BC 2022=E5=B9=B44=E6=9C=889=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=881:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Dear Medad,
>
>
> Thank you for the patch.
>
> Am 22.03.22 um 04:01 schrieb Medad CChien:
> > ECC must be configured in the BootBlock header.
>
> bootblock
>
> I search for *bootblock* in Linux and the git commit messages, and does
> not seem to be a common term. Is that term used in the datasheet?

Yes, bootblock is a bootloader of our SOC

>
> > Then, you can read error counts via
> > the EDAC kernel framework.
>
> Please reflow for 75 characters per line. (Also, there is no need to
> break lines after a sentence, unless 75 characters are reached or a new
> paragraph starts.)
>
> Tested on what board?

I tested this on Nuvoton's BMC board

>
> > Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
>
> Out of curiosity, is the first C in CChien the letter of your middle
> name, or the last name really spelled with two capital letters in the
> beginning?

this is a special last name in chinese.
my last name does really spell with two capitak letters in the begining.

>
> > ---
> >   arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/b=
oot/dts/nuvoton-common-npcm7xx.dtsi
> > index 3696980a3da1..ba542b26941e 100644
> > --- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> > +++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> > @@ -106,6 +106,13 @@
> >               interrupt-parent =3D <&gic>;
> >               ranges;
> >
> > +             mc: memory-controller@f0824000 {
> > +                     compatible =3D "nuvoton,npcm750-memory-controller=
";
> > +                     reg =3D <0x0 0xf0824000 0x0 0x1000>;
>
> Is f0824000 from some datasheet?
>
> > +                     interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > +                     status =3D "disabled";
> > +             };
> > +
> >               rstc: rstc@f0801000 {
> >                       compatible =3D "nuvoton,npcm750-reset";
> >                       reg =3D <0xf0801000 0x70>;
>
>
> Kind regards,
>
> Paul

B.R.
Medad
