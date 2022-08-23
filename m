Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2E559E91F
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 19:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiHWRV6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 13:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHWRUG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 13:20:06 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3045B65654;
        Tue, 23 Aug 2022 06:45:51 -0700 (PDT)
X-QQ-mid: bizesmtp73t1661262337tep0pb55
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 21:45:35 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: +ynUkgUhZJmQaSk3uMZ2M73PIL3bdE2w4IsUkT67BI3dTaTwjNONuAlddF700
        8K0gBXVgYZG8N0KQuoyNT/xya8RJM+BcNJW8AuKf+vYcnl7E0W42ML52Rz5UbsoHYs6HEBB
        nX1ho503+f/oNq6xrLWVuqpWHwG6oKLQp0p5jMbvrR7nFx29AVwgxJ7TyZMoi9kDpBd+i3+
        1bqmObUlqU4G1QHXMm5x0UTQrwX51WeSYBd3S0lhco2St4HujLMYPJBjK+nLEZQguUTeB3A
        mZSbB+J+3E3vJuWaNf5AhX9hki3vMdGKbvTY4PDwJaxHXl3SorhqgTAp5K7+Rgh0TOU8lTH
        VNsgdzsDsAu+OI/8nq18FT75yNR3eGKavSsKO0eNjM+8AXEV4/J+VryI6H+fw==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     dinguyen@kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/edac: fix repeated words in comments
Date:   Tue, 23 Aug 2022 21:45:28 +0800
Message-Id: <20220823134528.59406-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index e7e8e624a436..e9c0f25b2f18 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -169,7 +169,7 @@ static ssize_t altr_sdr_mc_err_inject_write(struct file *file,
 	 * To trigger the error, we need to read the data back
 	 * (the data was written with errors above).
 	 * The READ_ONCE macros and printk are used to prevent the
-	 * the compiler optimizing these reads out.
+	 * compiler optimizing these reads out.
 	 */
 	reg = READ_ONCE(ptemp[0]);
 	read_reg = READ_ONCE(ptemp[1]);
-- 
2.36.1

