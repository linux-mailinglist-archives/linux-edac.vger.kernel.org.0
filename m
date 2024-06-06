Return-Path: <linux-edac+bounces-1200-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 090A48FDED0
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 08:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5D01C21725
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 06:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5146713A415;
	Thu,  6 Jun 2024 06:36:29 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB961FD7;
	Thu,  6 Jun 2024 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655789; cv=none; b=KPn0rjI2JLMMMAfIHP5S7kJWUDT6WC5NW8zlKwA1wvwuAs+5Ck+YucD0GwW+FPDzfQRC3WhpCa9Q/lntApKvR3iuNoiXO2CQB1wPMZnAE8Qc6sP6nurDFQrBVOEky2ROC1xKFIvMoN5hZvHDdgj+U76KkO+8vOznFLzI5mxHwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655789; c=relaxed/simple;
	bh=vPXJ8cSWFgNVAmLKMLTd9Mxy8oHDbUFZaOahvRHCk7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kgn+Pi/1zSXPjsPZHur+mSrrsptqcriD4TqG9YzqqAw9lnfxWaXCb3Dn6OKBRen6/4ctxfIsACzPNNvETCAEx4aC1b1ADjCCshu+o4Zz+6XisPspt+nPJIpoMl6A4otmwCoAX91voeQ4Z2yLIjChWc71kPC4NTMe/S5zsphWzsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Vvvdk4zllz355cV;
	Thu,  6 Jun 2024 14:32:42 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id A018014035F;
	Thu,  6 Jun 2024 14:36:24 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 14:36:24 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v2 04/13] mm/memory-failure: save some page_folio() calls
Date: Thu, 6 Jun 2024 14:32:38 +0800
Message-ID: <20240606063247.712575-5-linmiaohe@huawei.com>
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


