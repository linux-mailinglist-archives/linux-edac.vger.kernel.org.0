Return-Path: <linux-edac+bounces-1116-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C188CE32C
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 11:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B441F21137
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 09:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58DA8613B;
	Fri, 24 May 2024 09:16:37 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938968563E;
	Fri, 24 May 2024 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542197; cv=none; b=FC+9XRICH+UERYztXB6QzlSBnKiK2tftfrYQa8xaa+Z0hNhNW3WEQ3pIG7QoXd/Welb8ZZdyc8lQcqKX2+HdTjyeNtVZTAVTpxJk0w/EBEjzlgNcL8YPLWFjlpBlhEnd3UMY35JotNPU33IpulFBwsuLFyaytfDYKdRD8ihmw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542197; c=relaxed/simple;
	bh=y0w53WfEjSiN1DNwbXvFSfhj2ofhj3Nj68ZTP8Cen5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z266fp8lUmOWl+dc8R/HsEfSc9RMW0p0gV64Q0o7bq6VUXWMtxyu+UrzuvYyRDXh3JEmdqk8Lmi6mP3lW9HVgCpfEwPtV82Aq7GAcLvsjh9+jud/AP1pbVc7kWRHMDgRFyUvqvrtWIWtWclsqzsnMqo2ZZl+ld7tD+ACKzSpNj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VlzsF1LTGz1wr5G;
	Fri, 24 May 2024 17:15:13 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C1881402E0;
	Fri, 24 May 2024 17:16:28 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 17:16:27 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 04/13] mm/memory-failure: save a page_folio() call
Date: Fri, 24 May 2024 17:13:01 +0800
Message-ID: <20240524091310.1430048-5-linmiaohe@huawei.com>
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

Use local variable folio directly to save a page_folio() call.
No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b571aaf987a2..73878ecdec22 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1658,7 +1658,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 	unmap_success = !page_mapped(p);
 	if (!unmap_success)
 		pr_err("%#lx: failed to unmap page (folio mapcount=%d)\n",
-		       pfn, folio_mapcount(page_folio(p)));
+		       pfn, folio_mapcount(folio));
 
 	/*
 	 * try_to_unmap() might put mlocked page in lru cache, so call
-- 
2.33.0


