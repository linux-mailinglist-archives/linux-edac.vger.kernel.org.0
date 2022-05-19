Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B8752C8F5
	for <lists+linux-edac@lfdr.de>; Thu, 19 May 2022 02:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiESAwl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 May 2022 20:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiESAwU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 May 2022 20:52:20 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88EA344E8;
        Wed, 18 May 2022 17:52:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u23so6472538lfc.1;
        Wed, 18 May 2022 17:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5igVcgabfc3GpqR+MTampE2W7vmBRqD9HW7OXsIkAag=;
        b=VPQenJuW+OU2IPmWU2GFyZZVSj5wN32qJwvTtwmzGWsd2jWWlVg88/rrpXKyHvRjT3
         Ml/wXy3LfZVPOn3QHJM8giH/EE0Kc+AiGW8Ss5XWWMXCNxna9kEiB3mjPnXRKVCtDUku
         5UVHJx89alZ3m+0KkfExjcSlUaHVHzdfHlbdcfUJPgFAm/4j+53XqocxKIQWqb7BowTh
         AE2vtuJqHk/nH2oNR/basBq1ZU+ZbQ6sO1ZAjwPSzNcWHrJ+6HdNns6FWCo2x+J6+583
         KmnJIrbQrpksPKtbvmIaYPN2K6WKZhAciyRTbLo/Du99PBz0kvzJxxqUvvxu0IEAnMKa
         BiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5igVcgabfc3GpqR+MTampE2W7vmBRqD9HW7OXsIkAag=;
        b=iQZ2srCUPb+4LEpOkrR8sSYWwdAv04vEw8gYJyUMzVf5JEw9Vo5HLu8q9TwSs7Ux3J
         HU1aMjPWgY0opUjJw8Wd2gc1WpVwfs6mAFRUIwALJyfRX6fuhMW8jY42+PVFJdBUtc3h
         13719S5prwzW0+FXJz4zAxF9iR+aJBfnPb6KmGof+AXQT1gTFk+7UpB7hHgW4bYq2/Tc
         llIhm4eOWtigshfqFF9C5SKlFE+lB60QncpGGmOg9qBLnlUBACFXsd7pLrVENjO64R8L
         LfxUQgdQuZ8zJ+4KJREIM0K7O5r3otiw0jK1ZCKfhK1qtJhOR1YB8GARocYYj2UI3olt
         I3Sg==
X-Gm-Message-State: AOAM5317vz5dHRcNE/bDopYwje+2afHluKYQOZkKq1OHbQNviftOfBa6
        9aF0z68Br2BQbduQQZILhiYs3bJKqo+rEVHJa5M=
X-Google-Smtp-Source: ABdhPJzye9D8ZzBG1mW+oOdXc4HL1Ud/n9N+sNSiOtlLukstVs8BE5VN6OqqEqObbwvyuiEqu9nepwH/GRCVRJdO+nA=
X-Received: by 2002:ac2:43a1:0:b0:472:1de:bbdc with SMTP id
 t1-20020ac243a1000000b0047201debbdcmr1492978lfl.48.1652921535991; Wed, 18 May
 2022 17:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220510031056.1657-1-ctcchien@nuvoton.com> <20220510031056.1657-3-ctcchien@nuvoton.com>
 <8d46eeb8-7926-f842-6105-1975a5adc3fe@molgen.mpg.de> <CAHpyw9cvrEKMUpRBWYWp9hDZgA8ALHBkNAQr6ZDqjj4uH-MRTQ@mail.gmail.com>
 <564c41fe-08cc-9c19-1506-c7b501458251@molgen.mpg.de>
In-Reply-To: <564c41fe-08cc-9c19-1506-c7b501458251@molgen.mpg.de>
From:   Medad Young <medadyoung@gmail.com>
Date:   Thu, 19 May 2022 08:52:04 +0800
Message-ID: <CAHpyw9dGfn8Q5zerjKDLWpVzcA6MmtfhOiJ_b7M1NLUFXDPMcA@mail.gmail.com>
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

Paul Menzel <pmenzel@molgen.mpg.de> =E6=96=BC 2022=E5=B9=B45=E6=9C=8818=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:33=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Dear Medad,
>
>
> Am 16.05.22 um 04:30 schrieb Medad Young:
>
> > Paul Menzel =E6=96=BC 2022=E5=B9=B45=E6=9C=8810=E6=97=A5 =E9=80=B1=E4=
=BA=8C =E4=B8=8B=E5=8D=882:14=E5=AF=AB=E9=81=93=EF=BC=9A
>
> >> Am 10.05.22 um 05:10 schrieb Medad CChien:
> >>> Document devicetree bindings for the Nuvoton BMC NPCM memory controll=
er.
> >>>
> >>> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >>> ---
> >>>    .../edac/nuvoton,npcm-memory-controller.yaml  | 61 +++++++++++++++=
++++
> >>>    1 file changed, 61 insertions(+)
> >>>    create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,=
npcm-memory-controller.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memo=
ry-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-me=
mory-controller.yaml
> >>> new file mode 100644
> >>> index 000000000000..6f37211796a3
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-cont=
roller.yaml
> >>> @@ -0,0 +1,61 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/edac/nuvoton,npcm-memory-controll=
er.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Nuvoton NPCM Memory Controller
> >>> +
> >>> +maintainers:
> >>> +  - Medad CChien <ctcchien@nuvoton.com>
> >>
> >> Just a side note, that in my experience functional like
> >> <linux-npcm-memory-controller@nuvoton.com> instead of personal address=
es
> >> are useful, as you can configure on your side, who to deliver messages
> >> to. For example, if you are on sick leave or vacation, you just
> >> configure to deliver the message to a colleague of yours (or they get
> >> messages in the first place anyway).
> >>
> >> Maybe you can bring that up at Nuvoton.
> >
> > I understand, but we do not have group email  address.
> > so maybe I should add more maintainers?
>
> If there are actually more maintainers, responsible and knowledgeable
> for that driver, than yes, these should be added (until you get a
> function address set up).
>

OK, thanks

>
> Kind regards,
>
> Paul

B.R.
Medad
