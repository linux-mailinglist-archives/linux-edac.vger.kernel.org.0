Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C3F281CC8
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 22:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgJBURl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 16:17:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:14522 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgJBURf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 16:17:35 -0400
IronPort-SDR: jANedMYXm+jQXwtKpLBjXrYN0rurv5cCM8CisQZT3ahIhLvXQKuzIGhcALRW6fCHR/BYeXYPWs
 U1a2Wn3ktfvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="227197753"
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="227197753"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 13:17:33 -0700
IronPort-SDR: ZKdw9NOqU9qw70x/kHYhCUkvzh66of7qE2GeNN7sZh4TvnshK9r6n1KJZFGq6xPaqvwc9wivj1
 R14akpLdK+cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="385960870"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga001.jf.intel.com with ESMTP; 02 Oct 2020 13:17:33 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH 3/3] x86/mce: include type of core when reporting a machine check error
Date:   Fri,  2 Oct 2020 13:19:31 -0700
Message-Id: <20201002201931.2826-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com>
References: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

In hybrid parts, each type of core reports different types of machine check
errors as the machine check error blocks are tied to different parts of the
hardware. Furthermore, errors may be different across micro-architecture
versions. Thus, in order to decode errors, userspace tools need to know the
type of core as well as the native model ID of the CPU which reported the
error.

This extra information is only included in the error report only when
running on hybrid parts. This conserves the existing behavior when running
on non-hybrid parts. Hence, legacy userspace tools running on new kernels
and hybrid hardware can still understand the format of the reported error
format.

Cc: "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/uapi/asm/mce.h | 1 +
 arch/x86/kernel/cpu/mce/core.c  | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index db9adc081c5a..e730572186d6 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -36,6 +36,7 @@ struct mce {
 	__u64 ppin;		/* Protected Processor Inventory Number */
 	__u32 microcode;	/* Microcode revision */
 	__u64 kflags;		/* Internal kernel use */
+	__u32 hybrid_info;	/* Type and native model ID in hybrid parts */
 };
 
 #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a6ff407dec71..ecac8d9b6070 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -143,6 +143,9 @@ noinstr void mce_setup(struct mce *m)
 	m->apicid = cpu_data(m->extcpu).initial_apicid;
 	m->mcgcap = __rdmsr(MSR_IA32_MCG_CAP);
 
+	if (this_cpu_has(X86_FEATURE_HYBRID_CPU))
+		m->hybrid_info = cpuid_eax(0x1a);
+
 	if (this_cpu_has(X86_FEATURE_INTEL_PPIN))
 		m->ppin = __rdmsr(MSR_PPIN);
 	else if (this_cpu_has(X86_FEATURE_AMD_PPIN))
@@ -264,6 +267,10 @@ static void __print_mce(struct mce *m)
 	pr_emerg(HW_ERR "PROCESSOR %u:%x TIME %llu SOCKET %u APIC %x microcode %x\n",
 		m->cpuvendor, m->cpuid, m->time, m->socketid, m->apicid,
 		m->microcode);
+
+	if (this_cpu_has(X86_FEATURE_HYBRID_CPU))
+		pr_emerg(HW_ERR "HYBRID_TYPE %x HYBRID_NATIVE_MODEL_ID %x\n",
+			 m->hybrid_info >> 24, m->hybrid_info & 0xffffff);
 }
 
 static void print_mce(struct mce *m)
-- 
2.17.1

