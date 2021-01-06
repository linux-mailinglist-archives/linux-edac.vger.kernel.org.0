Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7E32EC3BE
	for <lists+linux-edac@lfdr.de>; Wed,  6 Jan 2021 20:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbhAFTOf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Jan 2021 14:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbhAFTOf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Jan 2021 14:14:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EE0123123;
        Wed,  6 Jan 2021 19:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609960434;
        bh=jBkY8hzGgEcmtW1Rvt9yrsCWvFU24pLGzn5CXQyoAbM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cvn9UGR7uhdIaamPoKeKE3NJUJXCqv8ieiFj/DhrW5f4xBVv3hKOrZKRQYEKQ/Nop
         zUxUDob9+sq80L3DBOZHOsMT44c9Ha/74TuxIFwf2tMbiEP4xt5VgIjIDlM7VOGJGJ
         gTTZGGluuXlfy4+NTZvWvY1IbrB0fdYysyOGcARlL2wymQPUckh2Nb2QVjHe4ML5JE
         oo4CIyI8jYjgqYwqkgsbw+MltE5MiikbIvi38m4hJ34Ix80eyM71BK1aFzINc7evqh
         F/GBAcsJl3AD0jFftip3fzD4yzcgJO2D16SrCpTmfiJIbMyuhkQkvQXiI3ztUbzxbE
         9970pHu2alR0A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CC18835225DC; Wed,  6 Jan 2021 11:13:53 -0800 (PST)
Date:   Wed, 6 Jan 2021 11:13:53 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-edac@vger.kernel.org, tony.luck@intel.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        kernel-team@fb.com
Subject: Re: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Message-ID: <20210106191353.GA2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106174102.GA23874@paulmck-ThinkPad-P72>
 <20210106183244.GA24607@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106183244.GA24607@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 06, 2021 at 07:32:44PM +0100, Borislav Petkov wrote:
> On Wed, Jan 06, 2021 at 09:41:02AM -0800, Paul E. McKenney wrote:
> > The "Timeout: Not all CPUs entered broadcast exception handler" message
> > will appear from time to time given enough systems, but this message does
> > not identify which CPUs failed to enter the broadcast exception handler.
> > This information would be valuable if available, for example, in order to
> > correlated with other hardware-oriented error messages.
> 
> Because you're expecting that the CPUs which have not entered the
> exception handler might have stuck earlier and that's the correlation
> there?

Or that there might have been any number of other error messages that
flagged that CPU.  For a few examples, watchdogs, hung tasks, and RCU
CPU stall warnings.

> > This commit
> 
> That's a tautology. :)

Not yet, it isn't!  Well, except in -rcu.  ;-)

> > therefore maintains a cpumask_t of CPUs that have entered this handler,
> > and prints out which ones failed to enter in the event of a timeout.
> > Build-tested only.
> > 
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: <x86@kernel.org>
> > Cc: <linux-edac@vger.kernel.org>
> > Reported-by: Jonathan Lemon <bsd@fb.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> > index 13d3f1c..44d2b99 100644
> > --- a/arch/x86/kernel/cpu/mce/core.c
> > +++ b/arch/x86/kernel/cpu/mce/core.c
> > @@ -878,6 +878,12 @@ static atomic_t mce_executing;
> >  static atomic_t mce_callin;
> >  
> >  /*
> > + * Track which CPUs entered and not in order to print holdouts.
> > + */
> > +static cpumask_t mce_present_cpus;
> > +static cpumask_t mce_missing_cpus;
> > +
> > +/*
> >   * Check if a timeout waiting for other CPUs happened.
> >   */
> >  static int mce_timed_out(u64 *t, const char *msg)
> > @@ -894,8 +900,12 @@ static int mce_timed_out(u64 *t, const char *msg)
> >  	if (!mca_cfg.monarch_timeout)
> >  		goto out;
> >  	if ((s64)*t < SPINUNIT) {
> > -		if (mca_cfg.tolerant <= 1)
> > +		if (mca_cfg.tolerant <= 1) {
> > +			if (!cpumask_andnot(&mce_missing_cpus, cpu_online_mask, &mce_present_cpus))
> > +				pr_info("%s: MCE holdout CPUs: %*pbl\n",
> > +					__func__, cpumask_pr_args(&mce_missing_cpus));
> >  			mce_panic(msg, NULL, NULL);
> > +		}
> >  		cpu_missing = 1;
> >  		return 1;
> >  	}
> > @@ -1006,6 +1016,7 @@ static int mce_start(int *no_way_out)
> >  	 * is updated before mce_callin.
> >  	 */
> >  	order = atomic_inc_return(&mce_callin);
> 
> Doesn't a single mce_callin_mask suffice?

You are suggesting dropping mce_missing_cpus and just doing this?

if (!cpumask_andnot(&mce_present_cpus, cpu_online_mask, &mce_present_cpus))

I was worried (perhaps unnecessarily) about the possibility of CPUs
checking in during the printout operation, which would set rather than
clear the bit.  But perhaps the possible false positives that Tony points
out make this race not worth worrying about.

Thoughts?

							Thanx, Paul
