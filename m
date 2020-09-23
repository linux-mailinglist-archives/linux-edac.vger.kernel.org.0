Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27E1275795
	for <lists+linux-edac@lfdr.de>; Wed, 23 Sep 2020 13:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgIWL5w (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 23 Sep 2020 07:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgIWL5v (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 23 Sep 2020 07:57:51 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC90C0613CE
        for <linux-edac@vger.kernel.org>; Wed, 23 Sep 2020 04:57:51 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a2so18653425otr.11
        for <linux-edac@vger.kernel.org>; Wed, 23 Sep 2020 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=6na7YV2CNqhUw34VnwRnENA5O1rkcu25iJJvgyVQTsE=;
        b=lo5RWzJkAfeVI5JxNFMz9xRm23PXkbqlPgAVIu3Gk7N+FqahkM45ILgThcUtBmDBkx
         eU2zzHx4c0a3MInnu5/2Z+SjT0ktMaK5o69ypnbXQpzNw3ltCVvRwHM3dhwUon0wIgVq
         Zwe0ZLsH6zT84KeAO0gKxXACKn6pSd6fF+l833yts9R0ku5DNkv9oEADYsLWXbQ5G/CR
         Kjf16dRauBWC3l97Rndf6dTlRBB0QJkdw/xiW+jUF24qtGYcop743hdw4ND5Rc6y3iiU
         y0/0qF7xVmCNkOELeg+qxP3Oq+T0W06uNXFH023RYTSr8ke0TaDQoMs8Fn3/4ImaHd0w
         Fs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=6na7YV2CNqhUw34VnwRnENA5O1rkcu25iJJvgyVQTsE=;
        b=Jav/MVoGDwpweUoeJrL5GmzI5iKjAOK2K49zIqEgkv7KxHHDWV+u0jqw1JZ0rDh2J5
         j3PdkQIktgNw+wdF5Pxj1KT7J0PkA3tecKUE65mDsPOb/qzwCB/g3x16/0PTXdMnwWq0
         vJBe99dlD7/+snyNQQ1/q4lgYuPW/jP8JiwCbOmBd/guT/Gd25lrWK0aczQ4TAblYneb
         lKZoXWx6Y8y7k4CCJP3egPEQ71XqnKXHREiZE9FY++5/BKPUm2JaFBlfa5zAux+pznlH
         DvlhnGupxYot2gYdyScO255j7TL3Kr/bAnMceAv5QAr+rjecnYWiUkrloSjoyqU8podA
         g2iA==
X-Gm-Message-State: AOAM530BOv0CJyohZzTC9mMZErba3/cKw1MjImHEJi+WrsCKwbhQnwG/
        aMUWOL7AupQ13Y1pTvtj76oxim08qyTG
X-Google-Smtp-Source: ABdhPJxLYGPsZmeAd3+HOUsTpGRrSMFq5/D5v7TfwHWkkLIsAQxvB2pJoaGJjIxiky3BqufIf8xjow==
X-Received: by 2002:a9d:3b84:: with SMTP id k4mr6334549otc.4.1600862271008;
        Wed, 23 Sep 2020 04:57:51 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id b17sm9040883oog.25.2020.09.23.04.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 04:57:50 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.mvista.com (unknown [IPv6:2001:470:b8f6:1b:bda8:cea9:424f:cdc4])
        by serve.minyard.net (Postfix) with ESMTPA id D7ABA18003B;
        Wed, 23 Sep 2020 11:57:48 +0000 (UTC)
From:   minyard@acm.org
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        hidehiro.kawai.ez@hitachi.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: [PATCH] x86: Fix MCE error handing when kdump is enabled
Date:   Wed, 23 Sep 2020 06:57:42 -0500
Message-Id: <20200923115742.4634-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

If kdump is enabled, the handling of shooting down CPUs does not use the
RESET_VECTOR irq before trying to use NMIs to shoot down the CPUs.

For normal errors that is fine.  MCEs, however, interrupt all CPUs at
the same time so they are already running in an NMI, so sending them an
NMI won't do anything.  The MCE code in wait_for_panic() is set up to
receive the RESET_VECTOR because it enables irqs, but it won't work on
the NMI-only case.

There is already code in place to scan for the NMI callback being ready,
simply call that from the MCE's wait_for_panic() code so it will pick up
and handle it if an NMI shootdown is requested.  This required
propagating the registers down to wait_for_panic().

Reported-by: Wu Bo <wubo40@huawei.com>
Cc: hidehiro.kawai.ez@hitachi.com
Cc: linfeilong@huawei.com
Cc: liuzhiqiang26@huawei.com
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Wu Bo <wubo40@huawei.com>
---
Wu Bo found this doing kdumps because the IPMI driver saves panic
information to the IPMI event log during a panic.  But it was getting
interrupts at the same time because the other cores had interrupts
enabled, causing the process to take a long time.

Having interrupt enabled during a kdump shutdown and while the new kdump
kernel is running is obviously a bad thing and can cause other problems,
too.  I think this is the right fix, but I'm not an expert in this code.

Thanks,

-corey

 arch/x86/kernel/cpu/mce/core.c | 67 ++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f43a78bde670..3a842b3773b3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -282,20 +282,35 @@ static int fake_panic;
 static atomic_t mce_fake_panicked;
 
 /* Panic in progress. Enable interrupts and wait for final IPI */
-static void wait_for_panic(void)
+static void wait_for_panic(struct pt_regs *regs)
 {
 	long timeout = PANIC_TIMEOUT*USEC_PER_SEC;
 
 	preempt_disable();
 	local_irq_enable();
-	while (timeout-- > 0)
+	while (timeout-- > 0) {
+		/*
+		 * We are in an NMI waiting to be stopped by the
+		 * handing processor.  For kdump handling, we need to
+		 * be monitoring crash_ipi_issued since that is what
+		 * is used for an NMI stop used by kdump.  But we also
+		 * need to have interrupts enabled some so that
+		 * RESET_VECTOR will interrupt us on a normal
+		 * shutdown.
+		 */
+		local_irq_disable();
+		run_crash_ipi_callback(regs);
+		local_irq_enable();
+
 		udelay(1);
+	}
 	if (panic_timeout == 0)
 		panic_timeout = mca_cfg.panic_timeout;
 	panic("Panicing machine check CPU died");
 }
 
-static void mce_panic(const char *msg, struct mce *final, char *exp)
+static void mce_panic(const char *msg, struct mce *final, char *exp,
+		      struct pt_regs *regs)
 {
 	int apei_err = 0;
 	struct llist_node *pending;
@@ -306,7 +321,7 @@ static void mce_panic(const char *msg, struct mce *final, char *exp)
 		 * Make sure only one CPU runs in machine check panic
 		 */
 		if (atomic_inc_return(&mce_panicked) > 1)
-			wait_for_panic();
+			wait_for_panic(regs);
 		barrier();
 
 		bust_spinlocks(1);
@@ -817,7 +832,7 @@ static atomic_t mce_callin;
 /*
  * Check if a timeout waiting for other CPUs happened.
  */
-static int mce_timed_out(u64 *t, const char *msg)
+static int mce_timed_out(u64 *t, const char *msg, struct pt_regs *regs)
 {
 	/*
 	 * The others already did panic for some reason.
@@ -827,12 +842,12 @@ static int mce_timed_out(u64 *t, const char *msg)
 	 */
 	rmb();
 	if (atomic_read(&mce_panicked))
-		wait_for_panic();
+		wait_for_panic(regs);
 	if (!mca_cfg.monarch_timeout)
 		goto out;
 	if ((s64)*t < SPINUNIT) {
 		if (mca_cfg.tolerant <= 1)
-			mce_panic(msg, NULL, NULL);
+			mce_panic(msg, NULL, NULL, regs);
 		cpu_missing = 1;
 		return 1;
 	}
@@ -866,7 +881,7 @@ static int mce_timed_out(u64 *t, const char *msg)
  * All the spin loops have timeouts; when a timeout happens a CPU
  * typically elects itself to be Monarch.
  */
-static void mce_reign(void)
+static void mce_reign(struct pt_regs *regs)
 {
 	int cpu;
 	struct mce *m = NULL;
@@ -896,7 +911,7 @@ static void mce_reign(void)
 	 * other CPUs.
 	 */
 	if (m && global_worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3)
-		mce_panic("Fatal machine check", m, msg);
+		mce_panic("Fatal machine check", m, msg, regs);
 
 	/*
 	 * For UC somewhere we let the CPU who detects it handle it.
@@ -909,7 +924,8 @@ static void mce_reign(void)
 	 * source or one CPU is hung. Panic.
 	 */
 	if (global_worst <= MCE_KEEP_SEVERITY && mca_cfg.tolerant < 3)
-		mce_panic("Fatal machine check from unknown source", NULL, NULL);
+		mce_panic("Fatal machine check from unknown source", NULL, NULL,
+			  regs);
 
 	/*
 	 * Now clear all the mces_seen so that they don't reappear on
@@ -928,7 +944,7 @@ static atomic_t global_nwo;
  * in the entry order.
  * TBD double check parallel CPU hotunplug
  */
-static int mce_start(int *no_way_out)
+static int mce_start(int *no_way_out, struct pt_regs *regs)
 {
 	int order;
 	int cpus = num_online_cpus();
@@ -949,7 +965,8 @@ static int mce_start(int *no_way_out)
 	 */
 	while (atomic_read(&mce_callin) != cpus) {
 		if (mce_timed_out(&timeout,
-				  "Timeout: Not all CPUs entered broadcast exception handler")) {
+				  "Timeout: Not all CPUs entered broadcast exception handler",
+				  regs)) {
 			atomic_set(&global_nwo, 0);
 			return -1;
 		}
@@ -975,7 +992,8 @@ static int mce_start(int *no_way_out)
 		 */
 		while (atomic_read(&mce_executing) < order) {
 			if (mce_timed_out(&timeout,
-					  "Timeout: Subject CPUs unable to finish machine check processing")) {
+					  "Timeout: Subject CPUs unable to finish machine check processing",
+					  regs)) {
 				atomic_set(&global_nwo, 0);
 				return -1;
 			}
@@ -995,7 +1013,7 @@ static int mce_start(int *no_way_out)
  * Synchronize between CPUs after main scanning loop.
  * This invokes the bulk of the Monarch processing.
  */
-static int mce_end(int order)
+static int mce_end(int order, struct pt_regs *regs)
 {
 	int ret = -1;
 	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
@@ -1020,12 +1038,13 @@ static int mce_end(int order)
 		 */
 		while (atomic_read(&mce_executing) <= cpus) {
 			if (mce_timed_out(&timeout,
-					  "Timeout: Monarch CPU unable to finish machine check processing"))
+					  "Timeout: Monarch CPU unable to finish machine check processing",
+					  regs))
 				goto reset;
 			ndelay(SPINUNIT);
 		}
 
-		mce_reign();
+		mce_reign(regs);
 		barrier();
 		ret = 0;
 	} else {
@@ -1034,7 +1053,8 @@ static int mce_end(int order)
 		 */
 		while (atomic_read(&mce_executing) != 0) {
 			if (mce_timed_out(&timeout,
-					  "Timeout: Monarch CPU did not finish machine check processing"))
+					  "Timeout: Monarch CPU did not finish machine check processing",
+					  regs))
 				goto reset;
 			ndelay(SPINUNIT);
 		}
@@ -1286,9 +1306,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 */
 	if (lmce) {
 		if (no_way_out)
-			mce_panic("Fatal local machine check", &m, msg);
+			mce_panic("Fatal local machine check", &m, msg, regs);
 	} else {
-		order = mce_start(&no_way_out);
+		order = mce_start(&no_way_out, regs);
 	}
 
 	__mc_scan_banks(&m, final, toclear, valid_banks, no_way_out, &worst);
@@ -1301,7 +1321,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * When there's any problem use only local no_way_out state.
 	 */
 	if (!lmce) {
-		if (mce_end(order) < 0)
+		if (mce_end(order, regs) < 0)
 			no_way_out = worst >= MCE_PANIC_SEVERITY;
 	} else {
 		/*
@@ -1314,7 +1334,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 */
 		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
 			mce_severity(&m, cfg->tolerant, &msg, true);
-			mce_panic("Local fatal machine check!", &m, msg);
+			mce_panic("Local fatal machine check!", &m, msg, regs);
 		}
 	}
 
@@ -1325,7 +1345,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	if (cfg->tolerant == 3)
 		kill_it = 0;
 	else if (no_way_out)
-		mce_panic("Fatal machine check on current CPU", &m, msg);
+		mce_panic("Fatal machine check on current CPU", &m, msg, regs);
 
 	if (worst > 0)
 		irq_work_queue(&mce_irq_work);
@@ -1361,7 +1381,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 */
 		if (m.kflags & MCE_IN_KERNEL_RECOV) {
 			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
-				mce_panic("Failed kernel mode recovery", &m, msg);
+				mce_panic("Failed kernel mode recovery", &m,
+					  msg, regs);
 		}
 	}
 }
-- 
2.17.1

