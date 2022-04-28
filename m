Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C913D51359C
	for <lists+linux-edac@lfdr.de>; Thu, 28 Apr 2022 15:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiD1Nth (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Apr 2022 09:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiD1Ntg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 28 Apr 2022 09:49:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DBB443F4;
        Thu, 28 Apr 2022 06:46:22 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D04EC1EC0535;
        Thu, 28 Apr 2022 15:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651153576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=B1N//0VjX+LuzCM370MMHHTQD8wP/75xtQyHF1CH7v0=;
        b=XlYUyElz/R1ZCGLFXvBYvnOSGQGppRNt/yV9SL2lRWqbZ5HNPv4ME2TnNNxRJkzdXpNGZv
        jpyLGCi6i9W0czQf4n+GhAUCvte3HxxkkUwmSzIj6YXt7XzTbA9ARXzQIBiJqd2NUuHrBP
        dWVRwKspjMeO3zihsIsVbykbIHnU1uo=
Date:   Thu, 28 Apr 2022 15:46:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     michal.simek@xilinx.com, Shubhrajyoti.datta@xilinx.com,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH V2] EDAC/synopsys: Add edac driver support for i.MX
 platforms
Message-ID: <Ymqapaw8hznHy996@zn.tnic>
References: <20220428023209.18087-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220428023209.18087-1-sherry.sun@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Apr 28, 2022 at 10:32:09AM +0800, Sherry Sun wrote:
> i.MX8MP use synopsys v3.70a ddr controller IP, so add edac support
> for i.MX8MP based on the EDAC_SYNOPSYS driver.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
> Changes in V2:
> 1. Improve the patch title and the commit message.
> ---
>  drivers/edac/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 23f11554f400..d3e2477948c8 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -485,7 +485,7 @@ config EDAC_ARMADA_XP
>  
>  config EDAC_SYNOPSYS
>  	tristate "Synopsys DDR Memory Controller"
> -	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA
> +	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || ARCH_MXC
>  	help
>  	  Support for error detection and correction on the Synopsys DDR
>  	  memory controller.
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
