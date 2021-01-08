Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124722EF291
	for <lists+linux-edac@lfdr.de>; Fri,  8 Jan 2021 13:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbhAHMcl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 8 Jan 2021 07:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbhAHMcl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 8 Jan 2021 07:32:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A02C0612F4;
        Fri,  8 Jan 2021 04:32:00 -0800 (PST)
Received: from zn.tnic (p200300ec2f0a310099313965888db647.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:3100:9931:3965:888d:b647])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 299391EC0513;
        Fri,  8 Jan 2021 13:31:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610109118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Tu3Nlta5RSVpZXD0IzNaB9PfxGBdsgfgwf9n2ihbJ5s=;
        b=mwNt3ZDcB15d1hOhWbgNDdzHmhwWG77Rr++kNPKmRlmRWYRtKntFCoUpjblGgUnid45+r8
        4JDPtK5Whas6L59xllXlVBuz1Dmj5INXz5pfmIXKA7UaH/Pe0gIEGzHufB/48ucG7MO/zo
        0SPEoQAp5Mb0HsVaosIpH8C3S9oS4Ok=
Date:   Fri, 8 Jan 2021 13:31:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-edac@vger.kernel.org, tony.luck@intel.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        kernel-team@fb.com
Subject: Re: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Message-ID: <20210108123156.GD4042@zn.tnic>
References: <20210106174102.GA23874@paulmck-ThinkPad-P72>
 <20210106183244.GA24607@zn.tnic>
 <20210106191353.GA2743@paulmck-ThinkPad-P72>
 <20210107070724.GC14697@zn.tnic>
 <20210107170844.GM2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210107170844.GM2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 07, 2021 at 09:08:44AM -0800, Paul E. McKenney wrote:
> Some information is usually better than none.  And I bet that failing
> hardware is capable of all sorts of tricks at all sorts of levels.  ;-)

Tell me about it.

> Updated patch below.  Is this what you had in mind?

Ok, so I've massaged it into the below locally while taking another
detailed look. Made the pr_info pr_emerg and poked at the text more, as
I do. :)

Lemme know if something else needs to be adjusted, otherwise I'll queue
it.

Thx.

---
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Dec 23 17:04:19 2020 -0800

    x86/mce: Make mce_timed_out() identify holdout CPUs
    
    The
    
      "Timeout: Not all CPUs entered broadcast exception handler"
    
    message will appear from time to time given enough systems, but this
    message does not identify which CPUs failed to enter the broadcast
    exception handler. This information would be valuable if available,
    for example, in order to correlate with other hardware-oriented error
    messages.
    
    Add a cpumask of CPUs which maintains which CPUs have entered this
    handler, and print out which ones failed to enter in the event of a
    timeout.
    
     [ bp: Massage. ]
    
    Reported-by: Jonathan Lemon <bsd@fb.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Signed-off-by: Borislav Petkov <bp@suse.de>
    Tested-by: Tony Luck <tony.luck@intel.com>
    Link: https://lkml.kernel.org/r/20210106174102.GA23874@paulmck-ThinkPad-P72

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 13d3f1cbda17..6c81d0998e0a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -877,6 +877,12 @@ static atomic_t mce_executing;
  */
 static atomic_t mce_callin;
 
+/*
+ * Track which CPUs entered the MCA broadcast synchronization and which not in
+ * order to print holdouts.
+ */
+static cpumask_t mce_missing_cpus = CPU_MASK_ALL;
+
 /*
  * Check if a timeout waiting for other CPUs happened.
  */
@@ -894,8 +900,12 @@ static int mce_timed_out(u64 *t, const char *msg)
 	if (!mca_cfg.monarch_timeout)
 		goto out;
 	if ((s64)*t < SPINUNIT) {
-		if (mca_cfg.tolerant <= 1)
+		if (mca_cfg.tolerant <= 1) {
+			if (cpumask_and(&mce_missing_cpus, cpu_online_mask, &mce_missing_cpus))
+				pr_emerg("CPUs not responding to MCE broadcast (may include false positives): %*pbl\n",
+					 cpumask_pr_args(&mce_missing_cpus));
 			mce_panic(msg, NULL, NULL);
+		}
 		cpu_missing = 1;
 		return 1;
 	}
@@ -1006,6 +1016,7 @@ static int mce_start(int *no_way_out)
 	 * is updated before mce_callin.
 	 */
 	order = atomic_inc_return(&mce_callin);
+	cpumask_clear_cpu(smp_processor_id(), &mce_missing_cpus);
 
 	/*
 	 * Wait for everyone.
@@ -1114,6 +1125,7 @@ static int mce_end(int order)
 reset:
 	atomic_set(&global_nwo, 0);
 	atomic_set(&mce_callin, 0);
+	cpumask_setall(&mce_missing_cpus);
 	barrier();
 
 	/*
@@ -2712,6 +2724,7 @@ static void mce_reset(void)
 	atomic_set(&mce_executing, 0);
 	atomic_set(&mce_callin, 0);
 	atomic_set(&global_nwo, 0);
+	cpumask_setall(&mce_missing_cpus);
 }
 
 static int fake_panic_get(void *data, u64 *val)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
