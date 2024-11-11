Return-Path: <linux-edac+bounces-2486-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 728029C3861
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 07:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A401C216CC
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 06:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB42155393;
	Mon, 11 Nov 2024 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZvWQhiU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ED91537CB;
	Mon, 11 Nov 2024 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306738; cv=none; b=h8WaL4ogdUxNVln89+SOuG5Q0Hm95IUdDi9Ma7Mq4D53LvzU0Tjd/vm5h2Mrxz9Y3owo97udyjgj9gtCnVltXeuHU2r3imLcHnJOYJkucLE+BD6KnzKTOFpuQE4/YTRHD5ukfvZQ0+wbm3ArW3hVplsI5yAB0TmlFrIfOcdS3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306738; c=relaxed/simple;
	bh=+Ro3N2XP9AXkM6gaxt2uPjLl28aKbPKKJsQ+Ib431rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mu99PXQYjc32ej7Ws7Tk1H2YOPHzSOllefWMp2JxE65t20/QcoZa8E5lEJtD2lT4zxpvClFItUIEgfDtWhyG/5fcj0tChMftbqeEmHguKrjP8Q5EUs6DLDX8S5fRnzKz8HyQ+sTPiO9JCvJv2gJO4LKb8la9E/mlO7WZm5WgLxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZvWQhiU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731306737; x=1762842737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+Ro3N2XP9AXkM6gaxt2uPjLl28aKbPKKJsQ+Ib431rY=;
  b=FZvWQhiUpIYn6IZFYxgVHwwuSwj2qHPEGZsaEYGbM4+/8RfOiukmXkJ/
   6NW9CkDyv4U9Qm4zP/hJF4icF1HTWQVCSSII7tFyl0lHCbKzmBp1Fct+V
   8f8ZQHYdHMa1B5O1vW4FSUodfxGRq4TzU3nqyIWIgWrGZEVHTDLVWWzet
   XgBwE9p26K/nKR3rioa1GMIDYU8+pYdY/5SJUdU5UCOEPXTXU/MWtX/gU
   2msR/oDqhHffjql2PSlRL6lI4wGX2TAIHdVgpIAI9HqbnKL+rtP81NzZL
   yMWPBUaw1/lMAl/Dztz9km7B8rrsj8mOh46KAC3OaTw2Re6rXcyIOQCGS
   Q==;
X-CSE-ConnectionGUID: MXfQB+IMTTaI76xLEZbUWw==
X-CSE-MsgGUID: RlrGiLz0SMak5wDsVk54mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="41715479"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="41715479"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:32:16 -0800
X-CSE-ConnectionGUID: JjVqnH7ZRfyQYMj8HF3gzA==
X-CSE-MsgGUID: mrtgLAN+S4O0SgjE8sf4iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="117684504"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:32:13 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	hpa@zytor.com,
	yazen.ghannam@amd.com,
	sohil.mehta@intel.com,
	nik.borisov@suse.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH v4 1/8] x86/mce: Make several functions return bool
Date: Mon, 11 Nov 2024 14:04:21 +0800
Message-Id: <20241111060428.44258-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Make several functions that return 0 or 1 return a boolean value for
better readability.

No functional changes are intended.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v4:
  - Don't rename mce_notify_irq() (Boris).

Changes in v3:
  - Collect "Reviewed-by:" from Nikolay & Sohil.
  - Rename mce_notify_irq() to mce_notify_user() (Sohil).

Changes in v2:
  - Collect "Reviewed-by:" from Tony.

 arch/x86/include/asm/mce.h      |  4 ++--
 arch/x86/kernel/cpu/mce/amd.c   | 10 +++++-----
 arch/x86/kernel/cpu/mce/core.c  | 22 +++++++++++-----------
 arch/x86/kernel/cpu/mce/intel.c |  9 +++++----
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4543cf2eb5e8..ea9ca7689f6b 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -276,7 +276,7 @@ static inline void cmci_rediscover(void) {}
 static inline void cmci_recheck(void) {}
 #endif
 
-int mce_available(struct cpuinfo_x86 *c);
+bool mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
 bool mce_is_correctable(struct mce *m);
 bool mce_usable_address(struct mce *m);
@@ -296,7 +296,7 @@ enum mcp_flags {
 
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
-int mce_notify_irq(void);
+bool mce_notify_irq(void);
 
 DECLARE_PER_CPU(struct mce, injectm);
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6ca80fff1fea..018874b554cb 100644
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
index 7fb5556a0b53..167965bd2ac0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -492,10 +492,10 @@ static noinstr void mce_gather_info(struct mce_hw_err *err, struct pt_regs *regs
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
 
@@ -1778,7 +1778,7 @@ static void mce_timer_delete_all(void)
  * Can be called from interrupt context, but not from machine check/NMI
  * context.
  */
-int mce_notify_irq(void)
+bool mce_notify_irq(void)
 {
 	/* Not more than two messages every minute */
 	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
@@ -1789,9 +1789,9 @@ int mce_notify_irq(void)
 		if (__ratelimit(&ratelimit))
 			pr_info(HW_ERR "Machine check events logged\n");
 
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 EXPORT_SYMBOL_GPL(mce_notify_irq);
 
@@ -2015,25 +2015,25 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
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


