Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1449F530CAE
	for <lists+linux-edac@lfdr.de>; Mon, 23 May 2022 12:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiEWJeu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 May 2022 05:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiEWJep (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 23 May 2022 05:34:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DADC4B1F9;
        Mon, 23 May 2022 02:34:42 -0700 (PDT)
Received: from zn.tnic (p200300ea974657b3329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57b3:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E65A01EC018C;
        Mon, 23 May 2022 11:34:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653298477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wfztkaByN97ueSWPSqUqhksXQIUMUHKpNYslfU+pPrg=;
        b=ebzCyRjlW0zFUmL1cfxuMt0O5oJoWih0LGLxXewxEsVV0HwLlSAaeluWxaSLSeO8QNDjlX
        RcOcKTTgh1zkPPm6FIe+5BQlCC9pN1+LFFgLzn53igTIFT5imcU7xC2Riu5Mj/+AFraVpv
        uPGo0V8r+Ar0u93K+6/I7bDk6Lzm3r4=
Date:   Mon, 23 May 2022 11:34:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Medad Young <medadyoung@gmail.com>
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
Subject: Re: [PATCH v9 1/3] ARM: dts: nuvoton: Add memory controller node
Message-ID: <YotVJ+ExcrQshM4A@zn.tnic>
References: <20220510031056.1657-1-ctcchien@nuvoton.com>
 <20220510031056.1657-2-ctcchien@nuvoton.com>
 <YoUwe6Tj4Uh6ukc8@zn.tnic>
 <CAHpyw9fjThEP4NuU08aNJ_raHpq9-j9KgBb8YuZ_shXTjhm3JA@mail.gmail.com>
 <YoYPGWreQuF9QZzc@zn.tnic>
 <CAHpyw9es-n+bW9SsGBmmr3ghBFk8Q8E6ZTbE42BpU-6p8LfHtw@mail.gmail.com>
 <YoeE8cBhUkF3K44/@zn.tnic>
 <CAHpyw9fAfNf8j++JtLhuudSWj6N1-KAxA_fxEGL998WNVXTPdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHpyw9fAfNf8j++JtLhuudSWj6N1-KAxA_fxEGL998WNVXTPdQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, May 23, 2022 at 05:06:07PM +0800, Medad Young wrote:
> I did do "git commit --amend",
> I beleve the issue is about the mail server I used,
> I use gmail to send the mail due to the mail server of my company
> does't support smtp
> so now I should sign the commit with my gmail account.

No, you should supply --author too - I had forgotten about that.

commit 0876b99e4aa2bf7113070c9c0f5d0ade7ad91697 (HEAD -> refs/heads/test)
Author: Medad CChien <medadyoung@gmail.com>
Date:   Tue May 10 11:10:54 2022 +0800

    ARM: dts: nuvoton: Add memory controller node
    
    ECC must be configured in the BootBlock header.
    Then, you can read error counts via the EDAC kernel framework.
    
    Signed-off-by: Medad CChien <ctcchien@nuvoton.com>

$  git commit --amend --author="Medad CChien <ctcchien@nuvoton.com>"
[test 5d6cd85171d1] ARM: dts: nuvoton: Add memory controller node
 Author: Medad CChien <ctcchien@nuvoton.com>
 Date: Tue May 10 11:10:54 2022 +0800
 1 file changed, 7 insertions(+)
$ git log -p -1
commit 5d6cd85171d14e67840e672e2f96a16981243424 (HEAD -> refs/heads/test)
Author: Medad CChien <ctcchien@nuvoton.com>
Date:   Tue May 10 11:10:54 2022 +0800

    ARM: dts: nuvoton: Add memory controller node
    
    ECC must be configured in the BootBlock header.
    Then, you can read error counts via the EDAC kernel framework.
    
    Signed-off-by: Medad CChien <ctcchien@nuvoton.com>

$ git format-patch -1 -o /tmp/
/tmp/0001-ARM-dts-nuvoton-Add-memory-controller-node.patch

$ head /tmp/0001-ARM-dts-nuvoton-Add-memory-controller-node.patch
From 5d6cd85171d14e67840e672e2f96a16981243424 Mon Sep 17 00:00:00 2001
From: Medad CChien <ctcchien@nuvoton.com>
		    ^^^^^^^^^^^^^^^^^^^^^^


Don't hesitate to look at the manpages if a tool doesn't do what you
expect it to do.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
