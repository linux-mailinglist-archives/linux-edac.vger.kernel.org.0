Return-Path: <linux-edac+bounces-2700-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBAD9EE84B
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 15:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7A0284264
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 14:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3B12153D2;
	Thu, 12 Dec 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CafTW9Rc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB12144A6;
	Thu, 12 Dec 2024 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012265; cv=none; b=FLK07+otFLgBffeuE6kDUt/0zm0NJ742D+YHrnGCqFSppoByUA2uZK5TCbIs2bn0c0r9TLTOq1LOJQY102epw3amd4zuv6DJ2sJ/SXeLe27JwiyOlMvnE0cdi7XIvHc18SBljluaivj5iT3g2VlBQs/GPT5YwpgmzpooIcE9W7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012265; c=relaxed/simple;
	bh=CRnalEdgYhX9PXf7PXLXrNncXJsnuFzKijuQtScciGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WpMaHRsKASVKHXVmq55L8uqgItya9Atp/tAElUFCGq5SpVFOlj9b21U2Gzc4tcZi3KteOQgMs9exkl3JkdDRwfpaUF3qxCTbatQP7qOQU4v4Czq2E1OEKOlVDeMjVdwl5cBlw+a4B4AHtHVIqD6EDK+1HHdDR1DZ4lX1wamsGrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CafTW9Rc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734012264; x=1765548264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CRnalEdgYhX9PXf7PXLXrNncXJsnuFzKijuQtScciGw=;
  b=CafTW9RcCoxChL/3gQthdGD+At7iTZMxngL98/IleJxQoVrfIlDgyrPP
   sLaGegfr0cKLbHLM+BdwUvXKdjQjuBrO/AE4kiuk2G+p3rl+R9yR8cYPN
   AKjUIi38DZ7xJaw5JWH9nQU+97w7Ehgvf2YDxITeRQ6Uf8vwfVHydkzEN
   kkCXR131zTuox0AAz1w8Sh2jUhCZVd9MJo5zuAtXpnPLj0L6lVfGn/RVG
   Nksmf5kQ1wz09YPa4AskJz7NrmildVusFZJPJ6wl+fQdeH/1yER8eJVo+
   F51GyxF26Hu7D4g6Xrc+o/1hx1MGOj1WuROjmYBaaLv1mHzLAMCF51kZ+
   A==;
X-CSE-ConnectionGUID: oY3SJGKrTDO29Ftms0lzQw==
X-CSE-MsgGUID: tMdWeme0T3yjdxGrBdofRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34155237"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34155237"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:03:47 -0800
X-CSE-ConnectionGUID: zARhF+X5T52CA5rIVzNL/g==
X-CSE-MsgGUID: u5d2uhgJS+SffjHOD0Qu+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96465588"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:03:43 -0800
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
Subject: [PATCH v5 5/7] x86/mce: Convert family/model mixed checks to VFM-based checks
Date: Thu, 12 Dec 2024 22:01:01 +0800
Message-Id: <20241212140103.66964-6-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241212140103.66964-1-qiuxu.zhuo@intel.com>
References: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Convert family/model mixed checks to VFM-based checks to make the code
more compact. Also, as 'mce_num_banks' is an unsigned int, simplify the
check from 'if (this_cpu_read(mce_num_banks) > 0)' to
'if (this_cpu_read(mce_num_banks))'.

Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v5:
  - Collect "Reviewed-by:" from Sohil & Yazen.
  - Reduce 'if (mce_num_banks > 0)' to 'if (mce_num_banks)' - Yazen.

Changes in v4:
  - No changes but rebased.

Changes in v3:
  - Newly added.

 arch/x86/kernel/cpu/mce/core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 3855ec2ed0e0..f90cbcb31a62 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1936,7 +1936,7 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
 	 * Various K7s with broken bank 0 around. Always disable
 	 * by default.
 	 */
-	if (c->x86 == 6 && this_cpu_read(mce_num_banks) > 0)
+	if (c->x86 == 6 && this_cpu_read(mce_num_banks))
 		mce_banks[0].ctl = 0;
 
 	/*
@@ -1954,6 +1954,10 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 
+	/* Older CPUs (prior to family 6) don't need quirks. */
+	if (c->x86_vfm < INTEL_PENTIUM_PRO)
+		return;
+
 	/*
 	 * SDM documents that on family 6 bank 0 should not be written
 	 * because it aliases to another special BIOS controlled
@@ -1962,22 +1966,21 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
 	 * Don't ignore bank 0 completely because there could be a
 	 * valid event later, merely don't write CTL0.
 	 */
-	if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
+	if (c->x86_vfm < INTEL_NEHALEM_EP && this_cpu_read(mce_num_banks))
 		mce_banks[0].init = false;
 
 	/*
 	 * All newer Intel systems support MCE broadcasting. Enable
 	 * synchronization with a one second timeout.
 	 */
-	if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xe)) &&
-	    mca_cfg.monarch_timeout < 0)
+	if (c->x86_vfm >= INTEL_CORE_YONAH && mca_cfg.monarch_timeout < 0)
 		mca_cfg.monarch_timeout = USEC_PER_SEC;
 
 	/*
 	 * There are also broken BIOSes on some Pentium M and
 	 * earlier systems:
 	 */
-	if (c->x86 == 6 && c->x86_model <= 13 && mca_cfg.bootlog < 0)
+	if (c->x86_vfm < INTEL_CORE_YONAH && mca_cfg.bootlog < 0)
 		mca_cfg.bootlog = 0;
 
 	if (c->x86_vfm == INTEL_SANDYBRIDGE_X)
-- 
2.17.1


