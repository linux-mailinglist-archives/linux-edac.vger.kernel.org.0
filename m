Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69AF650B49
	for <lists+linux-edac@lfdr.de>; Mon, 19 Dec 2022 13:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiLSMSj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Dec 2022 07:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiLSMSi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 19 Dec 2022 07:18:38 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEA0E4A;
        Mon, 19 Dec 2022 04:18:37 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id e24so2021962uam.10;
        Mon, 19 Dec 2022 04:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YvLnmu4Wq8jjqUUGJ/Mh5PFJXWDf0nAdtM6JdYMI7IU=;
        b=UkeSJy17prYpZznPUkfkZ6vitltPqv/vkSPQAc8jUKhELnuYIlrCWeNqjwfscstCMM
         Xpwd0/+MFN16pkQ623U24NKZdrv+/iBaKhhG103g2iUbI7v8Mgsgs0tOBZ3k2qfR59DQ
         woEWK/LkIftDiLxjR7vIEJRjiQtsrROPuVaGdWXDPdcb7xRFvctRVWq67/cYwzRICso4
         QkrSCctqIn5k0LGtb7c53c9dvFgbmVAqvosfcu7J0Lx1TGSjzowx3aNdWRZZWONhm9Bs
         QdVDsgP7Ntkw1mdJbDc5KER0cBo+ShJk5oqtpdqDIlTVJKxGIb75V6pf1N1yNIMJyLM+
         iuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YvLnmu4Wq8jjqUUGJ/Mh5PFJXWDf0nAdtM6JdYMI7IU=;
        b=A5ybd95tjO81AUiLbxNtSRNdpTFzOeyTNOwrejC8fUb9pLZJwMRyPoEoykCwIW4z6K
         dYfT3DobMv1Jmhk9ibCxDLxFcFl+rwZmsKlII0EP+qMgSeTYh7ycqvT7wr7Tfrqz+TWG
         lWqGu23ydi3J1E5s/eRovRhRUjJ9qJuax3Eq+8cIzP+fq+9FvHpqMNUCA3bMe1WJcoZG
         aAz4HRMS1n86gIePaLObORqFRd4SUruT+UbxtMkd4JIeKbPbV2Bc8zgeyE6hBbZkYtFs
         NCmjlW8R8zbUwZ3gCUjiqngslBHCIZIJJYkiAdZUF4hX6yBXxUresmeGDFGQhk3UTDBd
         qAmA==
X-Gm-Message-State: ANoB5pmJQJrm0ROJVMOXbRMVFh5zwCn+rR5selzqm+FF7FGQbtRppJpp
        rgy3zEYCQXYdNDmg2GtKnpSc9Hd0dYluZvYs53i+/j78i02r/3Q409I=
X-Google-Smtp-Source: AA0mqf6nPovE1C1F5nKtDRiSxN9ZxHW96bV9sRtMh92ObF0Wj6j/kYZTZ8GwxdeFNjnyhJRKl4rgO3vbKrWzAbdtNQg=
X-Received: by 2002:a9f:23ca:0:b0:3d7:3610:45fc with SMTP id
 68-20020a9f23ca000000b003d7361045fcmr52992500uao.120.1671452316259; Mon, 19
 Dec 2022 04:18:36 -0800 (PST)
MIME-Version: 1.0
References: <20221216073141.3289309-1-milkfafa@gmail.com> <20221216073141.3289309-3-milkfafa@gmail.com>
 <525fd984-0b67-8e11-d13c-7c4ee1853c4e@linaro.org> <22a055a9-a14b-e8b7-84e2-b091a05a3ba4@linaro.org>
In-Reply-To: <22a055a9-a14b-e8b7-84e2-b091a05a3ba4@linaro.org>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Mon, 19 Dec 2022 20:18:25 +0800
Message-ID: <CADnNmFrvDWg6kK==Yje_RrOO=V-DBJiBhtOF84yC-aKvwBQrQA@mail.gmail.com>
Subject: Re: [PATCH v16 2/3] dt-bindings: edac: nuvoton: Add document for NPCM
 memory controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-edac@vger.kernel.org, rric@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, mchehab@kernel.org, bp@alien8.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, ctcchien@nuvoton.com,
        kflin@nuvoton.com, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Krzysztof,

Thanks for the review.

> > So this is a 16th version but through this entire year you never Cced
> > the maintainers... You did not send a single version to the memory
> > controller maintainers.
> >
> > I don't know why it is so big problem to use scripts/get_maintainers.pl.
>
> Although maybe the reason for this is that it was being put in edac
> directory... eh...

I should check the CC list for each version anyway. I'm sorry about that.

> > +++ b/Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-mc.yaml
>
> filename based on compatibles, so nuvoton,npcm-memory-controller.yaml

> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +
>
> No blank lines.

> > +    ahb {
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
>
> Why do you need this node in the example?

These problems will be addressed in next patch. Thank you.

Regards,
Marvin
