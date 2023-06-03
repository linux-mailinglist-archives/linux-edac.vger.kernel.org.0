Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8B0720E29
	for <lists+linux-edac@lfdr.de>; Sat,  3 Jun 2023 08:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjFCGir (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 3 Jun 2023 02:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjFCGir (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 3 Jun 2023 02:38:47 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3DCE58;
        Fri,  2 Jun 2023 23:38:46 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QY97Y6rMgz18LkM;
        Sat,  3 Jun 2023 14:34:01 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 3 Jun
 2023 14:38:43 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] RAS/CEC: remove unused del_lru_elem()
Date:   Sat, 3 Jun 2023 22:29:51 +0800
Message-ID: <20230603142951.801485-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The function del_lru_elem() is not used. Remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 drivers/ras/cec.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 321af498ee11..fa2fa596219c 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -261,25 +261,6 @@ static u64 del_lru_elem_unlocked(struct ce_array *ca)
 	return PFN(ca->array[min_idx]);
 }
 
-/*
- * We return the 0th pfn in the error case under the assumption that it cannot
- * be poisoned and excessive CEs in there are a serious deal anyway.
- */
-static u64 __maybe_unused del_lru_elem(void)
-{
-	struct ce_array *ca = &ce_arr;
-	u64 pfn;
-
-	if (!ca->n)
-		return 0;
-
-	mutex_lock(&ce_mutex);
-	pfn = del_lru_elem_unlocked(ca);
-	mutex_unlock(&ce_mutex);
-
-	return pfn;
-}
-
 static bool sanity_check(struct ce_array *ca)
 {
 	bool ret = false;
-- 
2.27.0

