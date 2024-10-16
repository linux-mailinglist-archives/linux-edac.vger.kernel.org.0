Return-Path: <linux-edac+bounces-2101-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470639A0ACF
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 14:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0795F283C12
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 12:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1430F209F5A;
	Wed, 16 Oct 2024 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6zfK92L"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE5420B20E;
	Wed, 16 Oct 2024 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083263; cv=none; b=XApu5N+8qxIp9gNKHUU21FeXxdmZ7za7wDZfHxiqEIKROevAdmpiOvePM1uOuzoEo5D43ChQfpqRv1wgibs0Tn9a/ggVG2TW6pJHXJzm/DYMbIpfDf72NdLGVDeHKMKgfTqyW3i0i0jjUf/b8k+KyWMlQ2bP7gJXlMj8HtLMDZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083263; c=relaxed/simple;
	bh=MbKH8dcNnkOxWPr1G1R/YGSLnrrcDN1t2+TEHYcZEW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SaKvSrL7dbJoy/8pgnaWr7gj196ohz29qHYEfrC6wGormr0sCbAlPH6ZTCDDlZ6WKhqzCGhOgke+oifWWztd/vT8WdIdYi6UYzEuCoBBV8r8rFdhM8tqXEXo8YRHFcMmXGPatLM1sl1hozlBD+m7P6LPnR42TZH/FPmKP8tE/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6zfK92L; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729083262; x=1760619262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=MbKH8dcNnkOxWPr1G1R/YGSLnrrcDN1t2+TEHYcZEW4=;
  b=c6zfK92L+JBuV0oh+lQZ0PbquR5/34AhhLdgPInVLw32v10LgYpBvFE+
   SL3qpeLq74wRRuJmXjHSXVUBM9hgxH/4tVHsRgtbKnCzI/ycP85iziJJ+
   k8zBy9N+F3Cvtqxq0Hdn9iYx7koJN/CNasr+OhDoHcoaDI9DtlSYDdHBB
   ldQ9mydiWshQHGrPZ5SB+OzXEdUbe3MrEqran3fGScqmGOZnctRUSDG8Q
   Oiw0DVueMsbOBy/1/C0cD5Ahn6DFljc3X4naV85q3Cgj5jsI1hCFOz4Cp
   YadqZ+gZyAGlbyIUrVHErXxIMXoUEMzRNVaecjyiXORtRS2Mn3m+ghLaT
   A==;
X-CSE-ConnectionGUID: Cgue9l6eQXycdzhvjDCwWw==
X-CSE-MsgGUID: ZcwSDOgQQ1GCA105waLu2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32217530"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32217530"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:19 -0700
X-CSE-ConnectionGUID: gutIEPBOQEmdkSUTdhJYuA==
X-CSE-MsgGUID: 3iUoe84zR+G79qC3HrUwjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82761713"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:16 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: tony.luck@intel.com,
	bp@alien8.de
Cc: tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH v2 05/10] x86/mce/genpool: Make mce_gen_pool_create() return explicit error codes
Date: Wed, 16 Oct 2024 20:30:31 +0800
Message-Id: <20241016123036.21366-6-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Make mce_gen_pool_create() return explicit error codes for better
readability.

No functional changes intended.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/kernel/cpu/mce/genpool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index 4284749ec803..ffa28769dea6 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -120,20 +120,20 @@ static int mce_gen_pool_create(void)
 {
 	int mce_numrecords, mce_poolsz, order;
 	struct gen_pool *gpool;
-	int ret = -ENOMEM;
 	void *mce_pool;
+	int ret;
 
 	order = order_base_2(sizeof(struct mce_evt_llist));
 	gpool = gen_pool_create(order, -1);
 	if (!gpool)
-		return ret;
+		return -ENOMEM;
 
 	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
 	mce_poolsz = mce_numrecords * (1 << order);
 	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
 	if (!mce_pool) {
 		gen_pool_destroy(gpool);
-		return ret;
+		return -ENOMEM;
 	}
 	ret = gen_pool_add(gpool, (unsigned long)mce_pool, mce_poolsz, -1);
 	if (ret) {
@@ -144,7 +144,7 @@ static int mce_gen_pool_create(void)
 
 	mce_evt_pool = gpool;
 
-	return ret;
+	return 0;
 }
 
 int mce_gen_pool_init(void)
-- 
2.17.1


