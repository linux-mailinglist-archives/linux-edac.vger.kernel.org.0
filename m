Return-Path: <linux-edac+bounces-2488-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731679C3865
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 07:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2421C21C1C
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 06:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E062D14F9F8;
	Mon, 11 Nov 2024 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOTg8iSe"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D895154C04;
	Mon, 11 Nov 2024 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306800; cv=none; b=nCkwzGVxz8fsKrnKiCz9fCWYhhbRg9qmmOTzSXBOufpEqp/abWO2YsNOZWwy8AaSrAam5C6hSN3b+khbuDHgfBi/Osvd0M0OQxDWhLfg2eSGNA2z41lYQhrWZ5hqpTb32IbaOvb2pGgsHw/MpuF967ALHpZy0qtkXTaCR1S5uYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306800; c=relaxed/simple;
	bh=fQ1REpPVnxbGxt0F0k8GS43rEvIgAVP3kRKZoGubAUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=C+WvOafCx3JtvXtj6XQsKhQy9AqoQVG1EQO21CypQHhPK/hiC65Yot+cJD3lbirqXVAiICtvdp3FX/RVjygjqGi4JhLipGhrytwcWJknss3iNRxOdeeBOqo8S7BhlFC+cxeEAi6jNtqqBrJbactQZ11hoZA7c0JnGUpBcJD/olY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOTg8iSe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731306799; x=1762842799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=fQ1REpPVnxbGxt0F0k8GS43rEvIgAVP3kRKZoGubAUk=;
  b=mOTg8iSe/8DjUqBtW1x+S5lNfJslVEafwOIAgtr7EiS4NiK8jbYrSxnU
   fJWN1ohJ27qmdP+0ijZTWWgDfx6FDO/BKUpIqucm6EIgD0iHOHmzo4wN1
   1fFkrESnisdI7VwiMmKzBE3NNDCIBGORT3FKQ7CqoVaGgA77Rf2/CeyL9
   vtiCIRAErrzs6ngPEwOs3l7mEIm7FgTkHuEJgeBPEyUE6PghDzhSBqAJ0
   lbSlN2PLRxPisUwsxo8UWoBZ+VyW0O4XHSlQQW3Xuz+U8QlWcAP3JXS+3
   UZQ7hhVAbu5ubyYbdyq3yygyE5f63wE/8TAJLM8yROIjwmWTVK0GLskVy
   Q==;
X-CSE-ConnectionGUID: qmETxzUyTmuEmSyZhvUz2Q==
X-CSE-MsgGUID: oVN7FEJ4RRyoL+owvEal/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="41715534"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="41715534"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:33:18 -0800
X-CSE-ConnectionGUID: /uZihFakSx+3y8FRD1XhhA==
X-CSE-MsgGUID: Lc2DZRnDSm6ShDFmF1hkdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="117684633"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:33:15 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	hpa@zytor.com,
	yazen.ghannam@amd.com,
	sohil.mehta@intel.com,
	nik.borisov@suse.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH v4 3/8] x86/mce: Make four functions return bool
Date: Mon, 11 Nov 2024 14:04:23 +0800
Message-Id: <20241111060428.44258-4-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Make those functions whose callers only care about success or failure
return a boolean value for better readability. Also, update the call
sites accordingly.

No functional changes.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v4:
  - New patch.

 arch/x86/kernel/cpu/mce/core.c     | 12 ++++++------
 arch/x86/kernel/cpu/mce/genpool.c  | 29 ++++++++++++++---------------
 arch/x86/kernel/cpu/mce/internal.h |  4 ++--
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 167965bd2ac0..ce6fe5e20805 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -151,7 +151,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(injectm);
 
 void mce_log(struct mce_hw_err *err)
 {
-	if (!mce_gen_pool_add(err))
+	if (mce_gen_pool_add(err))
 		irq_work_queue(&mce_irq_work);
 }
 EXPORT_SYMBOL_GPL(mce_log);
@@ -1911,14 +1911,14 @@ static void __mcheck_cpu_check_banks(void)
 }
 
 /* Add per CPU specific workarounds here */
-static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
+static bool __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	struct mca_config *cfg = &mca_cfg;
 
 	if (c->x86_vendor == X86_VENDOR_UNKNOWN) {
 		pr_info("unknown CPU type - not enabling MCE support\n");
-		return -EOPNOTSUPP;
+		return false;
 	}
 
 	/* This should be disabled by the BIOS, but isn't always */
@@ -2012,7 +2012,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 	if (cfg->bootlog != 0)
 		cfg->panic_timeout = 30;
 
-	return 0;
+	return true;
 }
 
 static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
@@ -2279,12 +2279,12 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	__mcheck_cpu_cap_init();
 
-	if (__mcheck_cpu_apply_quirks(c) < 0) {
+	if (!__mcheck_cpu_apply_quirks(c)) {
 		mca_cfg.disabled = 1;
 		return;
 	}
 
-	if (mce_gen_pool_init()) {
+	if (!mce_gen_pool_init()) {
 		mca_cfg.disabled = 1;
 		pr_emerg("Couldn't allocate MCE records pool!\n");
 		return;
diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index d0be6dda0c14..3ca9c007a666 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -94,64 +94,63 @@ bool mce_gen_pool_empty(void)
 	return llist_empty(&mce_event_llist);
 }
 
-int mce_gen_pool_add(struct mce_hw_err *err)
+bool mce_gen_pool_add(struct mce_hw_err *err)
 {
 	struct mce_evt_llist *node;
 
 	if (filter_mce(&err->m))
-		return -EINVAL;
+		return false;
 
 	if (!mce_evt_pool)
-		return -EINVAL;
+		return false;
 
 	node = (void *)gen_pool_alloc(mce_evt_pool, sizeof(*node));
 	if (!node) {
 		pr_warn_ratelimited("MCE records pool full!\n");
-		return -ENOMEM;
+		return false;
 	}
 
 	memcpy(&node->err, err, sizeof(*err));
 	llist_add(&node->llnode, &mce_event_llist);
 
-	return 0;
+	return true;
 }
 
-static int mce_gen_pool_create(void)
+static bool mce_gen_pool_create(void)
 {
 	int mce_numrecords, mce_poolsz, order;
 	struct gen_pool *gpool;
-	int ret = -ENOMEM;
 	void *mce_pool;
 
 	order = order_base_2(sizeof(struct mce_evt_llist));
 	gpool = gen_pool_create(order, -1);
 	if (!gpool)
-		return ret;
+		return false;
 
 	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
 	mce_poolsz = mce_numrecords * (1 << order);
 	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
 	if (!mce_pool) {
 		gen_pool_destroy(gpool);
-		return ret;
+		return false;
 	}
-	ret = gen_pool_add(gpool, (unsigned long)mce_pool, mce_poolsz, -1);
-	if (ret) {
+
+	if (gen_pool_add(gpool, (unsigned long)mce_pool, mce_poolsz, -1)) {
 		gen_pool_destroy(gpool);
 		kfree(mce_pool);
-		return ret;
+		return false;
 	}
 
 	mce_evt_pool = gpool;
 
-	return ret;
+	return true;
 }
 
-int mce_gen_pool_init(void)
+bool mce_gen_pool_init(void)
 {
 	/* Just init mce_gen_pool once. */
 	if (mce_evt_pool)
-		return 0;
+		return true;
 
 	return mce_gen_pool_create();
 }
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 84f810598231..95a504ece43e 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -31,8 +31,8 @@ struct mce_evt_llist {
 
 void mce_gen_pool_process(struct work_struct *__unused);
 bool mce_gen_pool_empty(void);
-int mce_gen_pool_add(struct mce_hw_err *err);
-int mce_gen_pool_init(void);
+bool mce_gen_pool_add(struct mce_hw_err *err);
+bool mce_gen_pool_init(void);
 struct llist_node *mce_gen_pool_prepare_records(void);
 
 int mce_severity(struct mce *a, struct pt_regs *regs, char **msg, bool is_excp);
-- 
2.17.1


