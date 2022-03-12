Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902834D6D4B
	for <lists+linux-edac@lfdr.de>; Sat, 12 Mar 2022 08:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiCLHsT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 12 Mar 2022 02:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiCLHsN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 12 Mar 2022 02:48:13 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5834234062;
        Fri, 11 Mar 2022 23:47:07 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KFvtK34J0z9sZ5;
        Sat, 12 Mar 2022 15:43:21 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 12 Mar
 2022 15:47:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>,
        <naoya.horiguchi@nec.com>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 3/3] mm/memory-failure.c: make non-LRU movable pages unhandlable
Date:   Sat, 12 Mar 2022 15:46:13 +0800
Message-ID: <20220312074613.4798-4-linmiaohe@huawei.com>
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

We can not really handle non-LRU movable pages in memory failure. Typically
they are balloon, zsmalloc, etc. Assuming we run into a base (4K) non-LRU
movable page, we could reach as far as identify_page_state(), it should not
fall into any category except me_unknown. For the non-LRU compound movable
pages, they could be taken for transhuge pages but it's unexpected to split
non-LRU  movable pages using split_huge_page_to_list in memory_failure. So
we could just simply make non-LRU  movable pages unhandlable to avoid these
possible nasty cases.

Suggested-by: Yang Shi <shy828301@gmail.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2ff7dd2078c4..ba621c6823ed 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1177,12 +1177,18 @@ void ClearPageHWPoisonTakenOff(struct page *page)
  * does not return true for hugetlb or device memory pages, so it's assumed
  * to be called only in the context where we never have such pages.
  */
-static inline bool HWPoisonHandlable(struct page *page)
+static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
 {
-	return PageLRU(page) || __PageMovable(page) || is_free_buddy_page(page);
+	bool movable = false;
+
+	/* Soft offline could mirgate non-LRU movable pages */
+	if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
+		movable = true;
+
+	return movable || PageLRU(page) || is_free_buddy_page(page);
 }
 
-static int __get_hwpoison_page(struct page *page)
+static int __get_hwpoison_page(struct page *page, unsigned long flags)
 {
 	struct page *head = compound_head(page);
 	int ret = 0;
@@ -1197,7 +1203,7 @@ static int __get_hwpoison_page(struct page *page)
 	 * for any unsupported type of page in order to reduce the risk of
 	 * unexpected races caused by taking a page refcount.
 	 */
-	if (!HWPoisonHandlable(head))
+	if (!HWPoisonHandlable(head, flags))
 		return -EBUSY;
 
 	if (get_page_unless_zero(head)) {
@@ -1222,7 +1228,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 
 try_again:
 	if (!count_increased) {
-		ret = __get_hwpoison_page(p);
+		ret = __get_hwpoison_page(p, flags);
 		if (!ret) {
 			if (page_count(p)) {
 				/* We raced with an allocation, retry. */
@@ -1250,7 +1256,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 		}
 	}
 
-	if (PageHuge(p) || HWPoisonHandlable(p)) {
+	if (PageHuge(p) || HWPoisonHandlable(p, flags)) {
 		ret = 1;
 	} else {
 		/*
@@ -2308,7 +2314,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 
 retry:
 	get_online_mems();
-	ret = get_hwpoison_page(page, flags);
+	ret = get_hwpoison_page(page, flags | MF_SOFT_OFFLINE);
 	put_online_mems();
 
 	if (ret > 0) {
-- 
2.23.0

