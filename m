Return-Path: <linux-edac+bounces-3304-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669CEA56050
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 06:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87566176B87
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 05:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D17192D76;
	Fri,  7 Mar 2025 05:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D/v5RpLb"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6556E28E3F;
	Fri,  7 Mar 2025 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326572; cv=none; b=QuWkTpMohX1SEpEqVToSXervRPt9qFT6A/kR1Ob/Pk5N847+Y5v24yMIrNxkEy4CLapgTg2zRxLgEIu4nGlsxNwiAklzUOjoSS28zXCf/pbSIr+6/zr6eLxKKv/RRVtoENnyWPuJ6ArHNv9IHpx/0WQmj+3K4URyUQ1V9z/4fCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326572; c=relaxed/simple;
	bh=P6QAQ54eZulQcij2xqoV0oSuiL2BZq3nrX3IUmugRTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnYI7E+vcitG45M8HYDtw4hPSZjCZqIl5EeH6TzFsSWLJ/WQ3nW1vM+pvFLBOoMslirovXbjS3XJdi019jjAp774+aWUTy4dSM47lHofh1ulSKBgCPecRi75YNQUhYJIU0MuTYqONWw4Zhj1+HoZcDFfwGQnNtcGolmbItfEda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D/v5RpLb; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741326567; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PW2KZ+lavZ5umj4nb4wShks/jgrzv4LZ8z+hqADlg6Y=;
	b=D/v5RpLb76WqB8indMjFaMfUkLmVJEvuHBLQrzMLk7HCaODKfL9xVPXjvBldGEfwVfLQhkaPo6vdsAZfLCct4XW2xPYaxQ+OtML+ZLm94ln3BDTlZXDUovSNL4QoOu5jc9h56lZQyK8N4AQMlSlWwkyKMmqwD3XNweYCJrFa+a0=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQr2xAj_1741326247 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Mar 2025 13:44:07 +0800
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
	tianruidong@linux.alibaba.com,
	xueshuai@linux.alibaba.com
Subject: [PATCH v4 1/3] x86/mce: Use is_copy_from_user() to determine copy-from-user context
Date: Fri,  7 Mar 2025 13:44:02 +0800
Message-ID: <20250307054404.73877-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250307054404.73877-1-xueshuai@linux.alibaba.com>
References: <20250307054404.73877-1-xueshuai@linux.alibaba.com>
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


