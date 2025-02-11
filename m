Return-Path: <linux-edac+bounces-3013-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A26A3032A
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 07:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4753166F8B
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 06:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46DA1E5B83;
	Tue, 11 Feb 2025 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IBv4NDd/"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543961D5CD9;
	Tue, 11 Feb 2025 06:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739253731; cv=none; b=lbG7mzYbF6LgnnuPMJzANiu+Wk3AC/kk+e9p6PnuX8e1KOVzR5V+/jxRYftp3+s6ZoA4qndWXxKukkp1xGC4oKB3fG5yU17HDUzN4x7HdYH/+SbVLLWN+0RBWrhDHyWKISxMS2oUSp98hSLlUGbzsjLUF7/XJ4jCr0A+X+iWRU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739253731; c=relaxed/simple;
	bh=/cLBrEIhLQ3n08yvWEKwzxH0hYx0q6II9tU6JMD/8f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlrqxFnvMz4a4hHxmhmV5bHOy2QLqHln/AXE6yxGzwdm98NYMRGgeRYRZpXlFATITS3Hpm6szT+CSkt+kMAv7Dbx4pZBIBDetsyhVHKcwJUfFzoDRCZYaGwM9YVjxxvNoW5WaaxIJXrGGipBUP7nT1iAEgd4OFjOCpV0Is5KNj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IBv4NDd/; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739253726; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hfmiBx8OqSwf83Pjl+Ndh5ksVZvALy8DLh1zZo/PfR0=;
	b=IBv4NDd/IZMNMZ3ebccSd1/tyOAXFlXZDmAtA2WvCQZYNW4tKXLSJ5lkWDkS4cbqE1Ae/SxDxrEdbvjjTV2j3qobKEjyQZTG+2IAmWPJsxj4sHQmnPcn2tYg2rh4vJlLZ1oOriBra4dc2u1+FSaRsVZ6rsOhDwjwwBWjbT26BXU=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPFiSIJ_1739253724 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Feb 2025 14:02:05 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: tony.luck@intel.com,
	bp@alien8.de,
	nao.horiguchi@gmail.com
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linmiaohe@huawei.com,
	akpm@linux-foundation.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v1 3/4] x86/mce: add EX_TYPE_EFAULT_REG as in-kernel recovery context to fix copy-from-user operations regression
Date: Tue, 11 Feb 2025 14:01:59 +0800
Message-ID: <20250211060200.33845-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
References: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4c132d1d844a ("x86/futex: Remove .fixup usage") introduced a new
extable fixup type, EX_TYPE_EFAULT_REG, and later patches updated the
extable fixup type for copy-from-user operations, changing it from
EX_TYPE_UACCESS to EX_TYPE_EFAULT_REG.

Specifically, commit 99641e094d6c ("x86/uaccess: Remove .fixup usage")
altered the extable fixup type for the get_user family, while commit
4c132d1d844a ("x86/futex: Remove .fixup usage") addressed the futex
operations. This change inadvertently caused a regression where the error
context for some copy-from-user operations no longer functions as an
in-kernel recovery context, leading to kernel panics with the message:
"Machine check: Data load in unrecoverable area of kernel."

To fix the regression, add EX_TYPE_EFAULT_REG as a in-kernel recovery
context for copy-from-user operations.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/x86/kernel/cpu/mce/severity.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index dac4d64dfb2a..14c2d71c3ce1 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -16,6 +16,7 @@
 #include <asm/traps.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <linux/extable.h>
 
 #include "internal.h"
 
@@ -285,7 +286,8 @@ static bool is_copy_from_user(struct pt_regs *regs)
  */
 static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 {
-	int fixup_type;
+	const struct exception_table_entry *e;
+	int fixup_type, imm;
 	bool copy_user;
 
 	if ((m->cs & 3) == 3)
@@ -294,9 +296,14 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	if (!mc_recoverable(m->mcgstatus))
 		return IN_KERNEL;
 
+	e = search_exception_tables(m->ip);
+	if (!e)
+		return IN_KERNEL;
+
 	/* Allow instrumentation around external facilities usage. */
 	instrumentation_begin();
-	fixup_type = ex_get_fixup_type(m->ip);
+	fixup_type = FIELD_GET(EX_DATA_TYPE_MASK, e->data);
+	imm  = FIELD_GET(EX_DATA_IMM_MASK,  e->data);
 	copy_user  = is_copy_from_user(regs);
 	instrumentation_end();
 
@@ -304,9 +311,13 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	case EX_TYPE_UACCESS:
 		if (!copy_user)
 			return IN_KERNEL;
-		m->kflags |= MCE_IN_KERNEL_COPYIN;
-		fallthrough;
-
+		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;
+		return IN_KERNEL_RECOV;
+	case EX_TYPE_IMM_REG:
+		if (!copy_user || imm != -EFAULT)
+			return IN_KERNEL;
+		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;
+		return IN_KERNEL_RECOV;
 	case EX_TYPE_FAULT_MCE_SAFE:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;
-- 
2.39.3


