Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D7C623A16
	for <lists+linux-edac@lfdr.de>; Thu, 10 Nov 2022 03:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiKJCyi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Nov 2022 21:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiKJCyg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Nov 2022 21:54:36 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F004723E8D
        for <linux-edac@vger.kernel.org>; Wed,  9 Nov 2022 18:54:35 -0800 (PST)
Received: from kwepemi500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N75yh22yRzmVhC;
        Thu, 10 Nov 2022 10:54:20 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500023.china.huawei.com
 (7.221.188.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 10:54:33 +0800
From:   Peng Wu <wupeng58@huawei.com>
To:     <yazen.ghannam@amd.com>, <bp@alien8.de>, <mchehab@kernel.org>,
        <james.morse@arm.com>, <rric@kernel.org>
CC:     <linux-edac@vger.kernel.org>, <liwei391@huawei.com>,
        Peng Wu <wupeng58@huawei.com>
Subject: [PATCH] EDAC/amd64: fix possible leak in hw_info_get()
Date:   Thu, 10 Nov 2022 02:52:56 +0000
Message-ID: <20221110025256.37599-1-wupeng58@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500023.china.huawei.com (7.221.188.76)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add missing kfree() in an error path in hw_info_get()
to avoid a memory leak.

Fixes: 80355a3b2db9 ("EDAC/amd64: Gather hardware information early")
Signed-off-by: Peng Wu <wupeng58@huawei.com>
---
 drivers/edac/amd64_edac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2f854feeeb23..b64b774eb974 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4108,8 +4108,10 @@ static int hw_info_get(struct amd64_pvt *pvt)
 	}
 
 	ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
-	if (ret)
+	if (ret) {
+		kfree(pvt->umc);
 		return ret;
+	}
 
 	read_mc_regs(pvt);
 
-- 
2.17.1

