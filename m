Return-Path: <linux-edac+bounces-2314-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7F39B2A02
	for <lists+linux-edac@lfdr.de>; Mon, 28 Oct 2024 09:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57DF1F216D5
	for <lists+linux-edac@lfdr.de>; Mon, 28 Oct 2024 08:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933AF1917D2;
	Mon, 28 Oct 2024 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TtF0yB6N"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8DE18D620;
	Mon, 28 Oct 2024 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103124; cv=none; b=sx+Ki33u8AxflkY/XRcXJBtZmvqaoGRE3y7LQifjM7B1SrOov2/5V8aHVX491YtTH8XAa3PpVMZNBnou9K74o3FMUZh6B4xZjSqxaQ2Wb2FeVzVsJQtZAD9zulbm1ermYfk49U9K9tH0bEss6T0w3l7SEvLoKUnFqVUvFX4iCII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103124; c=relaxed/simple;
	bh=ELA/QZucgIqHVsNkbruMNGJD5BiL7kuAMB6BvqFF6yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHSiD/rLKiE69SFpUexNo3Fabi/DB5mvkGoqI93VtMOhnIKQUjYe6jVLf1n/7CvojhkBzIFGCiG5UuYxvoDWuSArfBNnell3xfU+fr9O+rFqUgjgtVNPzAnVWRMHtfpYrmJ2G+YCJi1EK64zf6DKzi5QUL9JOoYxQRpJg9MMNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TtF0yB6N; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730103119; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lVswVmzgt9DzjxQRJ6NTMkFlRkHIKa9zwgB+YGqU+A8=;
	b=TtF0yB6Nn6WSf2eqPmD2bYZSLQqEUq0WBH++5fzbMItEJ3IaM99iiI09VqeVMw+IYffTudeNYIpgGEVTU7k0u88Oqc7uQe4gTPy8QJgEMhgpSULu4CqwqOE1irJ2tE0dy7SpSBIdtn7fGeOtacmlw2E0DOzsUCLztWrKPxWek10=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WI0hO4z_1730103115 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Oct 2024 16:11:57 +0800
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
Subject: [PATCH v15 2/3] mm: memory-failure: move return value documentation to function declaration
Date: Mon, 28 Oct 2024 16:11:41 +0800
Message-ID: <20241028081142.66028-3-xueshuai@linux.alibaba.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


