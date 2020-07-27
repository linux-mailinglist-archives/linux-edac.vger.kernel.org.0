Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF84122E4F3
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 06:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgG0EcL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 00:32:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:24190 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgG0EcK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 00:32:10 -0400
IronPort-SDR: PGLO3TRlfbAwYKZ/pApuuOMh5MGzxLsN4ci+HKggEhaTJbrOQOKhLSiZfc8pkwspoHoDQb29sP
 jlo8KjwHDceQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="131016893"
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="131016893"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 21:32:09 -0700
IronPort-SDR: EFguC1D63IEEvtnJE+miNIFEqv9bA3khDlh+AQAb/WX3f0F1SHb1Worytt0+MdZLvG0EoMZ5j4
 wblJXTIVkCug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="scan'208";a="329550040"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2020 21:32:09 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Cathy Zhang <cathy.zhang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH 3/4] x86/cpu: Refactor sync_core() for readability
Date:   Sun, 26 Jul 2020 21:31:31 -0700
Message-Id: <20200727043132.15082-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
References: <20200727043132.15082-1-ricardo.neri-calderon@linux.intel.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Instead of having #ifdef/#endif blocks inside sync_core() for X86_64 and
X86_32, implement the new function iret_to_self() with two versions.

In this manner, avoid having to use even more more #ifdef/#endif blocks
when adding support for SERIALIZE in sync_core().

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cathy Zhang <cathy.zhang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kyung Min Park <kyung.min.park@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
---
 arch/x86/include/asm/special_insns.h |  1 -
 arch/x86/include/asm/sync_core.h     | 56 ++++++++++++++++------------
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index eb8e781c4353..59a3e13204c3 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -234,7 +234,6 @@ static inline void clwb(volatile void *__p)
 
 #define nop() asm volatile ("nop")
 
-
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index 9c5573f2c333..fdb5b356e59b 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -6,6 +6,37 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 
+#ifdef CONFIG_X86_32
+static inline void iret_to_self(void)
+{
+	asm volatile (
+		"pushfl\n\t"
+		"pushl %%cs\n\t"
+		"pushl $1f\n\t"
+		"iret\n\t"
+		"1:"
+		: ASM_CALL_CONSTRAINT : : "memory");
+}
+#else
+static inline void iret_to_self(void)
+{
+	unsigned int tmp;
+
+	asm volatile (
+		"mov %%ss, %0\n\t"
+		"pushq %q0\n\t"
+		"pushq %%rsp\n\t"
+		"addq $8, (%%rsp)\n\t"
+		"pushfq\n\t"
+		"mov %%cs, %0\n\t"
+		"pushq %q0\n\t"
+		"pushq $1f\n\t"
+		"iretq\n\t"
+		"1:"
+		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
+}
+#endif /* CONFIG_X86_32 */
+
 /*
  * This function forces the icache and prefetched instruction stream to
  * catch up with reality in two very specific cases:
@@ -44,30 +75,7 @@ static inline void sync_core(void)
 	 * Like all of Linux's memory ordering operations, this is a
 	 * compiler barrier as well.
 	 */
-#ifdef CONFIG_X86_32
-	asm volatile (
-		"pushfl\n\t"
-		"pushl %%cs\n\t"
-		"pushl $1f\n\t"
-		"iret\n\t"
-		"1:"
-		: ASM_CALL_CONSTRAINT : : "memory");
-#else
-	unsigned int tmp;
-
-	asm volatile (
-		"mov %%ss, %0\n\t"
-		"pushq %q0\n\t"
-		"pushq %%rsp\n\t"
-		"addq $8, (%%rsp)\n\t"
-		"pushfq\n\t"
-		"mov %%cs, %0\n\t"
-		"pushq %q0\n\t"
-		"pushq $1f\n\t"
-		"iretq\n\t"
-		"1:"
-		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
-#endif
+	iret_to_self();
 }
 
 /*
-- 
2.17.1

