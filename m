Return-Path: <linux-edac+bounces-1211-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E9A8FDEE6
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 08:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FFE28BCE9
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 06:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8042D13F435;
	Thu,  6 Jun 2024 06:36:38 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A884B1411DF;
	Thu,  6 Jun 2024 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655798; cv=none; b=F3m8G9iIvic8IX4RD7Hlv7HvGGdja8D2+u35Z8FQULGC5FzvDQ9fcJPx9rbfu101wvg6hDrUiISV35YPHqTkN09JBr1tn2SSelBc5zJUlPgjO2ypLeGbLvqLnFx7vB4h8WS7hIBEoYQMa5ltCx1ECThAK4LER0Luc15p+ITY6cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655798; c=relaxed/simple;
	bh=gWbEWvBWF/zgJS/WWFg+d7T3ZlD9r2RJP+08wycR9hY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J94ZdWMyK2xs0TKjNFdlIVK2Mgm+7w+o5jwxx6BmGApXhya3J6RA1SQFRvne0c980Nv4DYG0fDj0tQ4giUY3DRrXggBUuB8GeNd0oJZA0NazHXV+hS5nGA2iLVh+8MHxjCU8r404/1LTUHgawTW+ZXPu53VwWNDBYtivhkNayCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Vvvdp6Dc2z1S66Z;
	Thu,  6 Jun 2024 14:32:46 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 58DFE14035F;
	Thu,  6 Jun 2024 14:36:29 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 14:36:28 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v2 13/13] mm/memory-failure: correct comment in me_swapcache_dirty
Date: Thu, 6 Jun 2024 14:32:47 +0800
Message-ID: <20240606063247.712575-14-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240606063247.712575-1-linmiaohe@huawei.com>
References: <20240606063247.712575-1-linmiaohe@huawei.com>
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
index 161bdc79b44c..4fd8ab8fe3b4 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1126,7 +1126,7 @@ static int me_pagecache_dirty(struct page_state *ps, struct page *p)
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


