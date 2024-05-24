Return-Path: <linux-edac+bounces-1112-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F078CE323
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 11:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38D81C21BAB
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 09:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6953A85654;
	Fri, 24 May 2024 09:16:36 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A650A85628;
	Fri, 24 May 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542196; cv=none; b=l2GA5ubUEOoN1pvcShhra8HPP4uxAcXDBYLVhlO7XeNmQYCmBi3Ehpz/AfBiLhXNlLUtCO+RTG9WlPIJ9VE0fiRBsj9xPvRw8kEU/NUvCXTvBjOErEWh2bcNdwANpAkcraqjUKFyb9VbzX4lGDzQ5FktNdlSBStkDVrkMM1aWEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542196; c=relaxed/simple;
	bh=7iiGlxRymc4gE2QRmP2u15Fa02JS2c+W/SOo+UAPaHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8NaCjp4GWUV0H1Yn+p3SqikyLrVQ+Ohxh0N53XCevNJVhG0KacAcjDOijV0BPK3F08TDPxm90/tIuuqvi3HU9elx7jvabKjVveDNkILbPWXmY7gjRnXZQ0/x9jm7HfJwpF8dWK9CVPcYexBmVBH75V/IojXDWO6Ywb/1QsfTUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VlzpM0QJHzsRmy;
	Fri, 24 May 2024 17:12:43 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C485180A9C;
	Fri, 24 May 2024 17:16:26 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 17:16:26 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 01/13] mm/memory-failure: simplify put_ref_page()
Date: Fri, 24 May 2024 17:12:58 +0800
Message-ID: <20240524091310.1430048-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240524091310.1430048-1-linmiaohe@huawei.com>
References: <20240524091310.1430048-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

Remove unneeded page != NULL check. pfn_to_page() won't return NULL.
No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ac030061eda0..922c902a7229 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2150,14 +2150,10 @@ static inline unsigned long folio_free_raw_hwp(struct folio *folio, bool flag)
 /* Drop the extra refcount in case we come from madvise() */
 static void put_ref_page(unsigned long pfn, int flags)
 {
-	struct page *page;
-
 	if (!(flags & MF_COUNT_INCREASED))
 		return;
 
-	page = pfn_to_page(pfn);
-	if (page)
-		put_page(page);
+	put_page(pfn_to_page(pfn));
 }
 
 static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
-- 
2.33.0


