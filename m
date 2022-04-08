Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1504F9B46
	for <lists+linux-edac@lfdr.de>; Fri,  8 Apr 2022 19:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiDHRE4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 8 Apr 2022 13:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbiDHREu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 8 Apr 2022 13:04:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9963C2134;
        Fri,  8 Apr 2022 10:02:43 -0700 (PDT)
Received: from zn.tnic (p200300ea971561a9329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9715:61a9:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D46A1EC051E;
        Fri,  8 Apr 2022 19:02:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1649437358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=89ZZusgZlQLzjBgn/vcDWRXT/K3jazA2dI5kFw6JX9I=;
        b=KMShXiXQDurLK/vgHdfMrM+Bc1DrLH0mxV3HkZnwtJ4q6i6wPKi4D20Nmfp+NpLK/FzTwX
        SGTwF9N4W0OE5/dBjtPXJSujvo4Ql1OJnNpoKEVGGc9S0lOET1RclTGx4/YkRMyWbmE+3D
        ssuRUjHgkKkqyGVlA+/n9Ii0m5im8U0=
Date:   Fri, 8 Apr 2022 19:02:36 +0200
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
Subject: Re: [PATCH v6 1/3] ARM: dts: nuvoton: Add memory controller node
Message-ID: <YlBqrAApeb8rV9WJ@zn.tnic>
References: <20220322030152.19018-1-ctcchien@nuvoton.com>
 <20220322030152.19018-2-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220322030152.19018-2-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Mar 22, 2022 at 11:01:50AM +0800, Medad CChien wrote:
> ECC must be configured in the BootBlock header.
> Then, you can read error counts via
> the EDAC kernel framework.
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

This needs an ACK from devicetree folks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
