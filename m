Return-Path: <linux-edac+bounces-1121-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D198CE337
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 11:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD521F22E9B
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 09:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37D127B47;
	Fri, 24 May 2024 09:16:40 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7A78626E;
	Fri, 24 May 2024 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542200; cv=none; b=YYs1QO7GM2pzyMEYzi62i9zftHzw9pr30WS3RkYGxRjpYOXdgXb+OxhHsR6bOrQVgKl5iR5wGk0EFIIbfMtBIQ5cUL5raYb3SJxwb7CO4/XU1HrBSZdkPZavC9Yb9T4/Hhl+ZUtyu413dAeVbyVNa+53cYzpHOX+rGh07/7aKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542200; c=relaxed/simple;
	bh=er7HX24yFsOrH0ScrFR/OGLdgsJH/93guW1I8ORBqe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAT0FpsaXp8yWqNow3JOmY9UFHnTh//SjFE+O9inQVkY1d/UrDceErEK2xaXAPCHjiF5sb8k2a0eDGIZ0XgzMTZVEIMV5V83T2J2pmFH89FU4bFFMzVeKvru/h55AgqmRcZo2hKDCfL5Wg3wlG5PgTFXdyzwoJRRH1wVT6mZJIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VlzqC226JzPmWX;
	Fri, 24 May 2024 17:13:27 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A7CC1400D1;
	Fri, 24 May 2024 17:16:31 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 17:16:30 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 11/13] mm/memory-failure: fix comment of get_hwpoison_page()
Date: Fri, 24 May 2024 17:13:08 +0800
Message-ID: <20240524091310.1430048-12-linmiaohe@huawei.com>
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

When return value is 0, it could also means the page is free hugetlb
page or free buddy page. Fix the corresponding comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e4252f297d41..705cd0bbb603 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1549,7 +1549,7 @@ static int __get_unpoison_page(struct page *page)
  * the given page has PG_hwpoison. So it's never reused for other page
  * allocations, and __get_unpoison_page() never races with them.
  *
- * Return: 0 on failure,
+ * Return: 0 on failure or free buddy (hugetlb) page,
  *         1 on success for in-use pages in a well-defined state,
  *         -EIO for pages on which we can not handle memory errors,
  *         -EBUSY when get_hwpoison_page() has raced with page lifecycle
-- 
2.33.0


