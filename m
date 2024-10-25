Return-Path: <linux-edac+bounces-2270-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3224F9AF7FB
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 05:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1EC1C20F99
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 03:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7E718BBB2;
	Fri, 25 Oct 2024 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b8Knrw/B"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD618A6AA;
	Fri, 25 Oct 2024 03:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825839; cv=none; b=Nj8LK8Woz4eY9IcbDltd2/Bedn9WpvnEhIUg5BufS4tudVvLp3KcUC456aHhGOLTaSkZsYi+xUyx2t2b4KkHrvedfgitZ+oIkQUUs3lcPb7pZil0bytpmaT2gKn++G5a3OEGI5kyZ4ywSrZIryw0AVrsM8RcJKjRFt3kgq8g5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825839; c=relaxed/simple;
	bh=A4SBIMSGcxsT9XLkRRfk4vh3jBOWwIDqBVxBwq+7jUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=a+eYacFOEs0AshSjbeaAjqM2JtzAwH4GSwTISNPjQhUgRguU05YVtAOXeyg9ixGqf2+Dd0iJt/ZWYKJ6efG3siQ08068C8j367b4vHfi4llwb+7syC5mMWYOmJ4fjv8NpUwa6jgtKYkNR+d6Q/mQXiVTodtBt/8qXon4t/C/UV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8Knrw/B; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729825837; x=1761361837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=A4SBIMSGcxsT9XLkRRfk4vh3jBOWwIDqBVxBwq+7jUA=;
  b=b8Knrw/BcjLT1jiAwe8KKpBd1NV74mAYFXtUrUa5r4WBhu5JAJXmP1+R
   02rIu/hV0nx2GckhzZjzwV3X+XNPqoWIEWqXhf7R1RDDDqjYM4oJviekQ
   bT/9N/05WVsI2w/JD6eWFkWYnSJHNP10NSaDPptfAMPvY3drIHFlqx+CR
   7ST/eT3DRRLpU6OyBDLXkNtw49IZNpcOPNGR0XDovLv/2hfzta98Gej9a
   tTjWw8glCFrckJmPuwfGtchf+qV2CBefBFs12DIhgcMsKJ25hBm9R+z2p
   Ct88e7+0MxxPtKmAU5PLmDlAYn5GkzKozXViK5RtdMDGdB7xxUFTuhH6U
   g==;
X-CSE-ConnectionGUID: yS/iIPesTg2bACvAA8ggYw==
X-CSE-MsgGUID: BSm03hfwTr2+X2boA8ZR7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29385582"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29385582"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:10:36 -0700
X-CSE-ConnectionGUID: 8u2917jSRgmKcYChSg9wAQ==
X-CSE-MsgGUID: vic9Un7ISwWtDZ01Up00Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80449711"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:10:35 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH v3 03/10] x86/mce: Make several functions return bool and rename a function
Date: Fri, 25 Oct 2024 10:45:55 +0800
Message-Id: <20241025024602.24318-4-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Make several functions that return 0 or 1 return a boolean value for
better readability. Additionally, mce_notify_irq() is about whether
notifying the user and is not IRQ relevant. Rename it to mce_notify_user()
to better reflect its purpose.

No functional changes are intended.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v3:
  - Collect "Reviewed-by:" from Nikolay & Sohil.
  - Rename mce_notify_irq() to mce_notify_user() (Sohil).

Changes in v2:
  - Collect "Reviewed-by:" from Tony.

 arch/x86/include/asm/mce.h       |  4 ++--
 arch/x86/kernel/cpu/mce/amd.c    | 10 +++++-----
 arch/x86/kernel/cpu/mce/core.c   | 28 ++++++++++++++--------------
 arch/x86/kernel/cpu/mce/inject.c |  2 +-
 arch/x86/kernel/cpu/mce/intel.c  |  9 +++++----
 5 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3b9970117a0f..dd9effd7c8b5 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -244,7 +244,7 @@ static inline void cmci_rediscover(void) {}
 static inline void cmci_recheck(void) {}
 #endif
 
-int mce_available(struct cpuinfo_x86 *c);
+bool mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
 bool mce_is_correctable(struct mce *m);
 bool mce_usable_address(struct mce *m);
@@ -264,7 +264,7 @@ enum mcp_flags {
 
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
-int mce_notify_irq(void);
+bool mce_notify_user(void);
 
 DECLARE_PER_CPU(struct mce, injectm);
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 14bf8c232e45..4dae9841ee38 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -381,7 +381,7 @@ static bool lvt_interrupt_supported(unsigned int bank, u32 msr_high_bits)
 	return msr_high_bits & BIT(28);
 }
 
-static int lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
+static bool lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 {
 	int msr = (hi & MASK_LVTOFF_HI) >> 20;
 
@@ -389,7 +389,7 @@ static int lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 		pr_err(FW_BUG "cpu %d, failed to setup threshold interrupt "
 		       "for bank %d, block %d (MSR%08X=0x%x%08x)\n", b->cpu,
 		       b->bank, b->block, b->address, hi, lo);
-		return 0;
+		return false;
 	}
 
 	if (apic != msr) {
@@ -399,15 +399,15 @@ static int lvt_off_valid(struct threshold_block *b, int apic, u32 lo, u32 hi)
 		 * was set is reserved. Return early here:
 		 */
 		if (mce_flags.smca)
-			return 0;
+			return false;
 
 		pr_err(FW_BUG "cpu %d, invalid threshold interrupt offset %d "
 		       "for bank %d, block %d (MSR%08X=0x%x%08x)\n",
 		       b->cpu, apic, b->bank, b->block, b->address, hi, lo);
-		return 0;
+		return false;
 	}
 
-	return 1;
+	return true;
 };
 
 /* Reprogram MCx_MISC MSR behind this threshold bank. */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2a938f429c4d..57c05015f984 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -479,10 +479,10 @@ static noinstr void mce_gather_info(struct mce *m, struct pt_regs *regs)
 	}
 }
 
-int mce_available(struct cpuinfo_x86 *c)
+bool mce_available(struct cpuinfo_x86 *c)
 {
 	if (mca_cfg.disabled)
-		return 0;
+		return false;
 	return cpu_has(c, X86_FEATURE_MCE) && cpu_has(c, X86_FEATURE_MCA);
 }
 
@@ -584,7 +584,7 @@ static int mce_early_notifier(struct notifier_block *nb, unsigned long val,
 
 	set_bit(0, &mce_need_notify);
 
-	mce_notify_irq();
+	mce_notify_user();
 
 	return NOTIFY_DONE;
 }
@@ -1704,7 +1704,7 @@ static void mce_timer_fn(struct timer_list *t)
 	 * Alert userspace if needed. If we logged an MCE, reduce the polling
 	 * interval, otherwise increase the polling interval.
 	 */
-	if (mce_notify_irq())
+	if (mce_notify_user())
 		iv = max(iv / 2, (unsigned long) HZ/100);
 	else
 		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
@@ -1748,7 +1748,7 @@ static void mce_timer_delete_all(void)
  * Can be called from interrupt context, but not from machine check/NMI
  * context.
  */
-int mce_notify_irq(void)
+bool mce_notify_user(void)
 {
 	/* Not more than two messages every minute */
 	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
@@ -1759,11 +1759,11 @@ int mce_notify_irq(void)
 		if (__ratelimit(&ratelimit))
 			pr_info(HW_ERR "Machine check events logged\n");
 
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
-EXPORT_SYMBOL_GPL(mce_notify_irq);
+EXPORT_SYMBOL_GPL(mce_notify_user);
 
 static void __mcheck_cpu_mce_banks_init(void)
 {
@@ -1985,25 +1985,25 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 	return 0;
 }
 
-static int __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
+static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
 {
 	if (c->x86 != 5)
-		return 0;
+		return false;
 
 	switch (c->x86_vendor) {
 	case X86_VENDOR_INTEL:
 		intel_p5_mcheck_init(c);
 		mce_flags.p5 = 1;
-		return 1;
+		return true;
 	case X86_VENDOR_CENTAUR:
 		winchip_mcheck_init(c);
 		mce_flags.winchip = 1;
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 
-	return 0;
+	return false;
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 49ed3428785d..f5a7dae385c6 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -229,7 +229,7 @@ static int raise_local(void)
 	} else if (m->status) {
 		pr_info("Starting machine check poll CPU %d\n", cpu);
 		raise_poll(m);
-		mce_notify_irq();
+		mce_notify_user();
 		pr_info("Machine check poll done on CPU %d\n", cpu);
 	} else
 		m->finished = 0;
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index b3cd2c61b11d..f863df0ff42c 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -75,12 +75,12 @@ static u16 cmci_threshold[MAX_NR_BANKS];
  */
 #define CMCI_STORM_THRESHOLD	32749
 
-static int cmci_supported(int *banks)
+static bool cmci_supported(int *banks)
 {
 	u64 cap;
 
 	if (mca_cfg.cmci_disabled || mca_cfg.ignore_ce)
-		return 0;
+		return false;
 
 	/*
 	 * Vendor check is not strictly needed, but the initial
@@ -89,10 +89,11 @@ static int cmci_supported(int *banks)
 	 */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
-		return 0;
+		return false;
 
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
-		return 0;
+		return false;
+
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
 	*banks = min_t(unsigned, MAX_NR_BANKS, cap & MCG_BANKCNT_MASK);
 	return !!(cap & MCG_CMCI_P);
-- 
2.17.1


