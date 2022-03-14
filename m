Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372AA4D7A65
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 06:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbiCNFeH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Mar 2022 01:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbiCNFeE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Mar 2022 01:34:04 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31412721;
        Sun, 13 Mar 2022 22:32:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q5so20191067ljb.11;
        Sun, 13 Mar 2022 22:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bg2tizYqINxLaPAUtFWgOMe6U6P8VVtNtHhthzp+bNk=;
        b=NfkG+SyIm8tCL/zOPwO1KnVTPxiHAE3v9/ysLSapqVw7bkxmxOhB2gmvGoQj1D55wT
         yP9JUSKVbEKu1IcCLpsl4a+l/rLJ1YZzTI4MOUwTJZjsZEMlpQ4FDi1/k74Ny59szLHe
         4GnDZcPErTJ6simgZ2+qeplpmZJQ3FoRm034iGgtalMdQC6mZ5G3p509KKto2DlrjNAs
         /HemlPuaWhrk7KnKhasu3Fi8CpJMQQoX4+wK6rTItWoHpum3eLd+MefoRUIOwnYtRhFI
         rixVSeJvqDJoMYq53sw+LBv/EFOcKZPnWCcrUsAGEzWGDheT2jBgW17SNFhWP5yE9QcV
         YYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bg2tizYqINxLaPAUtFWgOMe6U6P8VVtNtHhthzp+bNk=;
        b=nkJZdqVSpD6zKw554f6Wpjvl6VB+M/YLLaeyFQDTr79u5vAB+hxrXBweW2tXUTp7Gc
         ebuwtGKy+hGppORI4ctJNex7SdX1n1KY0IQLCIpqGIBjFznK30LEMgNVNQzvtn43VMw6
         iNsn+ysHRv3idPKowKTsKXlPTxWKBmBHMHltfXllbxnWyVglmePCCLaVrzpSflWnbZze
         hS/irNMEtItbXcaW2CITDZP/jFhqjx/fHSbESLnJJhkwCnhrINxmnvILv614Ze6Vy75y
         Lh0lqiYXuTuc2txO3iyqmos01nE0iHOm0drafrSEBtJrh0q3MKBJuAWqlZQ+O9TOYcDl
         SS3w==
X-Gm-Message-State: AOAM531LMEMoWb7hdbfmtHO3Zvb2rKyAA5AtXPbWyOcB9aQOwTJgBfIc
        nYr6TTlqg0x00PW/XHOq0DsWs7SY4kkxzLrYt9k=
X-Google-Smtp-Source: ABdhPJw99wXJ7VBc1ldLK6Gm+PgQRmnPgXWSIBgfH6KHHKs1ZlA6/QsEtlHm/AWU4bJ5LyqvuX0idpMKmQT55Ln8Vd0=
X-Received: by 2002:a2e:5009:0:b0:247:d738:3e8e with SMTP id
 e9-20020a2e5009000000b00247d7383e8emr13197832ljb.281.1647235972025; Sun, 13
 Mar 2022 22:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220311014245.4612-1-ctcchien@nuvoton.com> <20220311014245.4612-4-ctcchien@nuvoton.com>
 <1f5e1e49-4ab0-5e06-fa8f-2a11b0fd1df9@canonical.com>
In-Reply-To: <1f5e1e49-4ab0-5e06-fa8f-2a11b0fd1df9@canonical.com>
From:   Medad Young <medadyoung@gmail.com>
Date:   Mon, 14 Mar 2022 13:32:40 +0800
Message-ID: <CAHpyw9dHau348qJB6g+fCcKqWByUsRHAGwb_mdUg=hjhW+xNsw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] EDAC: nuvoton: Add NPCM memory controller driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org
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
=B9=B43=E6=9C=8811=E6=97=A5
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:15=E5=AF=AB=E9=81=93=EF=BC=9A
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
> > +     struct device *dev =3D &pdev->dev;
> > +     struct edac_mc_layer layers[1];
> > +     const struct of_device_id *id;
> > +     struct priv_data *priv_data;
> > +     struct mem_ctl_info *mci;
> > +     struct resource *res;
> > +     void __iomem *reg;
> > +     int ret =3D -ENODEV;
> > +     int irq;
> > +
> > +     id =3D of_match_device(npcm_edac_of_match, &pdev->dev);
> > +     if (!id)
> > +             return -ENODEV;
>
> Why do you need it? How such case is even possible?
this driver is used for two nuvoton SOCs, one is NPCM845 and the other
is NPCM750

>
> > +
> > +     npcm_chip =3D of_device_get_match_data(&pdev->dev);
> > +     if (!npcm_chip)
> > +             return -ENODEV;
>
> I wonder, how is it possible to have here NULL?
>
> Best regards,
> Krzysztof
