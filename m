Return-Path: <linux-edac+bounces-2105-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452EE9A0AD9
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 14:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D151C2214C
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 12:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD3620A5CA;
	Wed, 16 Oct 2024 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FnYazaK2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BDE20C49D;
	Wed, 16 Oct 2024 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083291; cv=none; b=gSTohC2bpe8InTkI4cbp1OoYPeiiKa5SWG7+JJWAvHr65+r/bc9p0fnxa7zjW6zm9tPq4hEqCqe0dcTRr5ft2/zEyrKawS9PTgAxJakw+QZcm2PfyDTOA+lPmFDl8wT/mlOjjvcnaiVht1EGeOmmt5xW/BdB+HA8nmiFl8uV8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083291; c=relaxed/simple;
	bh=sHQnHU4YJZwxBEj+lS+LwItMio6kPRE+zOl/Zicz/MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=prIOaI8hUi5eNbnyHJRw/MuIfWXZs6ni3cSFvQu9i/eNcHeo21Zw4Tl5/XPiTRdF7X17LTy5TJW3UAWn76T020/tA1cKXeNCwjtb3KTphRX1nVt8gtYOSn8A4cms4GNkfIG8rpW5PcIlNNOcx6d++l/ml976mqiEiKLYKlYYbbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FnYazaK2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729083291; x=1760619291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=sHQnHU4YJZwxBEj+lS+LwItMio6kPRE+zOl/Zicz/MU=;
  b=FnYazaK2ZlJ+bKBdrQWppN1xTnYkWEp4tyMlTnMpqm/WDk9g4D9adH4g
   5gIXk1INup3yvYOumk2ym2acPaDvEo6wYI3Axuqs9fFDse3S5RY3Q5WxL
   PFTP/lIKedyUTHO69/MwlWxFyqMrM+nn/3MmCWnIn7XzZWPnU2rP+ohuz
   +UxKyqQjij3hlt4K3BV8UX6l8u6EpLPhMfgn/ntyE/HOHMKFgTEdf/m8P
   66GjPZpiJyV6JaetwSNzJRNYIV3EE08Njk/Xkk0vpaeJStTwA+8C6pJJA
   J/RGdv8NoFKS06O+TRu5GZ294OS9w0Q95ppW7okwYYIAj4zIU0YGZI9oZ
   w==;
X-CSE-ConnectionGUID: Hp9BPydvRbOTZWJmo17iMw==
X-CSE-MsgGUID: 74yQ9ilLSg6yxKQryyD/cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32217630"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32217630"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:50 -0700
X-CSE-ConnectionGUID: Oz93yXp+Qnal0A4VzcHQQw==
X-CSE-MsgGUID: JVIzqzfgTmOmYFoqMxyZjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82761762"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:47 -0700
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
Subject: [PATCH v2 09/10] x86/mce/amd: Remove unnecessary NULL pointer initializations
Date: Wed, 16 Oct 2024 20:30:35 +0800
Message-Id: <20241016123036.21366-10-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

As the variables {pos, tmp, block, first_block} are all initialized
prior to their use, remove the unnecessary NULL pointer initializations.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v2:

 - Update the commit message to add the left out variable names {block, first_block}
   that this patch also fixes.

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


