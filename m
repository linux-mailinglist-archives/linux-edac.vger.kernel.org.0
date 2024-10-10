Return-Path: <linux-edac+bounces-2001-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C98B998C86
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 17:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC2E1F21DB5
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E102C1CDFD4;
	Thu, 10 Oct 2024 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FwjrL2vP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B901CDFA4;
	Thu, 10 Oct 2024 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575780; cv=none; b=TIR9Va2gDECv/7L45O3fp6HEXLta6+DLiM4LVuNKvPVSNSS3AGLy6kxidvRHH6zliE6lQq3FcFCHWeUKnqQ7Itk0d3ckmzdORibRdqaOVGByNXmbxqsWoMkFmNSVA2Buyou66xyTf/5tTgPjT+0SQdMZKb/6thmh/h6U6LPqa3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575780; c=relaxed/simple;
	bh=7+X6jaeieNzTyu8ssogMovOtcKGNTvrNvXl2BzPVSqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kh7GP7zhSIeA9W2AhPf78k+eohKE5sPpWiW/hc/RIRcOA5HO9T1iNhejjSDB3Nc4dlcJWBUvty+ybecv0PZGhk1XEDJ9AeLnnIr1VsSbrcsaVEdzUX0eaQi36IIPp6w8UTIx1hiCl/va1Ck0WWneQjzbQ4kyWdf9yOZAFM9qHt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FwjrL2vP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728575779; x=1760111779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7+X6jaeieNzTyu8ssogMovOtcKGNTvrNvXl2BzPVSqs=;
  b=FwjrL2vPCqvsIu9RWz3ddv0Gwe1SLOs7ezjVPApvi+2djnT9p7Hdq7eX
   uoUncKTdEC7U8369A304CRYe/a/AkydtdRvf76f/jrIFDYMdzIdwfpeYv
   3eIYU1G43i8ebBO6ZGBM6JEdnzy9k5sTjLZEgUo080g8c67HJmyFs1r+e
   UhPWYaIvF8H4HDwJoNND5ehbiXI9bcrkfcwkZOPsMWr0L+t5JNwRt6FlV
   CrBDhmb5/CuoSNFWYOH9zW3uQaQLNB8DHC3TO2R8RofZTDCGlBiR+/WCJ
   D302m7DoNhtpUW5BuPGB3U1m9ooCE5JWWKh5OZgP5O0AjadyWnXUDpIKo
   A==;
X-CSE-ConnectionGUID: UdDcMylnR6OdT2H9Hkpi/w==
X-CSE-MsgGUID: bPbiJd95Q5m5DF3rMknvBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="45423288"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="45423288"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:56:19 -0700
X-CSE-ConnectionGUID: kNmUVqeyTga0uGYteAwvtw==
X-CSE-MsgGUID: 9xnY+BeNRmKpwfsOH9h9Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81222842"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:56:16 -0700
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
Subject: [PATCH 09/10] x86/mce/amd: Remove unnecessary NULL pointer initializations
Date: Thu, 10 Oct 2024 23:32:01 +0800
Message-Id: <20241010153202.30876-10-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

As 'pos' and 'tmp' are initialized prior to their use in
list_for_each_entry_safe(), remove the unnecessary NULL pointer
initializations.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 4dae9841ee38..aecea842dac2 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -917,8 +917,8 @@ static void log_and_reset_block(struct threshold_block *block)
  */
 static void amd_threshold_interrupt(void)
 {
-	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
+	struct threshold_block *first_block, *block, *tmp;
 	unsigned int bank, cpu = smp_processor_id();
 
 	/*
@@ -1197,8 +1197,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 static int __threshold_add_blocks(struct threshold_bank *b)
 {
 	struct list_head *head = &b->blocks->miscj;
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
+	struct threshold_block *pos, *tmp;
 	int err = 0;
 
 	err = kobject_add(&b->blocks->kobj, b->kobj, b->blocks->kobj.name);
@@ -1308,8 +1307,7 @@ static void deallocate_threshold_blocks(struct threshold_bank *bank)
 
 static void __threshold_remove_blocks(struct threshold_bank *b)
 {
-	struct threshold_block *pos = NULL;
-	struct threshold_block *tmp = NULL;
+	struct threshold_block *pos, *tmp;
 
 	kobject_put(b->kobj);
 
-- 
2.17.1


