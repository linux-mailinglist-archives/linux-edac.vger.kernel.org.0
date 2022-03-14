Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CF94D7A23
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 06:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiCNFYP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Mar 2022 01:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbiCNFYO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Mar 2022 01:24:14 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD240F49;
        Sun, 13 Mar 2022 22:23:02 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q10so20192227ljc.7;
        Sun, 13 Mar 2022 22:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6TkxE6xRz8g17WpiXoeopvahoKZFX3mggMkzcb8O1aY=;
        b=hWqibxqlbX30iNxmQcq9yrTmRgNz5WW+C+UaQbxJOt8UUkVovhD6Rv1J3fh8Qbn7qj
         oODu7FdYsKewjTnXR/lO26F8XIVtkXy7cp+f27eCFrvEK6rL4jZWCt1lidBpZJJA/mTG
         FLC3egVqjWkqOsj/mOvP31/yalWYlli1SlnzGMAHyam9skPZbyEZA4pf6+5f//VHYR2Z
         9ApATWJfDAGcwrPcn4TMcAUBQx2t75UYsWMNrRHCmzKlQua1+Zd9b5CyMewfPcsWUd2e
         Z7aBkfb8bLbO+cjh2ikAM1iPjW8pC7KvkJRl3NDgpOE7v9p9pHLBXb7/4zPHsgAojfUI
         4VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6TkxE6xRz8g17WpiXoeopvahoKZFX3mggMkzcb8O1aY=;
        b=BQFl3Qts/aL6UNSYA2sRZ/mVet68bYeaW2Osye1hktAL1yvZ77vATSNL15j/ge3GwE
         8o1ux2DLGDukd6NP+g7IV0cKdv8xQXiMEN82vQSlK9EFIx/iV5aCxwvF+oR4vYRnoWRP
         8VplWwbNVx98OQp/qzKXTOLacZeYHcmViiP2q24iLyJ9baMKB6v74L3M5EwWG99qSBlW
         dOlmls2i7k+pYC25nax6BTg76ZEvHNfFUPU0g3VsHurDwBQ2irdYpIkbkDZ/0SZoXEuU
         8Bkmzm/HERL+UBJkVLbkooMmnyoKRhRpYw9Cit4E5CXSxS7howFkjOMOz2PqNdPSWPuv
         OmYw==
X-Gm-Message-State: AOAM531yQhK0M/8ge9e2vW3P1B0NRRYTUVbsMvjiw1TZP35vCxl3Afgu
        nGBe03wKacVqcJB8SYzsR4YwiLuKuc1zN7cZD5I=
X-Google-Smtp-Source: ABdhPJznoqn3GnpSLDMourmwmSBvSHe6fvICru56pmG6i2weBMsM9aW26AJtZ8U1IMpj566TkIOiTLnBfnTtl/yzrjQ=
X-Received: by 2002:a2e:9b48:0:b0:247:e0be:9226 with SMTP id
 o8-20020a2e9b48000000b00247e0be9226mr13129165ljj.487.1647235381209; Sun, 13
 Mar 2022 22:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220311014245.4612-1-ctcchien@nuvoton.com> <20220311014245.4612-2-ctcchien@nuvoton.com>
 <b9eb6b6b-b295-4d10-d4f2-c56461994d71@canonical.com>
In-Reply-To: <b9eb6b6b-b295-4d10-d4f2-c56461994d71@canonical.com>
From:   Medad Young <medadyoung@gmail.com>
Date:   Mon, 14 Mar 2022 13:22:50 +0800
Message-ID: <CAHpyw9ccSuzGLvjwDk-MxrERb=cmcdVACaXEbKsSkCUr5za+9A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: nuvoton: Add new device node
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

OK, I will Check it.
thanks for your comment

Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> =E6=96=BC 2022=E5=
=B9=B43=E6=9C=8811=E6=97=A5
=E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:59=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 11/03/2022 02:42, Medad CChien wrote:
> >  Add NPCM memory controller device node
> >
> > Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> > ---
>
> Subject is too generic. Describe shortly what are you adding.
>
>
> Best regards,
> Krzysztof
