Return-Path: <linux-edac+bounces-3280-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80E8A54056
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 03:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C30818917EF
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1DA18DF65;
	Thu,  6 Mar 2025 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x7IIJBkI"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D22511713;
	Thu,  6 Mar 2025 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227048; cv=none; b=ZV3hvCLtlpn6LjuFCxl5L3OVX6XWeJvvSBGy26DSCitEuSQNtnfb5Km6rZzSZezIFq49n6ETkXuKhuVf4h5oBUSZnCR+r5kzzRtxV18RwjfN0dGJm92Pg5Wzbs8rFhcJlhrd4pS4soMPZ+ASikjdWwfKo92gxfI6TLF7aGXOCl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227048; c=relaxed/simple;
	bh=tXNsChP8dVm0aJbEgP7t5nD2hth2OokvSbhiKk/HZPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qy7aMlEoyswQdFckMecSv3yWNaYVO5tN74cVqyUvUFN6a8X6JaqSvSXXvR9nv4sBCM9QEyoEX4sO5fqWEd7TNP3X+SYL0O4AnX8bZuula9JmTS3duVnkLUTngDdjdqkRrTa6GxjJyy0xWBBClPbExlN8U5x46+ujlATxxw8TAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x7IIJBkI; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741227036; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1/JD5Tq5dpzFixCp5vAo+Imjs5Cylkbn9pyvuB+VoBk=;
	b=x7IIJBkI0QNLH/IrNRXcMZgEVnEjmnhgQ/JwLH4KlthuH/wrnc4Sqg0ABt74RZvog9LBevKXkfPYPDXjpoOWXsJ0LLKAZuIFINi9JAssf+WY8kMbKLXqlwAXU5wo9m7WHk05Pn7fqpW0T/xWwZm3x3cwu84hdwBE13mEBS3aWQw=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQmzy.1_1741227033 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Mar 2025 10:10:34 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: tony.luck@intel.com,
	bp@alien8.de,
	peterz@infradead.org,
	catalin.marinas@arm.com,
	yazen.ghannam@amd.com,
	akpm@linux-foundation.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jpoimboe@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v3 1/3] x86/mce: Use is_copy_from_user() to determine copy-from-user context
Date: Thu,  6 Mar 2025 10:10:29 +0800
Message-ID: <20250306021031.5538-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250306021031.5538-1-xueshuai@linux.alibaba.com>
References: <20250306021031.5538-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4c132d1d844a ("x86/futex: Remove .fixup usage") introduced a new
extable fixup type, EX_TYPE_EFAULT_REG, and commit 4c132d1d844a
("x86/futex: Remove .fixup usage") updated the extable fixup type for
copy-from-user operations, changing it from EX_TYPE_UACCESS to
EX_TYPE_EFAULT_REG. The error context for copy-from-user operations no
longer functions as an in-kernel recovery context. Consequently, the error
context for copy-from-user operations no longer functions as an in-kernel
recovery context, resulting in kernel panics with the message: "Machine
check: Data load in unrecoverable area of kernel."

The critical aspect is identifying whether the error context involves a
read from user memory. We do not care about the ex-type if we know its a
MOV reading from userspace. is_copy_from_user() return true when both of
the following conditions are met:

    - the current instruction is copy
    - source address is user memory

So, use is_copy_from_user() to determin if a context is copy user directly.

Fixes: 4c132d1d844a ("x86/futex: Remove .fixup usage")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 arch/x86/kernel/cpu/mce/severity.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index dac4d64dfb2a..cb021058165f 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -300,13 +300,12 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	copy_user  = is_copy_from_user(regs);
 	instrumentation_end();
 
-	switch (fixup_type) {
-	case EX_TYPE_UACCESS:
-		if (!copy_user)
-			return IN_KERNEL;
-		m->kflags |= MCE_IN_KERNEL_COPYIN;
-		fallthrough;
+	if (copy_user) {
+		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_COPYIN;
+		return IN_KERNEL_RECOV
+	}
 
+	switch (fixup_type) {
 	case EX_TYPE_FAULT_MCE_SAFE:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;
-- 
2.39.3


