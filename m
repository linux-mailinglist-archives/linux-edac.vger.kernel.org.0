Return-Path: <linux-edac+bounces-3098-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC741A37B72
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 07:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCA41887569
	for <lists+linux-edac@lfdr.de>; Mon, 17 Feb 2025 06:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8110199FDE;
	Mon, 17 Feb 2025 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WSjrr6uD"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE019047A;
	Mon, 17 Feb 2025 06:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774029; cv=none; b=cuGicNt+3t/wvYEpelXrc4Tpv29XwOJbgNMQUTCGBPaDkNGkDzuPj95qIHbOu+j58ZbfVR6sgbkZBMo7BnVN8B/SAyKg5QeAc3re3TRYOYXJSPPpnM6ExsKU/7jTeO9+uhDV85qShPwQ8PDmcyoYg3x7imB43dm4JvOP2EuQiUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774029; c=relaxed/simple;
	bh=XfWvdGo8JigBXRfzGH+PwrHhrntmXaWle3GN74VrVSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbNawDibdTR6OEm1HpxdzmVINvdxq2ydLXm+2V+pZyYUJsBQp1zXS8xKwKm1mSUncydbZKuaSwjPddFMTnAc53w4PWdX+mozaiCnNhY/RhJPD+ryM3J5elSZzd3xu1v0pSC/KpmTqu5OTPgsnWy927TZCtSWb96BySzCl0n6v7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WSjrr6uD; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739774024; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=2HAfRf79L/SPv5Q+bga3YvpNIcG3LqJbC8lB0lpSzQc=;
	b=WSjrr6uDIeBpDzPLGd+hZDrC1F6HOTHsOniX4O9MlXYAHQK0NukIXxdeHPEFi15ZVZMVxvfwIqA/zOvie7RzO3K4qSAm4oPCfZyfkO/bjsYgeaDMY0Oj9c0aJ3OpV8w/ui6gJVVxzMgcbfQSwQL/2kDCnKPB8lFmzuMBGsozaWg=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPb1mQt_1739774022 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 14:33:43 +0800
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
	peterz@infradead.org,
	jpoimboe@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v2 5/5] mm: memory-failure: move return value documentation to function declaration
Date: Mon, 17 Feb 2025 14:33:35 +0800
Message-ID: <20250217063335.22257-6-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
---
 arch/x86/kernel/cpu/mce/core.c |  7 -------
 mm/memory-failure.c            | 10 +++++++---
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index c1b945dbccdf..c81695f320bc 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1403,13 +1403,6 @@ static void kill_me_maybe(struct callback_head *cb)
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
index b037952565be..8649849bcdb4 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2216,9 +2216,13 @@ static void kill_procs_now(struct page *p, unsigned long pfn, int flags,
  * Must run in process context (e.g. a work queue) with interrupts
  * enabled and no spinlocks held.
  *
- * Return: 0 for successfully handled the memory error,
- *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
- *         < 0(except -EOPNOTSUPP) on failure.
+ * Return:
+ *   0             - success,
+ *   -ENXIO        - memory not managed by the kernel
+ *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event,
+ *   -EHWPOISON    - the page was already poisoned, potentially
+ *                   kill process,
+ *   other negative values - failure.
  */
 int memory_failure(unsigned long pfn, int flags)
 {
-- 
2.39.3


