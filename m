Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCDA6D56B7
	for <lists+linux-edac@lfdr.de>; Tue,  4 Apr 2023 04:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjDDC0E (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Apr 2023 22:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjDDC0D (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Apr 2023 22:26:03 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F344D1BFA;
        Mon,  3 Apr 2023 19:26:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VfJnoQY_1680575158;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VfJnoQY_1680575158)
          by smtp.aliyun-inc.com;
          Tue, 04 Apr 2023 10:25:59 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     yazen.ghannam@amd.com
Cc:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2] EDAC/amd64: clean up some inconsistent indentings
Date:   Tue,  4 Apr 2023 10:25:57 +0800
Message-Id: <20230404022557.46409-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use consistent indentation to improve the readability and eliminate
the below warning:

drivers/edac/amd64_edac.c:1279 umc_determine_edac_cap() warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4639
Fixes: f6a4b4a1aa16 ("EDAC/amd64: Split determine_edac_cap() into dct/umc functions")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

change in v2:
--According to yazen's suggestion, include a fixes tag and
  describe the changes in the commit message

 drivers/edac/amd64_edac.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 6dad0f1064c0..5c4292e65b96 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1276,19 +1276,19 @@ static unsigned long umc_determine_edac_cap(struct amd64_pvt *pvt)
 	u8 i, umc_en_mask = 0, dimm_ecc_en_mask = 0;
 	unsigned long edac_cap = EDAC_FLAG_NONE;
 
-		for_each_umc(i) {
-			if (!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT))
-				continue;
+	for_each_umc(i) {
+		if (!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT))
+			continue;
 
-			umc_en_mask |= BIT(i);
+		umc_en_mask |= BIT(i);
 
-			/* UMC Configuration bit 12 (DimmEccEn) */
-			if (pvt->umc[i].umc_cfg & BIT(12))
-				dimm_ecc_en_mask |= BIT(i);
-		}
+		/* UMC Configuration bit 12 (DimmEccEn) */
+		if (pvt->umc[i].umc_cfg & BIT(12))
+			dimm_ecc_en_mask |= BIT(i);
+	}
 
-		if (umc_en_mask == dimm_ecc_en_mask)
-			edac_cap = EDAC_FLAG_SECDED;
+	if (umc_en_mask == dimm_ecc_en_mask)
+		edac_cap = EDAC_FLAG_SECDED;
 
 	return edac_cap;
 }
-- 
2.20.1.7.g153144c

