Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127833F235C
	for <lists+linux-edac@lfdr.de>; Fri, 20 Aug 2021 00:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhHSWpj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Aug 2021 18:45:39 -0400
Received: from mga18.intel.com ([134.134.136.126]:31925 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhHSWpj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Aug 2021 18:45:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="203814491"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="203814491"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 15:45:02 -0700
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="scan'208";a="522636079"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 15:45:01 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Sumanth Kamatala <skamatala@juniper.net>
Subject: [PATCH] x86/mce/dev-mcelog: Call mce_register_decode_chain() much earlier
Date:   Thu, 19 Aug 2021 15:44:52 -0700
Message-Id: <20210819224452.1619400-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When a fatal machine check results in a system reset, Linux does
not clear the error(s) from machine check bank(s).

Hardware preserves the machine check banks across a warm reset.

During initialization of the kernel after the reboot, Linux reads,
logs, and clears all machine check banks.

But there is a problem. In:
commit 5de97c9f6d85 ("x86/mce: Factor out and deprecate the /dev/mcelog driver")
the call to mce_register_decode_chain() moved later in the boot sequence.
This means that /dev/mcelog doesn't see those early error logs.

This was partially fixed by:
commit cd9c57cad3fe ("x86/MCE: Dump MCE to dmesg if no consumers")

which made sure that the logs were not lost completely by printing
to the console. But parsing console logs is error prone. Users
of /dev/mcelog should expect to find any early errors logged to
standard places.

Split the initialization code in dev-mcelog.c into:
1) an "early" part that registers for mce notifications. Call this
directly from mcheck_init() because early_initcall() is still too late.
This allocation is too early for kzalloc() so use memblock_alloc().
2) "late" part that registers the /dev/mcelog character device.

Fixes: 5de97c9f6d85 ("x86/mce: Factor out and deprecate the /dev/mcelog driver")
Reported-by: Sumanth Kamatala <skamatala@juniper.net>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/mce.h           |  6 ++++++
 arch/x86/kernel/cpu/mce/core.c       |  1 +
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 30 ++++++++++++++++++++++------
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 0607ec4f5091..54841da55357 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -369,4 +369,10 @@ umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ return
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
+
+#ifdef CONFIG_X86_MCELOG_LEGACY
+void __init dev_mcelog_init_decode_chain(void);
+#else
+static inline void dev_mcelog_init_decode_chain(void) { }
+#endif
 #endif /* _ASM_X86_MCE_H */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 22791aadc085..76c04d472e32 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2202,6 +2202,7 @@ int __init mcheck_init(void)
 	mce_register_decode_chain(&early_nb);
 	mce_register_decode_chain(&mce_uc_nb);
 	mce_register_decode_chain(&mce_default_nb);
+	dev_mcelog_init_decode_chain();
 	mcheck_vendor_init_severity();
 
 	INIT_WORK(&mce_work, mce_gen_pool_process);
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 100fbeebdc72..31b812c17ccc 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/poll.h>
+#include <linux/memblock.h>
 
 #include "internal.h"
 
@@ -341,20 +342,36 @@ static struct miscdevice mce_chrdev_device = {
 	&mce_chrdev_ops,
 };
 
-static __init int dev_mcelog_init_device(void)
+/*
+ * Register early to pick up logs when init code
+ * scans machine check banks for errors from previous
+ * kernel instance.
+ */
+__init void dev_mcelog_init_decode_chain(void)
 {
-	int mce_log_len;
-	int err;
+	int mce_log_entries, mce_log_len;
 
-	mce_log_len = max(MCE_LOG_MIN_LEN, num_online_cpus());
-	mcelog = kzalloc(struct_size(mcelog, entry, mce_log_len), GFP_KERNEL);
+	mce_log_entries = max(MCE_LOG_MIN_LEN, num_online_cpus());
+	mce_log_len = struct_size(mcelog, entry, mce_log_entries);
+	mcelog = memblock_alloc(mce_log_len, SMP_CACHE_BYTES);
 	if (!mcelog)
-		return -ENOMEM;
+		return;
 
+	memset(mcelog, 0, mce_log_len);
 	memcpy(mcelog->signature, MCE_LOG_SIGNATURE, sizeof(mcelog->signature));
 	mcelog->len = mce_log_len;
 	mcelog->recordlen = sizeof(struct mce);
 
+	mce_register_decode_chain(&dev_mcelog_nb);
+}
+
+static __init int dev_mcelog_init_device(void)
+{
+	int err;
+
+	if (!mcelog)
+		return -ENOMEM;
+
 	/* register character device /dev/mcelog */
 	err = misc_register(&mce_chrdev_device);
 	if (err) {
@@ -365,6 +382,7 @@ static __init int dev_mcelog_init_device(void)
 			pr_err("Unable to init device /dev/mcelog (rc: %d)\n", err);
 
 		kfree(mcelog);
+		mce_register_decode_chain(&dev_mcelog_nb);
 		return err;
 	}
 
-- 
2.29.2

