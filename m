Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F383652E287
	for <lists+linux-edac@lfdr.de>; Fri, 20 May 2022 04:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbiETCbU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 May 2022 22:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242350AbiETCbT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 May 2022 22:31:19 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1201901C;
        Thu, 19 May 2022 19:31:18 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id m6so8223255ljb.2;
        Thu, 19 May 2022 19:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4K3/H4TcsWiICjtjAzpXHxRhVd4rvAY9pu0lXYepp9Y=;
        b=q69QJAXMiVUP3LAmCEiU2tFX2Y/1D4c3xg9c/FaYVZEG7xZ5SrnVOxSJOzaEFIcHjg
         waOZGIkhjZU/wLDWMV3aocB77TOjyH+DQA0vPuggdBcAaGMdXEqp9X6skgHdUR10G8if
         dKjP0Dd1ZPhX3TdZJa2yc0bBkPf0bCwBaaPJWA9n9Y3iDBQ2eE5OK0JGWnYWSs5FY2fS
         9WkCXW7ZL7TPaiu/A8NwcSJyiydNV4bPEmBZE/Gujh/je4AYYarYFoIdk3egxphnFLPx
         cEl8Uefpx+AybA5x8NsUwXFGVulLDwNj8Kz9ytV5YCh3/yxkIijKDtCoAdDzwHtareV9
         D3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4K3/H4TcsWiICjtjAzpXHxRhVd4rvAY9pu0lXYepp9Y=;
        b=rhi13JcN65KoSADQCs4dNbhZBj0GYrlZ9OEIXJ9D2wCIpIRYcdzDVRIaIfhSl4skQN
         CUeBhk3zrGyVzkihJ+Lr4IzujhLAKXuosBEDuhEbbnkn9xVKgUuCNCe3bRt2swhm1frd
         xzopTWMiC3wFMwY/9XiCC8MVeWekaoEGC9aBh4bpg8qzR7PhfBYuXhXXc37DVvIRrLs9
         su5kDod9AZgbQOjjj0m3xwNm0T5jmuKZzFiW9OEzGeuzVYgMYisR4rFsIAixXYNPF/dP
         yCKTONgZh9/BdArj6MJeu2lc9pchJtX9WSpt4vcVpWSq5ZNQigEIKzHTZfEvAjm74yPA
         Zmkw==
X-Gm-Message-State: AOAM531GUBx46drF7Os8rM+ePNkFPXIpGK03CUDyqse0ZqTv91BpXJxE
        H9pmoylSRcycQsnKUeDa4FBvta8ZJXQLnwvJUTQ=
X-Google-Smtp-Source: ABdhPJzbJc3lipjGIY3YARcqBDA6+gKxe5BWxGiB9P7PGYHZu5lU7udIPhLjNFQfn6JA8kKxMeJhForJVBoaRyqDu1A=
X-Received: by 2002:a2e:a602:0:b0:253:d7e2:4d8a with SMTP id
 v2-20020a2ea602000000b00253d7e24d8amr2661606ljp.284.1653013876956; Thu, 19
 May 2022 19:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220510031056.1657-1-ctcchien@nuvoton.com> <20220510031056.1657-2-ctcchien@nuvoton.com>
 <YoUwe6Tj4Uh6ukc8@zn.tnic> <CAHpyw9fjThEP4NuU08aNJ_raHpq9-j9KgBb8YuZ_shXTjhm3JA@mail.gmail.com>
 <YoYPGWreQuF9QZzc@zn.tnic>
In-Reply-To: <YoYPGWreQuF9QZzc@zn.tnic>
From:   Medad Young <medadyoung@gmail.com>
Date:   Fri, 20 May 2022 10:31:05 +0800
Message-ID: <CAHpyw9es-n+bW9SsGBmmr3ghBFk8Q8E6ZTbE42BpU-6p8LfHtw@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] ARM: dts: nuvoton: Add memory controller node
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

Borislav Petkov <bp@alien8.de> =E6=96=BC 2022=E5=B9=B45=E6=9C=8819=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, May 19, 2022 at 08:55:53AM +0800, Medad Young wrote:
> > OK, I got it.
>
> Are you sure you did get it?
>

for the second warning, I did upadate my .git/config according to your advi=
se.
but I thought I met orthe problem, I will try to fix it

for the first warning, did I really need to fix it?

> $ ./scripts/checkpatch.pl /tmp/medad-v10-1-3.patch
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #29:
> new file mode 100644
>
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Medad CChien=
 <medadyoung@gmail.com>' !=3D 'Signed-off-by: Medad CChien <ctcchien@nuvoto=
n.com>'
>
> total: 0 errors, 2 warnings, 62 lines checked
>
> Before sending, you should really run checkpatch on your patches.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

thanks
B.R.
Medad
