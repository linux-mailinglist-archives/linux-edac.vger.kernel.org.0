Return-Path: <linux-edac+bounces-1256-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A776904C9B
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 09:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574C11C22CFE
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 07:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B587516C87B;
	Wed, 12 Jun 2024 07:22:30 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CB77D412;
	Wed, 12 Jun 2024 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176950; cv=none; b=nFnBsDZyMLTQY9ATw5I5+Y8+nH7NeOxiQwtkBCghYuqt3GsvRB49jnLc807uB0aF9m6H29pp1O7BZ21PDE7rgCjlO96iT7Zc2CBmoabCVrPOAYefagNczcdJ0layHmOZMbeAcBh16mmJc1dMg/B1KHn8pzH2bvIn3Sy3sFaDgLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176950; c=relaxed/simple;
	bh=vPXJ8cSWFgNVAmLKMLTd9Mxy8oHDbUFZaOahvRHCk7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMlwyLVwfxCniM14wd1wterzD3ag85jEYRcJ9Ju5GJ3gWrn0sBtNcLIqMS18MTHPthcKVK1CFbzN2+ceEFdLqRrX/dTt/OPaZfMeoWoG+KU/u4HF/kUWYYdW1UgbTFz63WBBy+qGg8Z+1zYaJ7X8BYphwmBC7iq3d28mv+pn5lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VzcMY0rTgzxT29;
	Wed, 12 Jun 2024 15:18:17 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 64D9D140154;
	Wed, 12 Jun 2024 15:22:21 +0800 (CST)
Received: from huawei.com (10.173.127.72) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 15:22:20 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v3 04/13] mm/memory-failure: save some page_folio() calls
Date: Wed, 12 Jun 2024 15:18:26 +0800
Message-ID: <20240612071835.157004-5-linmiaohe@huawei.com>
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

Use local variable folio directly to save a page_folio() call. Also
use folio_mapped() to save more page_folio() calls. No functional
change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/memory-failure.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 958b17a4b0f5..470c570d779c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1575,7 +1575,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 	 * This check implies we don't kill processes if their pages
 	 * are in the swap cache early. Those are always late kills.
 	 */
-	if (!page_mapped(p))
+	if (!folio_mapped(folio))
 		return true;
 
 	if (folio_test_swapcache(folio)) {
@@ -1626,10 +1626,10 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 		try_to_unmap(folio, ttu);
 	}
 
-	unmap_success = !page_mapped(p);
+	unmap_success = !folio_mapped(folio);
 	if (!unmap_success)
 		pr_err("%#lx: failed to unmap page (folio mapcount=%d)\n",
-		       pfn, folio_mapcount(page_folio(p)));
+		       pfn, folio_mapcount(folio));
 
 	/*
 	 * try_to_unmap() might put mlocked page in lru cache, so call
-- 
2.33.0


