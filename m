Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FD15181D0
	for <lists+linux-edac@lfdr.de>; Tue,  3 May 2022 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiECKCQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 May 2022 06:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbiECKCN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 May 2022 06:02:13 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E3F36144;
        Tue,  3 May 2022 02:58:41 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aed95.dynamic.kabel-deutschland.de [95.90.237.149])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E8DB461EA193F;
        Tue,  3 May 2022 11:58:38 +0200 (CEST)
Message-ID: <d09f0131-65e2-d382-27b9-29ded4f47d84@molgen.mpg.de>
Date:   Tue, 3 May 2022 11:58:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 3/3] EDAC: nuvoton: Add NPCM memory controller driver
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
References: <20220503094728.926-1-ctcchien@nuvoton.com>
 <20220503094728.926-4-ctcchien@nuvoton.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220503094728.926-4-ctcchien@nuvoton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear Medad,


Thank you for v8.

Am 03.05.22 um 11:47 schrieb Medad CChien:
> Add memory controller support for Nuvoton NPCM SoC.
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> Reviewed-by: Borislav Petkov <bp@alien8.de>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reported-by: kernel test robot <lkp@intel.com>

This line is confusing.

> error:
>     macro "edac_printk" requires 4 arguments, but only 2 given
> 
> warnings:
>     performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>     logical not is only applied to the left hand side of this bitwise operator [-Wlogical-not-parentheses]
>     mixing declarations and code is a C99 extension [-Wdeclaration-after-statement]
> 
> Note:
>     you can force an ecc event by writing a string to edac sysfs node
>     and remember to define CONFIG_EDAC_DEBUG to enable this feature
>     example: force a correctable event on checkcode bit 0
>     echo "CE checkcode 0" > /sys/devices/system/edac/mc/mc0/forced_ecc_error

Shouldn’t this go above all the tags?

> ---
>   drivers/edac/Kconfig     |   9 +
>   drivers/edac/Makefile    |   1 +
>   drivers/edac/npcm_edac.c | 680 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 690 insertions(+)
>   create mode 100644 drivers/edac/npcm_edac.c
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 58ab63642e72..64149b524f98 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -539,4 +539,13 @@ config EDAC_DMC520
>   	  Support for error detection and correction on the
>   	  SoCs with ARM DMC-520 DRAM controller.
>   
> +config EDAC_NPCM
> +	tristate "Nuvoton NPCM DDR Memory Controller"
> +	depends on (ARCH_NPCM || COMPILE_TEST)
> +	help
> +	  Support for error detection and correction on the Nuvoton NPCM DDR
> +	  memory controller.

Please add a blank line below.

> +	  First, ECC must be configured in the BootBlock header. Then, this driver
> +	  will expose error counters via the EDAC kernel framework.
> +
>   endif # EDAC

[…]
> +module_platform_driver(npcm_edac_mc_driver);
> +
> +MODULE_AUTHOR("Medad CChien<ctcchien@nuvoton.com>");

Please add a space before the <.

> +MODULE_DESCRIPTION("Nuvoton NPCM EDAC Driver");
> +MODULE_LICENSE("GPL v2");


Kind regards,

Paul
