Return-Path: <linux-edac+bounces-2034-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D02099C3CC
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 10:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23FB91F23F28
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 08:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA841547E4;
	Mon, 14 Oct 2024 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nDddljYk"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC63153BC1;
	Mon, 14 Oct 2024 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895393; cv=none; b=cLEiN4v1FlF8Zrugat0wsPk3HnlW18FAFQ1FvPi7QetlNNg+HmrzFvwxpHgwLJqNLM/NyjPcn5if73dSKQkIfRjK3WjpKiYndFk/YHcsfRc/jYUPiW49cCpdI+n6/h9Ls9VjS1gi9zAND0OKJun3SeYhTxtJWijT84i7YWkhwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895393; c=relaxed/simple;
	bh=NGGDrH//X7AoU0Bda2USdF3FK0Q58RbV+JuWpG44u9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ok8ghooPfiQ5KDIgzaDEeVz8RIy1dAm7FzP3egmRPGt/a20Hzi2lhfjRrOFAl23O7fRtsS2H7LxQNtBazv9R7ge8QtCKi4dgwQvw8r7hV/sxAyFuuPLFBvgU9PLS78fdqr/7wqsILqOkrLF6oH4yM7IMBIOjI/tBp763u9fX4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nDddljYk; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728895383; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gi2Mk7pPvTjLfm2Z0QyVj0/hlMnQaCSItYm0DF+izdc=;
	b=nDddljYkPcja4HPt+SNVKm04T1Nm1/EPO2HdvUmpulbc35v2oYSlKBAq+DVzICY07p5VsYRBCsR0iRQE3dYno3zhkPZGUcmfn2NS7GvT5Wu9nqjcyiEc2ff97Ks7Z/U5zNH2mz8wYu41vJWe61fb6OdK21R+UHr1lrZY7OkSbVc=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WH3mwU6_1728895378 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 16:43:00 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: mark.rutland@arm.com,
	catalin.marinas@arm.com,
	mingo@redhat.com,
	robin.murphy@arm.com,
	Jonathan.Cameron@Huawei.com,
	bp@alien8.de,
	rafael@kernel.org,
	wangkefeng.wang@huawei.com,
	tanxiaofei@huawei.com,
	mawupeng1@huawei.com,
	tony.luck@intel.com,
	linmiaohe@huawei.com,
	naoya.horiguchi@nec.com,
	james.morse@arm.com,
	tongtiangen@huawei.com,
	gregkh@linuxfoundation.org,
	will@kernel.org,
	jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-edac@vger.kernel.org,
	x86@kernel.org,
	xueshuai@linux.alibaba.com,
	justin.he@arm.com,
	ardb@kernel.org,
	ying.huang@intel.com,
	ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com,
	tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	lenb@kernel.org,
	hpa@zytor.com,
	robert.moore@intel.com,
	lvying6@huawei.com,
	xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: [PATCH v14 2/3] mm: memory-failure: move return value documentation to function declaration
Date: Mon, 14 Oct 2024 16:42:39 +0800
Message-ID: <20241014084240.18614-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Part of return value comments for memory_failure() were originally
documented at the call site. Move those comments to the function
declaration to improve code readability and to provide developers with
immediate access to function usage and return information.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/mce/core.c | 7 -------
 mm/memory-failure.c            | 9 ++++++---
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2a938f429c4d..c90d8fcd246a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1373,13 +1373,6 @@ static void kill_me_maybe(struct callback_head *cb)
 		return;
 	}
 
-	/*
-	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
-	 * to the current process with the proper error info,
-	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
-	 *
-	 * In both cases, no further processing is required.
-	 */
 	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
 		return;
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 96ce31e5a203..1c5098f32d48 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2209,9 +2209,12 @@ static void kill_procs_now(struct page *p, unsigned long pfn, int flags,
  * Must run in process context (e.g. a work queue) with interrupts
  * enabled and no spinlocks held.
  *
- * Return: 0 for successfully handled the memory error,
- *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
- *         < 0(except -EOPNOTSUPP) on failure.
+ * Return:
+ *   0             - success,
+ *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event,
+ *   -EHWPOISON    - the page was already poisoned, potentially
+ *                   kill process,
+ *   other negative values - failure.
  */
 int memory_failure(unsigned long pfn, int flags)
 {
-- 
2.39.3


