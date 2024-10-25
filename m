Return-Path: <linux-edac+bounces-2276-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A534E9AF807
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 05:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23798B218C2
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 03:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1373C18BC1D;
	Fri, 25 Oct 2024 03:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0VOmDdI"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E01718BBB6;
	Fri, 25 Oct 2024 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825896; cv=none; b=tP0kqbKyE56SL6eHozd9heiXwFQkYTPTK2lG/NTZYnaQ0/1CK0oqeuffVGv30p5k0y+qyPs1JOf4ujO3Kqm7Fb0lSzwS6VvSIoADpGFbXynUj10aedtDcDswmWjkNim/zjWRMEPtUbt14MLSA9WmuZ3DeY8x2C3G5L1G8yg0deA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825896; c=relaxed/simple;
	bh=WpEKt+OyZ/LmeihHlVtlOKhimP5oOSakRNdbsOE9Yr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Td2L+fUrRUzvkpCu1rv0N7B+XLe1PQ8cUR92l7qkgMr3dzf5rPj3hntoZmQjjxCJmJEU786rCNH4DVhgSdJfKNGK72kr/0iZM9X7XSUx5qZHWjwQmQtPdD2WVTYnzUr+rJrZVGvcAUXd1tl1yzsILHyxJ5Spu1A5eVjnyDFCIDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0VOmDdI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729825894; x=1761361894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WpEKt+OyZ/LmeihHlVtlOKhimP5oOSakRNdbsOE9Yr8=;
  b=M0VOmDdItNB8pRMtv6paVjJ7X/8mCKi2+DrnzMKSADqDuyL7zHC2Ia5r
   kKHkytZYw6VM3ui+IteYVbBgE5Xv71P16WfXz5hr+j9EvtVjsS1Ar4yBt
   3kH76jUAfwRoclbZ3eY6FTuCOIJvUa4B2em8+wWiwv5tNMc0nZHIwRGcK
   0VmXGj7YTwfNrVZiWZR0m06Z7R316EFbCCSpUwxWrpIYTYdNStT28QjaD
   IWBmc3hsBdTcaGT1mlydc/2Xh0QuHquABsO7s09d/GYVaswEKCrSQwr69
   IZkHER9h9macKA32KliEo9bygilkBNYyXxd1koevd3hcDKdtGnrXroPEb
   A==;
X-CSE-ConnectionGUID: dTIGKB9dS1e4T0PMY4tszA==
X-CSE-MsgGUID: 9aBJ9FkcSpOMpry1Yl0I6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29385698"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29385698"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:11:34 -0700
X-CSE-ConnectionGUID: 9etoNflWSE+jyiF50WDZsQ==
X-CSE-MsgGUID: GE6JpLNdQKGWXJ3cLGND8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80449894"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:11:32 -0700
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
Subject: [PATCH v3 09/10] x86/mce/amd: Remove unnecessary NULL pointer initializations
Date: Fri, 25 Oct 2024 10:46:01 +0800
Message-Id: <20241025024602.24318-10-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Remove unnecessary NULL pointer initializations from variables that
are already initialized before use.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v3:
 - Collect "Reviewed-by:" Nikolay & Sohil.
 - Remove the variables' names from the commit message (Sohil).

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


