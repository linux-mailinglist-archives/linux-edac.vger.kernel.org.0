Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EE72EC6D5
	for <lists+linux-edac@lfdr.de>; Thu,  7 Jan 2021 00:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbhAFXY3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Jan 2021 18:24:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbhAFXY2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Jan 2021 18:24:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C21C1221E9;
        Wed,  6 Jan 2021 23:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609975427;
        bh=MERlIdmrTF2M3Hb0DfEBDa8K4WZo4eLCln5OIHOz/BM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=o6ia6j5HHNl4QvLnuZIwEBrQL8O/Ef6tOBMugXYHsK6e/qPQCh4x/cvZnH2lrE6yr
         r0RJEHfV7Rrmfs6/ck6Ae6hvMFdahWyTKbY8lBN+zh2SJrOkt2RF83JPUgvqEC5aXM
         tllpNjGeoozq6tcvOjiEO+ule3pL/GWrxfp8hpSCBxMSo1fWE1LaRYRXqClbse59r4
         +rrJloMKyA7UFiZU4C8kS4Jjq3U1OOT57n4315HEPQaBWT+mBm+iHRWPydLU1PiG15
         kwB/yvHufku1q8bvkYxeqw+IyFIxWhnNlWDTS681LjsQrSBKGZ0hJrIrRp5iOBeOLk
         GscEBJ3QrNv0w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 814D035225DC; Wed,  6 Jan 2021 15:23:47 -0800 (PST)
Date:   Wed, 6 Jan 2021 15:23:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Message-ID: <20210106232347.GG2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106174102.GA23874@paulmck-ThinkPad-P72>
 <3513b04e2bb543d2871ca8c152dcf5ae@intel.com>
 <20210106191708.GB2743@paulmck-ThinkPad-P72>
 <20210106224918.GA7914@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106224918.GA7914@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 06, 2021 at 02:49:18PM -0800, Luck, Tony wrote:
> On Wed, Jan 06, 2021 at 11:17:08AM -0800, Paul E. McKenney wrote:
> > On Wed, Jan 06, 2021 at 06:39:30PM +0000, Luck, Tony wrote:
> > > > The "Timeout: Not all CPUs entered broadcast exception handler" message
> > > > will appear from time to time given enough systems, but this message does
> > > > not identify which CPUs failed to enter the broadcast exception handler.
> > > > This information would be valuable if available, for example, in order to
> > > > correlated with other hardware-oriented error messages.  This commit
> > > > therefore maintains a cpumask_t of CPUs that have entered this handler,
> > > > and prints out which ones failed to enter in the event of a timeout.
> > > 
> > > I tried doing this a while back, but found that in my test case where I forced
> > > an error that would cause both threads from one core to be "missing", the
> > > output was highly unpredictable. Some random number of extra CPUs were
> > > reported as missing. After I added some extra breadcrumbs it became clear
> > > that pretty much all the CPUs (except the missing pair) entered do_machine_check(),
> > > but some got hung up at various points beyond the entry point. My only theory
> > > was that they were trying to snoop caches from the dead core (or access some
> > > other resource held by the dead core) and so they hung too.
> > > 
> > > Your code is much neater than mine ... and perhaps works in other cases, but
> > > maybe the message needs to allow for the fact that some of the cores that
> > > are reported missing may just be collateral damage from the initial problem.
> > 
> > Understood.  The system is probably not in the best shape if this code
> > is ever executed, after all.  ;-)
> > 
> > So how about like this?
> > 
> > 	pr_info("%s: MCE holdout CPUs (may include false positives): %*pbl\n",
> 
> That looks fine.
> > 
> > Easy enough if so!
> > 
> > > If I get time in the next day or two, I'll run my old test against your code to
> > > see what happens.
> 
> I got time today (plenty of meetings in which to run experiments in background).

Thank you very much!

> This code:
> 
> -               if (mca_cfg.tolerant <= 1)
> +               if (mca_cfg.tolerant <= 1) {
> +                       if (!cpumask_andnot(&mce_missing_cpus, cpu_online_mask, &mce_present_cpus))
> +                               pr_info("%s: MCE holdout CPUs: %*pbl\n",
> +                                       __func__, cpumask_pr_args(&mce_missing_cpus));
>                         mce_panic(msg, NULL, NULL);
> 
> didn't trigger ... so maybe that cpumask_andnot() didn't return the value you expected?
> 
> I added a:
> 
> +                       pr_info("%s: MCE present CPUs: %*pbl\n", __func__, cpumask_pr_args(&mce_present_cpus));
> 
> to check that the mask was being set correctly, and saw:
> 
> [  219.329767] mce: mce_timed_out: MCE present CPUs: 0-23,48-119,144-191
> 
> So the every core of socket 1 failed to show up for this test.

I'll say that cpumask_andnot() didn't return the value I expected!
Mostly because idiot here somehow interpreted "If *@dstp is empty,
returns 0, else returns 1" as "Returns true if *dstp is empty".  So the
check is backwards.

Please see below for an updated patch.

> > For my own testing, is this still the right thing to use?
> > 
> > 	https://github.com/andikleen/mce-inject
> 
> That fakes up errors (by hooking into the mce_rdmsr() code to return arbitrary
> user supplied values).  The plus side of this is that you can fake any error
> signature without needing special h/w or f/w. The downside is that it is all fake
> and you can't create situations where some CPUs don't show up in the machine
> check handler.

So I would need to modify the code to test the code.  I have done worse
things, I suppose.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

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
[ paulmck: Fix cpumask_andnot() check + message per Tony Luck feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 13d3f1c..7a6e1f3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -878,6 +878,12 @@ static atomic_t mce_executing;
 static atomic_t mce_callin;
 
 /*
+ * Track which CPUs entered and not in order to print holdouts.
+ */
+static cpumask_t mce_present_cpus;
+static cpumask_t mce_missing_cpus;
+
+/*
  * Check if a timeout waiting for other CPUs happened.
  */
 static int mce_timed_out(u64 *t, const char *msg)
@@ -894,8 +900,12 @@ static int mce_timed_out(u64 *t, const char *msg)
 	if (!mca_cfg.monarch_timeout)
 		goto out;
 	if ((s64)*t < SPINUNIT) {
-		if (mca_cfg.tolerant <= 1)
+		if (mca_cfg.tolerant <= 1) {
+			if (cpumask_andnot(&mce_missing_cpus, cpu_online_mask, &mce_present_cpus))
+				pr_info("%s: MCE holdout CPUs (may include false positives): %*pbl\n",
+					__func__, cpumask_pr_args(&mce_missing_cpus));
 			mce_panic(msg, NULL, NULL);
+		}
 		cpu_missing = 1;
 		return 1;
 	}
@@ -1006,6 +1016,7 @@ static int mce_start(int *no_way_out)
 	 * is updated before mce_callin.
 	 */
 	order = atomic_inc_return(&mce_callin);
+	cpumask_set_cpu(smp_processor_id(), &mce_present_cpus);
 
 	/*
 	 * Wait for everyone.
@@ -1114,6 +1125,7 @@ static int mce_end(int order)
 reset:
 	atomic_set(&global_nwo, 0);
 	atomic_set(&mce_callin, 0);
+	cpumask_clear(&mce_present_cpus);
 	barrier();
 
 	/*
@@ -2712,6 +2724,7 @@ static void mce_reset(void)
 	atomic_set(&mce_executing, 0);
 	atomic_set(&mce_callin, 0);
 	atomic_set(&global_nwo, 0);
+	cpumask_clear(&mce_present_cpus);
 }
 
 static int fake_panic_get(void *data, u64 *val)
