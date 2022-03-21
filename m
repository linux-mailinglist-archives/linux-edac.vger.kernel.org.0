Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310B64E3069
	for <lists+linux-edac@lfdr.de>; Mon, 21 Mar 2022 20:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352417AbiCUTEr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Mar 2022 15:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352412AbiCUTEo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 21 Mar 2022 15:04:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0AE167E7;
        Mon, 21 Mar 2022 12:03:15 -0700 (PDT)
Received: from zn.tnic (p200300ea971561e8329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:61e8:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF4851EC056A;
        Mon, 21 Mar 2022 20:03:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1647889389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3tsEfYC5mE29FrztA7klv5Gy5kBdTlSRewG9h1lk6J0=;
        b=b2Lotxl6qpFk/BSkwu5EtFqSYbA64Og5nG81QQAjZmC/55o4n2tQflqjjyr26KVi5wOrOU
        1h7vZ/fuLu+fzxA6nOYnWXMUwFwQu/O3QwdFdu6woIBZJO3nhgvLO9efNrU95zSiLM2mck
        GIU/s4MUQGsZUr6TFX0ozIyPprqhOfI=
Date:   Mon, 21 Mar 2022 20:03:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Avi Fishman <avifishman70@gmail.com>
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
Subject: Re: [PATCH v5 3/3] EDAC: nuvoton: Add NPCM memory controller driver
Message-ID: <YjjL6OJ3MLXvC6mj@zn.tnic>
References: <20220317015854.18864-1-ctcchien@nuvoton.com>
 <20220317015854.18864-4-ctcchien@nuvoton.com>
 <37361667-C932-4139-B649-52DE029BDEE5@alien8.de>
 <CAKKbWA66rdm11fM2eWpQpSW2aCfFn-9OwJNNN4J2Q4rE2H4vEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKKbWA66rdm11fM2eWpQpSW2aCfFn-9OwJNNN4J2Q4rE2H4vEw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Mar 21, 2022 at 08:28:51PM +0200, Avi Fishman wrote:
> see in MAINTAINERS:
> ARM/NUVOTON NPCM ARCHITECTURE
> M:      Avi Fishman <avifishman70@gmail.com>
> M:      Tomer Maimon <tmaimon77@gmail.com>
> ...
> F:      drivers/*/*npcm*
> F:      drivers/*/*/*npcm*
> 
> Isn't it OK?

Ah, I didn't know you guys have such an entry already - we usually do
EDAC-specific ones but yeah, the current solution is ok too:

./scripts/get_maintainer.pl -f drivers/edac/npcm_edac.c
Avi Fishman <avifishman70@gmail.com> (supporter:ARM/NUVOTON NPCM ARCHITECTURE)
Tomer Maimon <tmaimon77@gmail.com> (supporter:ARM/NUVOTON NPCM ARCHITECTURE)
Tali Perry <tali.perry1@gmail.com> (supporter:ARM/NUVOTON NPCM ARCHITECTURE)
Patrick Venture <venture@google.com> (reviewer:ARM/NUVOTON NPCM ARCHITECTURE)
Nancy Yuen <yuenn@google.com> (reviewer:ARM/NUVOTON NPCM ARCHITECTURE)
...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
