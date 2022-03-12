Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8430D4D6D49
	for <lists+linux-edac@lfdr.de>; Sat, 12 Mar 2022 08:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiCLHsL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 12 Mar 2022 02:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiCLHsK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 12 Mar 2022 02:48:10 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFA423405E;
        Fri, 11 Mar 2022 23:47:05 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KFvwL1tqQzBrJW;
        Sat, 12 Mar 2022 15:45:06 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 12 Mar
 2022 15:47:03 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>,
        <naoya.horiguchi@nec.com>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 0/3] A few fixup patches for memory failure
Date:   Sat, 12 Mar 2022 15:46:10 +0800
Message-ID: <20220312074613.4798-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
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

Hi everyone,
This series contains a few patches to fix the race with changing page
compound page, make non-LRU movable pages unhandlable and so on. More
details can be found in the respective changelogs. Thanks!

---
v1->v2:
  drop "mm/memory-failure.c: fix wrong user reference report"
  make non-LRU movable pages unhandlable
  fix confusing commit log and introduce MF_MSG_DIFFERENT_PAGE_SIZE
  Many thanks Naoya, Mike and Yang Shi for review!
---

Miaohe Lin (3):
  mm/memory-failure.c: fix race with changing page compound again
  mm/memory-failure.c: avoid calling invalidate_inode_page() with
    unexpected pages
  mm/memory-failure.c: make non-LRU movable pages unhandlable

 include/linux/mm.h      |  1 +
 include/ras/ras_event.h |  1 +
 mm/memory-failure.c     | 34 ++++++++++++++++++++++++++--------
 3 files changed, 28 insertions(+), 8 deletions(-)

-- 
2.23.0

