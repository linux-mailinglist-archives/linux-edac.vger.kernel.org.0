Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC62E2EC33F
	for <lists+linux-edac@lfdr.de>; Wed,  6 Jan 2021 19:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbhAFSd2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Jan 2021 13:33:28 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59494 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbhAFSd2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Jan 2021 13:33:28 -0500
Received: from zn.tnic (p200300ec2f096900fa39b7692df2441c.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:6900:fa39:b769:2df2:441c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5550D1EC04EF;
        Wed,  6 Jan 2021 19:32:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609957967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ivwHOniwz5qGdYhs1Yn9GcbjBz+NdsKmDIMr40UYDcg=;
        b=CmfSIcfachhNklFKKiI/2js7DmC7mtHOkJmvcz4G2Rh3SDKEP2ATVd1AiipTBgnXc8Lism
        8kAry/NOoOFwEqrwNnE+YPN6lRqfTl1hxZG6DGP+UfX8HwxvUElb47/B6zzzTbm3bQN9WG
        rXlutzz821hNpT14cZ1WMHJO1MtIRPw=
Date:   Wed, 6 Jan 2021 19:32:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-edac@vger.kernel.org, tony.luck@intel.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        kernel-team@fb.com
Subject: Re: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Message-ID: <20210106183244.GA24607@zn.tnic>
References: <20210106174102.GA23874@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210106174102.GA23874@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 06, 2021 at 09:41:02AM -0800, Paul E. McKenney wrote:
> The "Timeout: Not all CPUs entered broadcast exception handler" message
> will appear from time to time given enough systems, but this message does
> not identify which CPUs failed to enter the broadcast exception handler.
> This information would be valuable if available, for example, in order to
> correlated with other hardware-oriented error messages.

Because you're expecting that the CPUs which have not entered the
exception handler might have stuck earlier and that's the correlation
there?

> This commit

That's a tautology. :)

> therefore maintains a cpumask_t of CPUs that have entered this handler,
> and prints out which ones failed to enter in the event of a timeout.
> Build-tested only.
> 
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: <linux-edac@vger.kernel.org>
> Reported-by: Jonathan Lemon <bsd@fb.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 13d3f1c..44d2b99 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -878,6 +878,12 @@ static atomic_t mce_executing;
>  static atomic_t mce_callin;
>  
>  /*
> + * Track which CPUs entered and not in order to print holdouts.
> + */
> +static cpumask_t mce_present_cpus;
> +static cpumask_t mce_missing_cpus;
> +
> +/*
>   * Check if a timeout waiting for other CPUs happened.
>   */
>  static int mce_timed_out(u64 *t, const char *msg)
> @@ -894,8 +900,12 @@ static int mce_timed_out(u64 *t, const char *msg)
>  	if (!mca_cfg.monarch_timeout)
>  		goto out;
>  	if ((s64)*t < SPINUNIT) {
> -		if (mca_cfg.tolerant <= 1)
> +		if (mca_cfg.tolerant <= 1) {
> +			if (!cpumask_andnot(&mce_missing_cpus, cpu_online_mask, &mce_present_cpus))
> +				pr_info("%s: MCE holdout CPUs: %*pbl\n",
> +					__func__, cpumask_pr_args(&mce_missing_cpus));
>  			mce_panic(msg, NULL, NULL);
> +		}
>  		cpu_missing = 1;
>  		return 1;
>  	}
> @@ -1006,6 +1016,7 @@ static int mce_start(int *no_way_out)
>  	 * is updated before mce_callin.
>  	 */
>  	order = atomic_inc_return(&mce_callin);

Doesn't a single mce_callin_mask suffice?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
