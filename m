Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4C752C13F
	for <lists+linux-edac@lfdr.de>; Wed, 18 May 2022 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241175AbiERRof (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 May 2022 13:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241077AbiERRof (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 May 2022 13:44:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE0966FA8;
        Wed, 18 May 2022 10:44:33 -0700 (PDT)
Received: from zn.tnic (p200300ea974657d0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57d0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 482851EC064D;
        Wed, 18 May 2022 19:44:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652895868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BSrK6ISkCDs9DDx3yHsim7FQBme+cBGtrIf8vV2CXP4=;
        b=QgCtwW8BgIpZDZ4SVm1lnqK7AQshTGtATAdfZqSJsD/6Kkg3SYkhtLYKOWwFVftsJ8D5fe
        3VZQm4soeBvt0bQkhY1d9gG8wq2efOLGJ6Wf3PfaeZX9APZ44EtemhKfjBi64QOsfbRvvj
        xSlR4mBGiMXGqg9F469FxEY6wyydLdw=
Date:   Wed, 18 May 2022 19:44:27 +0200
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
Subject: Re: [PATCH v9 1/3] ARM: dts: nuvoton: Add memory controller node
Message-ID: <YoUwe6Tj4Uh6ukc8@zn.tnic>
References: <20220510031056.1657-1-ctcchien@nuvoton.com>
 <20220510031056.1657-2-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220510031056.1657-2-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 10, 2022 at 11:10:54AM +0800, Medad CChien wrote:
> ECC must be configured in the BootBlock header.
> Then, you can read error counts via the EDAC kernel framework.
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> ---
>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> index 3696980a3da1..ba542b26941e 100644
> --- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> +++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> @@ -106,6 +106,13 @@
>  		interrupt-parent = <&gic>;
>  		ranges;
>  
> +		mc: memory-controller@f0824000 {
> +			compatible = "nuvoton,npcm750-memory-controller";
> +			reg = <0x0 0xf0824000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
>  		rstc: rstc@f0801000 {
>  			compatible = "nuvoton,npcm750-reset";
>  			reg = <0xf0801000 0x70>;
> -- 

Please integrate scripts/checkpatch.pl into your patch creation
workflow. Some of the warnings/errors *actually* make sense.

In this case:

WARNING: DT compatible string "nuvoton,npcm750-memory-controller" appears un-documented -- check ./Documentation/devicetree/bindings/
#35: FILE: arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi:110:
+                       compatible = "nuvoton,npcm750-memory-controller";

For that I'm guessing patch 2 needs to go first in the series.

In any case, the first two need an ACK from devicetree folks.

WARNING: From:/Signed-off-by: email address mismatch: 'From: Medad CChien <medadyoung@gmail.com>' != 'Signed-off-by: Medad CChien <ctcchien@nuvoton.com>'

For this one I wasn't sure so I had to ask: I guess it kinda makes sense
to have the From: be the same as your SOB email. I.e., make sure the
right authorship and SOB is maintained even when sending from machines
with broken email setups.

And that you can fix very easily: just add in your .git/config:

[user]
        name = Medad CChien
        email = ctcchien@nuvoton.com

and git would use that as the author and also slap a From: at the
beginning of the patch with the correct name and email address.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
