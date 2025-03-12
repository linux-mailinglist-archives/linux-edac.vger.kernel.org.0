Return-Path: <linux-edac+bounces-3351-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F087A5DB89
	for <lists+linux-edac@lfdr.de>; Wed, 12 Mar 2025 12:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D93B189AF7B
	for <lists+linux-edac@lfdr.de>; Wed, 12 Mar 2025 11:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0282823F38C;
	Wed, 12 Mar 2025 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XiiHiyJS"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C39155333;
	Wed, 12 Mar 2025 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778942; cv=none; b=SqueT6fOUF7oJ2HvGec0in1XLxDNjQvVKa9bZ5qhYe3mgOVk4wdWcSJ8B1R+oEqsOWkYosThUNoxqRB45SbZU9ihyR6vEiB5+n/HDJANMHltThdhgk9xahTKshj4Hiw4RRP04Z6KLFoEa11pamBAlEzrdzk23dJWCxXpS6BseHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778942; c=relaxed/simple;
	bh=bT/nJAXFmHd6EnGcFSBetthh2ryHhFLbX5hC7UrIWz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcsR8kpaASEdUUbs3jXnYbC67fJ0Ne2So3dzCXYYlsMnNYoGX9uJV5O/ERc7AUyCptaybiKo9QE6hEvXqi+YRXiI9xPB4OlhxF5Kp5V0gNo7qV5skeUjmeKtvF1Ve5BH02J7tHDM4fXvBGsXSKGr6Fujwf1kNiwbKU4vwrXzE9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XiiHiyJS; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741778936; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vDfxkI5giWrkXyBcohVPuoNEY+c5llJuxem0Ij3I5bc=;
	b=XiiHiyJSasEU+6GzgSOkMpeqxWs8aKhkUP8/a8RZW/3/EgoAXmRQnEuNEjj4zWl2BU3Po6pZLFvc1yc7SsKvCKX+h6k7EM0nA663hA1OJetrB4DapwAbB2sQTtZHYCHlsBT9DUQViNu3/Jkl8fIuK4NNajH2O3WtstZodvhrlzo=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WRCdv11_1741778934 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Mar 2025 19:28:54 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: akpm@linux-foundation.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com
Cc: tony.luck@intel.com,
	bp@alien8.de,
	peterz@infradead.org,
	catalin.marinas@arm.com,
	yazen.ghannam@amd.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jpoimboe@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com,
	xueshuai@linux.alibaba.com
Subject: [PATCH v4 1/3] x86/mce: Use is_copy_from_user() to determine copy-from-user context
Date: Wed, 12 Mar 2025 19:28:50 +0800
Message-ID: <20250312112852.82415-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250312112852.82415-1-xueshuai@linux.alibaba.com>
References: <20250312112852.82415-1-xueshuai@linux.alibaba.com>
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

To address this, it is crucial to identify if an error context involves a
read operation from user memory. The function is_copy_from_user() can be
utilized to determine:

    - the current operation is copy
    - when reading user memory

When these conditions are met, is_copy_from_user() will return true,
confirming that it is indeed a direct copy from user memory. This check is
essential for correctly handling the context of errors in these operations
without relying on the extable fixup types that previously allowed for
in-kernel recovery.

So, use is_copy_from_user() to determine if a context is copy user directly.

Fixes: 4c132d1d844a ("x86/futex: Remove .fixup usage")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/mce/severity.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index dac4d64dfb2a..2235a7477436 100644
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
+		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;
+		return IN_KERNEL_RECOV;
+	}
 
+	switch (fixup_type) {
 	case EX_TYPE_FAULT_MCE_SAFE:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;
-- 
2.39.3


