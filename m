Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B885DCC54F
	for <lists+linux-edac@lfdr.de>; Fri,  4 Oct 2019 23:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfJDV42 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Oct 2019 17:56:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:5964 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731179AbfJDV41 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 4 Oct 2019 17:56:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 14:56:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="191710648"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by fmsmga008.fm.intel.com with ESMTP; 04 Oct 2019 14:56:25 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 01/16] x86/intel: Initialize IA32_FEATURE_CONTROL MSR at boot
Date:   Fri,  4 Oct 2019 14:56:00 -0700
Message-Id: <20191004215615.5479-2-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191004215615.5479-1-sean.j.christopherson@intel.com>
References: <20191004215615.5479-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Opportunistically initialize IA32_FEATURE_CONTROL MSR to enable VMX when
the MSR is left unlocked by BIOS.  Configuring IA32_FEATURE_CONTROL at
boot time paves the way for similar enabling of other features, e.g.
Software Guard Extensions (SGX).

Temporarily leave equivalent KVM code in place in order to avoid
introducing a regression on Centaur and Zhaoxin CPUs, e.g. removing
KVM's code would leave the MSR unlocked on those CPUs and would break
existing functionality if people are loading kvm_intel on Centaur and/or
Zhaoxin.  Defer enablement of the boot-time configuration on Centaur and
Zhaoxin to future patches to aid bisection.

Note, Local Machine Check Exceptions (LMCE) are also supported by the
kernel and enabled via IA32_FEATURE_CONTROL, but the kernel currently
uses LMCE if and and only if the feature is explicitly enable by BIOS.
Keep the current behavior to avoid introducing bugs, future patches can
opt in to opportunistic enabling if it's deemed desirable to do so.

Always lock IA32_FEATURE_CONTROL if it exists, even if the CPU doesn't
support VMX, so that other existing and future kernel code that queries
IA32_FEATURE_CONTROL can assume it's locked.

Start from a clean slate when constructing the value to write to
IA32_FEATURE_CONTROL, i.e. ignore whatever value BIOS left in the MSR so
as not to enable random features or fault on the WRMSR.

Suggested-by: Borislav Petkov <bp@suse.de>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/Kconfig.cpu                  |  4 ++++
 arch/x86/kernel/cpu/Makefile          |  1 +
 arch/x86/kernel/cpu/cpu.h             |  4 ++++
 arch/x86/kernel/cpu/feature_control.c | 30 +++++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c           |  2 ++
 5 files changed, 41 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/feature_control.c

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index af9c967782f6..aafc14a0abf7 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -387,6 +387,10 @@ config X86_DEBUGCTLMSR
 	def_bool y
 	depends on !(MK6 || MWINCHIPC6 || MWINCHIP3D || MCYRIXIII || M586MMX || M586TSC || M586 || M486SX || M486) && !UML
 
+config X86_FEATURE_CONTROL_MSR
+	def_bool y
+	depends on CPU_SUP_INTEL
+
 menuconfig PROCESSOR_SELECT
 	bool "Supported processor vendors" if EXPERT
 	---help---
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index d7a1e5a9331c..df5ad0cfe3e9 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -29,6 +29,7 @@ obj-y			+= umwait.o
 obj-$(CONFIG_PROC_FS)	+= proc.o
 obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
 
+obj-$(CONFIG_X86_FEATURE_CONTROL_MSR) += feature_control.o
 ifdef CONFIG_CPU_SUP_INTEL
 obj-y			+= intel.o intel_pconfig.o
 obj-$(CONFIG_PM)	+= intel_epb.o
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index c0e2407abdd6..d2750f53a0cb 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -62,4 +62,8 @@ unsigned int aperfmperf_get_khz(int cpu);
 
 extern void x86_spec_ctrl_setup_ap(void);
 
+#ifdef CONFIG_X86_FEATURE_CONTROL_MSR
+void init_feature_control_msr(struct cpuinfo_x86 *c);
+#endif
+
 #endif /* ARCH_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/feature_control.c b/arch/x86/kernel/cpu/feature_control.c
new file mode 100644
index 000000000000..57b928e64cf5
--- /dev/null
+++ b/arch/x86/kernel/cpu/feature_control.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/tboot.h>
+
+#include <asm/cpufeature.h>
+#include <asm/msr-index.h>
+#include <asm/processor.h>
+
+void init_feature_control_msr(struct cpuinfo_x86 *c)
+{
+	u64 msr;
+
+	if (rdmsrl_safe(MSR_IA32_FEATURE_CONTROL, &msr))
+		return;
+
+	if (msr & FEATURE_CONTROL_LOCKED)
+		return;
+
+	/*
+	 * Ignore whatever value BIOS left in the MSR to avoid enabling random
+	 * features or faulting on the WRMSR.
+	 */
+	msr = FEATURE_CONTROL_LOCKED;
+
+	if (cpu_has(c, X86_FEATURE_VMX)) {
+		msr |= FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+		if (tboot_enabled())
+			msr |= FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX;
+	}
+	wrmsrl(MSR_IA32_FEATURE_CONTROL, msr);
+}
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index c2fdc00df163..15d59224e2f8 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -755,6 +755,8 @@ static void init_intel(struct cpuinfo_x86 *c)
 	/* Work around errata */
 	srat_detect_node(c);
 
+	init_feature_control_msr(c);
+
 	if (cpu_has(c, X86_FEATURE_VMX))
 		detect_vmx_virtcap(c);
 
-- 
2.22.0

