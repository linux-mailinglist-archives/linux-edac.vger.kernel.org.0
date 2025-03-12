Return-Path: <linux-edac+bounces-3353-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD6A5DB8E
	for <lists+linux-edac@lfdr.de>; Wed, 12 Mar 2025 12:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8051A189C390
	for <lists+linux-edac@lfdr.de>; Wed, 12 Mar 2025 11:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE1324168A;
	Wed, 12 Mar 2025 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l+osHe5E"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0917E240611;
	Wed, 12 Mar 2025 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778947; cv=none; b=i2qWBfrCPyEPt3YU/MKRzzrWciOWUGqylLu7bzAUoKejacr/p1/fWeFGX763n+RrQ+OLe64+/U6RGPsnQv6+xlnC81sqsRlo/4Z6mh45FB4xnNELlndImuW3tN5Y4TZe0NHNgISkH2xVWwKpoSEJnlhp9yr4/mgPQUKybVue7oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778947; c=relaxed/simple;
	bh=1B0zyuHbHYrUKZmiLC1az+QZbD/z8RspdhdW/A2QVtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWMU63j0HNMJb9+1/7GYU0GYZahDc2NHvqz/U2io3qHOEsp9Yu7NH4oj2OnPYZ3qhVP9a03MJAfbcdgCUGsgMpmS6KCkRRCrQknR5xsF3thsuh0AgEuPe+KRh9H/MDUQoFJMyZylA1jd+X6j6KaSRSwnNUBuV0BPGlPkJnHwixs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=l+osHe5E; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741778937; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=R4Y2pmrTYmO5bH57hWQGBotlkwzT7/jOJNJhq77FZVM=;
	b=l+osHe5E+0x5kCoyi8YGZ0mXf1/uREkuaJcqA2kJcZ5Ho4EG/+9mToEviln35roYuyOtXNX14tzoodWdO0KLWOIacPW1zbAj9E0clrUZO08pV6DRXtMKOLPQpO7QV0xsYjV4VnA2Kjpf0DEPs3qVJytouyUCre3xXii1wz9tsr4=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WRCdv1i_1741778935 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Mar 2025 19:28:56 +0800
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
Subject: [PATCH v4 3/3] mm: memory-failure: Enhance comments for return value of memory_failure()
Date: Wed, 12 Mar 2025 19:28:52 +0800
Message-ID: <20250312112852.82415-4-xueshuai@linux.alibaba.com>
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

The comments for the return value of memory_failure are not complete,
supplement the comments.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Tested-by: Tony Luck <tony.luck@intel.com>
---
 mm/memory-failure.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

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


