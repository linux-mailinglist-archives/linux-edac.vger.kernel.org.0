Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7246084A0
	for <lists+linux-edac@lfdr.de>; Sat, 22 Oct 2022 07:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJVFhc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 22 Oct 2022 01:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJVFhc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 22 Oct 2022 01:37:32 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE0929C3C1;
        Fri, 21 Oct 2022 22:37:30 -0700 (PDT)
X-QQ-mid: bizesmtp88t1666417028toi6erja
Received: from localhost.localdomain ( [182.148.15.254])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 22 Oct 2022 13:37:06 +0800 (CST)
X-QQ-SSF: 01000000000000C0E000000A0000000
X-QQ-FEAT: /+iK7ZpVlLQUvaMxQxCnGTbOqBBO+WfGbOoAxIwmBGcYlOlE5wj6EppqPyGud
        j6Dix0YjlE211NP4UThqFZCT8iHKkxln+/RiB3mL9C2Rt9H4WwKmH+omUFqob0CpFHnoFqW
        mwlWOKZVwKpaWxf50/NOep0wfVPeMLw4b0afxlokqIAmDmWfEVf65FOj+kRGWz4f1nzMxWs
        pMyph4yLAd5r/nR6BOy2H5kX0kFJfZZl8h73O4F2GwMs5bhZ7iI1aTRgCvRJ6uDCjrnuZDZ
        8lHL8MtUGXEhg0f0K16Kr0mN5MylXzzPze/aXvOCdLjBEcicdpja0dcaKPBEM4gKaK+R+Fy
        UsmtOFwyy5mWJRzDpP5fk33xuQ9w2WHiAlaFaSpD26Q6cbmglQ=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     dinguyen@kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/edac: fix repeated words in comments
Date:   Sat, 22 Oct 2022 13:37:00 +0800
Message-Id: <20221022053700.25752-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
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

