Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA964D6D4A
	for <lists+linux-edac@lfdr.de>; Sat, 12 Mar 2022 08:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiCLHsM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 12 Mar 2022 02:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiCLHsL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 12 Mar 2022 02:48:11 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DC823405F;
        Fri, 11 Mar 2022 23:47:06 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KFvwL60rQzBrYL;
        Sat, 12 Mar 2022 15:45:06 +0800 (CST)
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
Subject: [PATCH v2 1/3] mm/memory-failure.c: fix race with changing page compound again
Date:   Sat, 12 Mar 2022 15:46:11 +0800
Message-ID: <20220312074613.4798-2-linmiaohe@huawei.com>
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

There is a race window where we got the compound_head, the hugetlb page
could be freed to buddy, or even changed to another compound page just
before we try to get hwpoison page. Think about the below race window:
  CPU 1					  CPU 2
  memory_failure_hugetlb
  struct page *head = compound_head(p);
					  hugetlb page might be freed to
					  buddy, or even changed to another
					  compound page.

  get_hwpoison_page -- page is not what we want now...

If this race happens, just bail out. Also MF_MSG_DIFFERENT_PAGE_SIZE is
introduced to record this event.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/mm.h      |  1 +
 include/ras/ras_event.h |  1 +
 mm/memory-failure.c     | 12 ++++++++++++
 3 files changed, 14 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c9bada4096ac..ef98cff2b253 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3253,6 +3253,7 @@ enum mf_action_page_type {
 	MF_MSG_BUDDY,
 	MF_MSG_DAX,
 	MF_MSG_UNSPLIT_THP,
+	MF_MSG_DIFFERENT_PAGE_SIZE,
 	MF_MSG_UNKNOWN,
 };
 
diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
index d0337a41141c..1e694fd239b9 100644
--- a/include/ras/ras_event.h
+++ b/include/ras/ras_event.h
@@ -374,6 +374,7 @@ TRACE_EVENT(aer_event,
 	EM ( MF_MSG_BUDDY, "free buddy page" )				\
 	EM ( MF_MSG_DAX, "dax page" )					\
 	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
+	EM ( MF_MSG_DIFFERENT_PAGE_SIZE, "different page size" )	\
 	EMe ( MF_MSG_UNKNOWN, "unknown page" )
 
 /*
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 5444a8ef4867..dabecd87ad3f 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -733,6 +733,7 @@ static const char * const action_page_types[] = {
 	[MF_MSG_BUDDY]			= "free buddy page",
 	[MF_MSG_DAX]			= "dax page",
 	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
+	[MF_MSG_DIFFERENT_PAGE_SIZE]	= "different page size",
 	[MF_MSG_UNKNOWN]		= "unknown page",
 };
 
@@ -1534,6 +1535,17 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	}
 
 	lock_page(head);
+
+	/**
+	 * The page could have changed compound pages due to race window.
+	 * If this happens just bail out.
+	 */
+	if (!PageHuge(p) || compound_head(p) != head) {
+		action_result(pfn, MF_MSG_DIFFERENT_PAGE_SIZE, MF_IGNORED);
+		res = -EBUSY;
+		goto out;
+	}
+
 	page_flags = head->flags;
 
 	if (hwpoison_filter(p)) {
-- 
2.23.0

