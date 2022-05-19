Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EF652C909
	for <lists+linux-edac@lfdr.de>; Thu, 19 May 2022 02:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiESA4N (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 May 2022 20:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbiESA4L (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 May 2022 20:56:11 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FD413F1E;
        Wed, 18 May 2022 17:56:07 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m23so4508325ljc.0;
        Wed, 18 May 2022 17:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P/A63fdObVK1kzszX4o2zU+y2vARpab4MsV04+m6s4U=;
        b=hp3N9QMKgrTlSBUboc3w51NUmHyBG4nsmCUhx73K1tr0DWGeN0n3vWlZxAKnC19K9+
         xchUETOjGDjBHCKeJ2SZU+n5kOalPxfxheWKH/sjiYwdWqwbxG7nlYGHIajjMCPNO4rL
         vxCt2+PPEJ2ydejgr0Zf0DdzYZjAAAmqxAq0FU2E+++d+AxVIAN7PMdvmSGWJh7AXg+w
         0tV+CApwyyN44zJCihhdW4TS8Vagy9gn9Gg/5zW3X/yLC9qIxpX2btHVZ0N0SY0xg5rC
         1mOMgjaernRWL38xx2hzVgf5/XwDqG07hAsJqc3Rw8kN5EbUTER2krgUEpLNyvXVgieJ
         Kopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P/A63fdObVK1kzszX4o2zU+y2vARpab4MsV04+m6s4U=;
        b=CnDgS3pH+O5UNeg7YOHkVRF1yLlgqW5gmTKU3INc5P27hybuzO4biGqL/XKi3qSjzm
         +VIflwGcY/3ydJIjcAtoQklfXfWnuBxhqohWc0f+Fiqc/t8dyUxfeZLzgp3YBCSXlh2x
         wiMwcl6pzIvTsevKIQAsACs2e7+0ZsFjdCjWaCPWyZdxiseQrMHm1h1Kkqe5tmwNn4tD
         lkWySDRt7HCATJnNukF7rHRpY0F9sTBuJslL92CLb2F5Ib5CU5zvoBTrmKJJinjHVWae
         GEBBl77+USIAL/L47xFxbMZP57pqb9BCbiQE617sGwNZAk7krlGFNwCbDCBg5QYZn4+N
         c1HQ==
X-Gm-Message-State: AOAM531kg450hiXNY8kOJaDQWSXKCHTbUx5IEGqP8xbGtCjOB7UvjCQA
        dQ2Vx0QzQg9rbAlBI/LxIRn8OjN5ewSVET0BTTs=
X-Google-Smtp-Source: ABdhPJzzyBkkT9UcKeYwb2L46w/9p77j44udrFncFopXIIcNuuiPxeLDTWQt2NkOHcPGayjRR8/c17VPkT2d6Uwr6Os=
X-Received: by 2002:a05:651c:1247:b0:253:caad:4ee2 with SMTP id
 h7-20020a05651c124700b00253caad4ee2mr1121134ljh.281.1652921765326; Wed, 18
 May 2022 17:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220510031056.1657-1-ctcchien@nuvoton.com> <20220510031056.1657-2-ctcchien@nuvoton.com>
 <YoUwe6Tj4Uh6ukc8@zn.tnic>
In-Reply-To: <YoUwe6Tj4Uh6ukc8@zn.tnic>
From:   Medad Young <medadyoung@gmail.com>
Date:   Thu, 19 May 2022 08:55:53 +0800
Message-ID: <CAHpyw9fjThEP4NuU08aNJ_raHpq9-j9KgBb8YuZ_shXTjhm3JA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear Borislav,

Borislav Petkov <bp@alien8.de> =E6=96=BC 2022=E5=B9=B45=E6=9C=8819=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=881:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, May 10, 2022 at 11:10:54AM +0800, Medad CChien wrote:
> > ECC must be configured in the BootBlock header.
> > Then, you can read error counts via the EDAC kernel framework.
> >
> > Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> > ---
> >  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
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
> > +                     interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > +                     status =3D "disabled";
> > +             };
> > +
> >               rstc: rstc@f0801000 {
> >                       compatible =3D "nuvoton,npcm750-reset";
> >                       reg =3D <0xf0801000 0x70>;
> > --
>
> Please integrate scripts/checkpatch.pl into your patch creation
> workflow. Some of the warnings/errors *actually* make sense.
>
> In this case:
>
> WARNING: DT compatible string "nuvoton,npcm750-memory-controller" appears=
 un-documented -- check ./Documentation/devicetree/bindings/
> #35: FILE: arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi:110:
> +                       compatible =3D "nuvoton,npcm750-memory-controller=
";
>
> For that I'm guessing patch 2 needs to go first in the series.
>
> In any case, the first two need an ACK from devicetree folks.
>
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Medad CChien=
 <medadyoung@gmail.com>' !=3D 'Signed-off-by: Medad CChien <ctcchien@nuvoto=
n.com>'
>
> For this one I wasn't sure so I had to ask: I guess it kinda makes sense
> to have the From: be the same as your SOB email. I.e., make sure the
> right authorship and SOB is maintained even when sending from machines
> with broken email setups.
>
> And that you can fix very easily: just add in your .git/config:
>
> [user]
>         name =3D Medad CChien
>         email =3D ctcchien@nuvoton.com
>
> and git would use that as the author and also slap a From: at the
> beginning of the patch with the correct name and email address.
>

OK, I got it.

> HTH.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
