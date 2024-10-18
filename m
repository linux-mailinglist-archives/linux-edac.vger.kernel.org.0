Return-Path: <linux-edac+bounces-2143-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7796E9A47B8
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 22:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A951C20A44
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 20:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEAE200B96;
	Fri, 18 Oct 2024 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YujiOdCw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EAC1EE00E;
	Fri, 18 Oct 2024 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729282501; cv=none; b=dDW3+d8K/BqDsSb4sePXak07nopHhRqnRlBRigroeeER+hcudMgcCfLg+Vn+IPGcj3X0yzVb7ezfANu9MbGUj2PmjjhZv5N8hXtM8q4g9ur81dB5eSJ2TIBHAz+yMxpMxXCSZDVSTFROsfhQmSLf0fV9aoEsZMLn5N9GB8LCKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729282501; c=relaxed/simple;
	bh=wAQ/oFdCVMPeqHoYjJs6iERnBwfqRu91WmYEu49roWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caWuOz0JstXJiTrfxSiHzlRsYBTMN2kyyPyXnsPHFV4dUEPeUgDKp88fbCvZMjQWNwIygx10Ma2cGO3n+H73LnwfRGlJpXc7cYObdEMtsXfYDE4yWDSKbb+O0YSaZu/fOOHYHYIPyBbB/8QTak86PlasdD2oGDaxCDrBWfPkCSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YujiOdCw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729282499; x=1760818499;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wAQ/oFdCVMPeqHoYjJs6iERnBwfqRu91WmYEu49roWo=;
  b=YujiOdCwNUGzVLTMFj7eqWNtmSkahT0+J1ljzepH6RecwpieGC3EqX7W
   w0Mb3lLZGtxOF9VkhYdPigOvuHLg+zxhDxPn50y+KgN13EnN1GXzUU3FZ
   FhXUBKcF5YcOSKy9H9GmMJSKg1zZNrvfhmrJJRKFEPkeVcRTUNGWDLZoe
   27bsHYynw0tood9x4g2KOIuRVlB5qS0QokPEru1UvMxCG7gjSDh7YTrah
   pOQLUIvV0wsWaSnimm1PBYJf2Ivi41pw9Ku3yx9cOQYVF/eMfk9kXpYaO
   3UJmyjWsHExK3ro0TkmDwZHY2EMNmckZP/Jem0SbAV6ofKpN+/CiC955F
   Q==;
X-CSE-ConnectionGUID: Zqslu7TOQq+7iH7Urz+wrQ==
X-CSE-MsgGUID: Barwnjt1QuC5+gqrpSoT2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51374558"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51374558"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 13:14:59 -0700
X-CSE-ConnectionGUID: JoWCyihETbKzXa79ig2NfA==
X-CSE-MsgGUID: zHchQDUoQUicsXn4xZfCHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="79378918"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 13:14:58 -0700
Date: Fri, 18 Oct 2024 13:14:56 -0700
From: Tony Luck <tony.luck@intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, bp@alien8.de, tglx@linutronix.de,
	dave.hansen@linux.intel.com, mingo@redhat.com, hpa@zytor.com,
	x86@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into
 a switch() statement
Message-ID: <ZxLBwO4HkkJG4WYn@agluck-desk3.sc.intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-7-qiuxu.zhuo@intel.com>
 <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c928d9aa-1609-4f5f-943c-fec72091e989@intel.com>

On Fri, Oct 18, 2024 at 12:44:00PM -0700, Sohil Mehta wrote:
> > diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> > index 725c1d6fb1e5..40672fe0991a 100644
> > --- a/arch/x86/kernel/cpu/mce/core.c
> > +++ b/arch/x86/kernel/cpu/mce/core.c
> > @@ -1892,7 +1892,8 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
> >  	}
> >  
> >  	/* This should be disabled by the BIOS, but isn't always */
> 
> This comment is specific to the AMD and placing it before the switch
> makes it seem generic to the entire switch statement. It should probably
> be moved inside the AMD case just above the disable GART TLB check.
> 
> > -	if (c->x86_vendor == X86_VENDOR_AMD) {
> > +	switch (c->x86_vendor) {
> > +	case X86_VENDOR_AMD:
> >  		if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
> >  			/*
> >  			 * disable GART TBL walk error reporting, which
> > @@ -1925,9 +1926,9 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
> >  		if (c->x86 >= 0x17 && c->x86 <= 0x1A)
> >  			mce_flags.zen_ifu_quirk = 1;
> >  
> > -	}
> > +		break;
> >  
> 
> 
> Also, why not include the unknown vendor check (right above) inside the
> switch case as well?
> 
> if (c->x86_vendor == X86_VENDOR_UNKNOWN) {
> 	pr_info("unknown CPU type - not enabling MCE support\n");
> 	return -EOPNOTSUPP;
> }
> 
> This seems to follow the same pattern as others and can be the first
> case inside the switch.

The vendor specific bits are large enough to warrant their own
static functions (as we do elsewhere in this file).

How about this (only compile-tested) patch?

-Tony


From 967d8637ac90823f28f4612cbbac305c421b4853 Mon Sep 17 00:00:00 2001
From: Tony Luck <tony.luck@intel.com>
Date: Fri, 18 Oct 2024 13:01:02 -0700
Subject: [PATCH] x86/mce: Break up __mcheck_cpu_apply_quirks()

Split each vendor specific part into its own helper function.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 172 ++++++++++++++++++---------------
 1 file changed, 96 insertions(+), 76 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2a938f429c4d..f51fb393d369 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1880,101 +1880,121 @@ static void __mcheck_cpu_check_banks(void)
 	}
 }
 
-/* Add per CPU specific workarounds here */
-static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
+static void apply_quirks_amd(struct cpuinfo_x86 *c)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 	struct mca_config *cfg = &mca_cfg;
 
-	if (c->x86_vendor == X86_VENDOR_UNKNOWN) {
-		pr_info("unknown CPU type - not enabling MCE support\n");
-		return -EOPNOTSUPP;
-	}
-
 	/* This should be disabled by the BIOS, but isn't always */
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
+	if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
 		/*
-		 * Various K7s with broken bank 0 around. Always disable
-		 * by default.
+		 * disable GART TBL walk error reporting, which
+		 * trips off incorrectly with the IOMMU & 3ware
+		 * & Cerberus:
 		 */
-		if (c->x86 == 6 && this_cpu_read(mce_num_banks) > 0)
-			mce_banks[0].ctl = 0;
-
+		clear_bit(10, (unsigned long *)&mce_banks[4].ctl);
+	}
+	if (c->x86 < 0x11 && cfg->bootlog < 0) {
 		/*
-		 * overflow_recov is supported for F15h Models 00h-0fh
-		 * even though we don't have a CPUID bit for it.
+		 * Lots of broken BIOS around that don't clear them
+		 * by default and leave crap in there. Don't log:
 		 */
-		if (c->x86 == 0x15 && c->x86_model <= 0xf)
-			mce_flags.overflow_recov = 1;
+		cfg->bootlog = 0;
+	}
+	/*
+	 * Various K7s with broken bank 0 around. Always disable
+	 * by default.
+	 */
+	if (c->x86 == 6 && this_cpu_read(mce_num_banks) > 0)
+		mce_banks[0].ctl = 0;
 
-		if (c->x86 >= 0x17 && c->x86 <= 0x1A)
-			mce_flags.zen_ifu_quirk = 1;
+	/*
+	 * overflow_recov is supported for F15h Models 00h-0fh
+	 * even though we don't have a CPUID bit for it.
+	 */
+	if (c->x86 == 0x15 && c->x86_model <= 0xf)
+		mce_flags.overflow_recov = 1;
 
-	}
+	if (c->x86 >= 0x17 && c->x86 <= 0x1A)
+		mce_flags.zen_ifu_quirk = 1;
+}
 
-	if (c->x86_vendor == X86_VENDOR_INTEL) {
-		/*
-		 * SDM documents that on family 6 bank 0 should not be written
-		 * because it aliases to another special BIOS controlled
-		 * register.
-		 * But it's not aliased anymore on model 0x1a+
-		 * Don't ignore bank 0 completely because there could be a
-		 * valid event later, merely don't write CTL0.
-		 */
+static void apply_quirks_intel(struct cpuinfo_x86 *c)
+{
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+	struct mca_config *cfg = &mca_cfg;
 
-		if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
-			mce_banks[0].init = false;
+	/*
+	 * SDM documents that on family 6 bank 0 should not be written
+	 * because it aliases to another special BIOS controlled
+	 * register.
+	 * But it's not aliased anymore on model 0x1a+
+	 * Don't ignore bank 0 completely because there could be a
+	 * valid event later, merely don't write CTL0.
+	 */
 
-		/*
-		 * All newer Intel systems support MCE broadcasting. Enable
-		 * synchronization with a one second timeout.
-		 */
-		if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xe)) &&
-			cfg->monarch_timeout < 0)
-			cfg->monarch_timeout = USEC_PER_SEC;
+	if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
+		mce_banks[0].init = false;
 
-		/*
-		 * There are also broken BIOSes on some Pentium M and
-		 * earlier systems:
-		 */
-		if (c->x86 == 6 && c->x86_model <= 13 && cfg->bootlog < 0)
-			cfg->bootlog = 0;
+	/*
+	 * All newer Intel systems support MCE broadcasting. Enable
+	 * synchronization with a one second timeout.
+	 */
+	if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xe)) &&
+	    cfg->monarch_timeout < 0)
+		cfg->monarch_timeout = USEC_PER_SEC;
 
-		if (c->x86_vfm == INTEL_SANDYBRIDGE_X)
-			mce_flags.snb_ifu_quirk = 1;
+	/*
+	 * There are also broken BIOSes on some Pentium M and
+	 * earlier systems:
+	 */
+	if (c->x86 == 6 && c->x86_model <= 13 && cfg->bootlog < 0)
+		cfg->bootlog = 0;
 
-		/*
-		 * Skylake, Cascacde Lake and Cooper Lake require a quirk on
-		 * rep movs.
-		 */
-		if (c->x86_vfm == INTEL_SKYLAKE_X)
-			mce_flags.skx_repmov_quirk = 1;
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
 	}
+}
 
-	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
-		/*
-		 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
-		 * synchronization with a one second timeout.
-		 */
-		if (c->x86 > 6 || (c->x86_model == 0x19 || c->x86_model == 0x1f)) {
-			if (cfg->monarch_timeout < 0)
-				cfg->monarch_timeout = USEC_PER_SEC;
-		}
+/* Add per CPU specific workarounds here */
+static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
+{
+	struct mca_config *cfg = &mca_cfg;
+
+	switch (c->x86_vendor) {
+	case X86_VENDOR_UNKNOWN:
+		pr_info("unknown CPU type - not enabling MCE support\n");
+		return -EOPNOTSUPP;
+
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
2.47.0

> 

