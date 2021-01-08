Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CC72EF444
	for <lists+linux-edac@lfdr.de>; Fri,  8 Jan 2021 15:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbhAHOzz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 8 Jan 2021 09:55:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbhAHOzz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 8 Jan 2021 09:55:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66A9F2388B;
        Fri,  8 Jan 2021 14:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610117714;
        bh=KXyZUJgp4S/FkZX12/a7VseM4D/rbIALeIzXvFoAeKQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KHvTQDzTYJA6Un3GYPoyLFBis/3D66He4P4k9a2thvmNiGqblKgqsGnl8vu4A6LqL
         S3seVY8WEscIhRgwXxK/BJfAzx9/1hEH2euFIzo8L0jHmGgwWfm39uPNmtZ4C/0yrz
         rgPm0N4vcJ4s7mLlp4WQNP7YqPba0ZKCKvGxTYG8/xmw+Do6MUbsmhWRTIFSCO/DBo
         z8xRhQMXtStV74D2VjDVelROvxDZGVX9myhayqOTGlDI+MLebPiNw26/7c5d6Pj61I
         Ro6j8lSFKG0Z4MmBzyNX6f+HSt1ut3B+w98xUXV4oZ3Sh4/mXgkv6sz4hYXnj0bO/A
         uDHZhWgctSbVA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1B63D3522B7D; Fri,  8 Jan 2021 06:55:14 -0800 (PST)
Date:   Fri, 8 Jan 2021 06:55:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-edac@vger.kernel.org, tony.luck@intel.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        kernel-team@fb.com
Subject: Re: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Message-ID: <20210108145514.GS2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106174102.GA23874@paulmck-ThinkPad-P72>
 <20210106183244.GA24607@zn.tnic>
 <20210106191353.GA2743@paulmck-ThinkPad-P72>
 <20210107070724.GC14697@zn.tnic>
 <20210107170844.GM2743@paulmck-ThinkPad-P72>
 <20210108123156.GD4042@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108123156.GD4042@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 08, 2021 at 01:31:56PM +0100, Borislav Petkov wrote:
> On Thu, Jan 07, 2021 at 09:08:44AM -0800, Paul E. McKenney wrote:
> > Some information is usually better than none.  And I bet that failing
> > hardware is capable of all sorts of tricks at all sorts of levels.  ;-)
> 
> Tell me about it.
> 
> > Updated patch below.  Is this what you had in mind?
> 
> Ok, so I've massaged it into the below locally while taking another
> detailed look. Made the pr_info pr_emerg and poked at the text more, as
> I do. :)
> 
> Lemme know if something else needs to be adjusted, otherwise I'll queue
> it.

Looks good to me!  I agree that your change to the pr_emerg() string is
much better than my original.  And good point on your added comment,
plus it was fun to see that my original "holdouts" wording has not
completely vanished.  ;-)

Thank you very much!!!

							Thanx, Paul

> Thx.
> 
> ---
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Wed Dec 23 17:04:19 2020 -0800
> 
>     x86/mce: Make mce_timed_out() identify holdout CPUs
>     
>     The
>     
>       "Timeout: Not all CPUs entered broadcast exception handler"
>     
>     message will appear from time to time given enough systems, but this
>     message does not identify which CPUs failed to enter the broadcast
>     exception handler. This information would be valuable if available,
>     for example, in order to correlate with other hardware-oriented error
>     messages.
>     
>     Add a cpumask of CPUs which maintains which CPUs have entered this
>     handler, and print out which ones failed to enter in the event of a
>     timeout.
>     
>      [ bp: Massage. ]
>     
>     Reported-by: Jonathan Lemon <bsd@fb.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>     Signed-off-by: Borislav Petkov <bp@suse.de>
>     Tested-by: Tony Luck <tony.luck@intel.com>
>     Link: https://lkml.kernel.org/r/20210106174102.GA23874@paulmck-ThinkPad-P72
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 13d3f1cbda17..6c81d0998e0a 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -877,6 +877,12 @@ static atomic_t mce_executing;
>   */
>  static atomic_t mce_callin;
>  
> +/*
> + * Track which CPUs entered the MCA broadcast synchronization and which not in
> + * order to print holdouts.
> + */
> +static cpumask_t mce_missing_cpus = CPU_MASK_ALL;
> +
>  /*
>   * Check if a timeout waiting for other CPUs happened.
>   */
> @@ -894,8 +900,12 @@ static int mce_timed_out(u64 *t, const char *msg)
>  	if (!mca_cfg.monarch_timeout)
>  		goto out;
>  	if ((s64)*t < SPINUNIT) {
> -		if (mca_cfg.tolerant <= 1)
> +		if (mca_cfg.tolerant <= 1) {
> +			if (cpumask_and(&mce_missing_cpus, cpu_online_mask, &mce_missing_cpus))
> +				pr_emerg("CPUs not responding to MCE broadcast (may include false positives): %*pbl\n",
> +					 cpumask_pr_args(&mce_missing_cpus));
>  			mce_panic(msg, NULL, NULL);
> +		}
>  		cpu_missing = 1;
>  		return 1;
>  	}
> @@ -1006,6 +1016,7 @@ static int mce_start(int *no_way_out)
>  	 * is updated before mce_callin.
>  	 */
>  	order = atomic_inc_return(&mce_callin);
> +	cpumask_clear_cpu(smp_processor_id(), &mce_missing_cpus);
>  
>  	/*
>  	 * Wait for everyone.
> @@ -1114,6 +1125,7 @@ static int mce_end(int order)
>  reset:
>  	atomic_set(&global_nwo, 0);
>  	atomic_set(&mce_callin, 0);
> +	cpumask_setall(&mce_missing_cpus);
>  	barrier();
>  
>  	/*
> @@ -2712,6 +2724,7 @@ static void mce_reset(void)
>  	atomic_set(&mce_executing, 0);
>  	atomic_set(&mce_callin, 0);
>  	atomic_set(&global_nwo, 0);
> +	cpumask_setall(&mce_missing_cpus);
>  }
>  
>  static int fake_panic_get(void *data, u64 *val)
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
