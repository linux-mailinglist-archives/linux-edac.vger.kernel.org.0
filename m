Return-Path: <linux-edac+bounces-1206-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 882DC8FDEDB
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 08:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0795DB24F1D
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FD713CA93;
	Thu,  6 Jun 2024 06:36:30 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1514573537;
	Thu,  6 Jun 2024 06:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655790; cv=none; b=acqHo/+OEIucJnzgTtCYu8yUlSLN/ian2X1cb2Cpd+na28qFejFjn+60pReHaT78ZAVy/Bqwd4A23gwNH7Z6Io2bio1SMa8xDL1o/QnvufNzmIZe4/tRdbw4k0XZ3NZjv2DV1A/0Krqe1/Ogs8mpOrUY0cIBTorvBClPMvNj2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655790; c=relaxed/simple;
	bh=yn43M0DeR39TkC7VXj7oGZytt4kODHT/uqcA0DWlrKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oh8YJ8P8PnBLO/v22ckBXbzoaEojw+2dpbmx2WTdkt62Iue58qaFoi5DVWw/3mgKSjZgoTBU5Tl286zjfEkovjgyOjSWKqMxHqqaELD41MMT24s0gEefIsoLlazhvqQPjYeSziggEV34JuNVVovXT2Kc+F8c50ZsySg73o3qe0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VvvdT41fvzwRlf;
	Thu,  6 Jun 2024 14:32:29 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 48333180AA6;
	Thu,  6 Jun 2024 14:36:27 +0800 (CST)
Received: from huawei.com (10.173.135.154) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Jun
 2024 14:36:26 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v2 09/13] mm/memory-failure: remove obsolete comment in unpoison_memory()
Date: Thu, 6 Jun 2024 14:32:43 +0800
Message-ID: <20240606063247.712575-10-linmiaohe@huawei.com>
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

Since commit 130d4df57390 ("mm/sl[au]b: rearrange struct slab fields to
allow larger rcu_head"), folio->_mapcount is not overloaded with SLAB.
Update corresponding comment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/memory-failure.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 81a544df8381..51df2c2e0cc2 100644
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


