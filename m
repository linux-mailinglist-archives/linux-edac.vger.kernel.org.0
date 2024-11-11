Return-Path: <linux-edac+bounces-2489-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468B49C3869
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 07:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0839D282344
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 06:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FF1156644;
	Mon, 11 Nov 2024 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P3XWLy5Y"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6170155393;
	Mon, 11 Nov 2024 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306823; cv=none; b=TWQmF+z7pPJnyMWZU+X03vcK9QFyiL8ZHOZBJxRtpM5xm6uW3vGtpU+XKAIUTCdMyW6D9SOuVIlQy0UTjC7aMgZG19nPUeDghHvi1nszq3+LkkboqPLrXpEEfx6nwGI5kmUdu2SNlvm6sxLM3SIA84fACpIlAosszwG7Hpv+VEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306823; c=relaxed/simple;
	bh=b1qZB/jInl4tIhQyBG6A+5h2D5DrJJwk5eo3gXZ12Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NflSzp3xoR0yhauQ7ANz5PfvR7A9nJkPyabjCJv9lgU/yKz2XFy03Qh7Zqvm2KLEhifJlQqRNjFfJcB92ETkqHjUO1V1TFtsaMQ9Pw8A0fzciI4WGYYiAzy8mOUyqNA+8fqZU4Gkr+hVCJkH9BzjI0dXX/UPv0lbu05VSVV72sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P3XWLy5Y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731306822; x=1762842822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=b1qZB/jInl4tIhQyBG6A+5h2D5DrJJwk5eo3gXZ12Ak=;
  b=P3XWLy5YpfpY4BnWrlXCut5+urvEICIQe9bWQZg37Nos+G+7v8A0Oevq
   7IUG1sJTFk8dCJeS/TUI3C5q2U3TlMhvoXNN6KworNZKtrbEWBQCn+K7m
   ViTqY+xYPBDCdRg6XE5ZInKxeU4TKUvLbeoob8JZkNgCZBUt4osEoTqDU
   MdQ6Yp67D3t5kNVp7driH6zUdgQ6Ffn8SnFiiqv3Oh+xIvP1bqeXk3rlW
   kI49tAhtvHHqDhIkyX5FMfun+22u8Iw27gGE54+gi1cWOAazpf3xkEmYP
   rBiQr15pPycnMexwKp+X+W5rsP8kLyb67oQI2kkLUdCBcRQsLVzAsbyuy
   w==;
X-CSE-ConnectionGUID: YmdY5y4fS++fC9twWYkDWA==
X-CSE-MsgGUID: Ceoda23nRZ+N1reVPtGK+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="41715585"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="41715585"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:33:41 -0800
X-CSE-ConnectionGUID: Ckhl+3h6T1Snp1myqG4UgQ==
X-CSE-MsgGUID: Ne2UeJ9dTKaUMOrUnHxt2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="117684672"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:33:38 -0800
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
Subject: [PATCH v4 4/8] x86/mce: Break up __mcheck_cpu_apply_quirks()
Date: Mon, 11 Nov 2024 14:04:24 +0800
Message-Id: <20241111060428.44258-5-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
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


