Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF2957ED11
	for <lists+linux-edac@lfdr.de>; Sat, 23 Jul 2022 11:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiGWJ2N (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 23 Jul 2022 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiGWJ2M (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 23 Jul 2022 05:28:12 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33810BE0A;
        Sat, 23 Jul 2022 02:28:07 -0700 (PDT)
X-QQ-mid: bizesmtp80t1658568471t5vqgqcy
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 23 Jul 2022 17:27:50 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: D2GZf6M6C/jBSQ0W+PK6lcwqSNGvR5TTmB8xdVo4sk7NQXYkbqlgvzDZRsq02
        OqSDt5S3pOGCSnjtbxhc9fwLd/+irPjjkrVbAaV2HnWMAug74li76ZGTXZaWXklmm2n1aU5
        kJH2P1XJVvLZG+k+p1ejWf2MEN8bNHxvah43BTmjdJck/CvD9HMJIo6lG+DDiBR6cWk8+2a
        0DfwC1iCK9iizGjPEaEY92lK7vpHf/27cGdSyk/OCRHFWvk9ujCYkogGn3dKoGbIfGbV43z
        vAGu5KmB0ByXBCiMNlKOGAwsBow+nBh8uLmVQf1LIz7f+DtdbHZBZSPrNF1v0BHmouYF7iL
        r+D857LcSPm2QeDgopdlVl0ITtHkq1I0UPhLBKLFXSt+oVm/QzVNbRBGZD6mjBN1crhVNoi
        S9qpB8SwdRI=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     rric@kernel.org
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] edac: cpc925: Remove the static variable initialisations to 0
Date:   Sat, 23 Jul 2022 17:27:49 +0800
Message-Id: <20220723092749.7829-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Initialise global and static variable to 0 is always unnecessary.
Remove the unnecessary initialisations.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/edac/cpc925_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
index 9797e6d60dde..e65ecb159bb3 100644
--- a/drivers/edac/cpc925_edac.c
+++ b/drivers/edac/cpc925_edac.c
@@ -582,7 +582,7 @@ static void cpc925_mc_check(struct mem_ctl_info *mci)
 static u32 cpc925_cpu_mask_disabled(void)
 {
 	struct device_node *cpunode;
-	static u32 mask = 0;
+	static u32 mask;
 
 	/* use cached value if available */
 	if (mask != 0)
-- 
2.35.1

