Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B484FA542
	for <lists+linux-edac@lfdr.de>; Sat,  9 Apr 2022 07:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiDIF7t (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 9 Apr 2022 01:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiDIF7s (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 9 Apr 2022 01:59:48 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148B6263;
        Fri,  8 Apr 2022 22:57:41 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae90c.dynamic.kabel-deutschland.de [95.90.233.12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9B8C361E6478B;
        Sat,  9 Apr 2022 07:57:37 +0200 (CEST)
Message-ID: <c73bf178-f5bd-01c6-209d-051706112877@molgen.mpg.de>
Date:   Sat, 9 Apr 2022 07:57:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v6 1/3] ARM: dts: nuvoton: Add memory controller node
Content-Language: en-US
To:     Medad CChien <medadyoung@gmail.com>
Cc:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
References: <20220322030152.19018-1-ctcchien@nuvoton.com>
 <20220322030152.19018-2-ctcchien@nuvoton.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220322030152.19018-2-ctcchien@nuvoton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear Medad,


Thank you for the patch.

Am 22.03.22 um 04:01 schrieb Medad CChien:
> ECC must be configured in the BootBlock header.

bootblock

I search for *bootblock* in Linux and the git commit messages, and does 
not seem to be a common term. Is that term used in the datasheet?

> Then, you can read error counts via
> the EDAC kernel framework.

Please reflow for 75 characters per line. (Also, there is no need to 
break lines after a sentence, unless 75 characters are reached or a new 
paragraph starts.)

Tested on what board?

> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>

Out of curiosity, is the first C in CChien the letter of your middle 
name, or the last name really spelled with two capital letters in the 
beginning?

> ---
>   arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> index 3696980a3da1..ba542b26941e 100644
> --- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> +++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
> @@ -106,6 +106,13 @@
>   		interrupt-parent = <&gic>;
>   		ranges;
>   
> +		mc: memory-controller@f0824000 {
> +			compatible = "nuvoton,npcm750-memory-controller";
> +			reg = <0x0 0xf0824000 0x0 0x1000>;

Is f0824000 from some datasheet?

> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
>   		rstc: rstc@f0801000 {
>   			compatible = "nuvoton,npcm750-reset";
>   			reg = <0xf0801000 0x70>;


Kind regards,

Paul
