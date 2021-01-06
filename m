Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35012EC28D
	for <lists+linux-edac@lfdr.de>; Wed,  6 Jan 2021 18:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbhAFRlo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Jan 2021 12:41:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbhAFRln (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Jan 2021 12:41:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 743C220657;
        Wed,  6 Jan 2021 17:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954862;
        bh=5mBzpcki8s13JoLZB9q1DzsiGE9pAlVtbJL3csiyLlk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=RZix4m1or5LxS71QbCslkQcSrXjcL3Aefbty6iy5F4p8HTvEtVVJV32XQmhMnkUks
         BUrZt8Nxm6NHbaACmAPMvrv3aqvJg0cKocZHU8pOY2963YgIeuJ4Gi6j2BqYa+0HBW
         gQAT0zCIqLprqSSou0XCbyFkCSn5dl+8LXaheEu5PGu4Hqmc9Cjf4lenDmrHSRMOPG
         Ls7zLd75bt+bLEc5oj8sgYCMVZrszlx2SBu0SQQPlWi8VLrXiEbZAsth2aeaifYsU5
         9lLJz3dQRfTXUmpos02buSM8cAnQfsnHY2NNd2lkobGJlm9kBfVagF4SMVjbYWYx87
         n6WE8wn1oA+sQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3C0FA35225EC; Wed,  6 Jan 2021 09:41:02 -0800 (PST)
Date:   Wed, 6 Jan 2021 09:41:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-edac@vger.kernel.org
Cc:     tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, kernel-team@fb.com
Subject: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Message-ID: <20210106174102.GA23874@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The "Timeout: Not all CPUs entered broadcast exception handler" message
will appear from time to time given enough systems, but this message does
not identify which CPUs failed to enter the broadcast exception handler.
This information would be valuable if available, for example, in order to
correlated with other hardware-oriented error messages.  This commit
therefore maintains a cpumask_t of CPUs that have entered this handler,
and prints out which ones failed to enter in the event of a timeout.

Build-tested only.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: <linux-edac@vger.kernel.org>
Reported-by: Jonathan Lemon <bsd@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 13d3f1c..44d2b99 100644
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
+			if (!cpumask_andnot(&mce_missing_cpus, cpu_online_mask, &mce_present_cpus))
+				pr_info("%s: MCE holdout CPUs: %*pbl\n",
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
