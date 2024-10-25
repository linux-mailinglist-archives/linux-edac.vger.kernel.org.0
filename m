Return-Path: <linux-edac+bounces-2272-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463899AF7FF
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 05:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035DC280E79
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 03:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C407518BC2F;
	Fri, 25 Oct 2024 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwASJNJE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C5C8DF;
	Fri, 25 Oct 2024 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825858; cv=none; b=bnbcvIasm9bf23rdiYMvqLWQvflE9IqhVFVZ3Wr17g4ftcGNkcGv37an7uvzBc1SXyUfQ7ccX335KpAP6Cjm8ymj5xG11zgFWebymimn+0lZ4hKjvcRa38uN1k38xfC+PbmcvgHXLyKnR4VClY47vdzCccAoqhF980fEMt8w/0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825858; c=relaxed/simple;
	bh=QPS8iz5o7zWCv87loTsZLqJ/0UfTu8ebHTHlpIi1YaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=b5ahnXu4tLEUouqdrMGCyY3NbAT12JiHxWSD8cNg0C3xjyCP7OR03eaPVCBWoaueP5Z9KhiBpWWHPLcWRUOo86paPkGH3/bf80wSXE7RfcjjkiZimakCbLNm+RFBcH1cVBnuKWaGcJwZGtZ7Qsbi69M94xeYz0+RZpKYydM3p4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwASJNJE; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729825857; x=1761361857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=QPS8iz5o7zWCv87loTsZLqJ/0UfTu8ebHTHlpIi1YaM=;
  b=NwASJNJEvE6diNPCF4qcm5AKgmv8g2pUpUMGDQ290n3+MlelI4iFvwpK
   QoXaOT+92yVV8KZ3Mrm1JqXUdkE0waGwvgK63rF12M36UBYBAKM+6s1kF
   Mx/LjjguI4fV3NlbXoa5DdTnFtobNAVgGXzavwHkeNUYxNyDJwyF/PsZj
   6YGUWM5LJ5Fsb4Szpw8rPblU4+hbdtMlIZuqwmw66qMzYYAVTB/Ptqb27
   GwST83sIJD93UIqpXF0UnxvoAHVmuEUenWeLt6S+9YsfpouMMg2FSgq78
   3mzxAiP6bFkSVfDZe09qJd8omHupUz9iLeqh/JdVt8Yos5A19IiRUQDVm
   w==;
X-CSE-ConnectionGUID: npknmYukTnCzRLAnHx6B4g==
X-CSE-MsgGUID: 5iC6/d33QsiEyXKL+qNBOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29385618"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29385618"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:10:57 -0700
X-CSE-ConnectionGUID: 3/nurZceRAuQhUuaq4zaLA==
X-CSE-MsgGUID: q9FQiKN1T2+rzO1dDLtZaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80449801"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:10:54 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qiuxu.zhuo@intel.com
Subject: [PATCH v3 05/10] x86/mce/genpool: Make mce_gen_pool_create() return explicit error codes
Date: Fri, 25 Oct 2024 10:45:57 +0800
Message-Id: <20241025024602.24318-6-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Make mce_gen_pool_create() return explicit error codes for better
readability.

No functional changes intended.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v3:
  - Collect "Reviewed-by:" from Nikolay & Sohil.
  - Move the 'int ret' along with the other int variables (Sohil).

Changes in v2:
 - Collect "Reviewed-by:" from Tony.

 arch/x86/kernel/cpu/mce/genpool.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index 4284749ec803..64dffb50335a 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -118,22 +118,21 @@ int mce_gen_pool_add(struct mce *mce)
 
 static int mce_gen_pool_create(void)
 {
-	int mce_numrecords, mce_poolsz, order;
+	int mce_numrecords, mce_poolsz, order, ret;
 	struct gen_pool *gpool;
-	int ret = -ENOMEM;
 	void *mce_pool;
 
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
@@ -144,7 +143,7 @@ static int mce_gen_pool_create(void)
 
 	mce_evt_pool = gpool;
 
-	return ret;
+	return 0;
 }
 
 int mce_gen_pool_init(void)
-- 
2.17.1


