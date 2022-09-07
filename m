Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD90C5B05F1
	for <lists+linux-edac@lfdr.de>; Wed,  7 Sep 2022 16:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiIGOBJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Sep 2022 10:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIGOBJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Sep 2022 10:01:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C93B1A077;
        Wed,  7 Sep 2022 07:01:04 -0700 (PDT)
Received: from nazgul.tnic (unknown [84.201.196.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E81161EC06C2;
        Wed,  7 Sep 2022 16:00:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662559259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sxStWTfxn2dypJIOH/2fbSCIkvshh9DlNn17kfCiO1M=;
        b=rdv/6PCxOWQ6trByYJT/u8O35xl1DwgpQ/aVyb4TRg2GyFhTtHCoTOMv3N3tGXuoEEkhvZ
        M0Jk1fftoubrTSNVrX5Q1Tt8EM/HhVk3/CqP+i8c9VMWvmBFeawjMw2355aJ1W2Fyyr1q1
        88OzRnQzx+FuHUAGEbfsLIHYw9BvBJ0=
Date:   Wed, 7 Sep 2022 16:01:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: Re: [PATCH v4 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM
Message-ID: <YxikJCguJWunfh6x@nazgul.tnic>
References: <20220907111531.703-1-sai.krishna.potthuri@amd.com>
 <20220907111531.703-3-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220907111531.703-3-sai.krishna.potthuri@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 07, 2022 at 04:45:31PM +0530, Sai Krishna Potthuri wrote:
> Add EDAC support for Xilinx ZynqMP OCM Controller, this driver
> reports CE and UE errors based on the interrupts, and also creates ue/ce
> sysfs entries for error injection.
> 
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

I think you folks need to brush up on

Documentation/process/submitting-patches.rst

in order to build your SOB chain properly.

> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 58ab63642e72..08adedfd42b5 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -539,4 +539,13 @@ config EDAC_DMC520
>  	  Support for error detection and correction on the
>  	  SoCs with ARM DMC-520 DRAM controller.
>  
> +config EDAC_ZYNQMP_OCM
> +	tristate "Xilinx ZynqMP OCM Controller"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST

We already have an EDAC driver which depends on ARCH_ZYNQMP - the
Synopsys one. Can this one be made part of it?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
