Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054F451B922
	for <lists+linux-edac@lfdr.de>; Thu,  5 May 2022 09:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345034AbiEEHfu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 May 2022 03:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242062AbiEEHft (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 May 2022 03:35:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B7225CF;
        Thu,  5 May 2022 00:32:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j4so6055715lfh.8;
        Thu, 05 May 2022 00:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oB2KwW+fZDHqViOCO0SeVykq03oI7SrGtrTSNV/zeXw=;
        b=BFRMgPCyAxXKzFPzrX83J2MXIK6omEstm896Lx2iPA/ubW3FXufIIDGSpcw8nP7CfZ
         KT6VvMMcQWBRuio908uzwWeaZoaZF37iiYvkO9cu99FRdbR0RkWnJ/AsH6Bz3ptOkNC5
         9kq+ZBstRLXItzwWciuW4x1sGY9BNgrvGL5YDH8eCFf9VF9MJ+7AMoz5Ti3TPSpcKo7J
         SCqjV2razKzhfdKn1jwNKTN3W8e+110uqKe+UDoqurE1o07K8UnTvFMmgRQbpF/hqtl4
         hXWiO544ygw/QY3BDhL4KzQP6+9CyF4G5ox7dFLLFzCaucoNe4kPJOOBSk1Srlly+IfH
         6nRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oB2KwW+fZDHqViOCO0SeVykq03oI7SrGtrTSNV/zeXw=;
        b=XTudahIcyIG14kXQ4rB9VynUcyDQmY4jtSmdSWirpO9Y3Jm/kl3ahXnV62TImTUsAq
         frHHf47brvKcBzPlh41uDisJY/UZK3xw/UdnyeMD7HfvE7FErcAS2D+eDELy/GBf7YPm
         wzfs2wAHilJVLnLdT59qRxm+p/7KS+q2BYpNLXzS5klt7cdbuam0Co4PqAexxvW6VR6s
         hDfmZCh53FsLT/jP0FLEYQ1snSusDjxFaGFgRRANDmil3klHtUbjGUPbNsoT4PltqBX/
         HQzZ58D0/fk/LJs9OglCZaackVK0hjXF/u+adDACalP0xCjXSAgF5YfFfBQovASLyaDU
         rXlw==
X-Gm-Message-State: AOAM533CCdtsfxvOyQi+jNwvQK0HJXY1NJuPFnuSsrO9NeA61JO8hPPJ
        j3SLZ3qEup9tPfQMyaITrSUQ42ll97JrzRygGQE=
X-Google-Smtp-Source: ABdhPJxdjK58CQrmJIEecoD5ChKmpWmyR/5zI/i8u9leJjHYWUtdHJ1LEMyH3OIqMm8fbt5BxCCWR/FljHxYpu4pjwA=
X-Received: by 2002:a05:6512:c03:b0:447:7912:7e6b with SMTP id
 z3-20020a0565120c0300b0044779127e6bmr17108146lfu.508.1651735928726; Thu, 05
 May 2022 00:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220503094728.926-1-ctcchien@nuvoton.com> <20220503094728.926-2-ctcchien@nuvoton.com>
 <YnEAtQQ6Wnacfrub@zn.tnic>
In-Reply-To: <YnEAtQQ6Wnacfrub@zn.tnic>
From:   Medad Young <medadyoung@gmail.com>
Date:   Thu, 5 May 2022 15:31:57 +0800
Message-ID: <CAHpyw9dz-P76ioNoZJPty0A_iHcw6Yx_z1S01E9+xWou28BeUg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] ARM: dts: nuvoton: Add memory controller node
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear Borislav,

Borislav Petkov <bp@alien8.de> =E6=96=BC 2022=E5=B9=B45=E6=9C=883=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:15=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, May 03, 2022 at 05:47:26PM +0800, Medad CChien wrote:
> > ECC must be configured in the BootBlock header.
> > Then, you can read error counts via
> > the EDAC kernel framework.
> >
> > Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> > Reviewed-by: Borislav Petkov <bp@alien8.de>
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
> I don't think you understand the concept of Reviewed-by: tags. You
> may add them to a patch of yours when the reviewer gives them to you
> explicitly - not because she/he has given comments to a patch of yours.
>
> Please go over
>
> Documentation/process/
>
> and Documentation/process/submitting-patches.rst especially and then
> send patches.
>
> Thx.
>

Sorry, I did misunderstand  the concept of Reviewed-by: tags.
I will revise
thanks

> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

B.R.
Medad
