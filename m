Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D41252962
	for <lists+linux-edac@lfdr.de>; Wed, 26 Aug 2020 10:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgHZIlm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Aug 2020 04:41:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38940 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgHZIll (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 Aug 2020 04:41:41 -0400
Received: from zn.tnic (p200300ec2f0cee0024a26a8aa2aa63ac.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:ee00:24a2:6a8a:a2aa:63ac])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 217AC1EC0301;
        Wed, 26 Aug 2020 10:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598431300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZE7uC6CHQpyqIIxTbxn2FFeWPLzDl3FgM/mrD0u5pCU=;
        b=bkN50tGUkGAgffHjLGrW+4LjYaJ8cW/UveGXB6ARooAPae1UOhHppKsn+NGMis0EToMYcl
        GzoHU8jq7tVV87BEwDAoBRRy1rMQcoPwvLhggS2g2pH+K5yc/WFcfEVCt5YrRR5JPQpUfr
        3zHUd/7KKb4BlO0G4qf558YFKmswLXU=
Date:   Wed, 26 Aug 2020 10:41:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        James Morse <james.morse@arm.com>
Cc:     linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        York Sun <york.sun@nxp.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] drivers/edac: Add L1 and L2 error detection for A53
 and A57
Message-ID: <20200826084135.GA22390@zn.tnic>
References: <20200813075721.27981-1-s.hauer@pengutronix.de>
 <20200813075721.27981-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813075721.27981-2-s.hauer@pengutronix.de>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 13, 2020 at 09:57:20AM +0200, Sascha Hauer wrote:
> The Cortex A53 and A57 cores have error detection capabilities for the
> L1/L2 Caches, this patch adds a driver for them.
> 
> Unfortunately there is no robust way to inject errors into the caches,
> so this driver doesn't contain any code to actually test it. It has
> been tested though with code taken from an older version of this driver
> found here: https://lkml.org/lkml/2018/3/14/1203. For reasons stated
> in this thread the error injection code is not suitable for mainline,
> so it is removed from the driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/edac/arm,cortex-a5x-edac.yaml    |  32 +++
>  drivers/edac/Kconfig                          |   6 +
>  drivers/edac/Makefile                         |   1 +
>  drivers/edac/cortex_arm64_l1_l2.c             | 208 ++++++++++++++++++
>  4 files changed, 247 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/arm,cortex-a5x-edac.yaml
>  create mode 100644 drivers/edac/cortex_arm64_l1_l2.c

Just nitpicks below. James'd need to look at this too before it goes
anywhere.

Checkpatch is trying to tell me something here:

WARNING: DT compatible string "arm,cortex-a53-edac" appears un-documented -- check ./Documentation/devicetree/bindings/
#296: FILE: drivers/edac/cortex_arm64_l1_l2.c:190:
+       { .compatible = "arm,cortex-a53-edac" },

WARNING: DT compatible string "arm,cortex-a57-edac" appears un-documented -- check ./Documentation/devicetree/bindings/
#297: FILE: drivers/edac/cortex_arm64_l1_l2.c:191:
+       { .compatible = "arm,cortex-a57-edac" },

for 2/2 too:

WARNING: DT compatible string "arm,cortex-a53-edac" appears un-documented -- check ./Documentation/devicetree/bindings/
#39: FILE: arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi:842:
+               compatible = "arm,cortex-a53-edac";

WARNING: DT compatible string "arm,cortex-a57-edac" appears un-documented -- check ./Documentation/devicetree/bindings/
#56: FILE: arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi:805:
+               compatible = "arm,cortex-a57-edac";


False positive or valid?

...

> +static void read_errors(void *data)
> +{
> +	u64 cpumerr, l2merr;
> +	int cpu = smp_processor_id();
> +	char msg[MESSAGE_SIZE];
> +	struct edac_device_ctl_info *edac_ctl = data;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

Check your other functions too pls.

> +	/* cpumerrsr_el1 */
> +	asm volatile("mrs %0, s3_1_c15_c2_2" : "=r" (cpumerr));
> +	asm volatile("msr s3_1_c15_c2_2, %0" :: "r" (0));
> +
> +	if (cpumerr & CPUMERRSR_EL1_VALID) {
> +		const char *str;
> +		int fatal = (cpumerr & CPUMERRSR_EL1_FATAL) != 0;

Don't need "!= 0" and fatal can be bool.

> +		switch (FIELD_GET(CPUMERRSR_EL1_RAMID, cpumerr)) {
> +		case L1_I_TAG_RAM:
> +			str = "L1-I Tag RAM";
> +			break;
> +		case L1_I_DATA_RAM:
> +			str = "L1-I Data RAM";
> +			break;
> +		case L1_D_TAG_RAM:
> +			str = "L1-D Tag RAM";
> +			break;
> +		case L1_D_DATA_RAM:
> +			str = "L1-D Data RAM";
> +			break;
> +		case L1_D_DIRTY_RAM:
> +			str = "L1 Dirty RAM";
> +			break;
> +		case TLB_RAM:
> +			str = "TLB RAM";
> +			break;
> +		default:
> +			str = "unknown";
> +			break;
> +		}
> +
> +		snprintf(msg, MESSAGE_SIZE, "%s %s error(s) on CPU %d",
> +			 str, fatal ? "fatal" : "correctable", cpu);
> +
> +		if (fatal)
> +			edac_device_handle_ue(edac_ctl, 0, 0, msg);
> +		else
> +			edac_device_handle_ce(edac_ctl, 0, 0, msg);
> +	}
> +
> +	/* l2merrsr_el1 */
> +	asm volatile("mrs %0, s3_1_c15_c2_3" : "=r" (l2merr));
> +	asm volatile("msr s3_1_c15_c2_3, %0" :: "r" (0));
> +
> +	if (l2merr & L2MERRSR_EL1_VALID) {
> +		int fatal = (l2merr & L2MERRSR_EL1_FATAL) != 0;

See above.

> +
> +		snprintf(msg, MESSAGE_SIZE, "L2 %s error(s) on CPU %d",
> +			 fatal ? "fatal" : "correctable", cpu);
> +		if (fatal)
> +			edac_device_handle_ue(edac_ctl, 0, 1, msg);
> +		else
> +			edac_device_handle_ce(edac_ctl, 0, 1, msg);
> +	}
> +}

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
