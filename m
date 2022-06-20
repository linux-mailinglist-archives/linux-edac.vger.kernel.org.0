Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C339552268
	for <lists+linux-edac@lfdr.de>; Mon, 20 Jun 2022 18:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbiFTQkS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 20 Jun 2022 12:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiFTQkR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 20 Jun 2022 12:40:17 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5768BE15;
        Mon, 20 Jun 2022 09:40:16 -0700 (PDT)
Received: from zn.tnic (p200300ea974657f0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57f0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 46D431EC05ED;
        Mon, 20 Jun 2022 18:40:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1655743211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uVkwYYD3WNvkHSrPcC3CPbJPRGT2Rr8D4frbfFUL2Hs=;
        b=n1wHZBcSwAq8PYDjrtgmPSl7w3SaSZeFIoFaI1Uu6DNJRlYzUcqGQdWqi32jQLApZWcS2a
        hse+Za2prAk7smsjcBp9MCBk67LYupuxF7bWvaaFGclzZRn6B6Vgse2fzeRZGyb1KUqLJa
        ZC9u+BDllQRkUxZk5raV/125ljU+3lo=
Date:   Mon, 20 Jun 2022 18:40:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     medadyoung@gmail.com
Cc:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v12 1/3] dt-bindings: edac: nuvoton: add NPCM memory
 controller
Message-ID: <YrCi1fg+mUPwZ7sX@zn.tnic>
References: <20220610084340.2268-1-ctcchien@nuvoton.com>
 <20220610084340.2268-2-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220610084340.2268-2-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 10, 2022 at 04:43:38PM +0800, medadyoung@gmail.com wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4383949ff654..7f832e6ed4e5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2367,12 +2367,14 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
>  S:	Supported
>  F:	Documentation/devicetree/bindings/*/*/*npcm*
>  F:	Documentation/devicetree/bindings/*/*npcm*
> +F:	Documentation/devicetree/bindings/*/npcm-memory-controller.yaml
>  F:	arch/arm/boot/dts/nuvoton-npcm*
>  F:	arch/arm/mach-npcm/
>  F:	drivers/*/*npcm*
>  F:	drivers/*/*/*npcm*
>  F:	include/dt-bindings/clock/nuvoton,npcm7xx-clock.h
>  
> +

That looks like it went in when committing. You can remove it in case
you have to resend v13.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
