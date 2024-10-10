Return-Path: <linux-edac+bounces-1997-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F873998C79
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 17:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B361C243FA
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FBF1CC89F;
	Thu, 10 Oct 2024 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LApmEdBN"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628CB77F1B;
	Thu, 10 Oct 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575745; cv=none; b=VpX3lJmpRpUEZSdqDSzUGG2JkFt1s7b7LYng/ToivPuATrJUij2NVc+qX08lbL4HsJ9niwLmFkC+C4ecCxYeZAKRx1wPicenezaLaw0aGkb2wP9w1I9cAhv4l8wqJ+RRFUPYggTaIm2HfeapAGj/aomy6flDWNRakpBhwMO7Zdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575745; c=relaxed/simple;
	bh=Pp2wyt/ptr6Ycpfb65KUc+cKW7kGR88mHN8sOECc6TA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MSiQ+t+a36PHOBAOPXCT4knjhEaoHqvK/ZC57WGOBCUqnFp3PIxCODIdL+avS05+z3gJ6SB5NdtMGVdeT+9TbPYLZDSiuUgfGIs+9bNddxHiOB24LasdOL/4qwE0q2oC9Qs8Dfmofz0Ugcer41yzdjcaIrqMRIteiVM/PoopzHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LApmEdBN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728575745; x=1760111745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Pp2wyt/ptr6Ycpfb65KUc+cKW7kGR88mHN8sOECc6TA=;
  b=LApmEdBN6VE8O24AqBpp8u5US5b7c0bxfy3zEj6m2cscawZfuHJ6oo0V
   5QqEVDY8M0wDMk1WxVp2bYw22f5b8DG6cWEcovLhJA5A20DFOsu0g5FNi
   jeRn+An6i8oTscPO7ptzUKWTEYwsqqmiN1bRelWm+hhHQ2nGiX5uSWqMo
   C+99cpKZy96JwP7PH0R9lW3gr7W2f71hP3vJSt/2kD5F5cYm4OwQKz+QW
   bNn9EzSCufUEW7MRUMl0e9XDPkrAEAXmCYYLTVv9RtxSGCo7qB4AtwjHT
   Mcl9O8V6fYcr8fogivLthA5JkrQCSbRZVoYVj0rPLqTFIVJS1PU8afqKU
   w==;
X-CSE-ConnectionGUID: cvCCBa/+TxCv+njKgoc7xw==
X-CSE-MsgGUID: s4IdR0DWQmec+OTAE4taNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31643903"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31643903"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:55:44 -0700
X-CSE-ConnectionGUID: FbdVvS/VRLqcxNJECJ3OtQ==
X-CSE-MsgGUID: JNwyS6ScRlmJLlZicBkzgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81222472"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:55:41 -0700
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
Subject: [PATCH 05/10] x86/mce/genpool: Make mce_gen_pool_create() return explicit error codes
Date: Thu, 10 Oct 2024 23:31:57 +0800
Message-Id: <20241010153202.30876-6-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Make mce_gen_pool_create() return explicit error codes for better
readability.

No functional changes intended.

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


