Return-Path: <linux-edac+bounces-1741-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20850963AE4
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 08:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45EFC28750D
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2024 06:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796F115B543;
	Thu, 29 Aug 2024 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eYJ/FmN+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C0714A0AA;
	Thu, 29 Aug 2024 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911582; cv=none; b=LB/kHrnS9oCClxPXjQS7yDJa0FEq2uFWeSzH3fJBEfm6yh/rZVS/EroWoFQR0ahA85Cxu/Pw2T90NVUqgv6H0V0AvHKHo40lARDz4J/ZPAu6ycja1X7x5xUcFcoMf4CrUe6rAjHCR756qKebjZHO7N120HSfiI+SiSXLvVMFy5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911582; c=relaxed/simple;
	bh=CNGftTcjiHWPCuS/7frqZeGF4F0gkx+pCsq2XVAeRhY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=U8ENrxIrbqVBoogdIj0nZDVmvnstG/483oewglOsIFoq23L97DmcXPRI+CjNBGsLDybrtobdTjr3ttu9E/zfneOabArscUYZFuFqqm4k+86+khKch5Tvm0q+03+g02xTolaRWq5pPedNCoArBvcysmRwNBTHQ2+8vJzumsmnMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eYJ/FmN+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724911581; x=1756447581;
  h=from:to:cc:subject:date:message-id;
  bh=CNGftTcjiHWPCuS/7frqZeGF4F0gkx+pCsq2XVAeRhY=;
  b=eYJ/FmN+7a32cZjl+WFVkCgRmI6+54m+OGSXOuUQvuJvszLVOr+tySZb
   a9T3aapRoenqjOrU7KakDWafjDPLQXPo1QvXWN+lXHxg+jU1f0ccrxWf+
   v81Orc2PeBDHBznwhnWqfUTMG1UNB/ioLcxIw4xMy1kYA1LB7AMA8ZmaG
   RNSdjjxx9GdXGn5hWqd88HlW0T4axz4Pb0aDJ/kr2kN/3DFH3dpBJKAtx
   JMfEyzIhTTQezPOBBxAjoPXCe33v1AR6cqb9b0J9EdMN9LzWyaXd2ARr0
   /lCMxum1quCTks6vptUu1LlfDa5lfHQjHiEdzC4I7SQ8/p8/EOZULbVFR
   Q==;
X-CSE-ConnectionGUID: sC5NQrhGRsutusXnr/g32Q==
X-CSE-MsgGUID: TQzpLlyzQhOqv9k18+vqEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23668287"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23668287"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 23:06:21 -0700
X-CSE-ConnectionGUID: xTtIh/t0TWKxu4OzzxO7bg==
X-CSE-MsgGUID: sjomjephRYGRHanCKiGRBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="64158261"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 23:06:18 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/{skx_common,skx,i10nm}: Move the common debug code to skx_common
Date: Thu, 29 Aug 2024 13:51:01 +0800
Message-Id: <20240829055101.56245-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Commit

  afdb82fd763c ("EDAC, i10nm: make skx_common.o a separate module")

made skx_common.o a separate module. With skx_common.o now a separate
module, move the common debug code setup_{skx,i10nm}_debug() and
teardown_{skx,i10nm}_debug() in {skx,i10nm}_base.c to skx_common.c to
reduce code duplication. Additionally, prefix these function names with
'skx' to maintain consistency with other names in the file.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 52 ++-------------------------------------
 drivers/edac/skx_base.c   | 52 ++-------------------------------------
 drivers/edac/skx_common.c | 47 +++++++++++++++++++++++++++++++++++
 drivers/edac/skx_common.h |  8 ++++++
 4 files changed, 59 insertions(+), 100 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 24dd896d9a9d..c5b99d575cc7 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -1013,54 +1013,6 @@ static struct notifier_block i10nm_mce_dec = {
 	.priority	= MCE_PRIO_EDAC,
 };
 
-#ifdef CONFIG_EDAC_DEBUG
-/*
- * Debug feature.
- * Exercise the address decode logic by writing an address to
- * /sys/kernel/debug/edac/i10nm_test/addr.
- */
-static struct dentry *i10nm_test;
-
-static int debugfs_u64_set(void *data, u64 val)
-{
-	struct mce m;
-
-	pr_warn_once("Fake error to 0x%llx injected via debugfs\n", val);
-
-	memset(&m, 0, sizeof(m));
-	/* ADDRV + MemRd + Unknown channel */
-	m.status = MCI_STATUS_ADDRV + 0x90;
-	/* One corrected error */
-	m.status |= BIT_ULL(MCI_STATUS_CEC_SHIFT);
-	m.addr = val;
-	skx_mce_check_error(NULL, 0, &m);
-
-	return 0;
-}
-DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
-
-static void setup_i10nm_debug(void)
-{
-	i10nm_test = edac_debugfs_create_dir("i10nm_test");
-	if (!i10nm_test)
-		return;
-
-	if (!edac_debugfs_create_file("addr", 0200, i10nm_test,
-				      NULL, &fops_u64_wo)) {
-		debugfs_remove(i10nm_test);
-		i10nm_test = NULL;
-	}
-}
-
-static void teardown_i10nm_debug(void)
-{
-	debugfs_remove_recursive(i10nm_test);
-}
-#else
-static inline void setup_i10nm_debug(void) {}
-static inline void teardown_i10nm_debug(void) {}
-#endif /*CONFIG_EDAC_DEBUG*/
-
 static int __init i10nm_init(void)
 {
 	u8 mc = 0, src_id = 0, node_id = 0;
@@ -1159,7 +1111,7 @@ static int __init i10nm_init(void)
 
 	opstate_init();
 	mce_register_decode_chain(&i10nm_mce_dec);
-	setup_i10nm_debug();
+	skx_setup_debug("i10nm_test");
 
 	if (retry_rd_err_log && res_cfg->offsets_scrub && res_cfg->offsets_demand) {
 		skx_set_decode(i10nm_mc_decode, show_retry_rd_err_log);
@@ -1187,7 +1139,7 @@ static void __exit i10nm_exit(void)
 			enable_retry_rd_err_log(false);
 	}
 
-	teardown_i10nm_debug();
+	skx_teardown_debug();
 	mce_unregister_decode_chain(&i10nm_mce_dec);
 	skx_adxl_put();
 	skx_remove();
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index af3fa807acdb..14cfd394b469 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -587,54 +587,6 @@ static struct notifier_block skx_mce_dec = {
 	.priority	= MCE_PRIO_EDAC,
 };
 
-#ifdef CONFIG_EDAC_DEBUG
-/*
- * Debug feature.
- * Exercise the address decode logic by writing an address to
- * /sys/kernel/debug/edac/skx_test/addr.
- */
-static struct dentry *skx_test;
-
-static int debugfs_u64_set(void *data, u64 val)
-{
-	struct mce m;
-
-	pr_warn_once("Fake error to 0x%llx injected via debugfs\n", val);
-
-	memset(&m, 0, sizeof(m));
-	/* ADDRV + MemRd + Unknown channel */
-	m.status = MCI_STATUS_ADDRV + 0x90;
-	/* One corrected error */
-	m.status |= BIT_ULL(MCI_STATUS_CEC_SHIFT);
-	m.addr = val;
-	skx_mce_check_error(NULL, 0, &m);
-
-	return 0;
-}
-DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
-
-static void setup_skx_debug(void)
-{
-	skx_test = edac_debugfs_create_dir("skx_test");
-	if (!skx_test)
-		return;
-
-	if (!edac_debugfs_create_file("addr", 0200, skx_test,
-				      NULL, &fops_u64_wo)) {
-		debugfs_remove(skx_test);
-		skx_test = NULL;
-	}
-}
-
-static void teardown_skx_debug(void)
-{
-	debugfs_remove_recursive(skx_test);
-}
-#else
-static inline void setup_skx_debug(void) {}
-static inline void teardown_skx_debug(void) {}
-#endif /*CONFIG_EDAC_DEBUG*/
-
 /*
  * skx_init:
  *	make sure we are running on the correct cpu model
@@ -728,7 +680,7 @@ static int __init skx_init(void)
 	/* Ensure that the OPSTATE is set correctly for POLL or NMI */
 	opstate_init();
 
-	setup_skx_debug();
+	skx_setup_debug("skx_test");
 
 	mce_register_decode_chain(&skx_mce_dec);
 
@@ -742,7 +694,7 @@ static void __exit skx_exit(void)
 {
 	edac_dbg(2, "\n");
 	mce_unregister_decode_chain(&skx_mce_dec);
-	teardown_skx_debug();
+	skx_teardown_debug();
 	if (nvdimm_count)
 		skx_adxl_put();
 	skx_remove();
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 8d18099fd528..7cd074401167 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -739,6 +739,53 @@ void skx_remove(void)
 }
 EXPORT_SYMBOL_GPL(skx_remove);
 
+#ifdef CONFIG_EDAC_DEBUG
+/*
+ * Debug feature.
+ * Exercise the address decode logic by writing an address to
+ * /sys/kernel/debug/edac/{skx,i10nm}_test/addr.
+ */
+static struct dentry *skx_test;
+
+static int debugfs_u64_set(void *data, u64 val)
+{
+	struct mce m;
+
+	pr_warn_once("Fake error to 0x%llx injected via debugfs\n", val);
+
+	memset(&m, 0, sizeof(m));
+	/* ADDRV + MemRd + Unknown channel */
+	m.status = MCI_STATUS_ADDRV + 0x90;
+	/* One corrected error */
+	m.status |= BIT_ULL(MCI_STATUS_CEC_SHIFT);
+	m.addr = val;
+	skx_mce_check_error(NULL, 0, &m);
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
+
+void skx_setup_debug(const char *name)
+{
+	skx_test = edac_debugfs_create_dir(name);
+	if (!skx_test)
+		return;
+
+	if (!edac_debugfs_create_file("addr", 0200, skx_test,
+				      NULL, &fops_u64_wo)) {
+		debugfs_remove(skx_test);
+		skx_test = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(skx_setup_debug);
+
+void skx_teardown_debug(void)
+{
+	debugfs_remove_recursive(skx_test);
+}
+EXPORT_SYMBOL_GPL(skx_teardown_debug);
+#endif /*CONFIG_EDAC_DEBUG*/
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Tony Luck");
 MODULE_DESCRIPTION("MC Driver for Intel server processors");
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 473421ba7a18..f945c1bf5ca4 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -259,4 +259,12 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 
 void skx_remove(void);
 
+#ifdef CONFIG_EDAC_DEBUG
+void skx_setup_debug(const char *name);
+void skx_teardown_debug(void);
+#else
+static inline void skx_setup_debug(const char *name) {}
+static inline void skx_teardown_debug(void) {}
+#endif
+
 #endif /* _SKX_COMM_EDAC_H */
-- 
2.17.1


