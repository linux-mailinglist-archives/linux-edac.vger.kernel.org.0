Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5154D7D87
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 09:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiCNIZT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Mar 2022 04:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiCNIZS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Mar 2022 04:25:18 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E04DFC2;
        Mon, 14 Mar 2022 01:24:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id e6so19073029lfc.1;
        Mon, 14 Mar 2022 01:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d/Zl5IT0l4GxJ3EjJL6DVxZWvh+do4XqDD23U9DbZgg=;
        b=jekb1x+xSCPoaVZdOGtvtnkt50ZAaEN27HK0Je+kfHmEcH/Nb5Wpt+xMDNZeBCoEf8
         h86wS+ScdEpGUI+iaSeKOmjno4u2m5LYBGPOutdnup/+X41zgH2dciLKkdwBbnRLewCm
         jEL3iSX/gp78Z7h5t96/JEgarjlKvlXuNls5lH80FiEEEoqk/EBGCcTj02KO2A8EzKM5
         mW1xiHBgj8V3Opi1NJ9VRg7F+DA5eHHBGmzUNFvIbgCgDW+0uDEZgKa+g9DrAHqAfb/G
         50HPqXDChLWiUMMMYZ92PJYccNleApTRNksJfkgbqnyKOyzmf9OCLyr3fMZCgKJIgdpO
         bMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d/Zl5IT0l4GxJ3EjJL6DVxZWvh+do4XqDD23U9DbZgg=;
        b=nhN1ZehACzcLAEDnQkL26BeWemWm9h/FJda7OdAQKdviwvk0Nze1opTF4I0YEC6aus
         nl9b2Usiw3YCvEAsH3CBZgz67/TrBhsktpAvk1u49GorXSFk0NHXmsZxjYwfVYBguaX9
         m+p1IAVh4UayMP1nsWhebdMLdAErXWJLJuzsXk/9lcZ9XO0p9dPPuxQYudWM2PCubw1P
         yPKsodBNE0XI7Q+a5Lo6jnNZROvNt2IGx+9Yvbzw+U4WREgIJu8CznEcntXF60JVluil
         l9kzbnObi2d2BK93DOVPlvFIvfz5e0QcYZCInQkokFTFeuwTKdLpj6gRem9eQp84C4FW
         dc5A==
X-Gm-Message-State: AOAM5306Jcz6OPFHI5nFmjAq2La7bjL231FS91MtIGVjH/OCJJqgpOvL
        TKYQ4MvOjAbCvfFO0IWMvln6aDZIujErIzKVbWQ=
X-Google-Smtp-Source: ABdhPJxcQVutRrJHAKzxsvpL9ozDO8Rmh3dnF0ZeMh5Y3ZTHiJXvWl4AkLZHOTT+KLQ/oW0guE+d1qJaxJjCAZietL8=
X-Received: by 2002:a05:6512:3a8b:b0:448:30d6:a73c with SMTP id
 q11-20020a0565123a8b00b0044830d6a73cmr12806889lfu.393.1647246247341; Mon, 14
 Mar 2022 01:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220311014245.4612-1-ctcchien@nuvoton.com> <20220311014245.4612-4-ctcchien@nuvoton.com>
 <1f5e1e49-4ab0-5e06-fa8f-2a11b0fd1df9@canonical.com> <CAKKbWA7Pr8Gi-rU5_BZ32y5aiLV0tSM19WkRe+zF8spWdk5zMg@mail.gmail.com>
 <4f8fffa7-631a-9b87-ee0a-0fb7dc1fec66@canonical.com>
In-Reply-To: <4f8fffa7-631a-9b87-ee0a-0fb7dc1fec66@canonical.com>
From:   Medad Young <medadyoung@gmail.com>
Date:   Mon, 14 Mar 2022 16:23:56 +0800
Message-ID: <CAHpyw9fHhCtzT3RM3o+2n26Ni+FdDQoTUOCMCfFspZHsQSs7Qg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] EDAC: nuvoton: Add NPCM memory controller driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Avi Fishman <avifishman70@gmail.com>, rric@kernel.org,
        James Morse <james.morse@arm.com>, tony.luck@intel.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
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

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> =E6=96=BC 2022=E5=
=B9=B43=E6=9C=8814=E6=97=A5
=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:35=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 13/03/2022 21:22, Avi Fishman wrote:
> > On Fri, Mar 11, 2022 at 11:15 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> >>
> >> On 11/03/2022 02:42, Medad CChien wrote:
> >>> Add support for Nuvoton NPCM SoC.
> >>>
> >>> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> >>> ---
> >>>  drivers/edac/Kconfig     |   9 +
> >>>  drivers/edac/Makefile    |   1 +
> >>>  drivers/edac/npcm_edac.c | 714 +++++++++++++++++++++++++++++++++++++=
++
> >>>  3 files changed, 724 insertions(+)
> >>>  create mode 100644 drivers/edac/npcm_edac.c
> >>>
> >>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> >>> index 58ab63642e72..757e1d160640 100644
> >>> --- a/drivers/edac/Kconfig
> >>> +++ b/drivers/edac/Kconfig
> >>> @@ -539,4 +539,13 @@ config EDAC_DMC520
> >>>         Support for error detection and correction on the
> >>>         SoCs with ARM DMC-520 DRAM controller.
> >>>
> >>> +config EDAC_NPCM
> >>> +     tristate "Nuvoton NPCM DDR Memory Controller"
> >>> +     depends on ARCH_NPCM
> >>
> >> || COMPILE_TEST
> >> (and test if it compiles)
> >>
> >> (...)
> >>
> >>> +
> >>> +MODULE_DEVICE_TABLE(of, npcm_edac_of_match);
> >>> +
> >>> +static int npcm_edac_mc_probe(struct platform_device *pdev)
> >>> +{
> >>> +     const struct npcm_edac_platform_data *npcm_chip;
> >>> +     struct device *dev =3D &pdev->dev;
> >>> +     struct edac_mc_layer layers[1];
> >>> +     const struct of_device_id *id;
> >>> +     struct priv_data *priv_data;
> >>> +     struct mem_ctl_info *mci;
> >>> +     struct resource *res;
> >>> +     void __iomem *reg;
> >>> +     int ret =3D -ENODEV;
> >>> +     int irq;
> >>> +
> >>> +     id =3D of_match_device(npcm_edac_of_match, &pdev->dev);
> >>> +     if (!id)
> >>> +             return -ENODEV;
> >>
> >> Why do you need it? How such case is even possible?
> >>
> >>> +
> >>> +     npcm_chip =3D of_device_get_match_data(&pdev->dev);
> >>> +     if (!npcm_chip)
> >>> +             return -ENODEV;
> >>
> >> I wonder, how is it possible to have here NULL?
> >>
> > Both of_match_device() and of_device_get_match_data() can return NULL,
> > are we missing something?
>
> I think your driver is OF-only, right? If yes, how is it possible to be
> here in probe() (meaning: being matched by of_device_id) and a few lines
> later do not match the same of_device_id?

I got your point, thanks

> Best regards,
> Krzysztof
