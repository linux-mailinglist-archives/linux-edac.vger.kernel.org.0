Return-Path: <linux-edac+bounces-2099-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4169A0ACA
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 14:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B02AB2844A
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 12:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A24F208D7A;
	Wed, 16 Oct 2024 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6fjWgs4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31187208972;
	Wed, 16 Oct 2024 12:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083244; cv=none; b=UGpVl6s+otTfzYziQyOfJlg/pLOBTMp7MuvPFOi+vuBsnrkMMBZrHzrwoHSX8esMr/wHU0aLO4x5hniQlCZF75fiEcIYfW2U3biZ431x891/79ybrE7GcMhdJD+p7neBMjF43MhE7vsu0B8h9BHDwHWEAPsJ3EdbNvAXTdmjKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083244; c=relaxed/simple;
	bh=baLCTu2I4/nxgTNGcbcjWclVx9FiepeCwl/VhbSl0vM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WZ+sGLhnLaVKCW19ZqPZCqTJXqUjLujYhwCeWdAkCprYV46RYJuR4uS5JrfG29jPcY0zen+QOcIW/twVktIk1Ml7Vyh8zolz/G0qrSuQrLhxTQo0jIqvWhoK+H2CNbK6FHgPCNV8Yj9rVeDDKjcKyNHh4vDZTV9GMfbUns50bbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6fjWgs4; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729083244; x=1760619244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=baLCTu2I4/nxgTNGcbcjWclVx9FiepeCwl/VhbSl0vM=;
  b=B6fjWgs4NGZUdxeI/U+qwBVTSFaPiqq+rIOkaiOGv87o48ftFyZIusFQ
   29eahR1OPCRUZkDZ5UBe8OJOYEH31ejMqyQS4LEFSU+l8xzBT7YTIHwoZ
   5cBWLi/5AHlvU4y/vPAC1tZ7ZBReIQ7+K62CQXRFp8R69S+HmRiEdpnUu
   dJ7WcNWIW/sruq0XZbDZje8LwK5m81x3IGmjQgsdwrc6nhLI7cDNyqt5l
   8M00ZGd53expx8gvMtpx0l1fcQQA/P4BxlJ+CddiHc4wmrK0JmCDh9Loo
   UYZwSzscrFGfT6a+nbISVxvw9MVaE8jNayIwnD5oEG3Orz4jfPl7Z1FcW
   w==;
X-CSE-ConnectionGUID: Lt4Mm8ybStucl8UZ35Almg==
X-CSE-MsgGUID: xl5c98edTTGtcWcBDgXskQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32217483"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32217483"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:03 -0700
X-CSE-ConnectionGUID: SHAd4ewgTiCBYrsOrApMhw==
X-CSE-MsgGUID: TgBZGl2yQiSX3y05GpeDNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82761621"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:00 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: tony.luck@intel.com,
	bp@alien8.de
Cc: tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH v2 03/10] x86/mce: Make several functions return bool
Date: Wed, 16 Oct 2024 20:30:29 +0800
Message-Id: <20241016123036.21366-4-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Make several functions that return 0 or 1 return a boolean value for
better readability.

No functional changes are intended.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/include/asm/mce.h      |  4 ++--
 arch/x86/kernel/cpu/mce/amd.c   | 10 +++++-----
 arch/x86/kernel/cpu/mce/core.c  | 22 +++++++++++-----------
 arch/x86/kernel/cpu/mce/intel.c |  9 +++++----
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3b9970117a0f..7a01bb5b19d3 100644
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
+bool mce_notify_irq(void);
 
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
index 2a938f429c4d..725c1d6fb1e5 100644
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
 
@@ -1748,7 +1748,7 @@ static void mce_timer_delete_all(void)
  * Can be called from interrupt context, but not from machine check/NMI
  * context.
  */
-int mce_notify_irq(void)
+bool mce_notify_irq(void)
 {
 	/* Not more than two messages every minute */
 	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
@@ -1759,9 +1759,9 @@ int mce_notify_irq(void)
 		if (__ratelimit(&ratelimit))
 			pr_info(HW_ERR "Machine check events logged\n");
 
-		return 1;
+		return true;
 	}
-	return 0;
+	return false;
 }
 EXPORT_SYMBOL_GPL(mce_notify_irq);
 
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


