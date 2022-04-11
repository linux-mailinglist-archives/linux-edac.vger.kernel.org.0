Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0804FB56D
	for <lists+linux-edac@lfdr.de>; Mon, 11 Apr 2022 09:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245748AbiDKIAP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Apr 2022 04:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241381AbiDKIAP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 11 Apr 2022 04:00:15 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2256183B8;
        Mon, 11 Apr 2022 00:58:01 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c15so19022336ljr.9;
        Mon, 11 Apr 2022 00:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IMcasM2PXwFO3pPL8keGLKPAAlGEHPxLC32XHN34NLQ=;
        b=U0XUaMQ5tt4vKUweVNbljOWAJtiPEYBd5YlbplTVAuToU4xiavT1C7ARxnf1EBCCBH
         MnCHlB+ZkZ4JAj7CG2Tiq+1QdnUZ1NTVZykJlt4ODm9pni0CXwlVCm5LSiSAp/bHWbJb
         lgjQaPDDBcRYPYta5T4ctVgKgHPH3zMoA75HjCQGNvXkS4UFJxPS8BpyEXvhEsYWxxAx
         kZb82CUVQZmolyF8OzFEVGi+zJA/0afLmLRwjU49E2VfP8YNrL7555POqrnHeod7ep8b
         MNq6N0nC/7fhFg3KvgJ25aIiUqaLgzlE+J7Go3kwC+hJtJVRIuda9asI1ZEfjVqB28/a
         X1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IMcasM2PXwFO3pPL8keGLKPAAlGEHPxLC32XHN34NLQ=;
        b=ZJRb5TCMJ60djHy5ghdYrRrf7yGNkb2m51ayeGuB0Jt920RbUXz7Fk1Zzfmtr+4BSt
         JXbVOTI0AJBPZ2zaoQrjRVY9D8EvkvuP+A8c5YSSOzDLzUoyT1itd6SSPXgLOl8MF4f+
         5VHzcnIyMPbaaA9JJwX4aouj5ylEdWG1BwcZokkhILOaOthmrpDy+Itl0d7+UptASlBu
         E7Bwu9cK2YsV1LfqgE6jU1l2sCApjvsR+VXXfChXzYafaqT7hRJ/gvxYpw5fre0GFG/Y
         9EYNiyQhisC8XcpAYKqB14gXBcrtVRKUwEk0O9rlY2saEY26NsTp6XAfeZKvyplQyITU
         3chw==
X-Gm-Message-State: AOAM533NyS9ruIf3w8fVlWzLtdcTqmJRurz5EmXmrFWDbPouO0as0pM0
        KmdIMA53tSwUh65mXELzsc+IhWwy6L6igZ/7f5/g35NT46azeA==
X-Google-Smtp-Source: ABdhPJyPAAdguzOq292jJl/qwqyh/fbTfn44rqQap5nOluCafw7d/O4zQ36Mqdux7bn5CWzO66s3VyAKwZ5+TQdv6jo=
X-Received: by 2002:a2e:9b18:0:b0:24b:61f3:7beb with SMTP id
 u24-20020a2e9b18000000b0024b61f37bebmr3100487lji.487.1649663879833; Mon, 11
 Apr 2022 00:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220322030152.19018-1-ctcchien@nuvoton.com> <20220322030152.19018-3-ctcchien@nuvoton.com>
 <YlBrbV2rstunqrW6@zn.tnic>
In-Reply-To: <YlBrbV2rstunqrW6@zn.tnic>
From:   Medad Young <medadyoung@gmail.com>
Date:   Mon, 11 Apr 2022 15:57:48 +0800
Message-ID: <CAHpyw9eR9tcg9TSXnecOgJJsxSm=B=FyqKV9kOXd9We=o+RjKA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] dt-bindings: edac: nuvoton: add NPCM memory controller
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

thanks for your comment
I will revise it

B.R.
Medad

Borislav Petkov <bp@alien8.de> =E6=96=BC 2022=E5=B9=B44=E6=9C=889=E6=97=A5 =
=E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=881:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Mar 22, 2022 at 11:01:51AM +0800, Medad CChien wrote:
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
>
> .git/rebase-apply/patch:73: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
