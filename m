Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA9C4D7A1F
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 06:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiCNFXm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Mar 2022 01:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236103AbiCNFXh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Mar 2022 01:23:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734503CFF8;
        Sun, 13 Mar 2022 22:22:28 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c15so3601146ljr.9;
        Sun, 13 Mar 2022 22:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nbtSRVVGN9+RW0bywIMfiM4Hm879DO3M3rRCioh4tYQ=;
        b=NAiU65hC0RdlCLNvMHA6EpX6WuG1OWLd6FapI0qT+0lKExVONOE/rIQb0+3xcyJkAa
         z5iCeLlTWEynD+D7MnLrcagjOqNEPXn0GpMxTu3hskeyRL78MCrXgSx9nc1EPY6Wz0d5
         76gvib3waCrlOEfs6bVRH2G6zlsa1wRjmRp5+vwBY6qEDDjbNVvaxjVtQyctK2uU1cCG
         EfZDJ7LtZZPb/tYAuUBuqdPQAOsgXXhXfsWEw5MenlVKGDRzq3XiDn5QM2vIh9jT/DKm
         zPtTkKup3Zfj4oC+ayDWrOPCMMeloEwjIPlhm8Lt6JUImhvXi9tVgaL5BQvz5al04JwU
         /0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nbtSRVVGN9+RW0bywIMfiM4Hm879DO3M3rRCioh4tYQ=;
        b=4cVGIwEblLOlm2ibTploRUutXRPI8zjzF3fgam0DwRZgfXLKfnxgBNZas5Yf8Y4Ctx
         2nFJZRjHnxTqQSWmyplSFjzmtwC09gCYkEPjwqgYNUuX1aJz73YkBLEaJZFO84BC2h3O
         vtm1jSqLSH3M/4J/i2oMCFk1TgUdN3nXSht6DUSkny0ZusFgloWFHi92NtqW6JLzxtC8
         k4QgdN4sDy3Xsk1yqDqBv4uhoIn6v65UoIhdREU6XrhVTWXPhIR6mKfwm2+hOaLk4Qao
         SmZ5aVrlc3VFCuTisYHJgexCG3AovnyhhaXtTSvb34rnfBgO9GMH7KyzVMyTACr+WKHY
         6aiA==
X-Gm-Message-State: AOAM533GJhRE1klHSxNokqZ11jNl71KmhelxVfI7LNvt6oHkdUPhgeJK
        w265kp9AdGdGVlhSNLYv4mu27McVy3gfveXAknw=
X-Google-Smtp-Source: ABdhPJwvNQd3kXdudgrucu3kBp5FeLLKmBLeW5rm4ea83FVn+wM7tBsNQTBq6mKZ39OAcunmGGzS7AxL8r9kikQOvR8=
X-Received: by 2002:a2e:5009:0:b0:247:d738:3e8e with SMTP id
 e9-20020a2e5009000000b00247d7383e8emr13180918ljb.281.1647235346612; Sun, 13
 Mar 2022 22:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220311014245.4612-1-ctcchien@nuvoton.com> <20220311014245.4612-2-ctcchien@nuvoton.com>
 <YiwGFmbXw0qwM9mx@latitude>
In-Reply-To: <YiwGFmbXw0qwM9mx@latitude>
From:   Medad Young <medadyoung@gmail.com>
Date:   Mon, 14 Mar 2022 13:22:15 +0800
Message-ID: <CAHpyw9dmFdnmOEr9L=H5BMYsh7bV9JWCfnpNA=zVg2OdLD9AOQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: nuvoton: Add new device node
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
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

OK, I will check it.
thanks for your comment

B.R.
Medad

Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> =E6=96=BC 2022=E5=B9=B43=
=E6=9C=8812=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=8810:31=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> >Subject: [PATCH v3 1/3] ARM: dts: nuvoton: Add new device node
>
> To make it more obvious what this patch is about, I suggest something lik=
e:
>
> [PATCH v3 1/3] ARM: dts: nuvoton: Add memory controller node
>
>
> This arguably makes the next line in the commit message redundant,
> but there is other useful information that can be added there, if you
> like, such as how the kernel is going to use the memory controller.
>
>
> Best regards,
> Jonathan
>
> On Fri, Mar 11, 2022 at 09:42:43AM +0800, Medad CChien wrote:
> >  Add NPCM memory controller device node
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
> > 2.17.1
> >
