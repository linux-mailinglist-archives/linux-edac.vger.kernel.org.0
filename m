Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F6472C493
	for <lists+linux-edac@lfdr.de>; Mon, 12 Jun 2023 14:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbjFLMkq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Jun 2023 08:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjFLMj4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Jun 2023 08:39:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A20618C;
        Mon, 12 Jun 2023 05:39:55 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09D151EC0398;
        Mon, 12 Jun 2023 14:39:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686573594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OtR4NuAqh+pHPTCUSpv56F9hvDIrIt4bvebQxXNCupE=;
        b=jbXLavANDNUPKIW0uadvj4TxpIgfAKekRwfaVh727yyB/VsGQRDU8up79cts1NDS3icvCJ
        zM4iUSKDiFW+npXhrB7/EmkRv3m7VGNnTYMJ5RcsNAotwnBRkVb4j7LriJD/m1vvH9meSN
        VGr+z3pzKMKnZJQ4DQ5K0f3YsXWdWac=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with SMTP id LM8F35X4M-PE; Mon, 12 Jun 2023 12:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686573591; bh=OtR4NuAqh+pHPTCUSpv56F9hvDIrIt4bvebQxXNCupE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A9Zg4yb1aBDEj55k7A9V6N0+HBFCyzB6VYpMtHTfhHk8yYQB7EzlO6VaIzApZ967A
         x4P0Cn+Q0KJo+L/VMuT99YiZFpGcs0IthGftjWwioKqWgH/IX5cJf06bME1p7pTCZb
         /20VvUGcXv6bAcJWk9MobiUF0kt+FJL/50IsFrtU7rpRRkQw4C50hGyb6mfRMIxcpd
         22s0XnK4WneEdTxUyRBwh42iG1Q8IqTEZ+sMG98fVFyxt1ag87eqPLISmiH7dCEcwZ
         Kn9kyIfSjlBkfm1HdJKujp1ZbRarrdTvNjetu4trW1Z6pJO7ov1IJvkWOiJaI841hL
         YFCpFOo/wXWSGKjnsNzyMMM7yMe3dtHFJlfpOOoWIbPY0T5qjsRxJc7Ccl9YETZ/sC
         U56nwzcBl10K06igNUwOduYW/TUsBKqR3Wbr2Yj2skwQMzd08h3tTGmCdDWKNd/sTK
         VJ1IUcaM56gIvGuCdZAwgEFWCbBA4IV7iLRS+BV7bncYzXg+kLWValltRHrFcnWotR
         oh1Lr1wTeQCe1Eha3GtVKMGDDUjAK3EztnbWn0aBLR939H4S3zwy3DqB5wlP0TZFWV
         mCHbCoJWaxAaj0YMz9kixkqEgADWQogN9wVW4EDXwFkbQmRdR0gFEmXQ81S6ivTq4T
         2Ph9D+D7LL+JTCAntFnBePGQ=
Received: from zn.tnic (p200300ea971dc5F0329C23FfFEa6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5f0:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6743940E01F7;
        Mon, 12 Jun 2023 12:39:30 +0000 (UTC)
Date:   Mon, 12 Jun 2023 14:39:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marvin Lin <milkfafa@gmail.com>, robh+dt@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, benjaminfair@google.com, yuenn@google.com,
        venture@google.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        ctcchien@nuvoton.com, kflin@nuvoton.com
Subject: Re: [PATCH v18 1/3] ARM: dts: nuvoton: Add node for NPCM memory
 controller
Message-ID: <20230612123925.GGZIcR/dUrcu03z6V+@fat_crate.local>
References: <20230111093245.318745-1-milkfafa@gmail.com>
 <20230111093245.318745-2-milkfafa@gmail.com>
 <20230612110401.GPZIb7oZPdsPGFzSDc@fat_crate.local>
 <38c30778-9526-cba6-4ddb-00bcefeb5647@linaro.org>
 <20230612120107.GFZIcJA3zktkiyTS2+@fat_crate.local>
 <99795947-0584-df42-a28a-aa89d7e21c7e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99795947-0584-df42-a28a-aa89d7e21c7e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 12, 2023 at 02:09:33PM +0200, Krzysztof Kozlowski wrote:
> Please route the DTS (1/3) via Nuvoton SoC tree.

Don't all three need to go together?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
