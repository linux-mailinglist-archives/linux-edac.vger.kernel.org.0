Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4A54F9B4F
	for <lists+linux-edac@lfdr.de>; Fri,  8 Apr 2022 19:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbiDHRH5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 8 Apr 2022 13:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiDHRHz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 8 Apr 2022 13:07:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39396566;
        Fri,  8 Apr 2022 10:05:51 -0700 (PDT)
Received: from zn.tnic (p200300ea971561a9329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:61a9:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5165A1EC051E;
        Fri,  8 Apr 2022 19:05:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649437546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uYu8iWlZQYH+Bm17RBzzOYr9i3qetiJpgS6rm43ra5s=;
        b=kNRLSaJgdGIdnULXvFzS0nD0u5rgoguzLLKG2jKK2HJXktHucOTj/OksJaY5Ya7/TrLrTN
        WzwCSLID5vl1vtTjVrfizhGk7uN81rEr55q/J1rcgsUCRjFw3ZyzUQ7d/M5M+61ZUnuuud
        Wz1TkeqmcPs8PEBUTRXApZlGihoML4s=
Date:   Fri, 8 Apr 2022 19:05:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Medad CChien <medadyoung@gmail.com>
Cc:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v6 2/3] dt-bindings: edac: nuvoton: add NPCM memory
 controller
Message-ID: <YlBrbV2rstunqrW6@zn.tnic>
References: <20220322030152.19018-1-ctcchien@nuvoton.com>
 <20220322030152.19018-3-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220322030152.19018-3-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Mar 22, 2022 at 11:01:51AM +0800, Medad CChien wrote:
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    ahb {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        mc: memory-controller@f0824000 {
> +            compatible = "nuvoton,npcm750-memory-controller";
> +            reg = <0x0 0xf0824000 0x0 0x1000>;
> +            interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> +

.git/rebase-apply/patch:73: new blank line at EOF.
+
warning: 1 line adds whitespace errors.


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
