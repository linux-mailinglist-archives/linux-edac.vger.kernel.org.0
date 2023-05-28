Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA5F71379B
	for <lists+linux-edac@lfdr.de>; Sun, 28 May 2023 05:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjE1Dog (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 27 May 2023 23:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjE1Dof (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 27 May 2023 23:44:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A74AC9;
        Sat, 27 May 2023 20:44:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QTPfd0B9WzTkbb;
        Sun, 28 May 2023 11:44:25 +0800 (CST)
Received: from huawei.com (10.175.104.170) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 28 May
 2023 11:44:29 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <dave.hansen@linux.intel.com>
CC:     <hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] x86/mce: remove unused mce_vaddr
Date:   Sun, 28 May 2023 19:35:45 +0800
Message-ID: <20230528113545.650533-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Since commit a6e3cf70b772 ("x86/mce: Change to not send SIGBUS error during
copy from user"), mce_vaddr is not used anymore. Remove it and clean up the
relevant code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 arch/x86/kernel/cpu/mce/severity.c | 7 +------
 include/linux/sched.h              | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index c4477162c07d..0acc0039de81 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -252,12 +252,7 @@ static bool is_copy_from_user(struct pt_regs *regs)
 		return false;
 	}
 
-	if (fault_in_kernel_space(addr))
-		return false;
-
-	current->mce_vaddr = (void __user *)addr;
-
-	return true;
+	return !fault_in_kernel_space(addr);
 }
 
 /*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index eed5d65b8d1f..3054a7087230 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1493,7 +1493,6 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_X86_MCE
-	void __user			*mce_vaddr;
 	__u64				mce_kflags;
 	u64				mce_addr;
 	__u64				mce_ripv : 1,
-- 
2.27.0

