Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982542F221A
	for <lists+linux-edac@lfdr.de>; Mon, 11 Jan 2021 22:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbhAKVqU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 Jan 2021 16:46:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:20892 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731244AbhAKVqU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 Jan 2021 16:46:20 -0500
IronPort-SDR: SX9KRNCcOaCwHv2YBWGvMQP2KuzFy6EBTk+2zKJdemiIurw0jmzmRz6dnpZYe3BBTE4beRiTcU
 W4s9/9iwIm9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="177166210"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="177166210"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 13:45:08 -0800
IronPort-SDR: X4mXz3V4ZwtebLI/yZy2KXfk+qBWTED9qqdPXsjYD5tqRiH2UoJ4SxqZD1LZhzSpKaqg9IWTRL
 4b6bbRJwj8pw==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352760868"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 13:45:08 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 2/3] x86/mce: Add new return value to get_user() for machine check
Date:   Mon, 11 Jan 2021 13:44:51 -0800
Message-Id: <20210111214452.1826-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20210111214452.1826-1-tony.luck@intel.com>
References: <20210108222251.14391-1-tony.luck@intel.com>
 <20210111214452.1826-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When an exception occurs during any of the get_user() functions
fixup_exception() passes the trap number of the exception in regs->ax
to the fixup code.

Check for X86_TRAP_MC and return -ENXIO ("No such device or address")
so that callers can take action to avoid repeating an access to an
address that has an uncorrectable error.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/lib/getuser.S | 8 +++++++-
 arch/x86/mm/extable.c  | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index fa1bc2104b32..c49a449fced6 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -17,7 +17,7 @@
  *
  * Inputs:	%[r|e]ax contains the address.
  *
- * Outputs:	%[r|e]ax is error code (0 or -EFAULT)
+ * Outputs:	%[r|e]ax is error code (0 or -EFAULT or -ENXIO)
  *		%[r|e]dx contains zero-extended value
  *		%ecx contains the high half for 32-bit __get_user_8
  *
@@ -34,6 +34,7 @@
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/export.h>
+#include <asm/trapnr.h>
 
 #define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence", X86_FEATURE_LFENCE_RDTSC
 
@@ -168,8 +169,13 @@ SYM_CODE_START_LOCAL(.Lbad_get_user_clac)
 	ASM_CLAC
 bad_get_user:
 	xor %edx,%edx
+	cmpl $X86_TRAP_MC,%eax
+	je mce_get_user
 	mov $(-EFAULT),%_ASM_AX
 	ret
+mce_get_user:
+	mov $(-ENXIO),%_ASM_AX
+	ret
 SYM_CODE_END(.Lbad_get_user_clac)
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index b93d6cd08a7f..ac4fcb820c40 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -77,6 +77,7 @@ __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 {
 	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
 	regs->ip = ex_fixup_addr(fixup);
+	regs->ax = trapnr;
 	return true;
 }
 EXPORT_SYMBOL(ex_handler_uaccess);
-- 
2.21.1

