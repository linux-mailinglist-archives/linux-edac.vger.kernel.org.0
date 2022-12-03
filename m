Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BD6641478
	for <lists+linux-edac@lfdr.de>; Sat,  3 Dec 2022 07:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiLCGTh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 3 Dec 2022 01:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLCGTg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 3 Dec 2022 01:19:36 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0933ED208F;
        Fri,  2 Dec 2022 22:19:36 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NPKQt47vdz4xq1w;
        Sat,  3 Dec 2022 14:19:34 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 2B36JU32087812;
        Sat, 3 Dec 2022 14:19:30 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
        by mapi (Zmail) with MAPI id mid14;
        Sat, 3 Dec 2022 14:19:32 +0800 (CST)
Date:   Sat, 3 Dec 2022 14:19:32 +0800 (CST)
X-Zmail-TransId: 2b04638aea74ffffffff810fbe95
X-Mailer: Zmail v1.0
Message-ID: <202212031419324523731@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <tony.luck@intel.com>
Cc:     <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.panda@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHg4Ni9tY2UvZGV2LW1jZWxvZzogdXNlIHN0cnNjcHkoKSB0byBpbnN0ZWFkIG9mIHN0cm5jcHkoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2B36JU32087812
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 638AEA76.000 by FangMail milter!
X-FangMail-Envelope: 1670048374/4NPKQt47vdz4xq1w/638AEA76.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638AEA76.000/4NPKQt47vdz4xq1w
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Xu Panda <xu.panda@zte.com.cn>

The implementation of strscpy() is more robust and safer.
That's now the recommended way to copy NUL terminated strings.

Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com>
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 100fbeebdc72..a05ac0716ecf 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -105,8 +105,7 @@ static ssize_t set_trigger(struct device *s, struct device_attribute *attr,
 {
 	char *p;

-	strncpy(mce_helper, buf, sizeof(mce_helper));
-	mce_helper[sizeof(mce_helper)-1] = 0;
+	strscpy(mce_helper, buf, sizeof(mce_helper));
 	p = strchr(mce_helper, '\n');

 	if (p)
-- 
2.15.2
