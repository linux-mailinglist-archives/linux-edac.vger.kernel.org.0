Return-Path: <linux-edac+bounces-3282-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBCDA5405A
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 03:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68466168AEE
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 02:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC51191461;
	Thu,  6 Mar 2025 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GATmpJ/z"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA018DB05;
	Thu,  6 Mar 2025 02:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227049; cv=none; b=VIDu3QWsN2Qd8M01NmN0CN8yGX8B/7bFHOvEBr/Xyn0gOq5fcoFklGLnxliq2DHWHfxejY4x8Sb0pMem2DUZrDn/yV0/q3qjXwwm5j+9/MZf8LJuWPEUh4hLErbcrYfj4Q1r1dP4OMSTZbBzjdl6Fh+PPdQJ3rmspi1L6O+Y5jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227049; c=relaxed/simple;
	bh=ZOHXpr5EjoUdMxd0KS6PI80BQwNm1kjqbbGRIpSFliI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8B5CTil71TqF/CheTsDui8X6MG3VDf62zEj1kdBC+dTxN4v3Viyrg0YH0viLUGhT70QXmYgZ93ihUqpqcyPMKG7vW0oqllCLZ2gYiHDbLnaL7PtkWkJVm4xF2af1Xgwv43JLkxRRDuR/WGEgq05dElv1h3YhUkCeURloMvDQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GATmpJ/z; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741227039; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zNNjpjby7OEVOGOuCOx/+9vNU60KKs/GI6CHsj1/Iek=;
	b=GATmpJ/z18XaQ835Tf33p+yR/ngR0R5TiVsrb1U28BN4p6D7CiuNKpKvTseRRmp/hZZTHXBBA9apGHiX1lgvvFcdBe/zLTNjMwxLBP9yW8JX1qd4EYcXFbfEjRHn4/odFHKkSmTvf63HwcBEOrtQrFDq1Mol5x20PCI6rrfdOUo=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQmzy09_1741227036 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Mar 2025 10:10:36 +0800
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
Subject: [PATCH v3 3/3] mm: memory-failure: Enhance comments for return value of memory_failure()
Date: Thu,  6 Mar 2025 10:10:31 +0800
Message-ID: <20250306021031.5538-4-xueshuai@linux.alibaba.com>
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


