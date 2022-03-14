Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C674D7D8F
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 09:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbiCNIZz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Mar 2022 04:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiCNIZx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Mar 2022 04:25:53 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF2DE092;
        Mon, 14 Mar 2022 01:24:43 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q10so20668733ljc.7;
        Mon, 14 Mar 2022 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Iq78d1j2Ue+2y6u1MiPwO8kxCr3UFeP2P8LyryGJ4Ic=;
        b=Dws+yd7pP/4j0pJJ3NzE1FS+WEUDWo+U39fxUZEgwR/+CZjtWUFtDvpHGPP1Opi1d3
         K8JgF8oICvaNNXvW3XJDL1sVNJvKBYy3Ad5urfijjOX24uX1AcF2hsAdIu5yNsuQx47c
         +Ze4OWmVoR7A+h9PG1l8C+dHry7A7z0elHPZDRNEHWcUUU+aAmlsdIttF7nK/HXGlb8U
         G1iiCd6lZ0tGbayACmVI3Yh55JwdqHQZGoL6W1grXKKE7YJc9EJnom6CwTpSr8VBBue8
         13MHXJH/MeYe9AFjf9cyZLu3bGjKGHyYPfhcDfjJQ3ac75LrWPWdYE1utmyy6lZJ8rE0
         BBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Iq78d1j2Ue+2y6u1MiPwO8kxCr3UFeP2P8LyryGJ4Ic=;
        b=RpZUcTACimeZPYSjYSVPKbLKRQTCORkfOYRYCf56falOO8CT19QjuR6puP9DX4n91C
         WNR4zNFj3JLgtxVVtIp30yt+k+l3K/XTJN959yfVwpZkpkX6iBaDPb5ItPlM87jnf+AA
         iymns7x47Fj8sbNzzXBrtol0yy8HTzfpeB1g5B7tLzGD0vcDDT4hg7wXA4oxmHP1/HWk
         e5TX2pcX/J9bp6SLoKNe7A4yY4pfEKgkHF+scOrEWW3GRbMRSSYzbR1hXPxVjJzrCdRz
         pAal/5T+DfaIEACWp0FAd8drgEEBn3licnc6X1U7517YvT0XCw+4LrUPJC26XnnTrvsQ
         7vMw==
X-Gm-Message-State: AOAM531m0R6Nyaubj0Bkr5li88bq6Wve7Lg4AHYJB4rTQA7CN0gotCqs
        ibyIcrugTzUKK5WjA9wp9pYpb8GI+EyamfpOUzA=
X-Google-Smtp-Source: ABdhPJzxE2RH8clRVTd3DJzDgV4Zn7Rxw0lvZpFtJUyiP64C1vhUYmtEx0zSbl5qIqZzxSeicOylaVy5JTHvrT+jWUQ=
X-Received: by 2002:a2e:2202:0:b0:248:684:4476 with SMTP id
 i2-20020a2e2202000000b0024806844476mr13871061lji.64.1647246281586; Mon, 14
 Mar 2022 01:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220311014245.4612-1-ctcchien@nuvoton.com> <20220311014245.4612-4-ctcchien@nuvoton.com>
 <1f5e1e49-4ab0-5e06-fa8f-2a11b0fd1df9@canonical.com> <CAHpyw9dHau348qJB6g+fCcKqWByUsRHAGwb_mdUg=hjhW+xNsw@mail.gmail.com>
 <143db512-0223-1553-c141-2dc24a23c430@canonical.com>
In-Reply-To: <143db512-0223-1553-c141-2dc24a23c430@canonical.com>
From:   Medad Young <medadyoung@gmail.com>
Date:   Mon, 14 Mar 2022 16:24:30 +0800
Message-ID: <CAHpyw9dn=3sGfjcqtQN-GwdoCo=dfhOrofTGMZJc+2Jjpr7pAw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] EDAC: nuvoton: Add NPCM memory controller driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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
=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:36=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 14/03/2022 06:32, Medad Young wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> =E6=96=BC 2022=
=E5=B9=B43=E6=9C=8811=E6=97=A5
> > =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:15=E5=AF=AB=E9=81=93=EF=BC=9A
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
> > this driver is used for two nuvoton SOCs, one is NPCM845 and the other
> > is NPCM750
>
> Yes and how NULL can happen for OF-only driver? Unless I missed
> something and this is not an OF-only driver? Do you allow any other
> matching methods?

I got your point, thanks

> Best regards,
> Krzysztof
