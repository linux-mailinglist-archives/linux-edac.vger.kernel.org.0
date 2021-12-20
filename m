Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6FE47B483
	for <lists+linux-edac@lfdr.de>; Mon, 20 Dec 2021 21:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhLTUng (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 20 Dec 2021 15:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhLTUnd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 20 Dec 2021 15:43:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DB2C06173E;
        Mon, 20 Dec 2021 12:43:32 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4EC861EC04FB;
        Mon, 20 Dec 2021 21:43:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640033007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=T86GXEX9vGJuX8nPoBJwt1R9Pp7ZHqucQb6aglaYx4U=;
        b=pTaOMUE+xrYRjcx5kQinHy8DkvFRWsoYUWkwdac9oyJ3kfArAHcuP7Ns7c/CCzrl4Egayh
        SwY7aLioQjs75J0OAhOiTpsPVIOOAT0VRZe4/3EArEFoElcT6b+lxVqzGo15VwMID81sC4
        9zMSkJFZ0HuIEogiCUqpt4wKlkPR2lg=
Date:   Mon, 20 Dec 2021 21:43:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Zhaolong Zhang <zhangzl2013@126.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH] x86/mce: Remove the tolerance level control
Message-ID: <YcDq8PxvKtTENl/e@zn.tnic>
References: <YYj8ir/UYnG/zVK4@zn.tnic>
 <4a77f582.4434.17cff975224.Coremail.zhangzl2013@126.com>
 <776fad3d.3369.17d03d2c2ba.Coremail.zhangzl2013@126.com>
 <YYo6VwPZLCWcP3Bl@zn.tnic>
 <d66e53d9d8cf4dabb2daade220308d7a@intel.com>
 <YYrQe7bYe+OBzZ4B@zn.tnic>
 <84e2622e4300490587793d2509f7b3ff@intel.com>
 <YYrYUpM7c5Z+nFsv@zn.tnic>
 <42d1d11d63f3453db61fad58a91e2ba5@intel.com>
 <YYroWYUVJEVKqy+7@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYroWYUVJEVKqy+7@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

I guess something like this:

---
From: Borislav Petkov <bp@suse.de>

This is pretty much unused and not really useful. What is more, all
relevant MCA hardware has recoverable machine checks support so there's
no real need to tweak MCA tolerance levels in order to *maybe* extend
machine lifetime.

So rip it out.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 Documentation/ABI/removed/sysfs-mce       | 37 ++++++++++++++++
 Documentation/ABI/testing/sysfs-mce       | 32 --------------
 Documentation/vm/hwpoison.rst             |  2 -
 Documentation/x86/x86_64/boot-options.rst |  9 +---
 arch/x86/kernel/cpu/mce/core.c            | 53 +++++++++--------------
 arch/x86/kernel/cpu/mce/internal.h        |  3 +-
 arch/x86/kernel/cpu/mce/severity.c        | 21 ++++-----
 7 files changed, 68 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-mce

diff --git a/Documentation/ABI/removed/sysfs-mce b/Documentation/ABI/removed/sysfs-mce
new file mode 100644
index 000000000000..ef5dd2a80918
--- /dev/null
+++ b/Documentation/ABI/removed/sysfs-mce
@@ -0,0 +1,37 @@
+What:		/sys/devices/system/machinecheck/machinecheckX/tolerant
+Contact:	Borislav Petkov <bp@suse.de>
+Date:		Dec, 2021
+Description:
+		Unused and obsolete after the advent of recoverable machine
+		checks (see last sentence below) and those are present since
+		2010 (Nehalem).
+
+		Original description:
+
+		The entries appear for each CPU, but they are truly shared
+		between all CPUs.
+
+		Tolerance level. When a machine check exception occurs for a
+		non corrected machine check the kernel can take different
+		actions.
+
+		Since machine check exceptions can happen any time it is
+		sometimes risky for the kernel to kill a process because it
+		defies normal kernel locking rules. The tolerance level
+		configures how hard the kernel tries to recover even at some
+		risk of	deadlock. Higher tolerant values trade potentially
+		better uptime with the risk of a crash or even corruption
+		(for tolerant >= 3).
+
+		==  ===========================================================
+		 0  always panic on uncorrected errors, log corrected errors
+		 1  panic or SIGBUS on uncorrected errors, log corrected errors
+		 2  SIGBUS or log uncorrected errors, log corrected errors
+		 3  never panic or SIGBUS, log all errors (for testing only)
+		==  ===========================================================
+
+		Default: 1
+
+		Note this only makes a difference if the CPU allows recovery
+		from a machine check exception. Current x86 CPUs generally
+		do not.
diff --git a/Documentation/ABI/testing/sysfs-mce b/Documentation/ABI/testing/sysfs-mce
index c8cd989034b4..83172f50e27c 100644
--- a/Documentation/ABI/testing/sysfs-mce
+++ b/Documentation/ABI/testing/sysfs-mce
@@ -53,38 +53,6 @@ Description:
 		(but some corrected errors might be still reported
 		in other ways)
 
-What:		/sys/devices/system/machinecheck/machinecheckX/tolerant
-Contact:	Andi Kleen <ak@linux.intel.com>
-Date:		Feb, 2007
-Description:
-		The entries appear for each CPU, but they are truly shared
-		between all CPUs.
-
-		Tolerance level. When a machine check exception occurs for a
-		non corrected machine check the kernel can take different
-		actions.
-
-		Since machine check exceptions can happen any time it is
-		sometimes risky for the kernel to kill a process because it
-		defies normal kernel locking rules. The tolerance level
-		configures how hard the kernel tries to recover even at some
-		risk of	deadlock. Higher tolerant values trade potentially
-		better uptime with the risk of a crash or even corruption
-		(for tolerant >= 3).
-
-		==  ===========================================================
-		 0  always panic on uncorrected errors, log corrected errors
-		 1  panic or SIGBUS on uncorrected errors, log corrected errors
-		 2  SIGBUS or log uncorrected errors, log corrected errors
-		 3  never panic or SIGBUS, log all errors (for testing only)
-		==  ===========================================================
-
-		Default: 1
-
-		Note this only makes a difference if the CPU allows recovery
-		from a machine check exception. Current x86 CPUs generally
-		do not.
-
 What:		/sys/devices/system/machinecheck/machinecheckX/trigger
 Contact:	Andi Kleen <ak@linux.intel.com>
 Date:		Feb, 2007
diff --git a/Documentation/vm/hwpoison.rst b/Documentation/vm/hwpoison.rst
index 89b5f7a52077..c742de1769d1 100644
--- a/Documentation/vm/hwpoison.rst
+++ b/Documentation/vm/hwpoison.rst
@@ -60,8 +60,6 @@ There are two (actually three) modes memory failure recovery can be in:
 
 vm.memory_failure_recovery sysctl set to zero:
 	All memory failures cause a panic. Do not attempt recovery.
-	(on x86 this can be also affected by the tolerant level of the
-	MCE subsystem)
 
 early kill
 	(can be controlled globally and per process)
diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index ccb7e86bf8d9..07aa0007f346 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -47,14 +47,7 @@ Please see Documentation/x86/x86_64/machinecheck.rst for sysfs runtime tunables.
 		in a reboot. On Intel systems it is enabled by default.
    mce=nobootlog
 		Disable boot machine check logging.
-   mce=tolerancelevel[,monarchtimeout] (number,number)
-		tolerance levels:
-		0: always panic on uncorrected errors, log corrected errors
-		1: panic or SIGBUS on uncorrected errors, log corrected errors
-		2: SIGBUS or log uncorrected errors, log corrected errors
-		3: never panic or SIGBUS, log all errors (for testing only)
-		Default is 1
-		Can be also set using sysfs which is preferable.
+   mce=monarchtimeout (number)
 		monarchtimeout:
 		Sets the time in us to wait for other CPUs on machine checks. 0
 		to disable.
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b837fd4d..8d30469ab38c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -86,14 +86,6 @@ struct mce_vendor_flags mce_flags __read_mostly;
 
 struct mca_config mca_cfg __read_mostly = {
 	.bootlog  = -1,
-	/*
-	 * Tolerant levels:
-	 * 0: always panic on uncorrected errors, log corrected errors
-	 * 1: panic or SIGBUS on uncorrected errors, log corrected errors
-	 * 2: SIGBUS or log uncorrected errors (if possible), log corr. errors
-	 * 3: never panic or SIGBUS, log all errors (for testing only)
-	 */
-	.tolerant = 1,
 	.monarch_timeout = -1
 };
 
@@ -774,7 +766,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 			goto clear_it;
 
 		mce_read_aux(&m, i);
-		m.severity = mce_severity(&m, NULL, mca_cfg.tolerant, NULL, false);
+		m.severity = mce_severity(&m, NULL, NULL, false);
 		/*
 		 * Don't get the IP here because it's unlikely to
 		 * have anything to do with the actual error location.
@@ -854,7 +846,7 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 			quirk_sandybridge_ifu(i, m, regs);
 
 		m->bank = i;
-		if (mce_severity(m, regs, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
+		if (mce_severity(m, regs, &tmp, true) >= MCE_PANIC_SEVERITY) {
 			mce_read_aux(m, i);
 			*msg = tmp;
 			return 1;
@@ -902,12 +894,11 @@ static noinstr int mce_timed_out(u64 *t, const char *msg)
 	if (!mca_cfg.monarch_timeout)
 		goto out;
 	if ((s64)*t < SPINUNIT) {
-		if (mca_cfg.tolerant <= 1) {
-			if (cpumask_and(&mce_missing_cpus, cpu_online_mask, &mce_missing_cpus))
-				pr_emerg("CPUs not responding to MCE broadcast (may include false positives): %*pbl\n",
-					 cpumask_pr_args(&mce_missing_cpus));
-			mce_panic(msg, NULL, NULL);
-		}
+		if (cpumask_and(&mce_missing_cpus, cpu_online_mask, &mce_missing_cpus))
+			pr_emerg("CPUs not responding to MCE broadcast (may include false positives): %*pbl\n",
+				 cpumask_pr_args(&mce_missing_cpus));
+		mce_panic(msg, NULL, NULL);
+
 		ret = 1;
 		goto out;
 	}
@@ -971,9 +962,9 @@ static void mce_reign(void)
 	 * This dumps all the mces in the log buffer and stops the
 	 * other CPUs.
 	 */
-	if (m && global_worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
+	if (m && global_worst >= MCE_PANIC_SEVERITY) {
 		/* call mce_severity() to get "msg" for panic */
-		mce_severity(m, NULL, mca_cfg.tolerant, &msg, true);
+		mce_severity(m, NULL, &msg, true);
 		mce_panic("Fatal machine check", m, msg);
 	}
 
@@ -987,7 +978,7 @@ static void mce_reign(void)
 	 * No machine check event found. Must be some external
 	 * source or one CPU is hung. Panic.
 	 */
-	if (global_worst <= MCE_KEEP_SEVERITY && mca_cfg.tolerant < 3)
+	if (global_worst <= MCE_KEEP_SEVERITY)
 		mce_panic("Fatal machine check from unknown source", NULL, NULL);
 
 	/*
@@ -1234,7 +1225,7 @@ __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
 		/* Set taint even when machine check was not enabled. */
 		taint++;
 
-		severity = mce_severity(m, regs, cfg->tolerant, NULL, true);
+		severity = mce_severity(m, regs, NULL, true);
 
 		/*
 		 * When machine check was for corrected/deferred handler don't
@@ -1392,7 +1383,6 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	int worst = 0, order, no_way_out, kill_current_task, lmce, taint = 0;
 	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS) = { 0 };
 	DECLARE_BITMAP(toclear, MAX_NR_BANKS) = { 0 };
-	struct mca_config *cfg = &mca_cfg;
 	struct mce m, *final;
 	char *msg = NULL;
 
@@ -1411,7 +1401,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 
 	/*
 	 * If no_way_out gets set, there is no safe way to recover from this
-	 * MCE.  If mca_cfg.tolerant is cranked up, we'll try anyway.
+	 * MCE.
 	 */
 	no_way_out = 0;
 
@@ -1445,7 +1435,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * severity is MCE_AR_SEVERITY we have other options.
 	 */
 	if (!(m.mcgstatus & MCG_STATUS_RIPV))
-		kill_current_task = (cfg->tolerant == 3) ? 0 : 1;
+		kill_current_task = 1;
 	/*
 	 * Check if this MCE is signaled to only this logical processor,
 	 * on Intel, Zhaoxin only.
@@ -1462,7 +1452,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * to see it will clear it.
 	 */
 	if (lmce) {
-		if (no_way_out && cfg->tolerant < 3)
+		if (no_way_out)
 			mce_panic("Fatal local machine check", &m, msg);
 	} else {
 		order = mce_start(&no_way_out);
@@ -1482,7 +1472,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 			if (!no_way_out)
 				no_way_out = worst >= MCE_PANIC_SEVERITY;
 
-			if (no_way_out && cfg->tolerant < 3)
+			if (no_way_out)
 				mce_panic("Fatal machine check on current CPU", &m, msg);
 		}
 	} else {
@@ -1494,8 +1484,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 * fatal error. We call "mce_severity()" again to
 		 * make sure we have the right "msg".
 		 */
-		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
-			mce_severity(&m, regs, cfg->tolerant, &msg, true);
+		if (worst >= MCE_PANIC_SEVERITY) {
+			mce_severity(&m, regs, &msg, true);
 			mce_panic("Local fatal machine check!", &m, msg);
 		}
 	}
@@ -2223,10 +2213,9 @@ static int __init mcheck_enable(char *str)
 		cfg->bios_cmci_threshold = 1;
 	else if (!strcmp(str, "recovery"))
 		cfg->recovery = 1;
-	else if (isdigit(str[0])) {
-		if (get_option(&str, &cfg->tolerant) == 2)
-			get_option(&str, &(cfg->monarch_timeout));
-	} else {
+	else if (isdigit(str[0]))
+		get_option(&str, &(cfg->monarch_timeout));
+	else {
 		pr_info("mce argument %s ignored. Please use /sys\n", str);
 		return 0;
 	}
@@ -2476,7 +2465,6 @@ static ssize_t store_int_with_restart(struct device *s,
 	return ret;
 }
 
-static DEVICE_INT_ATTR(tolerant, 0644, mca_cfg.tolerant);
 static DEVICE_INT_ATTR(monarch_timeout, 0644, mca_cfg.monarch_timeout);
 static DEVICE_BOOL_ATTR(dont_log_ce, 0644, mca_cfg.dont_log_ce);
 static DEVICE_BOOL_ATTR(print_all, 0644, mca_cfg.print_all);
@@ -2497,7 +2485,6 @@ static struct dev_ext_attribute dev_attr_cmci_disabled = {
 };
 
 static struct device_attribute *mce_device_attrs[] = {
-	&dev_attr_tolerant.attr,
 	&dev_attr_check_interval.attr,
 #ifdef CONFIG_X86_MCELOG_LEGACY
 	&dev_attr_trigger,
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 52c633950b38..831d2e2c6c3b 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -35,7 +35,7 @@ int mce_gen_pool_add(struct mce *mce);
 int mce_gen_pool_init(void);
 struct llist_node *mce_gen_pool_prepare_records(void);
 
-int mce_severity(struct mce *a, struct pt_regs *regs, int tolerant, char **msg, bool is_excp);
+int mce_severity(struct mce *a, struct pt_regs *regs, char **msg, bool is_excp);
 struct dentry *mce_get_debugfs_dir(void);
 
 extern mce_banks_t mce_banks_ce_disabled;
@@ -127,7 +127,6 @@ struct mca_config {
 	bool ignore_ce;
 	bool print_all;
 
-	int tolerant;
 	int monarch_timeout;
 	int panic_timeout;
 	u32 rip_msr;
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 7aa2bda93cbb..b9f29d0434db 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -330,8 +330,7 @@ static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
  * See AMD Error Scope Hierarchy table in a newer BKDG. For example
  * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
  */
-static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, int tolerant,
-				    char **msg, bool is_excp)
+static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
 	enum context ctx = error_context(m, regs);
 
@@ -383,8 +382,7 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, int tol
 	return MCE_KEEP_SEVERITY;
 }
 
-static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs,
-				      int tolerant, char **msg, bool is_excp)
+static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
 	enum exception excp = (is_excp ? EXCP_CONTEXT : NO_EXCP);
 	enum context ctx = error_context(m, regs);
@@ -412,22 +410,21 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs,
 		if (msg)
 			*msg = s->msg;
 		s->covered = 1;
-		if (s->sev >= MCE_UC_SEVERITY && ctx == IN_KERNEL) {
-			if (tolerant < 1)
-				return MCE_PANIC_SEVERITY;
-		}
+
+		if (s->sev >= MCE_UC_SEVERITY && ctx == IN_KERNEL)
+			return MCE_PANIC_SEVERITY;
+
 		return s->sev;
 	}
 }
 
-int noinstr mce_severity(struct mce *m, struct pt_regs *regs, int tolerant, char **msg,
-			 bool is_excp)
+int noinstr mce_severity(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		return mce_severity_amd(m, regs, tolerant, msg, is_excp);
+		return mce_severity_amd(m, regs, msg, is_excp);
 	else
-		return mce_severity_intel(m, regs, tolerant, msg, is_excp);
+		return mce_severity_intel(m, regs, msg, is_excp);
 }
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.29.2


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
