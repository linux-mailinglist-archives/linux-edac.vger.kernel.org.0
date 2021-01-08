Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84E2EFB31
	for <lists+linux-edac@lfdr.de>; Fri,  8 Jan 2021 23:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbhAHWYM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 8 Jan 2021 17:24:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:1525 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbhAHWYM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 8 Jan 2021 17:24:12 -0500
IronPort-SDR: 41bHxkV0yZQ5kXHEsm0OURGHvxKIDzeXOuMKDZc4rbMgAGripvvnEDRheWkutdHYClpCfVP8bA
 fz8RZdao0XSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="177810719"
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="177810719"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 14:22:59 -0800
IronPort-SDR: 6AZfUQRjruUiq3waI6R4k01goON3OjB2cqqQj1j2GNQRPzZpyApD/F3AYswfgMRTmeJhb6rm1s
 +vA4n6WyeXBQ==
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="423091296"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 14:22:59 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 2/2] futex, x86/mce: Avoid double machine checks
Date:   Fri,  8 Jan 2021 14:22:51 -0800
Message-Id: <20210108222251.14391-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20210108222251.14391-1-tony.luck@intel.com>
References: <20210108222251.14391-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

futex_wait_setup() first tries to read the user value with page faults
disabled (because it holds a lock, and so cannot sleep). If that read
fails it drops the lock and tries again.

But there are now two reasons why the user space read can fail. Either:
1) legacy case of a page fault, in which case it is reasonable to retry
2) machine check on the user address, bad idea to re-read

Add some infrastructure to differentiate these cases.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/mmu.h     |  7 +++++++
 arch/x86/kernel/cpu/mce/core.c | 10 ++++++++++
 include/linux/mm.h             |  4 ++++
 kernel/futex.c                 |  3 +++
 4 files changed, 24 insertions(+)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d7494631ea9..a46c78381388 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -66,4 +66,11 @@ typedef struct {
 void leave_mm(int cpu);
 #define leave_mm leave_mm
 
+#if defined(CONFIG_X86_MCE) && defined(CONFIG_MEMORY_FAILURE)
+#undef arch_memory_failure
+#define arch_memory_failure x86_memory_failure
+#endif
+
+bool x86_memory_failure(u32 __user *addr);
+
 #endif /* _ASM_X86_MMU_H */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 1bf11213e093..b27aa30290bb 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1236,6 +1236,16 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
 	*m = *final;
 }
 
+bool x86_memory_failure(u32 __user *addr)
+{
+	if (current->mce_busy == 0)
+		return false;
+
+	WARN_ON(current->mce_vaddr != addr);
+
+	return true;
+}
+
 static void kill_me_now(struct callback_head *ch)
 {
 	force_sig(SIGBUS);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecdf8a8cd6ae..470708a71dd3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3177,5 +3177,9 @@ unsigned long wp_shared_mapping_range(struct address_space *mapping,
 
 extern int sysctl_nr_trim_pages;
 
+#ifndef arch_memory_failure
+#define arch_memory_failure(vaddr)	(0)
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
diff --git a/kernel/futex.c b/kernel/futex.c
index c47d1015d759..8fa2fc854026 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2658,6 +2658,9 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 	if (ret) {
 		queue_unlock(*hb);
 
+		if (arch_memory_failure(uaddr))
+			return ret;
+
 		ret = get_user(uval, uaddr);
 		if (ret)
 			return ret;
-- 
2.21.1

