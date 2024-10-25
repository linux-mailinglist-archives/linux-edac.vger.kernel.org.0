Return-Path: <linux-edac+bounces-2273-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36CC9AF802
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 05:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29D41B222A1
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 03:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B43A18BBB4;
	Fri, 25 Oct 2024 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mem5V2iL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FCC12B143;
	Fri, 25 Oct 2024 03:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825878; cv=none; b=ZGnfpdma3T52fkuZ1w5QqWzaQyQn545tPic4a9907wKruNV5Y2lfO4HT9+wfDFd4shMDXBMavAgAmuCbQbmnOXtMgy57TapOlkqLFoT7RQL32Lti4dnl4ZnJsS+ifuB75JnwK1v4YjOMkBt5gU5i+M0inGwzGOw6E9bPR/p/NfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825878; c=relaxed/simple;
	bh=vsFAIRDS1/W38+a7zORegDobcfVW3kiGbxDFfEUuVpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=oAwA+plTXWUMGr48W0K4SIgycVmHUoAK6oHr8er85IfvH5A/THZC7S+xJJd8nilRUm7JR7rzDOCcY5E++2TWHWHR/kpbzNCYPjVjZxSa0Ii4iNwvjZYpSvHvjl3ysShWFgrQ1io2gAjXvZ/IXY9jH0rgBVNNQmZS7sktbTEdCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mem5V2iL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729825876; x=1761361876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vsFAIRDS1/W38+a7zORegDobcfVW3kiGbxDFfEUuVpw=;
  b=Mem5V2iL0jjtUuqnh78xIND5p6au563TXGtR9r9Bu+P9htlFGYgJPZ+v
   bPI4xMpH68+Z5xFGbjUENXRTMM1/S1ISaxG0GeFYyAPXcXh8Ek13cgC9P
   lsTlMfqwU8kRHBUis/bnMo0ApbIsRMqvYBQTroX0dboPPFoDBp3MNN3QZ
   rESsokxOZl6Bnc4ttlE0ocHlVwAMIBmtQRcGZsYbBHwoFfopuKnD7KPBp
   0+g5noDGfv6KFK64dWwGEuauzFjJBFIinhEML7dgJqV4W8mDc63ngAKH8
   w69TsRfpYiL5i+llCNAQuTZPQmK+bRXPn5nImopUfG0PwT97b03koBE9T
   A==;
X-CSE-ConnectionGUID: oPRLgitETmGrPwaSvLObcA==
X-CSE-MsgGUID: LIOZmULbRy+otbOj0jmPwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29385649"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29385649"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:11:15 -0700
X-CSE-ConnectionGUID: ihQda9hDRsqRbXu9AVfFmQ==
X-CSE-MsgGUID: PCgTuei4QTCI+fKoT6Yjgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80449845"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:11:06 -0700
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
Subject: [PATCH v3 06/10] x86/mce: Break up __mcheck_cpu_apply_quirks()
Date: Fri, 25 Oct 2024 10:45:58 +0800
Message-Id: <20241025024602.24318-7-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

From: Tony Luck <tony.luck@intel.com>

Split each vendor specific part into its own helper function.

Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v3:
  - Newly added.

 arch/x86/kernel/cpu/mce/core.c | 194 ++++++++++++++++++---------------
 1 file changed, 106 insertions(+), 88 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 57c05015f984..bb8b1000fa0a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1880,101 +1880,119 @@ static void __mcheck_cpu_check_banks(void)
 	}
 }
 
+static void apply_quirks_amd(struct cpuinfo_x86 *c)
+{
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+	struct mca_config *cfg = &mca_cfg;
+
+	/* This should be disabled by the BIOS, but isn't always */
+	if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
+		/*
+		 * disable GART TBL walk error reporting, which
+		 * trips off incorrectly with the IOMMU & 3ware
+		 * & Cerberus:
+		 */
+		clear_bit(10, (unsigned long *)&mce_banks[4].ctl);
+	}
+	if (c->x86 < 0x11 && cfg->bootlog < 0) {
+		/*
+		 * Lots of broken BIOS around that don't clear them
+		 * by default and leave crap in there. Don't log:
+		 */
+		cfg->bootlog = 0;
+	}
+	/*
+	 * Various K7s with broken bank 0 around. Always disable
+	 * by default.
+	 */
+	if (c->x86 == 6 && this_cpu_read(mce_num_banks) > 0)
+		mce_banks[0].ctl = 0;
+
+	/*
+	 * overflow_recov is supported for F15h Models 00h-0fh
+	 * even though we don't have a CPUID bit for it.
+	 */
+	if (c->x86 == 0x15 && c->x86_model <= 0xf)
+		mce_flags.overflow_recov = 1;
+
+	if (c->x86 >= 0x17 && c->x86 <= 0x1A)
+		mce_flags.zen_ifu_quirk = 1;
+}
+
+static void apply_quirks_intel(struct cpuinfo_x86 *c)
+{
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+	struct mca_config *cfg = &mca_cfg;
+
+	/*
+	 * SDM documents that on family 6 bank 0 should not be written
+	 * because it aliases to another special BIOS controlled
+	 * register.
+	 * But it's not aliased anymore on model 0x1a+
+	 * Don't ignore bank 0 completely because there could be a
+	 * valid event later, merely don't write CTL0.
+	 */
+	if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
+		mce_banks[0].init = false;
+
+	/*
+	 * All newer Intel systems support MCE broadcasting. Enable
+	 * synchronization with a one second timeout.
+	 */
+	if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xe)) &&
+	    cfg->monarch_timeout < 0)
+		cfg->monarch_timeout = USEC_PER_SEC;
+
+	/*
+	 * There are also broken BIOSes on some Pentium M and
+	 * earlier systems:
+	 */
+	if (c->x86 == 6 && c->x86_model <= 13 && cfg->bootlog < 0)
+		cfg->bootlog = 0;
+
+	if (c->x86_vfm == INTEL_SANDYBRIDGE_X)
+		mce_flags.snb_ifu_quirk = 1;
+
+	/*
+	 * Skylake, Cascacde Lake and Cooper Lake require a quirk on
+	 * rep movs.
+	 */
+	if (c->x86_vfm == INTEL_SKYLAKE_X)
+		mce_flags.skx_repmov_quirk = 1;
+}
+
+static void apply_quirks_zhaoxin(struct cpuinfo_x86 *c)
+{
+	struct mca_config *cfg = &mca_cfg;
+
+	/*
+	 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
+	 * synchronization with a one second timeout.
+	 */
+	if (c->x86 > 6 || (c->x86_model == 0x19 || c->x86_model == 0x1f)) {
+		if (cfg->monarch_timeout < 0)
+			cfg->monarch_timeout = USEC_PER_SEC;
+	}
+}
+
 /* Add per CPU specific workarounds here */
 static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 {
-	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	struct mca_config *cfg = &mca_cfg;
 
-	if (c->x86_vendor == X86_VENDOR_UNKNOWN) {
+	switch (c->x86_vendor) {
+	case X86_VENDOR_UNKNOWN:
 		pr_info("unknown CPU type - not enabling MCE support\n");
 		return -EOPNOTSUPP;
-	}
-
-	/* This should be disabled by the BIOS, but isn't always */
-	if (c->x86_vendor == X86_VENDOR_AMD) {
-		if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
-			/*
-			 * disable GART TBL walk error reporting, which
-			 * trips off incorrectly with the IOMMU & 3ware
-			 * & Cerberus:
-			 */
-			clear_bit(10, (unsigned long *)&mce_banks[4].ctl);
-		}
-		if (c->x86 < 0x11 && cfg->bootlog < 0) {
-			/*
-			 * Lots of broken BIOS around that don't clear them
-			 * by default and leave crap in there. Don't log:
-			 */
-			cfg->bootlog = 0;
-		}
-		/*
-		 * Various K7s with broken bank 0 around. Always disable
-		 * by default.
-		 */
-		if (c->x86 == 6 && this_cpu_read(mce_num_banks) > 0)
-			mce_banks[0].ctl = 0;
-
-		/*
-		 * overflow_recov is supported for F15h Models 00h-0fh
-		 * even though we don't have a CPUID bit for it.
-		 */
-		if (c->x86 == 0x15 && c->x86_model <= 0xf)
-			mce_flags.overflow_recov = 1;
-
-		if (c->x86 >= 0x17 && c->x86 <= 0x1A)
-			mce_flags.zen_ifu_quirk = 1;
-
-	}
-
-	if (c->x86_vendor == X86_VENDOR_INTEL) {
-		/*
-		 * SDM documents that on family 6 bank 0 should not be written
-		 * because it aliases to another special BIOS controlled
-		 * register.
-		 * But it's not aliased anymore on model 0x1a+
-		 * Don't ignore bank 0 completely because there could be a
-		 * valid event later, merely don't write CTL0.
-		 */
-
-		if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
-			mce_banks[0].init = false;
-
-		/*
-		 * All newer Intel systems support MCE broadcasting. Enable
-		 * synchronization with a one second timeout.
-		 */
-		if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xe)) &&
-			cfg->monarch_timeout < 0)
-			cfg->monarch_timeout = USEC_PER_SEC;
-
-		/*
-		 * There are also broken BIOSes on some Pentium M and
-		 * earlier systems:
-		 */
-		if (c->x86 == 6 && c->x86_model <= 13 && cfg->bootlog < 0)
-			cfg->bootlog = 0;
-
-		if (c->x86_vfm == INTEL_SANDYBRIDGE_X)
-			mce_flags.snb_ifu_quirk = 1;
-
-		/*
-		 * Skylake, Cascacde Lake and Cooper Lake require a quirk on
-		 * rep movs.
-		 */
-		if (c->x86_vfm == INTEL_SKYLAKE_X)
-			mce_flags.skx_repmov_quirk = 1;
-	}
-
-	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
-		/*
-		 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
-		 * synchronization with a one second timeout.
-		 */
-		if (c->x86 > 6 || (c->x86_model == 0x19 || c->x86_model == 0x1f)) {
-			if (cfg->monarch_timeout < 0)
-				cfg->monarch_timeout = USEC_PER_SEC;
-		}
+	case X86_VENDOR_AMD:
+		apply_quirks_amd(c);
+		break;
+	case X86_VENDOR_INTEL:
+		apply_quirks_intel(c);
+		break;
+	case X86_VENDOR_ZHAOXIN:
+		apply_quirks_zhaoxin(c);
+		break;
 	}
 
 	if (cfg->monarch_timeout < 0)
-- 
2.17.1


