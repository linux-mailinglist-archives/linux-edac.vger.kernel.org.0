Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB8B58C365
	for <lists+linux-edac@lfdr.de>; Mon,  8 Aug 2022 08:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiHHGkZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Aug 2022 02:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiHHGkY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Aug 2022 02:40:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1835E558C;
        Sun,  7 Aug 2022 23:40:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w19so14795887ejc.7;
        Sun, 07 Aug 2022 23:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=4PB9dWeFFs7okMUHgyH7NuITCUpW/nF++sHaYJTEdl0=;
        b=I4vcOZhf0FsVzp3vJ8zDM6UWJfW9Tq9wbl8HCoVEOgvMh41kFHaIOLkNLtsyN//FoD
         bKS8ABO9PE78sVCKfMY9B3tCnz3KsWdeWalgquPtkPoWSzWX5fKLpscMP4VW0mGSLX2z
         avXoOSZSBooxU5zEZAOE+HrqnHxc8vm7n+as4tdoP/EpQji70Q4M+cJDeOIGvaV7nA48
         FSWFhz6dV2JRuAMcTDkybMR4WSkv98o2oraOemRy4R7juFcX+AzA/k12VxyURlNTWRuS
         Up65jsWKjxNQb9qAsfYzDbxnGICm1UYMVmXs1IUQ5MaGDSmdaBrMZ+7+58YG8PkySp+f
         UGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=4PB9dWeFFs7okMUHgyH7NuITCUpW/nF++sHaYJTEdl0=;
        b=rv3kDoLWaaK86uFnHLW0amhgpMI6WZeUGo1MMhcei8rUMK1Dod0aW/hENva4/NN3Bq
         UOp5lHtm9usa/277MxXtuMha7fUju6VRwnVL5zZi3u8t/gV8TawkRNSNISQDZFlb+I6L
         wxW/rnhwhiuGhhyRfPCi3w7CBXzcYtxOGIQ2OZ8BtgnmsdUhE+xFNmHr+Lzj9xVFWBuX
         /pLDH1ns3n28aiE5FrKFeOFlO2BVTnmIBgY5wCjxJ1qX6tj3SX6nasD5ek5hsyaGDmXW
         StoDmc13Jtn2kjJJ8hOz3t389V76sIOiiVTV4T6TxqpsFMfaKDGc25ip3MHVtji4rgPO
         LlGQ==
X-Gm-Message-State: ACgBeo2egccMLXr0ylxlHjMNokYlw+KDkqoSp63kxGHyFUhIH3WaCxdq
        XSJqSvlD5EX5TqF6C/HGtkU2wQDqJLhKJjiIzV0=
X-Google-Smtp-Source: AA6agR6y6giseEiiXpJKKy0/mCQgNYSFlwjFaxmFRHZe5VLTgiCCnUWW4JFzu/n0UJgvLBjkJfKFwM4QjR+FStuH5Ok=
X-Received: by 2002:a17:907:2815:b0:730:9ec7:9fa1 with SMTP id
 eb21-20020a170907281500b007309ec79fa1mr12343365ejc.567.1659940821469; Sun, 07
 Aug 2022 23:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220610084340.2268-1-ctcchien@nuvoton.com> <20220610084340.2268-2-ctcchien@nuvoton.com>
 <YrCi1fg+mUPwZ7sX@zn.tnic>
In-Reply-To: <YrCi1fg+mUPwZ7sX@zn.tnic>
From:   Medad Young <medadyoung@gmail.com>
Date:   Mon, 8 Aug 2022 14:40:10 +0800
Message-ID: <CAHpyw9dkE65vUiyG-=gvQHGCZ-=nm1AX2EwANGPDAJmfn7sZkQ@mail.gmail.com>
Subject: Re: [PATCH v12 1/3] dt-bindings: edac: nuvoton: add NPCM memory controller
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
        OpenBMC Maillist <openbmc@lists.ozlabs.org>, milkfafa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hello Borislav,

Thanks for your comments.
I add milkfafa@gmail.com into this mail thread,
and he is going to follow up this EDAC driver.
He will be in charge of maintaining this driver.
thanks

Borislav Petkov <bp@alien8.de> =E6=96=BC 2022=E5=B9=B46=E6=9C=8821=E6=97=A5=
 =E9=80=B1=E4=BA=8C =E5=87=8C=E6=99=A812:40=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Jun 10, 2022 at 04:43:38PM +0800, medadyoung@gmail.com wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4383949ff654..7f832e6ed4e5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -2367,12 +2367,14 @@ L:    openbmc@lists.ozlabs.org (moderated for n=
on-subscribers)
> >  S:   Supported
> >  F:   Documentation/devicetree/bindings/*/*/*npcm*
> >  F:   Documentation/devicetree/bindings/*/*npcm*
> > +F:   Documentation/devicetree/bindings/*/npcm-memory-controller.yaml
> >  F:   arch/arm/boot/dts/nuvoton-npcm*
> >  F:   arch/arm/mach-npcm/
> >  F:   drivers/*/*npcm*
> >  F:   drivers/*/*/*npcm*
> >  F:   include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
> >
> > +
>
> That looks like it went in when committing. You can remove it in case
> you have to resend v13.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

B.R.
Medad
