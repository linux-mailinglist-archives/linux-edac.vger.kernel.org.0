Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4324D6D4C
	for <lists+linux-edac@lfdr.de>; Sat, 12 Mar 2022 08:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiCLHsS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 12 Mar 2022 02:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiCLHsM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 12 Mar 2022 02:48:12 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3021A23405E;
        Fri, 11 Mar 2022 23:47:07 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KFvs023Q2zcb2J;
        Sat, 12 Mar 2022 15:42:12 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 12 Mar
 2022 15:47:04 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>,
        <naoya.horiguchi@nec.com>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 2/3] mm/memory-failure.c: avoid calling invalidate_inode_page() with unexpected pages
Date:   Sat, 12 Mar 2022 15:46:12 +0800
Message-ID: <20220312074613.4798-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220312074613.4798-1-linmiaohe@huawei.com>
References: <20220312074613.4798-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since commit 042c4f32323b ("mm/truncate: Inline invalidate_complete_page()
into its one caller"), invalidate_inode_page() can invalidate the pages in
the swap cache because the check of page->mapping != mapping is removed.
But invalidate_inode_page() is not expected to deal with the pages in swap
cache. Also non-lru movable page can reach here too. They're not page cache
pages. Skip these pages by checking PageSwapCache and PageLRU.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index dabecd87ad3f..2ff7dd2078c4 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2190,7 +2190,7 @@ static int __soft_offline_page(struct page *page)
 		return 0;
 	}
 
-	if (!PageHuge(page))
+	if (!PageHuge(page) && PageLRU(page) && !PageSwapCache(page))
 		/*
 		 * Try to invalidate first. This should work for
 		 * non dirty unmapped page cache pages.
-- 
2.23.0

