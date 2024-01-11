Return-Path: <linux-edac+bounces-334-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9EF82B009
	for <lists+linux-edac@lfdr.de>; Thu, 11 Jan 2024 14:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD41B1C221AF
	for <lists+linux-edac@lfdr.de>; Thu, 11 Jan 2024 13:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD203A8EE;
	Thu, 11 Jan 2024 13:56:04 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB86364A9;
	Thu, 11 Jan 2024 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4T9mQ92wXWz1Q7fB;
	Thu, 11 Jan 2024 21:55:13 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (unknown [7.193.23.234])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CAAD14011B;
	Thu, 11 Jan 2024 21:55:59 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 21:55:57 +0800
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
Subject: [PATCH -next v4 2/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to MCE_IN_KERNEL_COPY_MC
Date: Thu, 11 Jan 2024 21:55:47 +0800
Message-ID: <20240111135548.3207437-3-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111135548.3207437-1-tongtiangen@huawei.com>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)

In the x86 mce processing, macro MCE_IN_KERNEL_COPYIN is used to identify
copied from user. do_machine_check() uses this flag to isolate posion
page in memory_failure(). there's nothing wrong but we can expand the use
of this macro.

Currently, there are some kernel memory copy scenarios is also mc safe
which use copy_mc_to_kernel() or copy_mc_user_highpage(). In these
scenarios, posion pages need to be isolated too. Therefore, a macro similar
to MCE_IN_KERNEL_COPYIN is required. For this reason, we can rename
MCE_IN_KERNEL_COPYIN to MCE_IN_KERNEL_COPY_MC, the new macro can be applied
to both user-to-kernel mc safe copy and kernel-to-kernel mc safe copy.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/x86/include/asm/mce.h         | 8 ++++----
 arch/x86/kernel/cpu/mce/core.c     | 2 +-
 arch/x86/kernel/cpu/mce/severity.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index de3118305838..cb628ab2f32f 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -151,11 +151,11 @@
 
 /*
  * Indicates an MCE that happened in kernel space while copying data
- * from user. In this case fixup_exception() gets the kernel to the
- * error exit for the copy function. Machine check handler can then
- * treat it like a fault taken in user mode.
+ * from user or kernel. In this case fixup_exception() gets the kernel
+ * to the error exit for the copy function. Machine check handler can
+ * then treat it like a fault taken in user or kernel mode.
  */
-#define MCE_IN_KERNEL_COPYIN	BIT_ULL(7)
+#define MCE_IN_KERNEL_COPY_MC	BIT_ULL(7)
 
 /*
  * This structure contains all data related to the MCE log.  Also
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2bfd0e3c62e4..bd1a31ed148b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1607,7 +1607,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 				mce_panic("Failed kernel mode recovery", &m, msg);
 		}
 
-		if (m.kflags & MCE_IN_KERNEL_COPYIN)
+		if (m.kflags & MCE_IN_KERNEL_COPY_MC)
 			queue_task_work(&m, msg, kill_me_never);
 	}
 
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index bca780fa5e57..df67a7a13034 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -292,7 +292,7 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	case EX_TYPE_UACCESS:
 		if (!copy_user)
 			return IN_KERNEL;
-		m->kflags |= MCE_IN_KERNEL_COPYIN;
+		m->kflags |= MCE_IN_KERNEL_COPY_MC;
 		fallthrough;
 
 	case EX_TYPE_FAULT_MCE_SAFE:
-- 
2.25.1


