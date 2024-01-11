Return-Path: <linux-edac+bounces-335-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BEC82B00C
	for <lists+linux-edac@lfdr.de>; Thu, 11 Jan 2024 14:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6191F22047
	for <lists+linux-edac@lfdr.de>; Thu, 11 Jan 2024 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6AD3C497;
	Thu, 11 Jan 2024 13:56:05 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B811217989;
	Thu, 11 Jan 2024 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4T9mQH0QMSzNkcv;
	Thu, 11 Jan 2024 21:55:19 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 02BA514011B;
	Thu, 11 Jan 2024 21:55:58 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 21:55:56 +0800
From: Tong Tiangen <tongtiangen@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <wangkefeng.wang@huawei.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Tony Luck <tony.luck@intel.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton
	<akpm@linux-foundation.org>, Naoya Horiguchi <naoya.horiguchi@nec.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-mm@kvack.org>, Tong Tiangen <tongtiangen@huawei.com>, Guohanjun
	<guohanjun@huawei.com>
Subject: [PATCH -next v4 1/3] x86/mce: remove redundant fixup type EX_TYPE_COPY
Date: Thu, 11 Jan 2024 21:55:46 +0800
Message-ID: <20240111135548.3207437-2-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111135548.3207437-1-tongtiangen@huawei.com>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)

In commit 034ff37d3407 ("x86: rewrite '__copy_user_nocache' function"),
rewrited __copy_user_nocache() uses EX_TYPE_UACCESS instead of
EX_TYPE_COPY，this change does not broken the MC safe copy for
__copy_user_nocache(), but as a result, there's no place for EX_TYPE_COPY
to use. Therefore, we remove the definition of EX_TYPE_COPY.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/x86/include/asm/asm.h                 |  3 ---
 arch/x86/include/asm/extable_fixup_types.h | 23 +++++++++++-----------
 arch/x86/kernel/cpu/mce/severity.c         |  1 -
 arch/x86/mm/extable.c                      |  9 ---------
 4 files changed, 11 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index fbcfec4dc4cc..692409ea0c37 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -215,9 +215,6 @@ register unsigned long current_stack_pointer asm(_ASM_SP);
 #define _ASM_EXTABLE_UA(from, to)				\
 	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_UACCESS)
 
-#define _ASM_EXTABLE_CPY(from, to)				\
-	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_COPY)
-
 #define _ASM_EXTABLE_FAULT(from, to)				\
 	_ASM_EXTABLE_TYPE(from, to, EX_TYPE_FAULT)
 
diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index fe6312045042..787916ec1e12 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -36,18 +36,17 @@
 #define	EX_TYPE_DEFAULT			 1
 #define	EX_TYPE_FAULT			 2
 #define	EX_TYPE_UACCESS			 3
-#define	EX_TYPE_COPY			 4
-#define	EX_TYPE_CLEAR_FS		 5
-#define	EX_TYPE_FPU_RESTORE		 6
-#define	EX_TYPE_BPF			 7
-#define	EX_TYPE_WRMSR			 8
-#define	EX_TYPE_RDMSR			 9
-#define	EX_TYPE_WRMSR_SAFE		10 /* reg := -EIO */
-#define	EX_TYPE_RDMSR_SAFE		11 /* reg := -EIO */
-#define	EX_TYPE_WRMSR_IN_MCE		12
-#define	EX_TYPE_RDMSR_IN_MCE		13
-#define	EX_TYPE_DEFAULT_MCE_SAFE	14
-#define	EX_TYPE_FAULT_MCE_SAFE		15
+#define	EX_TYPE_CLEAR_FS		 4
+#define	EX_TYPE_FPU_RESTORE		 5
+#define	EX_TYPE_BPF			 6
+#define	EX_TYPE_WRMSR			 7
+#define	EX_TYPE_RDMSR			 8
+#define	EX_TYPE_WRMSR_SAFE		 9 /* reg := -EIO */
+#define	EX_TYPE_RDMSR_SAFE		10 /* reg := -EIO */
+#define	EX_TYPE_WRMSR_IN_MCE		11
+#define	EX_TYPE_RDMSR_IN_MCE		12
+#define	EX_TYPE_DEFAULT_MCE_SAFE	13
+#define	EX_TYPE_FAULT_MCE_SAFE		14
 
 #define	EX_TYPE_POP_REG			16 /* sp += sizeof(long) */
 #define EX_TYPE_POP_ZERO		(EX_TYPE_POP_REG | EX_DATA_IMM(0))
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index c4477162c07d..bca780fa5e57 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -290,7 +290,6 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 
 	switch (fixup_type) {
 	case EX_TYPE_UACCESS:
-	case EX_TYPE_COPY:
 		if (!copy_user)
 			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 271dcb2deabc..2354c0156e51 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -163,13 +163,6 @@ static bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 	return ex_handler_default(fixup, regs);
 }
 
-static bool ex_handler_copy(const struct exception_table_entry *fixup,
-			    struct pt_regs *regs, int trapnr)
-{
-	WARN_ONCE(trapnr == X86_TRAP_GP, "General protection fault in user access. Non-canonical address?");
-	return ex_handler_fault(fixup, regs, trapnr);
-}
-
 static bool ex_handler_msr(const struct exception_table_entry *fixup,
 			   struct pt_regs *regs, bool wrmsr, bool safe, int reg)
 {
@@ -267,8 +260,6 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 		return ex_handler_fault(e, regs, trapnr);
 	case EX_TYPE_UACCESS:
 		return ex_handler_uaccess(e, regs, trapnr, fault_addr);
-	case EX_TYPE_COPY:
-		return ex_handler_copy(e, regs, trapnr);
 	case EX_TYPE_CLEAR_FS:
 		return ex_handler_clear_fs(e, regs);
 	case EX_TYPE_FPU_RESTORE:
-- 
2.25.1


