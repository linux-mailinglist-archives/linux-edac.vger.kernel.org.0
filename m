Return-Path: <linux-edac+bounces-1260-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D051A904CA7
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 09:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B861C23E4B
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 07:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621B516C84E;
	Wed, 12 Jun 2024 07:22:56 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3B516C69E;
	Wed, 12 Jun 2024 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176976; cv=none; b=DAJROC0dJJI8O4SQy6AORhcJdyzTGkbyASrOfSrmj79EaSBrbtHBaKd0b6K1VPikEG1j+PFNk48+oKkehKDH7I9pxJ3LAiOJfv3nvxBbYULnOOFqvy09/CWy4W6VST4Tk+Ic5viWQm9XOAf4MMWBLqASgYTI0bRh5uhJixsk27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176976; c=relaxed/simple;
	bh=O7U4Cb2ud4SLuD5qD8Xl9m87FT6GLSwSSefl6bRunQ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bL1ZFFLUh3tlXLv9d1DzEoxwt9uUUcVlHMW3tUoUNf82m73UeS6dkUzeATQ6sFSCfjGn1lsPKTjBx9wkwfjACVESZJZWXvLtGEV9Qz7cQ9TwnHIrHrBJ6eaYTqdSnsQWDEqLk7YqCsyR4J7FUEkRVWk8X43NSprOYB7S3GrK2tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VzcR92RWrzdfy4;
	Wed, 12 Jun 2024 15:21:25 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id A42AC180AA9;
	Wed, 12 Jun 2024 15:22:52 +0800 (CST)
Received: from huawei.com (10.173.127.72) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 15:22:25 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v3 13/13] mm/memory-failure: correct comment in me_swapcache_dirty
Date: Wed, 12 Jun 2024 15:18:35 +0800
Message-ID: <20240612071835.157004-14-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240612071835.157004-1-linmiaohe@huawei.com>
References: <20240612071835.157004-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

Dirty swap cache page could live both in page table (not page cache) and
swap cache when freshly swapped in. Correct comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 12b516895ee7..2cf7acc286de 100644
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


