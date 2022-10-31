Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143A0613C17
	for <lists+linux-edac@lfdr.de>; Mon, 31 Oct 2022 18:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiJaRZA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 Oct 2022 13:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJaRY7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 Oct 2022 13:24:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259E21000;
        Mon, 31 Oct 2022 10:24:58 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7cf329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7cf:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6464F1EC042F;
        Mon, 31 Oct 2022 18:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667237096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KM4MlHYEPBibXJYMyGsoFqqbcjeyXylp9uhEPTyVtk8=;
        b=fqkPucJXDEbQwppgyrMobp5sbCAfvbFCHlkyyinEdrOw7FQhPPiDbdIaP4hUcwsTPXziIh
        rXFXJKQvkC4RzC+1a/qYO5/ujWncYk0+xTP35N6wRwniLkOv3eCN4AOdCMuSKetwvs+ahe
        6BptN4fsOJ6Tos2PFnpHjFSr9TptluE=
Date:   Mon, 31 Oct 2022 18:24:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sherry Sun <sherry.sun@nxp.com>,
        Shubhrajyoti Datta <Shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH RESEND v3 01/17] EDAC/synopsys: Fix native uMCTL2 IRQs
 handling procedure
Message-ID: <Y2AE5A74TIZwJ/7Q@zn.tnic>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220929232712.12202-2-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 30, 2022 at 02:26:56AM +0300, Serge Semin wrote:
> The generic DW uMCTL2 DDRC v3.x support was added in commit f7824ded4149
> ("EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR"). It
> hasn't been done quiet well there with respect to the IRQs handling
> procedure. An attempt to fix that was introduced in the recent commit
> 4bcffe941758 ("EDAC/synopsys: Re-enable the error interrupts on v3 hw").
> Alas again it didn't provide quite complete solution.

Because?

Btw, for the future, you should make sure you add those commit authors
to Cc so that they can get a chance to comment. Adding the folks from
that commit to Cc.

> First of all the commit f7824ded4149 ("EDAC/synopsys: Add support for
> version 3 of the Synopsys EDAC DDR") log says that v3.80a "has UE/CE auto
> cleared". They aren't in none of the IP-core versions.
	    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

What does that sentence mean exactly? The UE/CE auto clearing
functionality is not in that silicon?

> The IRQ status can be cleared by means of setting the ECCCLR/ECCCTL
> register self-cleared flags 0-3.

I'm guessing that's this reg:

/* ECC control register */
#define ECC_CTRL_OFST                   0xC4

?

> The pending IRQ clearance is done in the respective get_error_info()
> method of the driver. Thus defining a quirk flag with the
> "DDR_ECC_INTR_SELF_CLEAR" name was at least very inaccurate if not to
> say misleading.
>
> So was adding the comments about the "ce/ue bits automatically
> cleared".

Aah, you mean that the ->get_error_info() functions are doing the
clearing even if something should be doing self clearing. And that
DDR_ECC_INTR_SELF_CLEAR thing is queried when enabling the error
interrupt which is just bad naming because it looks like that quirk
controls what register to write/read.

> Second, disabling the being handled IRQ in the handler doesn't make sense
> in Linux since the IC line is masked during that procedure anyway. So
> disabling the IRQ in one part of the handler and enabling it at the end of
> the method is simply redundant. (See, the ZynqMP-specific code with the
> QoS IRQ CSR didn't do that originally.)

So what is this commit message of

  4bcffe941758 ("EDAC/synopsys: Re-enable the error interrupts on v3 hw")

then talking about:

"Then the interrupt handler will be called only once."

How is that interrupt supposed to be reenabled?

> Finally calling the zynqmp_get_error_info() method concurrently with the
> enable_irq()/disable_irq() functions causes the IRQs mask state race
> condition. Starting from DW uMCTL2 DDRC IP-core v3.10a [1] the ECCCLR
> register has been renamed to ECCCTL and has been equipped with CE/UE IRQs
> enable/disable flags [2].

Aha, that sounds like the right thing to toggle.

> So the CSR now serves for the IRQ status and control functions used
> concurrently during the IRQ handling and the IRQ disabling/enabling.
> Thus the corresponding critical section must be protected with the
> IRQ-safe spin-lock.

> So let's fix all the problems noted above. First the
> DDR_ECC_INTR_SELF_CLEAR flag is renamed to SYNPS_ZYNQMP_IRQ_REGS.

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy to
do frotz", as if you are giving orders to the codebase to change its
behaviour."

In this case, pls formulate it something like this:

"So fix all these problems noted above: rename DDR_ECC_INTR_SELF_CLEAR
to SYNPS_ZYNQMP_IRQ_REGS to denote that, ..."

And so on.

> Its semantic is now the opposite: the quirk means having the ZynqMP
> IRQ CSRs available on the platform.

Yes, that makes more sense.

> Second the DDR_UE_MASK and DDR_CE_MASK macros
> are renamed to imply being used in the framework of the ECCCLR/ECCCTL CSRs
> accesses. Third all the misleading comments are removed. Finally the
> ECC_CLR_OFST register IOs are now protected with the IRQ-safe spin-lock
> taken in order to prevent the IRQ status clearance and IRQ enable/disable
> race condition.
> 
> [1] DesignWare Cores Enhanced Universal DDR Memory and Protocol
> Controllers (uMCTL2/uPCTL2), Release Notes, Version 3.91a, October 2020,
> p. 27.
> [2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2),
> Databook Version 3.91a, October 2020, p.818-819.

If those are not publicly accessible, then there's no point to put them
in here.

> Fixes: f7824ded4149 ("EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Does this need to go to stable@ and thus older kernels?

> ---
>  drivers/edac/synopsys_edac.c | 76 +++++++++++++++++++++++-------------
>  1 file changed, 48 insertions(+), 28 deletions(-)

> @@ -300,6 +299,7 @@ struct synps_ecc_status {
>  /**
>   * struct synps_edac_priv - DDR memory controller private instance data.
>   * @baseaddr:		Base address of the DDR controller.
> + * @lock:		Concurrent CSRs access lock.
>   * @message:		Buffer for framing the event specific info.
>   * @stat:		ECC status information.
>   * @p_data:		Platform data.
> @@ -314,6 +314,7 @@ struct synps_ecc_status {
>   */
>  struct synps_edac_priv {
>  	void __iomem *baseaddr;
> +	spinlock_t lock;

That lock needs to be named properly and have a comment above it what it
protects.

>  	char message[SYNPS_EDAC_MSG_SIZE];
>  	struct synps_ecc_status stat;
>  	const struct synps_platform_data *p_data;

...

> @@ -516,24 +523,42 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
>  
>  static void enable_intr(struct synps_edac_priv *priv)
>  {
> +	unsigned long flags;
> +
>  	/* Enable UE/CE Interrupts */
> -	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
> -		writel(DDR_UE_MASK | DDR_CE_MASK,
> -		       priv->baseaddr + ECC_CLR_OFST);
> -	else
> +	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
>  		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
>  		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
>  
> +		return;
> +	}
> +
> +	/* IRQs Enable/Disable feature has been available since v3.10a */

How does this comment help here?

If it is available since a version number, why doesn't the below check a
version number? IOW, what is the relevance of that comment here?

In any case, I need to hear from this driver's maintainer too.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
