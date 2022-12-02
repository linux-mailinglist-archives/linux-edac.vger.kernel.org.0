Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B34640267
	for <lists+linux-edac@lfdr.de>; Fri,  2 Dec 2022 09:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiLBIm4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Dec 2022 03:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiLBImt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 2 Dec 2022 03:42:49 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C0913E2E;
        Fri,  2 Dec 2022 00:42:45 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NNmZY63JGzJp9B;
        Fri,  2 Dec 2022 16:39:17 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 2 Dec
 2022 16:42:42 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mce: fix missing stack-dumping in mce_panic()
Date:   Sat, 3 Dec 2022 00:37:28 +0800
Message-ID: <20221202163728.392509-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When machine check exception occurs, there is no stack-dumping now in
mce_panic(). It's because bust_spinlocks(1) is called prematurely so
oops_in_progress will be >= 2 when trying to call dump_stack() in
panic(). Thus dump_stack() won't be called as this is considered as
nested stack-dumping.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/x86/kernel/cpu/mce/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c8ec5c71712..c40dad1a6749 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -254,7 +254,6 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 			wait_for_panic();
 		barrier();
 
-		bust_spinlocks(1);
 		console_verbose();
 	} else {
 		/* Don't log too much for fake panic */
-- 
2.23.0

