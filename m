Return-Path: <linux-edac+bounces-3300-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0126A56030
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 06:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D1A1891A7C
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 05:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376C518DF6B;
	Fri,  7 Mar 2025 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Gw8AA/zt"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDC813C9A3;
	Fri,  7 Mar 2025 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326258; cv=none; b=NtWh8pde1tgeZFOnztQ49IVcrLAO3Y7ZtpeJyOU7+hXlQ8sQBsa7FpXtSfHHzZPj8m5XdeelsszbKNNtFXJuQhEI3uzORlsqHkGWBo6yNL5u05tOzJiD+3sY4rqMVa5j5ZQxB7ez86vlWBMNBJcH77vURyQv6+7zR2qGqwFuTL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326258; c=relaxed/simple;
	bh=ZOHXpr5EjoUdMxd0KS6PI80BQwNm1kjqbbGRIpSFliI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuLY+MzRx539Ka5hWbyo5amA6ExC47aAwhXyUzL1c6IV12VMHlLKd9xfmMDK4IYwZjRbnoFTPs7kMXs+Dn8yDbGng/6B3xnn/mlsBvsWL0AlfX6BpYr23r+l1i2OMCoXPUkHvkR20VBHCJGBkotjtVh7gcRizCq5h4fB1D6dlEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Gw8AA/zt; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741326252; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zNNjpjby7OEVOGOuCOx/+9vNU60KKs/GI6CHsj1/Iek=;
	b=Gw8AA/ztNQ85AetmvGmhWPIWaVv+CguWO4BVFcsMXIVRyM9n9Uva64hjw0b0VsFP5xNl71Y2Yp20zcWpDr7ZwXQTQkOEj4hpx8fePxaOvxSEk1lldv6/rb30NnhN0gr2zzrMBl6QcN/aVjZZ4UxHug+sYGktx5Qph8VJ5Zq1J2A=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQr2xBP_1741326249 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Mar 2025 13:44:10 +0800
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
Subject: [PATCH v4 3/3] mm: memory-failure: Enhance comments for return value of memory_failure()
Date: Fri,  7 Mar 2025 13:44:04 +0800
Message-ID: <20250307054404.73877-4-xueshuai@linux.alibaba.com>
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

The comments for the return value of memory_failure are not complete,
supplement the comments.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
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


