Return-Path: <linux-edac+bounces-3845-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621BEAAD2BB
	for <lists+linux-edac@lfdr.de>; Wed,  7 May 2025 03:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B865D467E42
	for <lists+linux-edac@lfdr.de>; Wed,  7 May 2025 01:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB821D63C0;
	Wed,  7 May 2025 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8TFf5me"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DEA1A8F94;
	Wed,  7 May 2025 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746580891; cv=none; b=ih/ZSZDD9zpp23DYRi2GOviDPsFqXhm4q16PTs//0aBKbRp2jdW/nfNIwwrKry1Ub8xbhVMPsY8Ff2MitOmc+aKI5XI4BaLix3BgbU2c+wt9mJlIfrc17xu9dOf7eeplUrU+f8crzXsahthYyej+oWDgHuxI8/ZAAvtN6QcQrN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746580891; c=relaxed/simple;
	bh=rAQ3L88ydpwyxQG8W291sUzYTiqgGjWuxhg99v92Wk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmPf18XcaQsDmzMdfDRYQHPJnathqzxWwx+lSWPy5oOsL3MJ6cUUfuo0uYr/KAmPuaZVZDoZfPqAYR684W+CPHIULum15DQxD3UwpqnSlEpOFzf/DnFn3kiBo7qSJ+TjbqARSFnu14le/YQTRKRe5eiAWVJHY6fqmrgklKmkMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8TFf5me; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746580890; x=1778116890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rAQ3L88ydpwyxQG8W291sUzYTiqgGjWuxhg99v92Wk8=;
  b=J8TFf5mekJRh0RfbWYk4lhKitqrPO37K2Y+5LJL2UBL5s5iinlD+RhM0
   gd+0DZ4oCGYiMUcTdsPy2J5TKeI8S2pHGdtUqT+YSrZRQRn+lvDkwtm0K
   UNQnZa2yOTmhNigUwagquPIhHoo/arN91AD55GoGr+xYr8WdDWXhADRJ9
   q+Ts4zSIOWl4OsHRotSjTAsS2d6Zb1cq5HfUTFKO8GfGO2YY1MAeRjMjr
   LJ54sCOAJBiQvskYrbfy3R24YNTnjNyf/Ghe0Z5qX8AdnBPO3WW1a/UEC
   uBtxhmHWI8l0mC7kGtYigT3soulRCqsnJj/FPAyFlz/gDKbsClIuSvLXY
   Q==;
X-CSE-ConnectionGUID: tnlch8FyTT29FEyJsy9Odg==
X-CSE-MsgGUID: FHVQ+D62RwCmr748ecTyTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47384024"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="47384024"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 18:21:28 -0700
X-CSE-ConnectionGUID: BMLo4i+yStuGr+oqeXdgnQ==
X-CSE-MsgGUID: hl0pnGzXQjacwuZyxqyeuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="136808760"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa009.fm.intel.com with ESMTP; 06 May 2025 18:21:27 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Xin Li <xin@zytor.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Brian Gerst <brgerst@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Andi Kleen <ak@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-perf-users@vger.kernel.org,
	linux-edac@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 8/9] perf/x86: Enable NMI-source reporting for perfmon
Date: Tue,  6 May 2025 18:21:44 -0700
Message-ID: <20250507012145.2998143-9-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507012145.2998143-1-sohil.mehta@intel.com>
References: <20250507012145.2998143-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Pan <jacob.jun.pan@linux.intel.com>

Program the designated PMI NMI-source vector into the local vector table
for the PMU. An NMI for the PMU would directly invoke the PMI handler
without polling other NMI handlers, resulting in reduced PMI delivery
latency.

Co-developed-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Zeng Guang <guang.zeng@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
v5: No significant change.
---
 arch/x86/events/core.c       | 4 ++--
 arch/x86/events/intel/core.c | 6 +++---
 arch/x86/include/asm/apic.h  | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 031e908f0d61..42b270526631 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1695,7 +1695,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 	 * This generic handler doesn't seem to have any issues where the
 	 * unmasking occurs so it was left at the top.
 	 */
-	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	apic_write(APIC_LVTPC, PERF_NMI);
 
 	for_each_set_bit(idx, x86_pmu.cntr_mask, X86_PMC_IDX_MAX) {
 		if (!test_bit(idx, cpuc->active_mask))
@@ -1737,7 +1737,7 @@ void perf_events_lapic_init(void)
 	/*
 	 * Always use NMI for PMU
 	 */
-	apic_write(APIC_LVTPC, APIC_DM_NMI);
+	apic_write(APIC_LVTPC, PERF_NMI);
 }
 
 static int
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 09d2d66c9f21..87c624686c58 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3202,7 +3202,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * NMI handler.
 	 */
 	if (!late_ack && !mid_ack)
-		apic_write(APIC_LVTPC, APIC_DM_NMI);
+		apic_write(APIC_LVTPC, PERF_NMI);
 	intel_bts_disable_local();
 	cpuc->enabled = 0;
 	__intel_pmu_disable_all(true);
@@ -3239,7 +3239,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 
 done:
 	if (mid_ack)
-		apic_write(APIC_LVTPC, APIC_DM_NMI);
+		apic_write(APIC_LVTPC, PERF_NMI);
 	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
 	cpuc->enabled = pmu_enabled;
 	if (pmu_enabled)
@@ -3252,7 +3252,7 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
 	 * Haswell CPUs.
 	 */
 	if (late_ack)
-		apic_write(APIC_LVTPC, APIC_DM_NMI);
+		apic_write(APIC_LVTPC, PERF_NMI);
 	return handled;
 }
 
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9bade39b5feb..b2f864e77d84 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -29,6 +29,7 @@
 #define BT_NMI			(APIC_DM_NMI | NMIS_VECTOR_BT)
 #define KGDB_NMI		(APIC_DM_NMI | NMIS_VECTOR_KGDB)
 #define MCE_NMI			(APIC_DM_NMI | NMIS_VECTOR_MCE)
+#define PERF_NMI		(APIC_DM_NMI | NMIS_VECTOR_PMI)
 
 /*
  * Debugging macros
-- 
2.43.0


