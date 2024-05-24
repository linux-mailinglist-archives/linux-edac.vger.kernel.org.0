Return-Path: <linux-edac+bounces-1119-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 230ED8CE332
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 11:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9E31F2211F
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7773F86ACC;
	Fri, 24 May 2024 09:16:39 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9946A85C76;
	Fri, 24 May 2024 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716542199; cv=none; b=Zt+vDv23EJd/b1uus8Bywvezd60xSB8OzwohJ1hM6Z8UKApOUJQk4a2VitRplVk0B663WdLJLhtev3mswI1xsMmhgXXn7bOzuRz7VIpQTob2o6AwXIi8Mz79nQyKGrKuDvELW6Ur0wo9f1QOoqG5jbHd65JZr3qRsHmGpH/+qf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716542199; c=relaxed/simple;
	bh=RqqyeXN49L+OxvoPKSY+bYr6mtFoqKTj/RQxWasN8sQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKztQZ6UFXaGuCMXHpS7xSv/cwcJgMEzjsHG+ksj55unY+vtOtl05aQM41JuXqm0/8J8VT/kIxjScIy3gUz+CeCPfSsQcqZ5UjD2iENWY8Snrs5Lvx86vVs4XgR5WyhWSitlfBAlUe4++Vq5RHANLAa9HnV35XgSi7BZ2pMjDqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VlzpT6NSWz1S4rl;
	Fri, 24 May 2024 17:12:49 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 803351400D1;
	Fri, 24 May 2024 17:16:30 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 May
 2024 17:16:29 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH 09/13] mm/memory-failure: remove obsolete comment in unpoison_memory()
Date: Fri, 24 May 2024 17:13:06 +0800
Message-ID: <20240524091310.1430048-10-linmiaohe@huawei.com>
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

Since commit 130d4df57390 ("mm/sl[au]b: rearrange struct slab fields to
allow larger rcu_head"), folio->_mapcount is not overloaded with SLAB.
Update corresponding comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 19d338e83e43..e4252f297d41 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2610,10 +2610,6 @@ int unpoison_memory(unsigned long pfn)
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


