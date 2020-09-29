Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323F127D9CE
	for <lists+linux-edac@lfdr.de>; Tue, 29 Sep 2020 23:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgI2VQv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 29 Sep 2020 17:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgI2VQv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 29 Sep 2020 17:16:51 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5FBC061755
        for <linux-edac@vger.kernel.org>; Tue, 29 Sep 2020 14:16:51 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x14so7089445oic.9
        for <linux-edac@vger.kernel.org>; Tue, 29 Sep 2020 14:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=DMcTkNl9pK2JK+4wKA6YYPpUFpron4tRg5J306e3r6I=;
        b=g3ruM82AgcxaD0NucRV/jZ/VfNNUvEIjecCfOg/qxndoO3mKjAceaNJxD8F289YlMH
         CJ0+RnmBRTCX21dD1t08GAvB+pI2JSEVgpjk5nL5nRJSbo6AwfzBLTMyDPGdHikBCCme
         E5VljqOYqgopYsU8VIxCvgyoA1WxPkbu1BfXK6UbfA0O86QZkQrLjNub1GnwoPMKmd1t
         RuPZ8rIMOIrkcbEsQrUG6roxisdr8kp47/dFNkd4mNK3ussDM5BX2bLdrNG5DZoH/MVv
         4EiMlqmsA+h/H6hDi977n4m4XVUSZmSDAnZiP/phOMD9gtCIkUmPzK04U4XguQP0L25U
         J1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=DMcTkNl9pK2JK+4wKA6YYPpUFpron4tRg5J306e3r6I=;
        b=HCYJ/OFAtntFs9ha/thSPsuc1QDFa/TTLWCSrmaV8YeHUDi+4jOX0tY5eHNf78l8lA
         uzphe8I5TbJeThJcARDOGvL+1qbIltfL9mteBoKKNo2OXVva6GcJf1YYGZ0/jBYE3eFB
         zGEnz+Iq3OYMcYnMhk8IcLrbgn3/C/a6NeHjX/EXD/Fqq8JxUG4eRdzo/u5HrLPn9vna
         Py8jVvn1Nfa4Yw95ZxwObzh2fwkJQmo996SGTonzBl4sOM942N2l2d7VyQugYUXjtA3V
         T0kDK6VPXhnhXnECsKdeDdF2q157g9/MD80rDb6PCKDBNdhfDVQIPIHvu0+HvoYlvUzi
         BWCQ==
X-Gm-Message-State: AOAM5305e3f30w7BeyBDKYATe+dLZmmVflQv896R5Pzth7g5ZwSbgdW6
        lnI/UJfodG8stUa2nQgHAQ==
X-Google-Smtp-Source: ABdhPJzQTTTjoG2Ed37VVbQybQqhb4ge81mJft/98aauaO/jV+I6RyPo6PEwzRlqn9fCau15sIza5Q==
X-Received: by 2002:a54:488c:: with SMTP id r12mr3907139oic.60.1601414210850;
        Tue, 29 Sep 2020 14:16:50 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id z20sm3227803oor.3.2020.09.29.14.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 14:16:49 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:ad7b:1513:3f4c:af82])
        by serve.minyard.net (Postfix) with ESMTPA id D229218003E;
        Tue, 29 Sep 2020 21:16:48 +0000 (UTC)
From:   minyard@acm.org
To:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        hidehiro.kawai.ez@hitachi.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: [PATCH v2] x86: Fix MCE error handing when kdump is enabled
Date:   Tue, 29 Sep 2020 16:16:44 -0500
Message-Id: <20200929211644.31632-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

If kdump is enabled, the handling of shooting down CPUs does not use the
RESET_VECTOR irq before trying to use NMIs to shoot down the CPUs.

For normal errors that is fine.  MCEs, however, interrupt all CPUs at
the same time so they are already running in an exception that is
higher priority than an NMI, so sending them an NMI won't do anything.
The MCE code in wait_for_panic() is set up to receive the RESET_VECTOR
because it enables irqs, but it won't work on the NMI-only case.

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
I hadn't heard anything, so I thought I would re-post with the updated
version of the patch.

Wu Bo found this doing kdumps because the IPMI driver saves panic
information to the IPMI event log during a panic.  But it was getting
interrupts at the same time because the other cores had interrupts
enabled, causing the process to take a long time.

Having interrupt enabled during a kdump shutdown and while the new kdump
kernel is running is obviously a bad thing and can cause other problems,
too.  I think this is the right fix, but I'm not an expert in this code.

The only thing I can think of that might be wrong with this is that if
you are going to take a kdump, it might be best to never re-enable
interrupts at all.  But I'm not sure.

Changes since v1:
  * Moved regs to the beginning of all parameter lists that it was
    added to.
  * Fixed the header text about NMIs and MCEs.

 arch/x86/kernel/cpu/mce/core.c | 63 +++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f43a78bde670..b786608f9a21 100644
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
+static void mce_panic(struct pt_regs *regs, const char *msg,
+		      struct mce *final, char *exp)
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
+static int mce_timed_out(struct pt_regs *regs, u64 *t, const char *msg)
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
+			mce_panic(regs, msg, NULL, NULL);
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
+		mce_panic(regs, "Fatal machine check", m, msg);
 
 	/*
 	 * For UC somewhere we let the CPU who detects it handle it.
@@ -909,7 +924,8 @@ static void mce_reign(void)
 	 * source or one CPU is hung. Panic.
 	 */
 	if (global_worst <= MCE_KEEP_SEVERITY && mca_cfg.tolerant < 3)
-		mce_panic("Fatal machine check from unknown source", NULL, NULL);
+		mce_panic(regs,
+			  "Fatal machine check from unknown source", NULL, NULL);
 
 	/*
 	 * Now clear all the mces_seen so that they don't reappear on
@@ -928,7 +944,7 @@ static atomic_t global_nwo;
  * in the entry order.
  * TBD double check parallel CPU hotunplug
  */
-static int mce_start(int *no_way_out)
+static int mce_start(struct pt_regs *regs, int *no_way_out)
 {
 	int order;
 	int cpus = num_online_cpus();
@@ -948,7 +964,7 @@ static int mce_start(int *no_way_out)
 	 * Wait for everyone.
 	 */
 	while (atomic_read(&mce_callin) != cpus) {
-		if (mce_timed_out(&timeout,
+		if (mce_timed_out(regs, &timeout,
 				  "Timeout: Not all CPUs entered broadcast exception handler")) {
 			atomic_set(&global_nwo, 0);
 			return -1;
@@ -974,7 +990,7 @@ static int mce_start(int *no_way_out)
 		 * only seen by one CPU before cleared, avoiding duplicates.
 		 */
 		while (atomic_read(&mce_executing) < order) {
-			if (mce_timed_out(&timeout,
+			if (mce_timed_out(regs, &timeout,
 					  "Timeout: Subject CPUs unable to finish machine check processing")) {
 				atomic_set(&global_nwo, 0);
 				return -1;
@@ -995,7 +1011,7 @@ static int mce_start(int *no_way_out)
  * Synchronize between CPUs after main scanning loop.
  * This invokes the bulk of the Monarch processing.
  */
-static int mce_end(int order)
+static int mce_end(struct pt_regs *regs, int order)
 {
 	int ret = -1;
 	u64 timeout = (u64)mca_cfg.monarch_timeout * NSEC_PER_USEC;
@@ -1019,13 +1035,13 @@ static int mce_end(int order)
 		 * loops.
 		 */
 		while (atomic_read(&mce_executing) <= cpus) {
-			if (mce_timed_out(&timeout,
+			if (mce_timed_out(regs, &timeout,
 					  "Timeout: Monarch CPU unable to finish machine check processing"))
 				goto reset;
 			ndelay(SPINUNIT);
 		}
 
-		mce_reign();
+		mce_reign(regs);
 		barrier();
 		ret = 0;
 	} else {
@@ -1033,7 +1049,7 @@ static int mce_end(int order)
 		 * Subject: Wait for Monarch to finish.
 		 */
 		while (atomic_read(&mce_executing) != 0) {
-			if (mce_timed_out(&timeout,
+			if (mce_timed_out(regs, &timeout,
 					  "Timeout: Monarch CPU did not finish machine check processing"))
 				goto reset;
 			ndelay(SPINUNIT);
@@ -1286,9 +1302,9 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 */
 	if (lmce) {
 		if (no_way_out)
-			mce_panic("Fatal local machine check", &m, msg);
+			mce_panic(regs, "Fatal local machine check", &m, msg);
 	} else {
-		order = mce_start(&no_way_out);
+		order = mce_start(regs, &no_way_out);
 	}
 
 	__mc_scan_banks(&m, final, toclear, valid_banks, no_way_out, &worst);
@@ -1301,7 +1317,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * When there's any problem use only local no_way_out state.
 	 */
 	if (!lmce) {
-		if (mce_end(order) < 0)
+		if (mce_end(regs, order) < 0)
 			no_way_out = worst >= MCE_PANIC_SEVERITY;
 	} else {
 		/*
@@ -1314,7 +1330,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 */
 		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
 			mce_severity(&m, cfg->tolerant, &msg, true);
-			mce_panic("Local fatal machine check!", &m, msg);
+			mce_panic(regs, "Local fatal machine check!", &m, msg);
 		}
 	}
 
@@ -1325,7 +1341,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	if (cfg->tolerant == 3)
 		kill_it = 0;
 	else if (no_way_out)
-		mce_panic("Fatal machine check on current CPU", &m, msg);
+		mce_panic(regs, "Fatal machine check on current CPU", &m, msg);
 
 	if (worst > 0)
 		irq_work_queue(&mce_irq_work);
@@ -1361,7 +1377,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 */
 		if (m.kflags & MCE_IN_KERNEL_RECOV) {
 			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
-				mce_panic("Failed kernel mode recovery", &m, msg);
+				mce_panic(regs, "Failed kernel mode recovery",
+					  &m, msg);
 		}
 	}
 }
-- 
2.17.1

