Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B30910C178
	for <lists+linux-edac@lfdr.de>; Thu, 28 Nov 2019 02:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfK1Bks (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Nov 2019 20:40:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:10954 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbfK1BkZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 27 Nov 2019 20:40:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 17:40:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,251,1571727600"; 
   d="scan'208";a="221166522"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.41])
  by orsmga002.jf.intel.com with ESMTP; 27 Nov 2019 17:40:20 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v4 18/19] perf/x86: Provide stubs of KVM helpers for non-Intel CPUs
Date:   Wed, 27 Nov 2019 17:40:15 -0800
Message-Id: <20191128014016.4389-19-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128014016.4389-1-sean.j.christopherson@intel.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Provide stubs for perf_guest_get_msrs() and intel_pt_handle_vmx() when
building without support for Intel CPUs, i.e. CPU_SUP_INTEL=n.  Lack of
stubs is not currently a problem as the only user, KVM_INTEL, takes a
dependency on CPU_SUP_INTEL=y.  Provide the stubs for all CPUs so that
KVM_INTEL can be built for any CPU with compatible hardware support,
e.g. Centuar and Zhaoxin CPUs.

Note, the existing stub for perf_guest_get_msrs() is essentially dead
code as KVM selects CONFIG_PERF_EVENTS, i.e. the only user guarantees
the full implementation is built.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/perf_event.h | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index ee26e9215f18..29964b0e1075 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -322,17 +322,10 @@ struct perf_guest_switch_msr {
 	u64 host, guest;
 };
 
-extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
 extern void perf_check_microcode(void);
 extern int x86_perf_rdpmc_index(struct perf_event *event);
 #else
-static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
-{
-	*nr = 0;
-	return NULL;
-}
-
 static inline void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 {
 	memset(cap, 0, sizeof(*cap));
@@ -342,8 +335,23 @@ static inline void perf_events_lapic_init(void)	{ }
 static inline void perf_check_microcode(void) { }
 #endif
 
+#if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
+extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
+#else
+static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
+{
+	*nr = 0;
+	return NULL;
+}
+#endif
+
 #ifdef CONFIG_CPU_SUP_INTEL
  extern void intel_pt_handle_vmx(int on);
+#else
+static inline void intel_pt_handle_vmx(int on)
+{
+
+}
 #endif
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_AMD)
-- 
2.24.0

