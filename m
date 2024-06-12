Return-Path: <linux-edac+bounces-1252-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA768904C94
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 09:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53072B239FA
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 07:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0426B167272;
	Wed, 12 Jun 2024 07:22:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAE845948;
	Wed, 12 Jun 2024 07:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176944; cv=none; b=T6QXVvmraKlFSTiuW9NlAnauxDi9tvaRjAnIUerBnAak2ETFxPzKBzfFN6qkB7ALNDHUV2vBvYfRT5sukkpJgEz0UAaQPNqrVfnMVXnAL4gLhyhKj54vwKq4tg6G3cKjuk6s3xjOr2qmz/6eClzOe3VpHN99/K4OWy6TiVkUNlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176944; c=relaxed/simple;
	bh=H+ROwO0chqPlRn6Si/4Oz4F0SzdC7g4y+tLqpdk/xjY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQaXt9O5zsaApG7UgIFXZVAra8NyOzr0eJ7yKxXxqB4O/4+XLiL9SeJESOq7855nB+1qrbdMdXEyoIMZ+NPP5OYkQiYehKIi6ONK2wdXso7Hu81iZ4dR8cP3Vo3SItG6POrR3NfBlXPL2c3psjd5Tk89XMiaMsJGm+rc2MNszog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VzcMr4lcQz355t4;
	Wed, 12 Jun 2024 15:18:32 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id E837B180065;
	Wed, 12 Jun 2024 15:22:19 +0800 (CST)
Received: from huawei.com (10.173.127.72) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 15:22:19 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v3 01/13] mm/memory-failure: simplify put_ref_page()
Date: Wed, 12 Jun 2024 15:18:23 +0800
Message-ID: <20240612071835.157004-2-linmiaohe@huawei.com>
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

Remove unneeded page != NULL check. pfn_to_page() won't return NULL.
No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f679b579d45d..2e6038c73119 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2120,14 +2120,10 @@ static inline unsigned long folio_free_raw_hwp(struct folio *folio, bool flag)
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


