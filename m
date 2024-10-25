Return-Path: <linux-edac+bounces-2274-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B71A9AF803
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 05:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E880EB22136
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 03:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A047018BC27;
	Fri, 25 Oct 2024 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="km19rUW3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7745318A6AA;
	Fri, 25 Oct 2024 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825880; cv=none; b=R4RXskBGyOEQnBTKryjUKDlzOij9juw7vvm+wPcRGbxccMoTlQh028N8cddo06K0i7XA31Ik98zFViNXYtZMytYH1WY66CWXoxQdeqPQ+90IJy+VMz2LD7pWE2fr7eB3TcBcXWGmCg6Scm6a0rWaeGe6ytZGtUzGXZi3D5KQKt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825880; c=relaxed/simple;
	bh=riRYIu549TqQL9NAjo3bdoB4DBxCVvJ1sN5Z8POMX/I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RNzbeYIS1PEBoicTUgSGHsLtkFQNf4E18zT6GokzVnZyacLqvC0zr5HpTglTx3DttLEH3e+nxZCy//fZ/+aF57AD9M+RDpRJL3FoI9kzvsEPAC8aQlr6ldcc0ul2dyvrH5yj0GNkCwlqX1bIvz9lyC3C0F4H19avClV9W0VJNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=km19rUW3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729825879; x=1761361879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=riRYIu549TqQL9NAjo3bdoB4DBxCVvJ1sN5Z8POMX/I=;
  b=km19rUW3BMKOmvuno6Q5AnClEcHv/cNH1wN4x45fiLbIQR3eLATaJiGr
   M7DBRDcPv0Ba7AwZaiJwwadgWa8o5DE1U7cKzSS5nyCBsCN255aWMsPC9
   w4rx32zcfGsJfvvtOm3kaDM5alnPBoKy3pjJxmsz12RdYjfzzQMWVSUas
   ZInv5VFaEyoD+QqdzaOuudhxCygyg2cEl9NDc8swehvjk1w7TwLhFBqJQ
   WGHSyRSgu1m2jQ+7j+8IQwozsnrF1MoMOIDb1AsHHNQD3B4p3zKcXGBj2
   zuFRQ7We8P1sjsjPJozWqsStebw2mm13B1y8QaYHmCeZZAqzmZD9IQeJH
   A==;
X-CSE-ConnectionGUID: boM+MZDoQVeDKN4nJjx9Hw==
X-CSE-MsgGUID: ETQ6LGUTQqC1650PZ5788A==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29385658"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29385658"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:11:18 -0700
X-CSE-ConnectionGUID: uOVQgan8TyaIhyG0wZVa6A==
X-CSE-MsgGUID: oFUtcQ34TdKSqEaYpoP2ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80449860"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:11:17 -0700
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
Subject: [PATCH v3 07/10] x86/mce: Convert family/model mixed checks to VFM-based checks
Date: Fri, 25 Oct 2024 10:45:59 +0800
Message-Id: <20241025024602.24318-8-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Convert family/model mixed checks to VFM-based checks to make
the code more compact.

Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v3:
  - Newly added.

 arch/x86/kernel/cpu/mce/core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bb8b1000fa0a..936804a5a0b9 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1924,6 +1924,10 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	struct mca_config *cfg = &mca_cfg;
 
+	/* Older CPUs (prior to family 6) don't need quirks. */
+	if (c->x86_vfm < INTEL_PENTIUM_PRO)
+		return;
+
 	/*
 	 * SDM documents that on family 6 bank 0 should not be written
 	 * because it aliases to another special BIOS controlled
@@ -1932,22 +1936,21 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
 	 * Don't ignore bank 0 completely because there could be a
 	 * valid event later, merely don't write CTL0.
 	 */
-	if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
+	if (c->x86_vfm < INTEL_NEHALEM_EP && this_cpu_read(mce_num_banks) > 0)
 		mce_banks[0].init = false;
 
 	/*
 	 * All newer Intel systems support MCE broadcasting. Enable
 	 * synchronization with a one second timeout.
 	 */
-	if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xe)) &&
-	    cfg->monarch_timeout < 0)
+	if (c->x86_vfm >= INTEL_CORE_YONAH && cfg->monarch_timeout < 0)
 		cfg->monarch_timeout = USEC_PER_SEC;
 
 	/*
 	 * There are also broken BIOSes on some Pentium M and
 	 * earlier systems:
 	 */
-	if (c->x86 == 6 && c->x86_model <= 13 && cfg->bootlog < 0)
+	if (c->x86_vfm < INTEL_CORE_YONAH && cfg->bootlog < 0)
 		cfg->bootlog = 0;
 
 	if (c->x86_vfm == INTEL_SANDYBRIDGE_X)
-- 
2.17.1


