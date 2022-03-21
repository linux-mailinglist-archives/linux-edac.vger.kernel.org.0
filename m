Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BFB4E2FFA
	for <lists+linux-edac@lfdr.de>; Mon, 21 Mar 2022 19:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbiCUSad (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Mar 2022 14:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352138AbiCUSab (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 21 Mar 2022 14:30:31 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBF02AE0A;
        Mon, 21 Mar 2022 11:29:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m3so14037773lfj.11;
        Mon, 21 Mar 2022 11:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QJZE8dkCUnUnco1V96yxtmClw0LriXyfY1+6Wy3W2Cc=;
        b=K/auwkg58bis+KPUyv2LucN9+M2eugoOwqQbdSPyxV/O+vsw08julPiPq/JKG/QQF4
         hvUsNny4SYaI3irAM2JnrqK/hUchdS6UHbb4A/+vIx2bY9vQMubluIWrsAVCgJtmIgHn
         nXN2WsRp5E+YMeuZNUwRfMWVL+XKgduggKhmZILxvMjCY7zYW9H3evS0m5ZZ3h3A8zIK
         JKzoJO/vUuCBEPzXyuqb5jA6ogKNsDGhPS1zv0mD4shTBcJ35k5DChWFlhmdCDfhO33F
         Rg8UONAMbrIWNO6yPHVzVEnh06oZNQGdlkkzecccFiIY3Hqt6wPtS1zL6k9uHjydBf0S
         d+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QJZE8dkCUnUnco1V96yxtmClw0LriXyfY1+6Wy3W2Cc=;
        b=OolXeokEEFlaCqfTPrGvIv1QPZVEE7vrl3ahQcEuOKBz/97ct3Iv1MacL2OPn25Ygw
         SMJBXFu14xKa9+nMZBttpU2KaeHcJ1JIjUh8cVjK2Qrswjj+GFeG/zF+seDbLQArCWZy
         w5QghfweEn8yF+1qbkU47J99P0dTVAaoQAgJNDVgEiX3PIUpSKsM4ep6j5Ua8FCT2kLy
         UTSpGn2UgKLh6OIgYBFy7WhK2aJje9AmxRD1Pp28c31X5uJT8Bf+Yi0/Vm0tb7UInJ1V
         c4vyPIrvdPpWw1kv3J5mHNpJCBdB68KGJ6P846R4T92z3n7QijN7bEj69Owo3JmNJ2uo
         tfwg==
X-Gm-Message-State: AOAM531GzeuEYmzRywSL2iOJRhvnNcvEPFfDbJc6dMnd/OneZwAzTyRr
        7vUkQP5PYhjEY82zYqdsi2YBrfxvqpDT/DLO+g==
X-Google-Smtp-Source: ABdhPJwXvLHLay8erHVCVarSzPk3KZSKXrgZr/Qo7BnjPvJl91SNmZ0JLwo1w/mYrxtHRGimXzrK+jroSI6bBTB7WGQ=
X-Received: by 2002:a05:6512:3b2c:b0:44a:35fd:994c with SMTP id
 f44-20020a0565123b2c00b0044a35fd994cmr1302459lfv.473.1647887343882; Mon, 21
 Mar 2022 11:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220317015854.18864-1-ctcchien@nuvoton.com> <20220317015854.18864-4-ctcchien@nuvoton.com>
 <37361667-C932-4139-B649-52DE029BDEE5@alien8.de>
In-Reply-To: <37361667-C932-4139-B649-52DE029BDEE5@alien8.de>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Mon, 21 Mar 2022 20:28:51 +0200
Message-ID: <CAKKbWA66rdm11fM2eWpQpSW2aCfFn-9OwJNNN4J2Q4rE2H4vEw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] EDAC: nuvoton: Add NPCM memory controller driver
To:     Boris Petkov <bp@alien8.de>
Cc:     Medad CChien <medadyoung@gmail.com>, rric@kernel.org,
        James Morse <james.morse@arm.com>, YSCHU@nuvoton.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        tony.luck@intel.com, Benjamin Fair <benjaminfair@google.com>,
        Patrick Venture <venture@google.com>, KWLIU@nuvoton.com,
        Rob Herring <robh+dt@kernel.org>, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, Nancy Yuen <yuenn@google.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, ctcchien@nuvoton.com,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 17, 2022 at 2:50 PM Boris Petkov <bp@alien8.de> wrote:
>
> On March 17, 2022 1:58:54 AM UTC, Medad CChien <medadyoung@gmail.com> wrote:
> >Add support for Nuvoton NPCM SoC.
> >
> >Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> >Reported-by: kernel test robot <lkp@intel.com>
>
> What exactly has the robot reported here?
>
> >---
> > drivers/edac/Kconfig     |   9 +
> > drivers/edac/Makefile    |   1 +
> > drivers/edac/npcm_edac.c | 710 +++++++++++++++++++++++++++++++++++++++
> > 3 files changed, 720 insertions(+)
> > create mode 100644 drivers/edac/npcm_edac.c
>
> I don't see a MAINTAINERS file entry so that people can Cc you on bugs. See the other EDAC drivers for an example.
>

see in MAINTAINERS:
ARM/NUVOTON NPCM ARCHITECTURE
M:      Avi Fishman <avifishman70@gmail.com>
M:      Tomer Maimon <tmaimon77@gmail.com>
...
F:      drivers/*/*npcm*
F:      drivers/*/*/*npcm*

Isn't it OK?

> --
> Sent from a small device: formatting sux and brevity is inevitable.



-- 
Regards,
Avi
