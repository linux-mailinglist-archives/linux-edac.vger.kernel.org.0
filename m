Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE0451B93E
	for <lists+linux-edac@lfdr.de>; Thu,  5 May 2022 09:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbiEEHkP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 May 2022 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiEEHkO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 May 2022 03:40:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DD54838B;
        Thu,  5 May 2022 00:36:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p10so6055080lfa.12;
        Thu, 05 May 2022 00:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EvNPzmObJdLQoZe7mkFbV9lZXE5XGs6QumW7oyIXLLg=;
        b=HjL+/0qWmEWMgyiEe4e0unetPVu7pERTINMfTVtGtp3kO1zXtYJRAuyHyPv64jg1bh
         YhLUSfmqysBZuPqmB6XCgmDb2SEY5ocC4kCAPKnGm51CwF0BiD38pNcOyF4A1UoZBD7m
         amtR0IXtpKofD2GGI6cIygG6YvWki3kN90f+MFz/AkjrhMcFhggWvs700Lr13W33NalE
         et2ptnCYotWOX5aLb2Chy4K6L3v76wD2TihnEObTIIsQtnO4rCv/q9TI21gHBTNUmlHI
         7vgqOmq+Yl4hW020s6SrGYQZ+Az/+DposHcglABsHqAVxtMy21eDhHFXokAo/W2FLMUU
         BCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EvNPzmObJdLQoZe7mkFbV9lZXE5XGs6QumW7oyIXLLg=;
        b=glmVIxJ1aPeGIErmNqCLZHIL4jD8CzyVyL7uoNO2wSgap4xs+KFWPGDvrcZ2XQ86oz
         udKcqyIAsEmABMoy2Fft306t1mK9rt4KYu9wabvkVxmJJR/MgPRQ+1BuozF14AI9IW7P
         s+yLV4jc8KRM1xt8Jsa/eISYqWdcx1DPDwOthfUOeRmYjYqTsw4QnslpunAcmv+GAyqG
         c4jPjrkGV6ACYr1fkl5P+HePOy/NEIWjDybKCZt6nK6l4FaR6D5ieWWu3fTCzIfVU9vN
         0cAQarF5i3mKVKiXoLc/fMpHU0gVknwLyfD93b5OKpcCeBelwHKqvuJDj3wgbwjeM/08
         /62g==
X-Gm-Message-State: AOAM530pogvbhQHz5AGtY/+Kb+MdH7KI8skTpER+N2V1ROFv3xEIikIz
        eaTm0kK9Bd103fiJ6svzgJ16ZzVdYfw9hVKaBY0=
X-Google-Smtp-Source: ABdhPJzlCwN+zu+ztaxXdspnktpkbaSmCvx647Fl1CfKZFFvfCQpdiXXJZmh6tGGVGJJg0JoGRfpxnCdKl/iqzeKPdA=
X-Received: by 2002:ac2:42d0:0:b0:471:fc7b:e53a with SMTP id
 n16-20020ac242d0000000b00471fc7be53amr16112040lfl.185.1651736194069; Thu, 05
 May 2022 00:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220503094728.926-1-ctcchien@nuvoton.com> <20220503094728.926-4-ctcchien@nuvoton.com>
 <d09f0131-65e2-d382-27b9-29ded4f47d84@molgen.mpg.de>
In-Reply-To: <d09f0131-65e2-d382-27b9-29ded4f47d84@molgen.mpg.de>
From:   Medad Young <medadyoung@gmail.com>
Date:   Thu, 5 May 2022 15:36:22 +0800
Message-ID: <CAHpyw9e+d20dVM3PO0UfqvxpTnkvU541ccEa0CGLCZFgjTr8vw@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] EDAC: nuvoton: Add NPCM memory controller driver
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

Paul Menzel <pmenzel@molgen.mpg.de> =E6=96=BC 2022=E5=B9=B45=E6=9C=883=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:58=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Dear Medad,
>
>
> Thank you for v8.
>
> Am 03.05.22 um 11:47 schrieb Medad CChien:
> > Add memory controller support for Nuvoton NPCM SoC.
> >
> > Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> > Reviewed-by: Borislav Petkov <bp@alien8.de>
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > Reported-by: kernel test robot <lkp@intel.com>
>
> This line is confusing.

OK, I will add more description.

>
> > error:
> >     macro "edac_printk" requires 4 arguments, but only 2 given
> >
> > warnings:
> >     performing pointer arithmetic on a null pointer has undefined behav=
ior [-Wnull-pointer-arithmetic]
> >     logical not is only applied to the left hand side of this bitwise o=
perator [-Wlogical-not-parentheses]
> >     mixing declarations and code is a C99 extension [-Wdeclaration-afte=
r-statement]
> >
> > Note:
> >     you can force an ecc event by writing a string to edac sysfs node
> >     and remember to define CONFIG_EDAC_DEBUG to enable this feature
> >     example: force a correctable event on checkcode bit 0
> >     echo "CE checkcode 0" > /sys/devices/system/edac/mc/mc0/forced_ecc_=
error
>
> Shouldn=E2=80=99t this go above all the tags?

Yes, I should move this note above all the tags

>
> > ---
> >   drivers/edac/Kconfig     |   9 +
> >   drivers/edac/Makefile    |   1 +
> >   drivers/edac/npcm_edac.c | 680 ++++++++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 690 insertions(+)
> >   create mode 100644 drivers/edac/npcm_edac.c
> >
> > diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> > index 58ab63642e72..64149b524f98 100644
> > --- a/drivers/edac/Kconfig
> > +++ b/drivers/edac/Kconfig
> > @@ -539,4 +539,13 @@ config EDAC_DMC520
> >         Support for error detection and correction on the
> >         SoCs with ARM DMC-520 DRAM controller.
> >
> > +config EDAC_NPCM
> > +     tristate "Nuvoton NPCM DDR Memory Controller"
> > +     depends on (ARCH_NPCM || COMPILE_TEST)
> > +     help
> > +       Support for error detection and correction on the Nuvoton NPCM =
DDR
> > +       memory controller.
>
> Please add a blank line below.
>
> > +       First, ECC must be configured in the BootBlock header. Then, th=
is driver
> > +       will expose error counters via the EDAC kernel framework.
> > +
> >   endif # EDAC
>
> [=E2=80=A6]
> > +module_platform_driver(npcm_edac_mc_driver);
> > +
> > +MODULE_AUTHOR("Medad CChien<ctcchien@nuvoton.com>");
>
> Please add a space before the <.

OK

>
> > +MODULE_DESCRIPTION("Nuvoton NPCM EDAC Driver");
> > +MODULE_LICENSE("GPL v2");
>
>
> Kind regards,
>
> Paul

B.R.
Medad
