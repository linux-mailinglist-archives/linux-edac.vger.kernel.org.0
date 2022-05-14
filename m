Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA414526FF5
	for <lists+linux-edac@lfdr.de>; Sat, 14 May 2022 10:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiENIQK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 14 May 2022 04:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiENIPv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 14 May 2022 04:15:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B1062D3;
        Sat, 14 May 2022 01:15:45 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L0dW04Rj9zCsdF;
        Sat, 14 May 2022 16:10:52 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 14 May
 2022 16:15:43 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rric@kernel.org>, <yuehaibing@huawei.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] edac: i5100_edac: Remove unused inline function i5100_nrecmema_dm_buf_id()
Date:   Sat, 14 May 2022 16:04:33 +0800
Message-ID: <20220514080433.29944-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

commit a4972b1b9a04 ("edac: i5100_edac: Remove unused i5100_recmema_dm_buf_id")
leave this behind, remove it.
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/edac/i5100_edac.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
index 324a46b8479b..f5d82518c15e 100644
--- a/drivers/edac/i5100_edac.c
+++ b/drivers/edac/i5100_edac.c
@@ -244,11 +244,6 @@ static inline u32 i5100_nrecmema_rank(u32 a)
 	return a >>  8 & ((1 << 3) - 1);
 }
 
-static inline u32 i5100_nrecmema_dm_buf_id(u32 a)
-{
-	return a & ((1 << 8) - 1);
-}
-
 static inline u32 i5100_nrecmemb_cas(u32 a)
 {
 	return a >> 16 & ((1 << 13) - 1);
-- 
2.17.1

