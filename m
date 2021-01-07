Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044C42EC763
	for <lists+linux-edac@lfdr.de>; Thu,  7 Jan 2021 01:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbhAGAma (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Jan 2021 19:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:57014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbhAGAm3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Jan 2021 19:42:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3452D230FE;
        Thu,  7 Jan 2021 00:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609980109;
        bh=jNo9PcDXkeFNFA14h4Cp0ur5/ltuGI30OyysC0hEDA4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iRtsT/dr9eo+NdEV/TzX9U4w8966UorirhMo/pweAkSAJIgZyM3EwiHWlcu7xgku6
         1v09Bxh/6LE14n4bvL4S00QDh/OmVHX102Hrt8JuNJvnxZJziTma3RZdgkEFWWKFOY
         3iDcFSzmxuBALFIPQ2VPvuFQ4t1tj3k3668lGchVno2I5ZFQYNeysoJWHM/oDguIn2
         DC8wemuui9SQJWs6caK5OAs7pODCskrANrFUt5cFmyvlcRmFQGpbVETBhfxOuK2gEx
         lPIMDajQQR9/2flat1bWM2piovAutS3UYgbHnridc+tYLGIJ+9JQmJR5Vqua5JHjPi
         gTlQ4NVkH1p9A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D92FE35225DC; Wed,  6 Jan 2021 16:41:48 -0800 (PST)
Date:   Wed, 6 Jan 2021 16:41:48 -0800
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
Message-ID: <20210107004148.GJ2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106174102.GA23874@paulmck-ThinkPad-P72>
 <3513b04e2bb543d2871ca8c152dcf5ae@intel.com>
 <20210106191708.GB2743@paulmck-ThinkPad-P72>
 <20210106224918.GA7914@agluck-desk2.amr.corp.intel.com>
 <20210106232347.GG2743@paulmck-ThinkPad-P72>
 <366fc78e7b8c4474958b289eec31ed25@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <366fc78e7b8c4474958b289eec31ed25@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 07, 2021 at 12:26:19AM +0000, Luck, Tony wrote:
> > Please see below for an updated patch.
> 
> Yes. That worked:
> 
> [   78.946069] mce: mce_timed_out: MCE holdout CPUs (may include false positives): 24-47,120-143
> [   78.946151] mce: mce_timed_out: MCE holdout CPUs (may include false positives): 24-47,120-143
> [   78.946153] Kernel panic - not syncing: Timeout: Not all CPUs entered broadcast exception handler
> 
> I guess that more than one CPU hit the timeout and so your new message was printed twice
> before the panic code took over?

Could well be.

It would be easy to add a flag that allowed only one CPU to print the
message.  Does that make sense?  (See off-the-cuff probably-broken
delta patch below for one approach.)

> Once again, the whole of socket 1 is MIA rather than just the pair of threads on one of the cores there.
> But that's a useful improvement (eliminating the other three sockets on this system).
> 
> Tested-by: Tony Luck <tony.luck@intel.com>

Thank you very much!  I will apply this.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7a6e1f3..b46ac56 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -882,6 +882,7 @@ static atomic_t mce_callin;
  */
 static cpumask_t mce_present_cpus;
 static cpumask_t mce_missing_cpus;
+static atomic_t mce_missing_cpus_gate;
 
 /*
  * Check if a timeout waiting for other CPUs happened.
@@ -900,7 +901,7 @@ static int mce_timed_out(u64 *t, const char *msg)
 	if (!mca_cfg.monarch_timeout)
 		goto out;
 	if ((s64)*t < SPINUNIT) {
-		if (mca_cfg.tolerant <= 1) {
+		if (mca_cfg.tolerant <= 1 && !atomic_xchg(&mce_missing_cpus_gate, 1)) {
 			if (cpumask_andnot(&mce_missing_cpus, cpu_online_mask, &mce_present_cpus))
 				pr_info("%s: MCE holdout CPUs (may include false positives): %*pbl\n",
 					__func__, cpumask_pr_args(&mce_missing_cpus));
@@ -1017,6 +1018,7 @@ static int mce_start(int *no_way_out)
 	 */
 	order = atomic_inc_return(&mce_callin);
 	cpumask_set_cpu(smp_processor_id(), &mce_present_cpus);
+	atomic_set(&mce_missing_cpus_gate, 0);
 
 	/*
 	 * Wait for everyone.
@@ -1126,6 +1128,7 @@ static int mce_end(int order)
 	atomic_set(&global_nwo, 0);
 	atomic_set(&mce_callin, 0);
 	cpumask_clear(&mce_present_cpus);
+	atomic_set(&mce_missing_cpus_gate, 0);
 	barrier();
 
 	/*
@@ -2725,6 +2728,7 @@ static void mce_reset(void)
 	atomic_set(&mce_callin, 0);
 	atomic_set(&global_nwo, 0);
 	cpumask_clear(&mce_present_cpus);
+	atomic_set(&mce_missing_cpus_gate, 0);
 }
 
 static int fake_panic_get(void *data, u64 *val)
