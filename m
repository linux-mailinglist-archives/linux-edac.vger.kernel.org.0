Return-Path: <linux-edac+bounces-2699-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A324E9EE843
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 15:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AF2284228
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 14:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDC521506B;
	Thu, 12 Dec 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZggm9x4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D512135BA;
	Thu, 12 Dec 2024 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012263; cv=none; b=rwMdWHpUrKMOoHFTwNrwSppHR2I3n9mNr69y2RzasvLmbrLgxFCBYZjg0UPtEWTgMmDSj+DeRxonGDER+ukg4kszaX5bPWYa7tqXVxyghfaW1EyE4oGlZSpuVDyygvg+9cHCtGNfDubLylLJCwpK9IVadyiYVvcxmSwrQkbmWAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012263; c=relaxed/simple;
	bh=LPOTicj7Z0PLHA0FQdORXAwNTLqZoav5MTDoWYk74n8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pLLrW4cHh48ymZUz9wLZIu+zZcxSrN+iqgtglgG3plQPkYXT0hDiDb1VgimhHePpaEAEtVVx1209kMoNFEMZiWVJ1yY5XCj0t6FB0kBLF+qoQ/vAtWemDLw3qX+6nqbcu02zawBJwFl2OMJ7+jQH5RIoJp2ogo6ssd6tZt15n2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZggm9x4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734012262; x=1765548262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=LPOTicj7Z0PLHA0FQdORXAwNTLqZoav5MTDoWYk74n8=;
  b=OZggm9x40zm3sQ1XgK52sFgwgX6Lp0wqwMBwwYnLWrc92g/N484Jn3k/
   RnKOyqh0D97Enj8BshPmMo3bwZ50wi0OHrrPpNanrdZV0r0ihWJq8ReGD
   i2+WPY1hGlFv6ezG4v9m2r1J5tjjgFSIY0erf960HDLnOxJmp0nDLS83o
   ZwGHKcWH3y7r4qaFjqWlqZioI3Z/+SlgPeHq2OipSSX/Sjuz0rCXkOA8s
   aXA06IttV3XEfFMFkT7/eUmxTdkIo23h2T91dgt0V9SGJhib8Iw5o90qx
   Az7pflDX5Sd+qvd89dftd1PaFPm52jid9+hCDfiAiK3Ac/s4x9uJoSWgV
   A==;
X-CSE-ConnectionGUID: om4/JRrHTHCJqse7LyLBUQ==
X-CSE-MsgGUID: N9eHeA5VRGi/556pKrGV+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34155204"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34155204"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:03:40 -0800
X-CSE-ConnectionGUID: +zW2Ui/UQ4qqWM2MwK+S2g==
X-CSE-MsgGUID: mh4AtgyrTRmxt7fqIZq0ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96465567"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:03:35 -0800
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
Subject: [PATCH v5 4/7] x86/mce: Break up __mcheck_cpu_apply_quirks()
Date: Thu, 12 Dec 2024 22:01:00 +0800
Message-Id: <20241212140103.66964-5-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241212140103.66964-1-qiuxu.zhuo@intel.com>
References: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

From: Tony Luck <tony.luck@intel.com>

Split each vendor specific part into its own helper function.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v5:
  - Collect "Reviewed-by:" from Sohil.

Changes in v4:
  - Add necessary blank lines in apply_quirks_amd() (Yazen).
  - Use 'mca_cfg' instead of 'cfg' in apply_quirks_*(). (Yazen).

Changes in v3:
  - New patch.

 arch/x86/kernel/cpu/mce/core.c | 192 ++++++++++++++++++---------------
 1 file changed, 104 insertions(+), 88 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ce6fe5e20805..3855ec2ed0e0 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1910,101 +1910,117 @@ static void __mcheck_cpu_check_banks(void)
 	}
 }
 
+static void apply_quirks_amd(struct cpuinfo_x86 *c)
+{
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
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
+
+	if (c->x86 < 0x11 && mca_cfg.bootlog < 0) {
+		/*
+		 * Lots of broken BIOS around that don't clear them
+		 * by default and leave crap in there. Don't log:
+		 */
+		mca_cfg.bootlog = 0;
+	}
+
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
+	    mca_cfg.monarch_timeout < 0)
+		mca_cfg.monarch_timeout = USEC_PER_SEC;
+
+	/*
+	 * There are also broken BIOSes on some Pentium M and
+	 * earlier systems:
+	 */
+	if (c->x86 == 6 && c->x86_model <= 13 && mca_cfg.bootlog < 0)
+		mca_cfg.bootlog = 0;
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
+	/*
+	 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
+	 * synchronization with a one second timeout.
+	 */
+	if (c->x86 > 6 || (c->x86_model == 0x19 || c->x86_model == 0x1f)) {
+		if (mca_cfg.monarch_timeout < 0)
+			mca_cfg.monarch_timeout = USEC_PER_SEC;
+	}
+}
+
 /* Add per CPU specific workarounds here */
 static bool __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 {
-	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	struct mca_config *cfg = &mca_cfg;
 
-	if (c->x86_vendor == X86_VENDOR_UNKNOWN) {
+	switch (c->x86_vendor) {
+	case X86_VENDOR_UNKNOWN:
 		pr_info("unknown CPU type - not enabling MCE support\n");
 		return false;
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


