Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED0A2812A6
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 14:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgJBM3A (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 08:29:00 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2945 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbgJBM3A (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 08:29:00 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 49972A71E05F8C9D331E;
        Fri,  2 Oct 2020 13:28:59 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.84.119) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 2 Oct 2020 13:28:58 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <rjw@rjwysocki.net>, <james.morse@arm.com>,
        <lenb@kernel.org>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 3/7] RAS/CEC: Move X86 MCE specific code under CONFIG_X86_MCE
Date:   Fri, 2 Oct 2020 13:22:31 +0100
Message-ID: <20201002122235.1280-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201002122235.1280-1-shiju.jose@huawei.com>
References: <20201002122235.1280-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.84.119]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

CEC may need to support other architectures such as ARM64.
Move X86 MCE specific code under CONFIG_X86_MCE to support
building for other architectures.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/ras/cec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index f20da1103f27..803e641d8e5c 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -8,7 +8,9 @@
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
 
+#if defined(CONFIG_X86_MCE)
 #include <asm/mce.h>
+#endif
 
 #include "debugfs.h"
 
@@ -511,6 +513,7 @@ static int __init create_debugfs_nodes(void)
 	if (!IS_ENABLED(CONFIG_RAS_CEC_DEBUG))
 		return 0;
 
+#if defined(CONFIG_X86_MCE)
 	pfn = debugfs_create_file("pfn", S_IRUSR | S_IWUSR, d, &dfs_pfn, &pfn_ops);
 	if (!pfn) {
 		pr_warn("Error creating pfn debugfs node!\n");
@@ -522,6 +525,7 @@ static int __init create_debugfs_nodes(void)
 		pr_warn("Error creating array debugfs node!\n");
 		goto err;
 	}
+#endif
 
 	return 0;
 
@@ -531,6 +535,7 @@ static int __init create_debugfs_nodes(void)
 	return 1;
 }
 
+#if defined(CONFIG_X86_MCE)
 static int cec_notifier(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -556,28 +561,33 @@ static struct notifier_block cec_nb = {
 	.notifier_call	= cec_notifier,
 	.priority	= MCE_PRIO_CEC,
 };
+#endif
 
 static void __init cec_init(void)
 {
 	if (ce_arr.disabled)
 		return;
 
+#if defined(CONFIG_X86_MCE)
 	ce_arr.array = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!ce_arr.array) {
 		pr_err("Error allocating CE array page!\n");
 		return;
 	}
+#endif
 
 	if (create_debugfs_nodes()) {
 		free_page((unsigned long)ce_arr.array);
 		return;
 	}
 
+#if defined(CONFIG_X86_MCE)
 	ce_arr.id_shift = PAGE_SHIFT;
 	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
 	schedule_delayed_work(&cec_work, CEC_DECAY_DEFAULT_INTERVAL);
 
 	mce_register_decode_chain(&cec_nb);
+#endif
 
 	pr_info("Correctable Errors collector initialized.\n");
 }
-- 
2.17.1


