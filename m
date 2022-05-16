Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F8527BF0
	for <lists+linux-edac@lfdr.de>; Mon, 16 May 2022 04:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239392AbiEPCbK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 15 May 2022 22:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbiEPCbE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 15 May 2022 22:31:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB5915711;
        Sun, 15 May 2022 19:31:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id d19so23462946lfj.4;
        Sun, 15 May 2022 19:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4s0OSmePhoJXuHiuMzZo1VwoeuQdSeAInIYJXLS5OyM=;
        b=Qy577rTsVDyHwVUTciphWV+VNPU0RzZ4IdFO25T1sbgmjfn247DhYQoRqZJt/HbXFE
         Zj8Mey1O+VdqkZZ75zH8Bm+J1PAP5/RrBud4ThJBNncM/Z42o929WNGKYOG4/MBvN2Nh
         Q61UEZuPT1fm3yrTtQq9AQ+xgIQ39W8e1VCvdufdTFL0goCFzu7agfSiyJ3E/oqCjafc
         Kk3PfZmbdiRqxvJfdvQaqQbSqvsIwc7cN0QFJqfI+srg1oLQV55jCxiOeM8dyAKl8olC
         uwpBMzz7ZjXDprNlNz9GNVbpZF149gN4LpjWkkFxilg9y+WFyuiW58JfgXvtUl2ciLFw
         H08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4s0OSmePhoJXuHiuMzZo1VwoeuQdSeAInIYJXLS5OyM=;
        b=mzwbI/b2jvLcbOhf/0Swv4UgIgPajHVC+Af/GIj3qOBpDI/+KSO879+4XfC3NsXxP4
         GVVvSohmE6sxOViRWNA2w2/Cmc7ZYNWCsVgo9M6El1vNu7uuEM2PYPbYg/fG7YMm/7xQ
         5s2aBFPIsqJVhcmAXkDwf4FaxE8jC9Jj9LRG/wThUnL3XDZ3t83VLCxHEAxw52ypRlT/
         zKzEn2oXjz+aGYv9ImSC7U7M3xEPv/KaJYBLpUB2f4WRaTDrtcOZVV14ntJM2ZMjLGex
         JrFT+OSRVWlJQQ9KMrPfARhnrAj+vNaBC3RGs66Y3fVJaLUFAiexFFSATGX6M2aqy6fV
         1gWA==
X-Gm-Message-State: AOAM531qzA+dGWuoX8IX/fTMHPSIJwgPEJea8lLAXDNuyusIshjtQ8rm
        0KTMrAqURr/HUL0F2iyl3ZXawctEFgcWwo972WukX/5FBFo=
X-Google-Smtp-Source: ABdhPJxZq6+lnoKQQOPMomvc/GGVcnlfK80rcb3L0qena45Z2EZ6GSg202Ym+IGA0gz340U5CzyhYcNIOBuICW8aYzY=
X-Received: by 2002:a05:6512:c03:b0:447:7912:7e6b with SMTP id
 z3-20020a0565120c0300b0044779127e6bmr11291271lfu.508.1652668259368; Sun, 15
 May 2022 19:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220510031056.1657-1-ctcchien@nuvoton.com> <20220510031056.1657-3-ctcchien@nuvoton.com>
 <8d46eeb8-7926-f842-6105-1975a5adc3fe@molgen.mpg.de>
In-Reply-To: <8d46eeb8-7926-f842-6105-1975a5adc3fe@molgen.mpg.de>
From:   Medad Young <medadyoung@gmail.com>
Date:   Mon, 16 May 2022 10:30:48 +0800
Message-ID: <CAHpyw9cvrEKMUpRBWYWp9hDZgA8ALHBkNAQr6ZDqjj4uH-MRTQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] dt-bindings: edac: nuvoton: add NPCM memory controller
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

thanks for your comment.

Paul Menzel <pmenzel@molgen.mpg.de> =E6=96=BC 2022=E5=B9=B45=E6=9C=8810=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Dear Medad,
>
>
> Thank you for your patch.
>
> Am 10.05.22 um 05:10 schrieb Medad CChien:
> > Document devicetree bindings for the Nuvoton BMC NPCM memory controller=
.
> >
> > Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > ---
> >   .../edac/nuvoton,npcm-memory-controller.yaml  | 61 ++++++++++++++++++=
+
> >   1 file changed, 61 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npc=
m-memory-controller.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory=
-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memo=
ry-controller.yaml
> > new file mode 100644
> > index 000000000000..6f37211796a3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-contro=
ller.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/edac/nuvoton,npcm-memory-controller=
.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton NPCM Memory Controller
> > +
> > +maintainers:
> > +  - Medad CChien <ctcchien@nuvoton.com>
>
> Just a side note, that in my experience functional like
> <linux-npcm-memory-controller@nuvoton.com> instead of personal addresses
> are useful, as you can configure on your side, who to deliver messages
> to. For example, if you are on sick leave or vacation, you just
> configure to deliver the message to a colleague of yours (or they get
> messages in the first place anyway).
>
> Maybe you can bring that up at Nuvoton.
>

I understand, but we do not have group email  address.
so maybe I should add more maintainers?

> [=E2=80=A6]
>
>
> Kind regards,
>
> Paul

B.R.
Medad
