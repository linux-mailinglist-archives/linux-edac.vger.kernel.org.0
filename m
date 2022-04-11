Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8139B4FB590
	for <lists+linux-edac@lfdr.de>; Mon, 11 Apr 2022 10:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343523AbiDKIDy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Apr 2022 04:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343537AbiDKIDx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 11 Apr 2022 04:03:53 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60D81900E;
        Mon, 11 Apr 2022 01:01:38 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p10so25064784lfa.12;
        Mon, 11 Apr 2022 01:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dLagX0bznMYseBWYG2xpKUjyrFUW3pN56bkzoSU2tp0=;
        b=cQkZQcy+MHkSXUoI9MDT/c+0IGaIn27ea7X86YOuBUMNrKg83hntaExUO3lD9XId0p
         ly/XPa0D6U2DoNOg3j+gf5pkBCLsW1zW6vvL9c8PjlYdJ4tyQJAvIubVqSEIp2QNQDTF
         5KoGJm0ZiXPohruC2B0c+94CQJV+X/C0xpl70Pt2ejLEWPG4heCAQmGwSfty2je2uFB/
         QkEmv6M2fi3TlglcnxdMYhJ92xTA9jxJ29wn+Kcd4yqcD8Ahhj8ggyKnlkPN3+W4CzsT
         LLhA9bxZEx35GUYJtOOVp5N8aR9yyQu7Eu27bjFvWXgpYATBUszDzcYc1kZ1fnSrmOeO
         TEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dLagX0bznMYseBWYG2xpKUjyrFUW3pN56bkzoSU2tp0=;
        b=j6JV2XzllgIkxszDut7I2L3VJkkjxmIPkEB83foREtAkd62FxuSJfACw5HqvmxtzTb
         cEtTJCwwHJDHQZY4wmAn6Dy/nx2iOuwVQ1EnzXP+/A7T5ugmnhs8mfHqfvWHu7pGgriw
         2DAbKv36sRlECpeyd/4W3EMWN3awuYcsNUKwx2hqlSrsaABZotsv1a4CW7F2af8ReCf5
         fKVXZpvjj5jNtyk0HkyV5PpRWUp7KHc0M9SvyFEnxSWEvfmnWYiihTZSi7R+uD8PmDQ6
         6Dz1vC1nJfW+IErsC0vz77Be4iV+pk28kndkAkdpwUSanCKHzzLgZzKSEynkz8OOo5Ht
         OpDg==
X-Gm-Message-State: AOAM533+xUD7AwFd4GuXufnsYd8fyPOKM5VVoedkz1lJbULwy2zIVZ43
        yJNl5aHCxVY8tDbH0709UBhQTcAu+O299fIL6dY=
X-Google-Smtp-Source: ABdhPJxgJUUuROZgRKb0LEDLbuJHGqQUY3ojRGDjYwhHu2TK5fuKy2HxIiB6oeFUznuhvW81hNnfqmy8On1RUDGf9mE=
X-Received: by 2002:a05:6512:262a:b0:45d:b42d:3e46 with SMTP id
 bt42-20020a056512262a00b0045db42d3e46mr20444462lfb.22.1649664096793; Mon, 11
 Apr 2022 01:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220322030152.19018-1-ctcchien@nuvoton.com> <20220322030152.19018-3-ctcchien@nuvoton.com>
 <9cf20395-369a-2738-608d-dd5f1aabe48b@molgen.mpg.de>
In-Reply-To: <9cf20395-369a-2738-608d-dd5f1aabe48b@molgen.mpg.de>
From:   Medad Young <medadyoung@gmail.com>
Date:   Mon, 11 Apr 2022 16:01:25 +0800
Message-ID: <CAHpyw9fByk_pyD3pb0MX=p_t1AuD5qXKaECKwrB0uog6ZxX5qw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] dt-bindings: edac: nuvoton: add NPCM memory controller
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

thanks for your comments

Paul Menzel <pmenzel@molgen.mpg.de> =E6=96=BC 2022=E5=B9=B44=E6=9C=889=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=882:12=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Dear Medad,
>
>
> Thank you for your patch.
>
> Am 22.03.22 um 04:01 schrieb Medad CChien:
> > Added device tree binding documentation for Nuvoton BMC
> > NPCM memory controller.
>
> Please use present tense, and spell *devicetree* without a space. The
> line below even fits in 75 characters:
>
> Document devicetree bindings for the Nuvoton BMC NPCM memory controller.

OK


>
> > Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > ---
> >   .../edac/nuvoton,npcm-memory-controller.yaml  | 62 ++++++++++++++++++=
+
> >   1 file changed, 62 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npc=
m-memory-controller.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory=
-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memo=
ry-controller.yaml
> > new file mode 100644
> > index 000000000000..97469294f4ba
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-contro=
ller.yaml
> > @@ -0,0 +1,62 @@
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
> > +
> > +description: |
> > +  The Nuvoton BMC SoC supports DDR4 memory with and without ECC (error
> > +  correction check).
> > +
> > +  The memory controller supports single bit error correction, double b=
it
> > +  error detection (in-line ECC in which a section (1/8th) of the
> > +  memory device used to store data is used for ECC storage).
>
> *memory* fits on the line above?

do you mean I should change the term "memory" to others?

>
> > +
> > +  Note, the bootloader must configure ECC mode for the memory controll=
er.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nuvoton,npcm845-memory-controller
> > +      - nuvoton,npcm750-memory-controller
>
> Sort the entries?

OK

>
>
> Kind regards,
>
> Paul
>
>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    items:
> > +      - description: uncorrectable error interrupt
> > +      - description: correctable error interrupt
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    items:
> > +      - const: ue
> > +      - const: ce
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    ahb {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +        mc: memory-controller@f0824000 {
> > +            compatible =3D "nuvoton,npcm750-memory-controller";
> > +            reg =3D <0x0 0xf0824000 0x0 0x1000>;
> > +            interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > +        };
> > +    };
> > +
