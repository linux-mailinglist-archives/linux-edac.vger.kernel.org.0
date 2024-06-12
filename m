Return-Path: <linux-edac+bounces-1265-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B43904CB2
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 09:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2CB1C23E5A
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2024 07:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F22916DEB2;
	Wed, 12 Jun 2024 07:22:57 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E316C69B;
	Wed, 12 Jun 2024 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176977; cv=none; b=KZ0XiPVmFyFBm18mrC00hSAIutXnWH7x9DGfsAi3i61HaOvn7KKd/KRw/9BKjy3q5Adjn7uZN+KBTKLg2NWiYg8HRbtzeadNg7pDIJsjEDD5DaALeoly430vFE8QtpC3LshQ+9ysyC96mkQuF8mpdGOmWJ9Ni8ZDDdbk3G2lbKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176977; c=relaxed/simple;
	bh=ZuSETaPyzBPBunGNQVbY0upqRDdAiMGZzjomw9wVIxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDp/pABglFRnj9v5G8wRRb2/qMY5ZgfiCqeGpGnE9AWquRo7uUvPQLiDKDGI5tyo0uuqwUhAKYZ05NObAD5vbXPoG57/z2JCOIsW4O9PYNIQJ/K+kTNJgFdlPs12ApZBS8mffXCfhoEZ/N80YdhIvBVvOokyKfGayXPXuuWvzqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VzcR91Vjfzdfth;
	Wed, 12 Jun 2024 15:21:25 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C8D7180AAE;
	Wed, 12 Jun 2024 15:22:52 +0800 (CST)
Received: from huawei.com (10.173.127.72) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 15:22:23 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v3 09/13] mm/memory-failure: remove obsolete comment in unpoison_memory()
Date: Wed, 12 Jun 2024 15:18:31 +0800
Message-ID: <20240612071835.157004-10-linmiaohe@huawei.com>
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

Since commit 130d4df57390 ("mm/sl[au]b: rearrange struct slab fields to
allow larger rcu_head"), folio->_mapcount is not overloaded with SLAB.
Update corresponding comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/memory-failure.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index bd3ab367ba2f..bb8e79381c1f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2584,10 +2584,6 @@ int unpoison_memory(unsigned long pfn)
 	    folio_test_reserved(folio) || folio_test_offline(folio))
 		goto unlock_mutex;
 
-	/*
-	 * Note that folio->_mapcount is overloaded in SLAB, so the simple test
-	 * in folio_mapped() has to be done after folio_test_slab() is checked.
-	 */
 	if (folio_mapped(folio)) {
 		unpoison_pr_info("Unpoison: Someone maps the hwpoison page %#lx\n",
 				 pfn, &unpoison_rs);
-- 
2.33.0


