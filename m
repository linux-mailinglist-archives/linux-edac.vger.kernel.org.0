Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3857358FBE9
	for <lists+linux-edac@lfdr.de>; Thu, 11 Aug 2022 14:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiHKMJD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Aug 2022 08:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbiHKMJA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Aug 2022 08:09:00 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C46B956BB;
        Thu, 11 Aug 2022 05:08:58 -0700 (PDT)
X-QQ-mid: bizesmtp87t1660219717tldpgmki
Received: from localhost.localdomain ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 20:08:36 +0800 (CST)
X-QQ-SSF: 01000000002000G0V000B00A0000020
X-QQ-FEAT: znfcQSa1hKZBIBR//c2YM5szmyqV0zQakcVthppvMDJuh8snMej6NDGyDuEZC
        Y4FzOsR/8o+ikBkXxX7Q56hqs23J9g8ZkGV9w5WO30FGKGR+Qpe/DKwb/b33Ipl8h9v0Mc4
        VGPPS+LWX2UbRtB7S6v5hY/JAMfB3g2AU0aaCn332gI6m1elnYye0AAcYZE2px2kPZtRFps
        GoFOJn90ZRnvOwh4GM/iyC42zD0kvo83RmDjHVQeQN8HhCcVlDYPSKddq6ABYFgBwIaY3b4
        vxxep1Bt5M+q+IB5LshYxotBn26PTZK9cLMhlRAs7Y5HAoIfjzLvTdzwZTX16iWnK4IOFdq
        Zvi7DU9/ab+j+WYBeOrYrE8qpS3+OggGeo62Awov8ltBd9OKfzQVATe85Y9Bw7DQ5OQCnYz
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     dinguyen@kernel.org
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] EDAC/altera: Fix comment typo
Date:   Thu, 11 Aug 2022 20:08:22 +0800
Message-Id: <20220811120822.16832-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/edac/altera_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e7e8e624a436..940f8149172c 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -168,7 +168,7 @@ static ssize_t altr_sdr_mc_err_inject_write(struct file *file,
 	/*
 	 * To trigger the error, we need to read the data back
 	 * (the data was written with errors above).
-	 * The READ_ONCE macros and printk are used to prevent the
+	 * The READ_ONCE macros and printk are used to prevent
 	 * the compiler optimizing these reads out.
 	 */
 	reg = READ_ONCE(ptemp[0]);
-- 
2.36.1

