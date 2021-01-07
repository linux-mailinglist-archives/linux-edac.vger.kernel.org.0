Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CFD2ED52D
	for <lists+linux-edac@lfdr.de>; Thu,  7 Jan 2021 18:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbhAGRJ0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Jan 2021 12:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:51480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbhAGRJ0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Jan 2021 12:09:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 699C82311E;
        Thu,  7 Jan 2021 17:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610039325;
        bh=Ae684cwuNq4RhuSrLBrd+ncse0Ixp9T3bL2Vjgf29ZI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=q1gw86e5uP5mDfhVt4VLEtHbj2aYhmDotxc5eelA0dEl8qUpUEP8TCeMkKwK2i8Dt
         kdd+0h9GGMVA5PF3Zx1zHM0DcjBRMjism06a76fkySNywMfdOTYhIPXLR6qgoXTsL+
         rc99VWFkwJezzeK+soRZj/Ve9zb/AmvUkwVhZ3zHtxS6amEYO1jhUlNqr8KwxT8WAQ
         jBU/kVoLXZI9CL3eQF4MG7/PT6wyA2pAgudcOuJPdbEi9Mw3kEzCUeanJ22HNGNwIL
         H7BS+vnED4OB/rkfKBpPwiMmojBm0SLDPR0a51GyxSvWANBgR8qm108DyKeTSno2h0
         Nt0JomXs0ds4g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F0A43352271C; Thu,  7 Jan 2021 09:08:44 -0800 (PST)
Date:   Thu, 7 Jan 2021 09:08:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-edac@vger.kernel.org, tony.luck@intel.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        kernel-team@fb.com
Subject: Re: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Message-ID: <20210107170844.GM2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106174102.GA23874@paulmck-ThinkPad-P72>
 <20210106183244.GA24607@zn.tnic>
 <20210106191353.GA2743@paulmck-ThinkPad-P72>
 <20210107070724.GC14697@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107070724.GC14697@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 07, 2021 at 08:07:24AM +0100, Borislav Petkov wrote:
> On Wed, Jan 06, 2021 at 11:13:53AM -0800, Paul E. McKenney wrote:
> > Not yet, it isn't!  Well, except in -rcu.  ;-)
> 
> Of course it is - saying "This commit" in this commit's commit message
> is very much a tautology. :-)

Tautology?  Maybe self-referential?  ;-)

> > You are suggesting dropping mce_missing_cpus and just doing this?
> > 
> > if (!cpumask_andnot(&mce_present_cpus, cpu_online_mask, &mce_present_cpus))
> 
> Yes.

I could drop mce_present_cpus, and then initialize mce_missing_cpus
to CPU_MASK_ALL, and have each CPU clear its bit on entry using
cpumask_clear_cpu().  Then cpumask_and() it with cpu_online_mask and
print it out.  That allows late-arriving CPUs to be properly accounted
for, most of the time, anyway.

> And pls don't call it "holdout CPUs"

How about "missing CPUs"?  That is what I used in the meantime, please
see below.  If you have something you would prefer that it be called,
please let me know.

>                                      and change the order so that it is
> more user-friendly (yap, you don't need __func__ either):
> 
> [   78.946153] mce: Not all CPUs (24-47,120-143) entered the broadcast exception handler.
> [   78.946153] Kernel panic - not syncing: Timeout: MCA synchronization.
> 
> or so.

I removed __func__, but the pr_info() already precedes the mce_panic().
Do I need a udelay() after the pr_info() or some such?  If so, how long
should is spin?

> And that's fine if it appears twice as long as it is the same info - the
> MCA code is one complex mess so you can probably guess why I'd like to
> have new stuff added to it be as simplistic as possible.

Works for me.  ;-)

> > I was worried (perhaps unnecessarily) about the possibility of CPUs
> > checking in during the printout operation, which would set rather than
> > clear the bit.  But perhaps the possible false positives that Tony points
> > out make this race not worth worrying about.
> > 
> > Thoughts?
> 
> Yah, apparently, it is not going to be a precise report as you wanted it
> to be but at least it'll tell you which *sockets* you can rule out, if
> not cores.
> 
> :-)

Some information is usually better than none.  And I bet that failing
hardware is capable of all sorts of tricks at all sorts of levels.  ;-)

Updated patch below.  Is this what you had in mind?

							Thanx, Paul

------------------------------------------------------------------------

commit 4b4b57692fdd3b111098eda94df7529f85c54406
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Dec 23 17:04:19 2020 -0800

    x86/mce: Make mce_timed_out() identify holdout CPUs
    
    The "Timeout: Not all CPUs entered broadcast exception handler" message
    will appear from time to time given enough systems, but this message does
    not identify which CPUs failed to enter the broadcast exception handler.
    This information would be valuable if available, for example, in order to
    correlated with other hardware-oriented error messages.  This commit
    therefore maintains a cpumask_t of CPUs that have entered this handler,
    and prints out which ones failed to enter in the event of a timeout.
    
    Cc: Tony Luck <tony.luck@intel.com>
    Cc: Borislav Petkov <bp@alien8.de>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: "H. Peter Anvin" <hpa@zytor.com>
    Cc: <x86@kernel.org>
    Cc: <linux-edac@vger.kernel.org>
    [ paulmck: Fix cpumask_andnot() check per Tony Luck testing and feedback. ]
    [ paulmck: Apply Borislav Petkov feedback. ]
    Reported-by: Jonathan Lemon <bsd@fb.com>
    Tested-by: Tony Luck <tony.luck@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 13d3f1c..c83331b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -878,6 +878,11 @@ static atomic_t mce_executing;
 static atomic_t mce_callin;
 
 /*
+ * Track which CPUs entered and not in order to print holdouts.
+ */
+static cpumask_t mce_missing_cpus = CPU_MASK_ALL;
+
+/*
  * Check if a timeout waiting for other CPUs happened.
  */
 static int mce_timed_out(u64 *t, const char *msg)
@@ -894,8 +899,12 @@ static int mce_timed_out(u64 *t, const char *msg)
 	if (!mca_cfg.monarch_timeout)
 		goto out;
 	if ((s64)*t < SPINUNIT) {
-		if (mca_cfg.tolerant <= 1)
+		if (mca_cfg.tolerant <= 1) {
+			if (cpumask_and(&mce_missing_cpus, cpu_online_mask, &mce_missing_cpus))
+				pr_info("MCE missing CPUs (may include false positives): %*pbl\n",
+					cpumask_pr_args(&mce_missing_cpus));
 			mce_panic(msg, NULL, NULL);
+		}
 		cpu_missing = 1;
 		return 1;
 	}
@@ -1006,6 +1015,7 @@ static int mce_start(int *no_way_out)
 	 * is updated before mce_callin.
 	 */
 	order = atomic_inc_return(&mce_callin);
+	cpumask_clear_cpu(smp_processor_id(), &mce_missing_cpus);
 
 	/*
 	 * Wait for everyone.
@@ -1114,6 +1124,7 @@ static int mce_end(int order)
 reset:
 	atomic_set(&global_nwo, 0);
 	atomic_set(&mce_callin, 0);
+	cpumask_setall(&mce_missing_cpus);
 	barrier();
 
 	/*
@@ -2712,6 +2723,7 @@ static void mce_reset(void)
 	atomic_set(&mce_executing, 0);
 	atomic_set(&mce_callin, 0);
 	atomic_set(&global_nwo, 0);
+	cpumask_setall(&mce_missing_cpus);
 }
 
 static int fake_panic_get(void *data, u64 *val)
