Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D77351B904
	for <lists+linux-edac@lfdr.de>; Thu,  5 May 2022 09:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344449AbiEEHdS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 May 2022 03:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344142AbiEEHdR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 May 2022 03:33:17 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A5D29801;
        Thu,  5 May 2022 00:29:38 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j4so6046488lfh.8;
        Thu, 05 May 2022 00:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Z3ugqzs69IZl2+sRBwHWpG9kKlwl5WbPNjhplCiidk=;
        b=NLnXMShaRN7PFstFtp8tEoVSOhftf8xxi0e83XfbK5BkN2iQ8x6cZgI8cOHrXkau6N
         QCfJH+/eiJeveTWsc/Wy4YmWIIDlcr3IDSOQXHB8LXW1qOgYWCq52+SmQQ4VQQdBNrj4
         6LwIQKCd6kqAdMSC4cHBaKQJIGP1MFrnrjRU0Pn5klIABxim8rvlc8nZbdFO9B67MrC8
         iSchmvzpQDBS7k2oRxryDg7m/Tjm5LT5A3Xo6lWFQOYPZpNX1ieE9oZsgiXaKgWOuiS/
         JE1SzzPfpZ7KWUpWof7vsPq0O/xAq3viH5rHjblyvfnM2t0IkX/k4du+kMlbaGzXxPEA
         TMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Z3ugqzs69IZl2+sRBwHWpG9kKlwl5WbPNjhplCiidk=;
        b=mLv2mSDEcbj+eIIdShIqJ8hb+/B07epIfZdVvDouSyQraHm8wMVKf1hx6GFYKCRxzK
         Z4JcVUTYtaHslIKOrkDvyDjTH80bDp+mRTAyhTB+Kw6Xz8XMt8Cdp3+xcX+Y7yCXGDmk
         X5uOMXM+2VhfcpxCWgyIdB5LaudTaNvRrwrrK84z2w+NqeW6oODq97/cmGIBu0Y2EvPC
         wqxedVO0tr7xZu+yEq2C8JatRxiZBkkxljib4OxlqJIPhmWZz5+U/ZcoNdz0Oe3pS/as
         nk8Rc8URObEm8vACmVM6VuIR66yex/xNAEjPLqI9xjK6hcfFtvpEk0f7ASIpEWPdTn89
         cFDA==
X-Gm-Message-State: AOAM531Rxp/0gsqvKjq5pOWnYkn4RpUHLKVciodlBks4AC4H2rwaPXEk
        PO6FbhfIum+Ll7h+8sO4QTjWwhKfrhm7r5pFl/w=
X-Google-Smtp-Source: ABdhPJwWrkWiEJE8wFxjLWt23K89Z5Y+pMlvG1QF6O0ewp61J8ENn3UK3Mk3CGRcyf6V/ntmhPUqWSTVxcUQ2sMYgFo=
X-Received: by 2002:a05:6512:c03:b0:447:7912:7e6b with SMTP id
 z3-20020a0565120c0300b0044779127e6bmr17101977lfu.508.1651735776564; Thu, 05
 May 2022 00:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220503094728.926-1-ctcchien@nuvoton.com> <20220503094728.926-2-ctcchien@nuvoton.com>
 <776bb807-feba-7c75-d280-11c33e33f71d@molgen.mpg.de>
In-Reply-To: <776bb807-feba-7c75-d280-11c33e33f71d@molgen.mpg.de>
From:   Medad Young <medadyoung@gmail.com>
Date:   Thu, 5 May 2022 15:29:25 +0800
Message-ID: <CAHpyw9dJqzgf_LKD9cmumoPMCNX92Pd9+m5xxDwxoLsEyVX1gg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] ARM: dts: nuvoton: Add memory controller node
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
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:56=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Dear Medad,
>
>
> Thank you for v8.
>
> Am 03.05.22 um 11:47 schrieb Medad CChien:
> > ECC must be configured in the BootBlock header.
> > Then, you can read error counts via
> > the EDAC kernel framework.
>
> Please reflow for 75 characters per line.

OK, I will reflow for 75 characters per line.

>
> [=E2=80=A6]
>
>
> Kind regards,
>
> Paul

B.R.
Medad
