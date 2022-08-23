Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81B359E92D
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbiHWRQj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 13:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbiHWRP0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 13:15:26 -0400
X-Greylist: delayed 87 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 Aug 2022 06:50:21 PDT
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA6BA570F
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 06:50:21 -0700 (PDT)
X-QQ-mid: bizesmtp70t1661262526tiw72smg
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 21:48:45 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: LYJkq/r0B5FfH0YfLsgRqkeNgTq9glRMoYqK0TuteNXZlnm1P+5YhGg3igi7K
        TXrSVBTh4HqbtblTt+XI39tI2s7H6IDpuX07S1pgasUGU2+ySDqXrE+3vijQBbZAU/D5PaO
        MdqgY5J3Lk9JVFGT+Il2zUGHsTmok5XzaV/THLGYVu55Zc6ApHAM04G2KA5Eo/67t/VKGjd
        aBkpiYguK8CMawXqHE5UcRDKjljK1qzuFsXoG4HSKznMZ4VrjpPwX5v7WymM9HYX51KYQpa
        qS23seadAfJitz/I4dKGj/bbGZlukj0vyqgGc6P7HqeTn9AzgxQd5GkVYIK6u4kUOyOAdHQ
        nTBVu+fMlkZX60Lg6l1LH+nXTwS+aAv29aI6XCpXu9Z35nL1no=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/edac: fix repeated words in comments
Date:   Tue, 23 Aug 2022 21:48:38 +0800
Message-Id: <20220823134838.61048-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Delete the redundant word 'have'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/edac/i5000_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
index ba46057d4220..dc81eeb58720 100644
--- a/drivers/edac/i5000_edac.c
+++ b/drivers/edac/i5000_edac.c
@@ -1376,7 +1376,7 @@ static int i5000_probe1(struct pci_dev *pdev, int dev_idx)
 	 * As we don't have a motherboard identification routine to determine
 	 * actual number of slots/dimms per channel, we thus utilize the
 	 * resource as specified by the chipset. Thus, we might have
-	 * have more DIMMs per channel than actually on the mobo, but this
+	 * more DIMMs per channel than actually on the mobo, but this
 	 * allows the driver to support up to the chipset max, without
 	 * some fancy mobo determination.
 	 */
-- 
2.36.1


