Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748A65AA7F4
	for <lists+linux-edac@lfdr.de>; Fri,  2 Sep 2022 08:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiIBGQt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Sep 2022 02:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbiIBGQl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 2 Sep 2022 02:16:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93492915C4;
        Thu,  1 Sep 2022 23:16:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id t5so1299976edc.11;
        Thu, 01 Sep 2022 23:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=aiWzycCBoIbbruOADleMkCk4b+tj8c7FcfdTIbVcXyE=;
        b=gXbBJGQnKr/0+Kwbk9Pv0NByprxnRUodstMYhyuMmyfTySZ8jRGcj5PRr2i4XmkRp2
         zRvLX6RNK3bu5TBdptCrAyNdHut4CYD5JxU0MCSxH5hkm5gq6707jKq1Z4B+7/9P1hcM
         iFsuH8Prp9lnC9DLLfotwX+jNTbmQuxjIW1KgXKVWpSLCPO0VoXbDCeipJY8JZJRBpgv
         hxtdYXQZQYxqQePUWnikGSEcD2ZRp9XSSJjjVEO8IBtw5L/7YqlXmNDWYxXLh7Eq28uE
         r/RwwG9BDzWVv5S6UY9utfHi8h3fWXMLISU2EW3kYL864OQsTg5s7wBQPG//hInEEKkT
         BnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aiWzycCBoIbbruOADleMkCk4b+tj8c7FcfdTIbVcXyE=;
        b=2/vSCeGxuXobB1rWqiqrlDBIhG0R+R8mpAD4QqFsXOg1dEyb97sns0vP9NObUa6n2N
         CcR1LIHWjGZbkMxonT3RHom+skNvC1+vU5HhH6avID+GmYJTP4Y4cqhP622xuYaUaKTC
         GVxVMOj/1XcrDMERJ6+3qZoHr0CpStp9aQmCrCu42sQoQehfwi0CiTuvmem7w7TNJQpM
         z5Osh1sX5U/N+J7x87llugwfG9DvqUtjhlpWmxsTCXRWSsv30+WCLy8Xp8wYXy4vhDtY
         o6aYDkEosQ18hOV64412abaO44TFPKQTwF6ee4MOyH4Y+iCyP4/waaftmlhFmybNR3fV
         S+Uw==
X-Gm-Message-State: ACgBeo115f/lek5Htq8XX9R6BOoUT3enP367NJ+oTKfRF6ZKpxrvCqqs
        w9EBcCKVl7ZL/rKfUx5cw4x3s2C4gESLACWxtBE=
X-Google-Smtp-Source: AA6agR7ffwCW0E/pGXEIeZCbLWCZa03s3qO/DMl52Zz0jW7ILT8w0hg410F8D96hAnOQk/HPn7gjJ3p/1TCpAEKoFPE=
X-Received: by 2002:a05:6402:1215:b0:448:1431:465e with SMTP id
 c21-20020a056402121500b004481431465emr24048836edw.395.1662099398839; Thu, 01
 Sep 2022 23:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220830022238.28379-1-milkfafa@gmail.com> <20220830022238.28379-3-milkfafa@gmail.com>
 <a3a93acc-434e-4a94-6ba6-6a71f2da8736@linaro.org>
In-Reply-To: <a3a93acc-434e-4a94-6ba6-6a71f2da8736@linaro.org>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Fri, 2 Sep 2022 14:16:27 +0800
Message-ID: <CADnNmFqpNxdHTY619MgnSxPbMHw9s9C71GOxKAphWf_xwDGnXw@mail.gmail.com>
Subject: Re: [PATCH v14 2/3] dt-bindings: edac: nuvoton: Add document for NPCM
 memory controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>, rric@kernel.org,
        James Morse <james.morse@arm.com>, tony.luck@intel.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Patrick Venture <venture@google.com>,
        CS20 KWLiu <KWLIU@nuvoton.com>, YSCHU@nuvoton.com,
        JJLIU0@nuvoton.com, KFTING <KFTING@nuvoton.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>, ctcchien@nuvoton.com,
        Marvin Lin <kflin@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Krzysztof,

> > +++ b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/edac/nuvoton,npcm-memory-controller.yaml#
>
> This should be in memory-controllers directory.

> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton NPCM Memory Controller Device Tree Bindings
>
> s/Device Tree Bindings//

Thanks for the review. Next version will move YAML to
memory-controllers directory and remove "Device Tree Bindings".

Regards,
Marvin
