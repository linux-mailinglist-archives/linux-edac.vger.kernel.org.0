Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141C14D782E
	for <lists+linux-edac@lfdr.de>; Sun, 13 Mar 2022 21:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiCMUXj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 13 Mar 2022 16:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiCMUXi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 13 Mar 2022 16:23:38 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1F77A9B1;
        Sun, 13 Mar 2022 13:22:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id s29so2386494lfb.13;
        Sun, 13 Mar 2022 13:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9y+xQerG7o8f0xpkTQNL0kHWd//IRK7WsRPUjIKkRY=;
        b=mcqLMkH9PsDkMfugEJIKsysEpBRkET8V2q9fT6Xb+C4iqUZTceNDngLFzMArtKycoh
         CNzZIdYYLAAZsq7yPv1l5e6SX7hHLg7L0FfUo+pi4WZ6152TWqQkSI5O851RRpjCS0sd
         Hir2QKaoRnszVL/JtyndIXQJTXCUq7k8QVvgDau6WmzTZxZ981gN7fX0PwJ99hNFFp1a
         Ryz1IS4fLtrrR5y3SlH63wBNcWvVIcZRDkb0HyhM4UCq/jXUA+f3VjmVeBmvFO/G62BO
         6iT/V12g/PdhhSno1o7muIFmxYSLSpwpDbSce/7KvIxkB90WMUe9S3mwgXbpT8FN4lLq
         7f5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9y+xQerG7o8f0xpkTQNL0kHWd//IRK7WsRPUjIKkRY=;
        b=3GLaGxKJAMfgHzgVMhUNL/5OObjijrrSakkHDU68OvVICIIu/V2CuMYHhRsChOtTEk
         ABB3GAMpAe7VjnK3QWvlh519kkDBEp52047GuB5UHMwAVdKCU4gqic9wXo6JietI7kjg
         IAV4EeNCbC9KI1Kn2LWttsMQwTVkpGdbLGN0MI+8hY6QkAuW6SBP6bXzfG8HUnRRLfug
         iBTht+1Ef7dQdh5v7tMMHBv+6YOdGJlK+fE6oyNLhkQVZsJ/Zw4p/a7JmbVtXrc/IMWr
         71RWlj7wzDmpCsE7Ky7+4ipKkmzky8cepuNXOWDs59ta1rdbXvMB/zsSp9Em7aHPFxyc
         ocww==
X-Gm-Message-State: AOAM5304TUztqWvfgOhywUw7YRY6AQDb0osidrLpk129KNMDZ8eBUDoy
        JDKbWI6MzGSrz9UeDTJ0qamHZp56nOZ2fv966A==
X-Google-Smtp-Source: ABdhPJxhZHoUdofDUetTejGKDGs97K7es5I2NpHzVQXbOgFXN4QeOorOIohQEZKVBrZTuQ3Kjjkl2YDcxUYjICHnppM=
X-Received: by 2002:a05:6512:2243:b0:448:6830:ee82 with SMTP id
 i3-20020a056512224300b004486830ee82mr9663503lfu.262.1647202948325; Sun, 13
 Mar 2022 13:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220311014245.4612-1-ctcchien@nuvoton.com> <20220311014245.4612-4-ctcchien@nuvoton.com>
 <1f5e1e49-4ab0-5e06-fa8f-2a11b0fd1df9@canonical.com>
In-Reply-To: <1f5e1e49-4ab0-5e06-fa8f-2a11b0fd1df9@canonical.com>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Sun, 13 Mar 2022 22:22:17 +0200
Message-ID: <CAKKbWA7Pr8Gi-rU5_BZ32y5aiLV0tSM19WkRe+zF8spWdk5zMg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] EDAC: nuvoton: Add NPCM memory controller driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Medad CChien <medadyoung@gmail.com>, rric@kernel.org,
        James Morse <james.morse@arm.com>, tony.luck@intel.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 11, 2022 at 11:15 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 11/03/2022 02:42, Medad CChien wrote:
> > Add support for Nuvoton NPCM SoC.
> >
> > Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> > ---
> >  drivers/edac/Kconfig     |   9 +
> >  drivers/edac/Makefile    |   1 +
> >  drivers/edac/npcm_edac.c | 714 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 724 insertions(+)
> >  create mode 100644 drivers/edac/npcm_edac.c
> >
> > diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> > index 58ab63642e72..757e1d160640 100644
> > --- a/drivers/edac/Kconfig
> > +++ b/drivers/edac/Kconfig
> > @@ -539,4 +539,13 @@ config EDAC_DMC520
> >         Support for error detection and correction on the
> >         SoCs with ARM DMC-520 DRAM controller.
> >
> > +config EDAC_NPCM
> > +     tristate "Nuvoton NPCM DDR Memory Controller"
> > +     depends on ARCH_NPCM
>
> || COMPILE_TEST
> (and test if it compiles)
>
> (...)
>
> > +
> > +MODULE_DEVICE_TABLE(of, npcm_edac_of_match);
> > +
> > +static int npcm_edac_mc_probe(struct platform_device *pdev)
> > +{
> > +     const struct npcm_edac_platform_data *npcm_chip;
> > +     struct device *dev = &pdev->dev;
> > +     struct edac_mc_layer layers[1];
> > +     const struct of_device_id *id;
> > +     struct priv_data *priv_data;
> > +     struct mem_ctl_info *mci;
> > +     struct resource *res;
> > +     void __iomem *reg;
> > +     int ret = -ENODEV;
> > +     int irq;
> > +
> > +     id = of_match_device(npcm_edac_of_match, &pdev->dev);
> > +     if (!id)
> > +             return -ENODEV;
>
> Why do you need it? How such case is even possible?
>
> > +
> > +     npcm_chip = of_device_get_match_data(&pdev->dev);
> > +     if (!npcm_chip)
> > +             return -ENODEV;
>
> I wonder, how is it possible to have here NULL?
>
Both of_match_device() and of_device_get_match_data() can return NULL,
are we missing something?

> Best regards,
> Krzysztof

-- 
Regards,
Avi
