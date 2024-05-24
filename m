Return-Path: <linux-edac+bounces-1115-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BBD8CE328
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 11:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C801F22BCB
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 09:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C8E85939;
	Fri, 24 May 2024 09:16:37 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D165A85634;
	Fri, 24 May 2024 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542196; cv=none; b=VFFKWIW7RGmR/X7yA39gzHZxmyJ/YdKzL4oIII2YC5Bx+jSQW4nT4M4UOLNN7mhaE7xfmUWmFAOmy2qJLFZ57Q8zf1NitaI7qKhkYGJrWz68/2q8xf0EdTdyItb6Sum8maU6Tn6a6MH8143bq11/R9rfUYuJqYIKFqv0U9AZt5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542196; c=relaxed/simple;
	bh=QM21hj2Jz5wBPhDuCLolpQBGMoHySqd7jjYhrdKlfoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2bfhdTj+1dIX3QL9V8MPwuG50xrBBJDvgRQYfiLpq5Sbh5IwLZ+Q9SsmufZjWUFDIP3DCZUvxOdE9tW1lKWrP75Q83oh3NkgLEEgqYIm3JhhmW0ARTDR+XGpcGm+Xxkiv4MxL7/aA3JisnZ740E/CMLQTmmIrhdGLdUQwalplU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Vlzpk0WFPz2cMp9;
	Fri, 24 May 2024 17:13:02 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F42714037C;
	Fri, 24 May 2024 17:16:32 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 17:16:31 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 13/13] mm/memory-failure: correct comment in me_swapcache_dirty
Date: Fri, 24 May 2024 17:13:10 +0800
Message-ID: <20240524091310.1430048-14-linmiaohe@huawei.com>
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

Dirty swap cache page could live both in page table (not page cache) and
swap cache when freshly swapped in. Correct comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b6bdb4e2834a..16bf67ffa56a 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1150,7 +1150,7 @@ static int me_pagecache_dirty(struct page_state *ps, struct page *p)
  * Clean and dirty swap cache.
  *
  * Dirty swap cache page is tricky to handle. The page could live both in page
- * cache and swap cache(ie. page is freshly swapped in). So it could be
+ * table and swap cache(ie. page is freshly swapped in). So it could be
  * referenced concurrently by 2 types of PTEs:
  * normal PTEs and swap PTEs. We try to handle them consistently by calling
  * try_to_unmap(!TTU_HWPOISON) to convert the normal PTEs to swap PTEs,
-- 
2.33.0


