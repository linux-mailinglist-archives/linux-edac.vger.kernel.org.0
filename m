Return-Path: <linux-edac+bounces-3740-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F05A9C1B6
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 10:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC77F4C2F6B
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35B5255E32;
	Fri, 25 Apr 2025 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LAHupr+a"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBCC25395B;
	Fri, 25 Apr 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570160; cv=none; b=kJPrbxqNjOx3Avic6+/BSglt0eyElQqZ4HFg3MruYVIWL/Y/Qv267ysnpXYq+B8OV0f6i6PIxvMmiihe9H/Whhci9QspS3YPJrt12kXRttB5IICig0XputimhhId+1E8O4XyybtxwEnliwsN78hSq6TmZ7hbtuZEDihMNRsCPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570160; c=relaxed/simple;
	bh=NDognvLvDHWzs0ZVdpZxgIq4j8zsUyk3xC2JBzkjl6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nm7noHBR0KoKuUBRdGTTs8PGfHnhdUvqgsf7pEnNphTCCBBDzovp5J/RhGxxn/JYvffqkIIUxnS/uJnFbH8xmrCtzZPaL9fA8Q7uIUPvB3c0Ua5NuzxioBD4UyXJFyRU9P8Rrc0jDq5tLhhk+S3SCNcV3yAD+P5mEl1wJ7GeKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=LAHupr+a; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53P8Yg5b2390085
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 25 Apr 2025 01:35:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53P8Yg5b2390085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1745570116;
	bh=uv41QT4bUCUeg9kRJU+Ll1R/EUQNWmYyobPhZDDnvG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAHupr+aVuwBpQ/lNk4VRYfQ8YqH5gxJ2rbpQnBuRb4FaPPs70H6aY1LwvgqiZm7g
	 HGijy5UeFm73/eBXR+IGsU6GUt8lk0uW2ujOhjHd+8YFP6FlTKaPe4NoqX38awxYPk
	 /xIGSplFs/IhIrHT35jWYZVGRoIeRgbzT1lZOmuyNtXHKUuFWzrhnryI2+qkXFrVTN
	 TY5LUhj34npFxPcxFG7+6q0Ud1MXC09OUc5i8nZbZf+9zaMDQf/GlSdPVLQbd+lBGC
	 WCjWDfnBVN4vbnbd4hlZgXwvR+IWnKB3H6jRhkgL304Rs2jXmKs1f9GQRy0wpbeZsY
	 ZKoo8rEiZWH1g==
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
        haiyangz@microsoft.com, decui@microsoft.com,
        dapeng1.mi@linux.intel.com
Subject: [PATCH v3 13/14] x86/msr: Replace wrmsr(msr, low, 0) with wrmsrq(msr, low)
Date: Fri, 25 Apr 2025 01:34:36 -0700
Message-ID: <20250425083442.2390017-14-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425083442.2390017-1-xin@zytor.com>
References: <20250425083442.2390017-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The third argument in wrmsr(msr, low, 0) is unnecessary.  Instead, use
wrmsrq(msr, low), which automatically sets the higher 32 bits of the
MSR value to 0.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/hyperv/hv_apic.c                 | 6 +++---
 arch/x86/include/asm/apic.h               | 2 +-
 arch/x86/include/asm/switch_to.h          | 2 +-
 arch/x86/kernel/cpu/amd.c                 | 2 +-
 arch/x86/kernel/cpu/common.c              | 8 ++++----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 4 ++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 2 +-
 arch/x86/kernel/cpu/umwait.c              | 4 ++--
 arch/x86/kernel/kvm.c                     | 2 +-
 9 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index c450e67cb0a4..4d617ee59377 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -75,10 +75,10 @@ static void hv_apic_write(u32 reg, u32 val)
 {
 	switch (reg) {
 	case APIC_EOI:
-		wrmsr(HV_X64_MSR_EOI, val, 0);
+		wrmsrq(HV_X64_MSR_EOI, val);
 		break;
 	case APIC_TASKPRI:
-		wrmsr(HV_X64_MSR_TPR, val, 0);
+		wrmsrq(HV_X64_MSR_TPR, val);
 		break;
 	default:
 		native_apic_mem_write(reg, val);
@@ -92,7 +92,7 @@ static void hv_apic_eoi_write(void)
 	if (hvp && (xchg(&hvp->apic_assist, 0) & 0x1))
 		return;
 
-	wrmsr(HV_X64_MSR_EOI, APIC_EOI_ACK, 0);
+	wrmsrq(HV_X64_MSR_EOI, APIC_EOI_ACK);
 }
 
 static bool cpu_is_self(int cpu)
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 0174dd548327..68e10e30fe9b 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -209,7 +209,7 @@ static inline void native_apic_msr_write(u32 reg, u32 v)
 	    reg == APIC_LVR)
 		return;
 
-	wrmsr(APIC_BASE_MSR + (reg >> 4), v, 0);
+	wrmsrq(APIC_BASE_MSR + (reg >> 4), v);
 }
 
 static inline void native_apic_msr_eoi(void)
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
index 4f21df7af715..499b1c15cc8b 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -61,7 +61,7 @@ static inline void refresh_sysenter_cs(struct thread_struct *thread)
 		return;
 
 	this_cpu_write(cpu_tss_rw.x86_tss.ss1, thread->sysenter_cs);
-	wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
+	wrmsrq(MSR_IA32_SYSENTER_CS, thread->sysenter_cs);
 }
 #endif
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 0bbe79862aa6..5e28ec2fe4e8 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1200,7 +1200,7 @@ void amd_set_dr_addr_mask(unsigned long mask, unsigned int dr)
 	if (per_cpu(amd_dr_addr_mask, cpu)[dr] == mask)
 		return;
 
-	wrmsr(amd_msr_dr_addr_masks[dr], mask, 0);
+	wrmsrq(amd_msr_dr_addr_masks[dr], mask);
 	per_cpu(amd_dr_addr_mask, cpu)[dr] = mask;
 }
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cefc99990bde..ef9751d577c3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1982,9 +1982,9 @@ void enable_sep_cpu(void)
 	 */
 
 	tss->x86_tss.ss1 = __KERNEL_CS;
-	wrmsr(MSR_IA32_SYSENTER_CS, tss->x86_tss.ss1, 0);
-	wrmsr(MSR_IA32_SYSENTER_ESP, (unsigned long)(cpu_entry_stack(cpu) + 1), 0);
-	wrmsr(MSR_IA32_SYSENTER_EIP, (unsigned long)entry_SYSENTER_32, 0);
+	wrmsrq(MSR_IA32_SYSENTER_CS, tss->x86_tss.ss1);
+	wrmsrq(MSR_IA32_SYSENTER_ESP, (unsigned long)(cpu_entry_stack(cpu) + 1));
+	wrmsrq(MSR_IA32_SYSENTER_EIP, (unsigned long)entry_SYSENTER_32);
 
 	put_cpu();
 }
@@ -2198,7 +2198,7 @@ static inline void setup_getcpu(int cpu)
 	struct desc_struct d = { };
 
 	if (boot_cpu_has(X86_FEATURE_RDTSCP) || boot_cpu_has(X86_FEATURE_RDPID))
-		wrmsr(MSR_TSC_AUX, cpudata, 0);
+		wrmsrq(MSR_TSC_AUX, cpudata);
 
 	/* Store CPU and node number in limit. */
 	d.limit0 = cpudata;
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 324bd4919300..1190c48a16b2 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -905,7 +905,7 @@ int resctrl_arch_measure_cycles_lat_fn(void *_plr)
 	 * Disable hardware prefetchers.
 	 */
 	rdmsr(MSR_MISC_FEATURE_CONTROL, saved_low, saved_high);
-	wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
+	wrmsrq(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits);
 	mem_r = READ_ONCE(plr->kmem);
 	/*
 	 * Dummy execute of the time measurement to load the needed
@@ -1001,7 +1001,7 @@ static int measure_residency_fn(struct perf_event_attr *miss_attr,
 	 * Disable hardware prefetchers.
 	 */
 	rdmsr(MSR_MISC_FEATURE_CONTROL, saved_low, saved_high);
-	wrmsr(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits, 0x0);
+	wrmsrq(MSR_MISC_FEATURE_CONTROL, prefetch_disable_bits);
 
 	/* Initialize rest of local variables */
 	/*
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 26f4d820ee6e..2ec6d7d843c5 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1707,7 +1707,7 @@ void resctrl_arch_mon_event_config_write(void *_config_info)
 		pr_warn_once("Invalid event id %d\n", config_info->evtid);
 		return;
 	}
-	wrmsr(MSR_IA32_EVT_CFG_BASE + index, config_info->mon_config, 0);
+	wrmsrq(MSR_IA32_EVT_CFG_BASE + index, config_info->mon_config);
 }
 
 static void mbm_config_write_domain(struct rdt_resource *r,
diff --git a/arch/x86/kernel/cpu/umwait.c b/arch/x86/kernel/cpu/umwait.c
index 0050eae153bb..933fcd7ff250 100644
--- a/arch/x86/kernel/cpu/umwait.c
+++ b/arch/x86/kernel/cpu/umwait.c
@@ -33,7 +33,7 @@ static DEFINE_MUTEX(umwait_lock);
 static void umwait_update_control_msr(void * unused)
 {
 	lockdep_assert_irqs_disabled();
-	wrmsr(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached), 0);
+	wrmsrq(MSR_IA32_UMWAIT_CONTROL, READ_ONCE(umwait_control_cached));
 }
 
 /*
@@ -71,7 +71,7 @@ static int umwait_cpu_offline(unsigned int cpu)
 	 * the original control MSR value in umwait_init(). So there
 	 * is no race condition here.
 	 */
-	wrmsr(MSR_IA32_UMWAIT_CONTROL, orig_umwait_control_cached, 0);
+	wrmsrq(MSR_IA32_UMWAIT_CONTROL, orig_umwait_control_cached);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 44a45df7200a..bc9d21d7395f 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -399,7 +399,7 @@ static void kvm_disable_steal_time(void)
 	if (!has_steal_clock)
 		return;
 
-	wrmsr(MSR_KVM_STEAL_TIME, 0, 0);
+	wrmsrq(MSR_KVM_STEAL_TIME, 0);
 }
 
 static u64 kvm_steal_clock(int cpu)
-- 
2.49.0


