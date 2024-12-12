Return-Path: <linux-edac+bounces-2698-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C4B9EE832
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 15:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C585C284115
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCB52139A1;
	Thu, 12 Dec 2024 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6Umax10"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67B42AF0E;
	Thu, 12 Dec 2024 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012213; cv=none; b=rqNEhE8BJXZmrc/0vpF1MJ+qccQsrepEUUNX4bfx8dEL9L/wQsDRuaZDhi28WGiILMvy3yd1bXwnWg25g1ItE20lAtu6PcX6wWJb3mZfvql7e8vLzQtkQSSw70g3kqzZsTiFfybuI+EHm3tLdMpeOzxxTgdauiurH7j1uwlI1zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012213; c=relaxed/simple;
	bh=9AtoswEzvy6dedv1iFBC7Tp+vtUxFePfYFyh2Sbwe14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AEdBiyZNNN1yaAjuKHik9rTaoAiXpcpW6k6noKjzMErc7r3m35qyDyFyWRMjLDm7L6XBCTybkxDMcpZMGH9urRG6ZYEsEInFHAzEcaoJGc1DDDL2Pv2jv6YZYTC7HQq39SY37FIqp1qd6orO6JG2zv43/T4xqPxB9aLjU2ql2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6Umax10; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734012212; x=1765548212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9AtoswEzvy6dedv1iFBC7Tp+vtUxFePfYFyh2Sbwe14=;
  b=J6Umax10gjhhiAsc58beU+hvooYxhDjcp4ABM/TNEgqvA673wacNRGN2
   5OMCyduup+HHPTA9T6ESFsqKhQFwtwxCqLeQC3ZzYyXAOfqxD+wVfcG7S
   ttumGfYu4A3EFE6EfBb3bVpyKtJO2xsMvLuJgyFG6lCDD2/yQZKmFmIWL
   BNhGICixCnOdkUzHzBUupQWj3snJ2nOc5bswPpyAbWPgv3iyiLiAujtaw
   K6ZbjD+tkB6rvItUDb/lTsfeypsI4/MfnfGGCTL5rz6wVJCwQCxkvpHw1
   NxcbZcWlANMD2z/F/7mg925Pejm2QhA4Msuh0T5tfzK29vsZaKMk/3F4X
   A==;
X-CSE-ConnectionGUID: sNE8RfSgTG+DXf6RgAQNew==
X-CSE-MsgGUID: pWBjosg/TbSdvJpzbP7YSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34155157"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34155157"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:03:30 -0800
X-CSE-ConnectionGUID: 0ygcj6xbQG2nVRpXlig4XQ==
X-CSE-MsgGUID: h0bN8cvtREiO5R44HReaPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96465533"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:03:27 -0800
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
Subject: [PATCH v5 3/7] x86/mce: Make four functions return bool
Date: Thu, 12 Dec 2024 22:00:59 +0800
Message-Id: <20241212140103.66964-4-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241212140103.66964-1-qiuxu.zhuo@intel.com>
References: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Make those functions whose callers only care about success or failure
return a boolean value for better readability. Also, update the call
sites accordingly as the polarities of all the return values have been
flipped.

No functional changes.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v5:
  - Collect "Reviewed-by:" from Sohil.
  - Mention the polarities of return values are flipped in the commit message.

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


