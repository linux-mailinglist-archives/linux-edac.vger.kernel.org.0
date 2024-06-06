Return-Path: <linux-edac+bounces-1207-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB358FDF12
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 08:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05C11C23598
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 06:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A15B13E058;
	Thu,  6 Jun 2024 06:36:32 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B6A13C83C;
	Thu,  6 Jun 2024 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655792; cv=none; b=OE/RsZpuxhBYr1RIdDKN2CEiVY5vFL9K7gV5l5Q+C9CHwauuYSSOD5rr+zG0EA75lRZwuUrdxmEtG9LkfF4RLTFb/IJzWOCLpKSbN11JpljJj+WwOphLZa4Si4tbkCCBjKhBSZlj88tZyF67LzfiemT0jTBKl5UTWdeXmB9L1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655792; c=relaxed/simple;
	bh=Xs7kN5pF8eh8DJ3mjsT6LLYtcEjIHoDQJGKl7WuxVHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1oinl7ks8ElEWD3G53TnGys8FamKb8MbcWh6VHBKOPuaRg2NwlsL+YL5dsobDD+QhFdXR4E+LLTCddpchyKx29RkAu3N6gzKnhTMrLcDi5bTexR5IKc5JqzdRl6BkIIZjYC7QcMMNpqKQW++fJjDLTs/CRRxTd+YyzBo7EaSWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VvvhR5XVdzdZNS;
	Thu,  6 Jun 2024 14:35:03 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 488EB18007E;
	Thu,  6 Jun 2024 14:36:28 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 14:36:27 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v2 11/13] mm/memory-failure: fix comment of get_hwpoison_page()
Date: Thu, 6 Jun 2024 14:32:45 +0800
Message-ID: <20240606063247.712575-12-linmiaohe@huawei.com>
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

When return value is 0, it could also means the page is free hugetlb
page or free buddy page. Fix the corresponding comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 51df2c2e0cc2..0d37f20968e6 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1525,7 +1525,7 @@ static int __get_unpoison_page(struct page *page)
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


