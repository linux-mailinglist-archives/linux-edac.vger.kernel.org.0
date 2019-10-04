Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9F7CC55E
	for <lists+linux-edac@lfdr.de>; Fri,  4 Oct 2019 23:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbfJDV4g (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Oct 2019 17:56:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:5996 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731605AbfJDV4f (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 4 Oct 2019 17:56:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 14:56:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,257,1566889200"; 
   d="scan'208";a="191710698"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by fmsmga008.fm.intel.com with ESMTP; 04 Oct 2019 14:56:33 -0700
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
Subject: [PATCH 11/16] x86/cpu: Print VMX features as separate line item in /proc/cpuinfo
Date:   Fri,  4 Oct 2019 14:56:10 -0700
Message-Id: <20191004215615.5479-12-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191004215615.5479-1-sean.j.christopherson@intel.com>
References: <20191004215615.5479-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add support for generating VMX feature names in capflags.c and printing
the resulting names in /proc/cpuinfo as "vmx flags" when VMX support is
detected.  Do not print VMX flags if no bits are set in word 0, which
includes Pin controls.  INTR and NMI exiting are fundamental pillars of
virtualization, if they're not supported then the CPU is broken, it does
not actually support VMX, or the kernel wasn't built with support for
the target CPU.

Remove all code which sets the synthetic VMX flags in cpufeatures so
that duplicate VMX features are not printed in "flags" and "vmx flags".

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/boot/mkcpustr.c          |  1 +
 arch/x86/kernel/cpu/Makefile      |  5 ++--
 arch/x86/kernel/cpu/centaur.c     | 35 ----------------------
 arch/x86/kernel/cpu/intel.c       | 49 -------------------------------
 arch/x86/kernel/cpu/mkcapflags.sh | 15 +++++++---
 arch/x86/kernel/cpu/proc.c        | 15 ++++++++++
 arch/x86/kernel/cpu/zhaoxin.c     | 35 ----------------------
 7 files changed, 30 insertions(+), 125 deletions(-)

diff --git a/arch/x86/boot/mkcpustr.c b/arch/x86/boot/mkcpustr.c
index 9caa10e82217..da0ccc5de538 100644
--- a/arch/x86/boot/mkcpustr.c
+++ b/arch/x86/boot/mkcpustr.c
@@ -15,6 +15,7 @@
 #include "../include/asm/required-features.h"
 #include "../include/asm/disabled-features.h"
 #include "../include/asm/cpufeatures.h"
+#include "../include/asm/vmxfeatures.h"
 #include "../kernel/cpu/capflags.c"
 
 int main(void)
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index df5ad0cfe3e9..025cbfd45687 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -54,11 +54,12 @@ obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
 
 ifdef CONFIG_X86_FEATURE_NAMES
 quiet_cmd_mkcapflags = MKCAP   $@
-      cmd_mkcapflags = $(CONFIG_SHELL) $(srctree)/$(src)/mkcapflags.sh $< $@
+      cmd_mkcapflags = $(CONFIG_SHELL) $(srctree)/$(src)/mkcapflags.sh $@ $^
 
 cpufeature = $(src)/../../include/asm/cpufeatures.h
+vmxfeature = $(src)/../../include/asm/vmxfeatures.h
 
-$(obj)/capflags.c: $(cpufeature) $(src)/mkcapflags.sh FORCE
+$(obj)/capflags.c: $(cpufeature) $(vmxfeature) $(src)/mkcapflags.sh FORCE
 	$(call if_changed,mkcapflags)
 endif
 targets += capflags.c
diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index a6ca4c31c1b6..be11c796926b 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -18,13 +18,6 @@
 #define RNG_ENABLED	(1 << 3)
 #define RNG_ENABLE	(1 << 6)	/* MSR_VIA_RNG */
 
-#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
-#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
-#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
-#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
-#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
-#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
-
 static void init_c3(struct cpuinfo_x86 *c)
 {
 	u32  lo, hi;
@@ -119,31 +112,6 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
 	}
 }
 
-static void centaur_detect_vmx_virtcap(struct cpuinfo_x86 *c)
-{
-	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
-
-	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
-	msr_ctl = vmx_msr_high | vmx_msr_low;
-
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
-		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
-		set_cpu_cap(c, X86_FEATURE_VNMI);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
-		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
-		      vmx_msr_low, vmx_msr_high);
-		msr_ctl2 = vmx_msr_high | vmx_msr_low;
-		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
-		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
-			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
-			set_cpu_cap(c, X86_FEATURE_EPT);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
-			set_cpu_cap(c, X86_FEATURE_VPID);
-	}
-}
-
 static void init_centaur(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_32
@@ -251,9 +219,6 @@ static void init_centaur(struct cpuinfo_x86 *c)
 #endif
 
 	init_feature_control_msr(c);
-
-	if (cpu_has(c, X86_FEATURE_VMX))
-		centaur_detect_vmx_virtcap(c);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 15d59224e2f8..594d2686ad52 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -494,52 +494,6 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #endif
 }
 
-static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
-{
-	/* Intel VMX MSR indicated features */
-#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
-#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
-#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
-#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
-#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
-#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
-#define x86_VMX_FEATURE_EPT_CAP_AD		0x00200000
-
-	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
-	u32 msr_vpid_cap, msr_ept_cap;
-
-	clear_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
-	clear_cpu_cap(c, X86_FEATURE_VNMI);
-	clear_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
-	clear_cpu_cap(c, X86_FEATURE_EPT);
-	clear_cpu_cap(c, X86_FEATURE_VPID);
-	clear_cpu_cap(c, X86_FEATURE_EPT_AD);
-
-	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
-	msr_ctl = vmx_msr_high | vmx_msr_low;
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
-		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
-		set_cpu_cap(c, X86_FEATURE_VNMI);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
-		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
-		      vmx_msr_low, vmx_msr_high);
-		msr_ctl2 = vmx_msr_high | vmx_msr_low;
-		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
-		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
-			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT) {
-			set_cpu_cap(c, X86_FEATURE_EPT);
-			rdmsr(MSR_IA32_VMX_EPT_VPID_CAP,
-			      msr_ept_cap, msr_vpid_cap);
-			if (msr_ept_cap & x86_VMX_FEATURE_EPT_CAP_AD)
-				set_cpu_cap(c, X86_FEATURE_EPT_AD);
-		}
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
-			set_cpu_cap(c, X86_FEATURE_VPID);
-	}
-}
-
 #define MSR_IA32_TME_ACTIVATE		0x982
 
 /* Helpers to access TME_ACTIVATE MSR */
@@ -757,9 +711,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 
 	init_feature_control_msr(c);
 
-	if (cpu_has(c, X86_FEATURE_VMX))
-		detect_vmx_virtcap(c);
-
 	if (cpu_has(c, X86_FEATURE_TME))
 		detect_tme(c);
 
diff --git a/arch/x86/kernel/cpu/mkcapflags.sh b/arch/x86/kernel/cpu/mkcapflags.sh
index aed45b8895d5..1db560ed2ca3 100644
--- a/arch/x86/kernel/cpu/mkcapflags.sh
+++ b/arch/x86/kernel/cpu/mkcapflags.sh
@@ -6,8 +6,7 @@
 
 set -e
 
-IN=$1
-OUT=$2
+OUT=$1
 
 dump_array()
 {
@@ -15,6 +14,7 @@ dump_array()
 	SIZE=$2
 	PFX=$3
 	POSTFIX=$4
+	IN=$5
 
 	PFX_SZ=$(echo $PFX | wc -c)
 	TABS="$(printf '\t\t\t\t\t')"
@@ -57,11 +57,18 @@ trap 'rm "$OUT"' EXIT
 	echo "#endif"
 	echo ""
 
-	dump_array "x86_cap_flags" "NCAPINTS*32" "X86_FEATURE_" ""
+	dump_array "x86_cap_flags" "NCAPINTS*32" "X86_FEATURE_" "" $2
 	echo ""
 
-	dump_array "x86_bug_flags" "NBUGINTS*32" "X86_BUG_" "NCAPINTS*32"
+	dump_array "x86_bug_flags" "NBUGINTS*32" "X86_BUG_" "NCAPINTS*32" $2
+	echo ""
 
+	echo "#ifdef CONFIG_X86_VMX_FEATURE_NAMES"
+	echo "#ifndef _ASM_X86_VMXFEATURES_H"
+	echo "#include <asm/vmxfeatures.h>"
+	echo "#endif"
+	dump_array "x86_vmx_flags" "NVMXINTS*32" "VMX_FEATURE_" "" $3
+	echo "#endif /* CONFIG_X86_VMX_FEATURE_NAMES */"
 ) > $OUT
 
 trap - EXIT
diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
index cb2e49810d68..4eec8889b0ff 100644
--- a/arch/x86/kernel/cpu/proc.c
+++ b/arch/x86/kernel/cpu/proc.c
@@ -7,6 +7,10 @@
 
 #include "cpu.h"
 
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+extern const char * const x86_vmx_flags[NVMXINTS*32];
+#endif
+
 /*
  *	Get CPU information for use by the procfs.
  */
@@ -102,6 +106,17 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		if (cpu_has(c, i) && x86_cap_flags[i] != NULL)
 			seq_printf(m, " %s", x86_cap_flags[i]);
 
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+	if (cpu_has(c, X86_FEATURE_VMX) && c->vmx_capability[0]) {
+		seq_puts(m, "\nvmx flags\t:");
+		for (i = 0; i < 32*NVMXINTS; i++) {
+			if (test_bit(i, (unsigned long *)c->vmx_capability) &&
+			    x86_vmx_flags[i] != NULL)
+				seq_printf(m, " %s", x86_vmx_flags[i]);
+		}
+	}
+#endif
+
 	seq_puts(m, "\nbugs\t\t:");
 	for (i = 0; i < 32*NBUGINTS; i++) {
 		unsigned int bug_bit = 32*NCAPINTS + i;
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 01b05a4a5a85..edfc7cc4ec33 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -16,13 +16,6 @@
 #define RNG_ENABLED	(1 << 3)
 #define RNG_ENABLE	(1 << 8)	/* MSR_ZHAOXIN_RNG */
 
-#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
-#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
-#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
-#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
-#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
-#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
-
 static void init_zhaoxin_cap(struct cpuinfo_x86 *c)
 {
 	u32  lo, hi;
@@ -89,31 +82,6 @@ static void early_init_zhaoxin(struct cpuinfo_x86 *c)
 
 }
 
-static void zhaoxin_detect_vmx_virtcap(struct cpuinfo_x86 *c)
-{
-	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
-
-	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
-	msr_ctl = vmx_msr_high | vmx_msr_low;
-
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
-		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
-		set_cpu_cap(c, X86_FEATURE_VNMI);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
-		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
-		      vmx_msr_low, vmx_msr_high);
-		msr_ctl2 = vmx_msr_high | vmx_msr_low;
-		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
-		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
-			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
-			set_cpu_cap(c, X86_FEATURE_EPT);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
-			set_cpu_cap(c, X86_FEATURE_VPID);
-	}
-}
-
 static void init_zhaoxin(struct cpuinfo_x86 *c)
 {
 	early_init_zhaoxin(c);
@@ -142,9 +110,6 @@ static void init_zhaoxin(struct cpuinfo_x86 *c)
 #endif
 
 	init_feature_control_msr(c);
-
-	if (cpu_has(c, X86_FEATURE_VMX))
-		zhaoxin_detect_vmx_virtcap(c);
 }
 
 #ifdef CONFIG_X86_32
-- 
2.22.0

