Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969465522C0
	for <lists+linux-edac@lfdr.de>; Mon, 20 Jun 2022 19:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242619AbiFTR3X (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 20 Jun 2022 13:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242488AbiFTR3X (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 20 Jun 2022 13:29:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68826F7E;
        Mon, 20 Jun 2022 10:29:22 -0700 (PDT)
Received: from zn.tnic (p200300ea974657f0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57f0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF7F31EC05ED;
        Mon, 20 Jun 2022 19:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1655746156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gUlzAeZNwuh0l98Jvd0V4kz7rJaVDobs7VUQsJjRpeE=;
        b=YSEahRpz9+/ygJgmF92+3xk1J5HAo3hHVl4w9sGjucH52jxe7gW9H6wSNQ8CuDpU/r5T0C
        W7BOM9jwhx6/Ngrtqk3n0Brh7nsp200ln1+QzRqPns66eY5a2w5zSmtakQeKrt3jGYkWer
        2GTQ0k8fwOOFgZR46oPpCZUOKpL7ffk=
Date:   Mon, 20 Jun 2022 19:29:10 +0200
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
Subject: Re: [PATCH v12 2/3] ARM: dts: nuvoton: Add memory controller node
Message-ID: <YrCuZkvG8atg0z54@zn.tnic>
References: <20220610084340.2268-1-ctcchien@nuvoton.com>
 <20220610084340.2268-3-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220610084340.2268-3-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 10, 2022 at 04:43:39PM +0800, medadyoung@gmail.com wrote:
> From: Medad CChien <ctcchien@nuvoton.com>
> 
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

This one needs an Ack from DT folks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
