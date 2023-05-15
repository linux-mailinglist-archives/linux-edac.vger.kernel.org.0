Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C70702BE9
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 13:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbjEOLzr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 07:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241491AbjEOLzZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 07:55:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A3519B3;
        Mon, 15 May 2023 04:47:31 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F90E1EC00F4;
        Mon, 15 May 2023 13:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1684151249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WV+Z1Z5j3WTJZZNZcbCUTOiJaFzKxS5LcsxLdgWPj0Q=;
        b=b5IRKg48bZLrDh6VuZcI8xUjXlz2BwYefH5+5Xc1OrMY7ad5XgKcudZJGevlk2YfGWsNRO
        nOLS7CtiOgyYOsdAIRkwMwQo7CuG7FDqcbnrChR/yODWqMdn39+//VZmQYwA7vWuB7diKA
        NTPaBHka1FGX05RqkXR7daKzc+Jo58U=
Date:   Mon, 15 May 2023 13:47:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc:     linux-edac@vger.kernel.org, git@amd.com,
        devicetree@vger.kernel.org, rric@kernel.org,
        shubhrajyoti.datta@gmail.com, james.morse@arm.com,
        tony.luck@intel.com, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, sai.krishna.potthuri@amd.com
Subject: Re: [RESEND PATCH v6 2/2] EDAC/versal: Add a Xilinx Versal memory
 controller driver
Message-ID: <20230515114720.GGZGIbyA9B/4pSyAgw@fat_crate.local>
References: <20230514172432.12505-1-shubhrajyoti.datta@amd.com>
 <20230514172432.12505-3-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230514172432.12505-3-shubhrajyoti.datta@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, May 14, 2023 at 10:54:32PM +0530, Shubhrajyoti Datta wrote:
> Add EDAC support for Xilinx DDR Controller, this driver
> reports correctable and uncorrectable errors , and also creates
> debugfs entries for error injection.

Your 0th message has more info than this.

Use it:

"Add a EDAC driver for the RAS capabilities on the Xilinx integrated DDR
Memory Controllers (DDRMCs) which support both DDR4 and LPDDR4/4X memory
interfaces. It has four programmable NoC interface ports and is designed
to handle multiple streams of traffic."

> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf0f18502372..3177eac9265f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22631,6 +22631,13 @@ S:	Maintained
>  F:	drivers/soc/xilinx/xlnx_event_manager.c
>  F:	include/linux/firmware/xlnx-event-manager.h
>  
> +XILINX VERSAL EDAC DRIVER
> +M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> +M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
> +F:	drivers/edac/xilinx_ddrmc_edac.c
> +

Alphabetically sorted (diff ontop):

---
diff --git a/MAINTAINERS b/MAINTAINERS
index 86cb5613358b..2b976e66c66b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23184,6 +23184,13 @@ F:	Documentation/devicetree/bindings/media/xilinx/
 F:	drivers/media/platform/xilinx/
 F:	include/uapi/linux/xilinx-v4l2-controls.h
 
+XILINX VERSAL EDAC DRIVER
+M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
+F:	drivers/edac/xilinx_ddrmc_edac.c
+
 XILINX WATCHDOG DRIVER
 M:	Srinivas Neeli <srinivas.neeli@amd.com>
 R:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
@@ -23233,13 +23240,6 @@ M:	Harsha <harsha.harsha@xilinx.com>
 S:	Maintained
 F:	drivers/crypto/xilinx/zynqmp-sha.c
 
-XILINX VERSAL EDAC DRIVER
-M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
-M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
-S:	Maintained
-F:	Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
-F:	drivers/edac/xilinx_ddrmc_edac.c
-
 XILLYBUS DRIVER
 M:	Eli Billauer <eli.billauer@gmail.com>
 L:	linux-kernel@vger.kernel.org

...

> +/**
> + * err_callback - Handle Correctable and Uncorrectable errors.
> + * @payload:	payload data.
> + * @data:	mci controller data.
> + *
> + * Handles ECC correctable and uncorrectable errors.
> + */
> +static void err_callback(const u32 *payload, void *data)
> +{
> +	struct mem_ctl_info *mci = (struct mem_ctl_info *)data;
> +	struct edac_priv *priv;
> +	struct ecc_status *p;
> +	int regval;
> +
> +	priv = mci->pvt_info;
> +	p = &priv->stat;
> +
> +	regval = readl(priv->ddrmc_baseaddr + XDDR_ISR_OFFSET);
> +	regval &= (XDDR_IRQ_CE_MASK | XDDR_IRQ_UE_MASK);
> +	if (!regval)
> +		return;
> +
> +	/* Unlock the PCSR registers */
> +	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
> +
> +	/* Clear the ISR */

From previous review:

"Does that ISR clearing reenable the interrupt? If so, you can't do that here."

I see that you're using this xlnx_register_event() thing but, again, what
happens if you clear the ISR and another error gets logged while you're
handling this one?

In that previous review:

https://lore.kernel.org/r/Y9bu8CpiVKvFS1d%2B@zn.tnic

there are more issues which I've raised and I still find them here.

And you haven't taken the time to explain why it is ok or not ok
- you've simply ignored them.

So I'm going to ignore your patch too until you've addressed *all*
review feedback.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
