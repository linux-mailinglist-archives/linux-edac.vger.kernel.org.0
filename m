Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9786162E8
	for <lists+linux-edac@lfdr.de>; Wed,  2 Nov 2022 13:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiKBMpX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Nov 2022 08:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKBMpV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Nov 2022 08:45:21 -0400
X-Greylist: delayed 367 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Nov 2022 05:45:20 PDT
Received: from mxus.zte.com.cn (mxus.zte.com.cn [20.112.44.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE09238B8;
        Wed,  2 Nov 2022 05:45:20 -0700 (PDT)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxus.zte.com.cn (FangMail) with ESMTPS id 4N2RJP5pstz9tyD7;
        Wed,  2 Nov 2022 20:38:29 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4N2RHq6VKpz5BNRf;
        Wed,  2 Nov 2022 20:37:59 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2A2CbsFU049223;
        Wed, 2 Nov 2022 20:37:54 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Wed, 2 Nov 2022 20:37:57 +0800 (CST)
Date:   Wed, 2 Nov 2022 20:37:57 +0800 (CST)
X-Zmail-TransId: 2af9636264a57d5a1a4f
X-Mailer: Zmail v1.0
Message-ID: <202211022037573160098@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <tony.luck@intel.com>
Cc:     <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jiang.xuexin@zte.com.cn>, <xue.zhihong@zte.com.cn>,
        <zhang.songyi@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHg4Ni9NQ0UvQU1EOiByZW1vdmUgcmVkdW5kYW50IHJldCB2YXJpYWJsZQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2A2CbsFU049223
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at 10-207-168-7 with ID 636264C4.000 by FangMail milter!
X-FangMail-Envelope: 1667392710/4N2RJP5pstz9tyD7/636264C4.000/192.168.250.138/[192.168.250.138]/mxhk.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 636264C4.000/4N2RJP5pstz9tyD7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From 7fd536f480bfd526f40870c1567caf3263a584e7 Mon Sep 17 00:00:00 2001
From: zhang songyi <zhang.songyi@zte.com.cn>
Date: Wed, 2 Nov 2022 16:48:44 +0800
Subject: [PATCH linux-next] x86/MCE/AMD: remove redundant ret variable

Return value from show() and store() directly instead of taking this in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 arch/x86/kernel/cpu/mce/amd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 10fb5b5c9efa..425d0803eeb6 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1009,11 +1009,8 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 {
    struct threshold_block *b = to_block(kobj);
    struct threshold_attr *a = to_attr(attr);
-   ssize_t ret;

-   ret = a->show ? a->show(b, buf) : -EIO;
-
-   return ret;
+   return a->show ? a->show(b, buf) : -EIO;
 }

 static ssize_t store(struct kobject *kobj, struct attribute *attr,
@@ -1021,11 +1018,8 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 {
    struct threshold_block *b = to_block(kobj);
    struct threshold_attr *a = to_attr(attr);
-   ssize_t ret;
-
-   ret = a->store ? a->store(b, buf, count) : -EIO;

-   return ret;
+   return a->store ? a->store(b, buf, count) : -EIO;
 }

 static const struct sysfs_ops threshold_ops = {
--
2.15.2
