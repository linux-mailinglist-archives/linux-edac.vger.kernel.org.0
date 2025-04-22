Return-Path: <linux-edac+bounces-3608-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FB3A9627E
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 10:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B0817D0C0
	for <lists+linux-edac@lfdr.de>; Tue, 22 Apr 2025 08:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F0925C717;
	Tue, 22 Apr 2025 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bhOnyEJJ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F625522B;
	Tue, 22 Apr 2025 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745310232; cv=none; b=ZEdnFk75roxHJ3SKAioJmt+VAU1m/yWKWMnyUOGFDf+/dI4LBT6juJySA5h1yIhIILCWQMbVO1YHkK57YgYQeuWZB8veYkOIrfNwYy3Z5U0U3CV4VTHIQbWTfMNaBQ4JVQexv3EdQCvPbirGPahjmn4NimIWy8lwE9w4KEwip40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745310232; c=relaxed/simple;
	bh=4cF3LV8TD/rxDoNqTzi8ac3u7KhUM/vZA/zD5XUm6E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+sMjK7vLSbmSJJN6jVV7+zT/icgF+6LNqFDf1d5c5uMVVw36SxEyPTZ5p2KfrOBeCtvojMbZ6VU5kft73HbtN6Cy5UEgXgvo8XrZ0KgZAuEAm9RAH1fo4+i69qTKTI/dBPwMeG/JPInfyIlvh9lwtpunOhZzqdNCkPC34Vzltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bhOnyEJJ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53M8MG9h1954391
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 22 Apr 2025 01:23:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53M8MG9h1954391
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1745310201;
	bh=HZ6mNNbZ7ulzph9dMmRPGpUoSI6d0gZZ7dCJYm/kVRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bhOnyEJJ9eA/e2yJpfrvVgyfJSJRYVg7h8wU1lJUr8G7Pna/4/NLi+alPmNV+SLRK
	 Uo8LDKcvd0Pk5gC6kAB15JJcOI7+0ixbYobSD9S0ZkC7VSMyiQmcJ67McllPf46ule
	 Zo//0nO6Loi0Zm3hZIoJu5gSw+5ZCTgTLpB+N7vw24j4D7huPiDQAIXQ0mMYlE28Iu
	 JM+TWlUg9eQw7SWWSKY+QaKd6tM1sIujXGDJmyW5dZHdNPzvi4RUSSLufTAC57nokH
	 MNXZdSlARgUnRzsuDgzLRJT7LYVtmLxfbvHlFRDyLxwsptSQyd6JLbwRKWTnLYST6j
	 R0HGqr7RcZJWA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-edac@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        acme@kernel.org, jgross@suse.com, andrew.cooper3@citrix.com,
        peterz@infradead.org, namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        wei.liu@kernel.org, ajay.kaher@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com,
        pbonzini@redhat.com, vkuznets@redhat.com, seanjc@google.com,
        luto@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com
Subject: [RFC PATCH v2 29/34] x86/msr: Rename native_rdmsrq() to native_rdmsrq_no_trace()
Date: Tue, 22 Apr 2025 01:22:10 -0700
Message-ID: <20250422082216.1954310-30-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422082216.1954310-1-xin@zytor.com>
References: <20250422082216.1954310-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

native_rdmsrq() doesn't do trace thus can be used in noinstr context,
rename it to native_rdmsrq_no_trace() to make it explicit.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/boot/startup/sme.c               | 4 ++--
 arch/x86/events/amd/brs.c                 | 2 +-
 arch/x86/hyperv/hv_vtl.c                  | 4 ++--
 arch/x86/hyperv/ivm.c                     | 2 +-
 arch/x86/include/asm/mshyperv.h           | 2 +-
 arch/x86/include/asm/msr.h                | 8 ++++----
 arch/x86/include/asm/sev-internal.h       | 2 +-
 arch/x86/kernel/cpu/common.c              | 2 +-
 arch/x86/kernel/cpu/mce/core.c            | 4 ++--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 2 +-
 arch/x86/kvm/vmx/vmx.c                    | 4 ++--
 11 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 5e147bf5a0a8..859d92ad91a4 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -524,7 +524,7 @@ void __head sme_enable(struct boot_params *bp)
 	me_mask = 1UL << (ebx & 0x3f);
 
 	/* Check the SEV MSR whether SEV or SME is enabled */
-	sev_status = msr = native_rdmsrq(MSR_AMD64_SEV);
+	sev_status = msr = native_rdmsrq_no_trace(MSR_AMD64_SEV);
 	feature_mask = (msr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
 	/*
@@ -555,7 +555,7 @@ void __head sme_enable(struct boot_params *bp)
 			return;
 
 		/* For SME, check the SYSCFG MSR */
-		msr = native_rdmsrq(MSR_AMD64_SYSCFG);
+		msr = native_rdmsrq_no_trace(MSR_AMD64_SYSCFG);
 		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
 			return;
 	}
diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 0153616a97cd..0623b6d775fb 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -49,7 +49,7 @@ static __always_inline void set_debug_extn_cfg(u64 val)
 
 static __always_inline u64 get_debug_extn_cfg(void)
 {
-	return native_rdmsrq(MSR_AMD_DBG_EXTN_CFG);
+	return native_rdmsrq_no_trace(MSR_AMD_DBG_EXTN_CFG);
 }
 
 static bool __init amd_brs_detect(void)
diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index c6343e699154..9e41e380ad26 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -149,11 +149,11 @@ static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
 	input->vp_context.rip = rip;
 	input->vp_context.rsp = rsp;
 	input->vp_context.rflags = 0x0000000000000002;
-	input->vp_context.efer = native_rdmsrq(MSR_EFER);
+	input->vp_context.efer = native_rdmsrq_no_trace(MSR_EFER);
 	input->vp_context.cr0 = native_read_cr0();
 	input->vp_context.cr3 = __native_read_cr3();
 	input->vp_context.cr4 = native_read_cr4();
-	input->vp_context.msr_cr_pat = native_rdmsrq(MSR_IA32_CR_PAT);
+	input->vp_context.msr_cr_pat = native_rdmsrq_no_trace(MSR_IA32_CR_PAT);
 	input->vp_context.idtr.limit = idt_ptr.size;
 	input->vp_context.idtr.base = idt_ptr.address;
 	input->vp_context.gdtr.limit = gdt_ptr.size;
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 821609af5bd2..dfddf522e838 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -111,7 +111,7 @@ u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
 
 static inline u64 rd_ghcb_msr(void)
 {
-	return native_rdmsrq(MSR_AMD64_SEV_ES_GHCB);
+	return native_rdmsrq_no_trace(MSR_AMD64_SEV_ES_GHCB);
 }
 
 static inline void wr_ghcb_msr(u64 val)
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 778444310cfb..ab94221ff38d 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -305,7 +305,7 @@ void hv_set_non_nested_msr(unsigned int reg, u64 value);
 
 static __always_inline u64 hv_raw_get_msr(unsigned int reg)
 {
-	return native_rdmsrq(reg);
+	return native_rdmsrq_no_trace(reg);
 }
 
 #else /* CONFIG_HYPERV */
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index a1c63bed14be..050d750a5ab7 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -157,7 +157,7 @@ static __always_inline bool is_msr_imm_insn(void *ip)
  *                         __native_rdmsrq()   -----------------------
  *                            /     \                                |
  *                           /       \                               |
- *               native_rdmsrq()    native_read_msr_safe()           |
+ *        native_rdmsrq_no_trace()    native_read_msr_safe()         |
  *                   /    \                                          |
  *                  /      \                                         |
  *      native_rdmsr()    native_read_msr()                          |
@@ -248,7 +248,7 @@ static __always_inline bool __native_rdmsrq(u32 msr, u64 *val, int type)
 	return __native_rdmsrq_variable(msr, val, type);
 }
 
-static __always_inline u64 native_rdmsrq(u32 msr)
+static __always_inline u64 native_rdmsrq_no_trace(u32 msr)
 {
 	u64 val = 0;
 
@@ -258,14 +258,14 @@ static __always_inline u64 native_rdmsrq(u32 msr)
 
 #define native_rdmsr(msr, low, high)			\
 do {							\
-	u64 __val = native_rdmsrq(msr);			\
+	u64 __val = native_rdmsrq_no_trace(msr);	\
 	(void)((low) = (u32)__val);			\
 	(void)((high) = (u32)(__val >> 32));		\
 } while (0)
 
 static inline u64 native_read_msr(u32 msr)
 {
-	u64 val = native_rdmsrq(msr);
+	u64 val = native_rdmsrq_no_trace(msr);
 
 	if (tracepoint_enabled(read_msr))
 		do_trace_read_msr(msr, val, 0);
diff --git a/arch/x86/include/asm/sev-internal.h b/arch/x86/include/asm/sev-internal.h
index 7eb030702435..743da9fc7454 100644
--- a/arch/x86/include/asm/sev-internal.h
+++ b/arch/x86/include/asm/sev-internal.h
@@ -96,7 +96,7 @@ int svsm_perform_call_protocol(struct svsm_call *call);
 
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
-	return native_rdmsrq(MSR_AMD64_SEV_ES_GHCB);
+	return native_rdmsrq_no_trace(MSR_AMD64_SEV_ES_GHCB);
 }
 
 static __always_inline void sev_es_wr_ghcb_msr(u64 val)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 99d8a8c15ba5..9d2de568cb96 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -164,7 +164,7 @@ static void ppin_init(struct cpuinfo_x86 *c)
 
 	/* Is the enable bit set? */
 	if (val & 2UL) {
-		c->ppin = native_rdmsrq(info->msr_ppin);
+		c->ppin = native_rdmsrq_no_trace(info->msr_ppin);
 		set_cpu_cap(c, info->feature);
 		return;
 	}
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bd3cb984ccb9..9f7538b9d2fa 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -121,7 +121,7 @@ void mce_prep_record_common(struct mce *m)
 {
 	m->cpuid	= cpuid_eax(1);
 	m->cpuvendor	= boot_cpu_data.x86_vendor;
-	m->mcgcap	= native_rdmsrq(MSR_IA32_MCG_CAP);
+	m->mcgcap	= native_rdmsrq_no_trace(MSR_IA32_MCG_CAP);
 	/* need the internal __ version to avoid deadlocks */
 	m->time		= __ktime_get_real_seconds();
 }
@@ -1313,7 +1313,7 @@ static noinstr bool mce_check_crashing_cpu(void)
 	    (crashing_cpu != -1 && crashing_cpu != cpu)) {
 		u64 mcgstatus;
 
-		mcgstatus = native_rdmsrq(MSR_IA32_MCG_STATUS);
+		mcgstatus = native_rdmsrq_no_trace(MSR_IA32_MCG_STATUS);
 
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
 			if (mcgstatus & MCG_STATUS_LMCES)
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 184bc1b3fb02..819c07a23c6d 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -482,7 +482,7 @@ int resctrl_arch_pseudo_lock_fn(void *_plr)
 	 * the buffer and evict pseudo-locked memory read earlier from the
 	 * cache.
 	 */
-	saved_msr = native_rdmsrq(MSR_MISC_FEATURE_CONTROL);
+	saved_msr = native_rdmsrq_no_trace(MSR_MISC_FEATURE_CONTROL);
 	native_wrmsrq_no_trace(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits);
 	closid_p = this_cpu_read(pqr_state.cur_closid);
 	rmid_p = this_cpu_read(pqr_state.cur_rmid);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b53575dee64a..cdbbfa0b9851 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -380,7 +380,7 @@ static __always_inline void vmx_disable_fb_clear(struct vcpu_vmx *vmx)
 	if (!vmx->disable_fb_clear)
 		return;
 
-	msr = native_rdmsrq(MSR_IA32_MCU_OPT_CTRL);
+	msr = native_rdmsrq_no_trace(MSR_IA32_MCU_OPT_CTRL);
 	msr |= FB_CLEAR_DIS;
 	native_wrmsrq_no_trace(MSR_IA32_MCU_OPT_CTRL, msr);
 	/* Cache the MSR value to avoid reading it later */
@@ -7307,7 +7307,7 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
 		return;
 
 	if (flags & VMX_RUN_SAVE_SPEC_CTRL)
-		vmx->spec_ctrl = native_rdmsrq(MSR_IA32_SPEC_CTRL);
+		vmx->spec_ctrl = native_rdmsrq_no_trace(MSR_IA32_SPEC_CTRL);
 
 	/*
 	 * If the guest/host SPEC_CTRL values differ, restore the host value.
-- 
2.49.0


