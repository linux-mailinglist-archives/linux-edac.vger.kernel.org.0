Return-Path: <linux-edac+bounces-1998-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FBE998C7A
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 17:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B099C1C2440B
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CEF1CDA05;
	Thu, 10 Oct 2024 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J2LBTCow"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2A77F1B;
	Thu, 10 Oct 2024 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575754; cv=none; b=r54RTNoO2fWZyNEYiMxNe02Ofz2qxmKj+JSbmJwuuF6TGXV2o+CpxA7M5csuHh8viPutczFIfp/6Ig2Mgzg82iOrkCqr5i+cxi+06MTQG+JcB2U6moeympXazSzQppJdscFU1gKs4gQzLfQlwQXfm51vx16dkpR1kAWbl8KF7+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575754; c=relaxed/simple;
	bh=W62PbZYRv8kc3IiXZFBqVqA0JdM2rYr+xbg62nvROiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZJWJTFmJZkV1Cfm5vPYCT2BirQQw4GQZxq/njYZyj8qJem+epTblpmLPtuKUrEV83xKUUtGZXxkeZPLZTZnOgn5MswwfhF+ExVwJ8fqS993CmLMm4QtLHNKTjwAvY8u6Ww4MJCFdVMtS5oH3gWISP5aqd+0IKeMcEnwzltt7M3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J2LBTCow; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728575754; x=1760111754;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=W62PbZYRv8kc3IiXZFBqVqA0JdM2rYr+xbg62nvROiE=;
  b=J2LBTCowS6Ws9U2NNfcJa+pmY0EpvdiEybIfLiA6zR79IjzFfb+QbKNg
   3kwWUPRt5DoAOkItOsmtKRbSf/eaXdREtncyrm1x0peDDioznW5U9i8GY
   oQ++oQcJGxcVrzsH96hyUFIT00JOEWhMRLfnGX4qUNnL1AkO4I2B8C43R
   6wocxMyFkgQ3xVE5HJvjZdlMI6wl4MdEkraxVFz2n6AUqYUpxYt/PzBkp
   jd2VYdRPl/X6XIx/ofyJosV4VDOIdQBkZO5+ZRasGXX1MLZ1baBoDtbn+
   /kiLA2zg7i5rnDO4v/yGk91SpoSYuGBEwoICxIX0fsqgzS/S3XBw642FU
   Q==;
X-CSE-ConnectionGUID: r46lKNp/Qh6ymvHngmMl4A==
X-CSE-MsgGUID: Eqwn3XF2Shub44hH8qGN7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31643959"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31643959"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:55:53 -0700
X-CSE-ConnectionGUID: XyG7ypn2S4icAU14QHtyeg==
X-CSE-MsgGUID: zMsrbkgSR4+G4llZ1A/YgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81222580"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:55:50 -0700
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
Subject: [PATCH 06/10] x86/mce: Convert multiple if () statements into a switch() statement
Date: Thu, 10 Oct 2024 23:31:58 +0800
Message-Id: <20241010153202.30876-7-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Convert the multiple if() statements used for vendor differentiation
into a switch() statement for better readability.

As a bonus, the size of new generated text is reduced by 16 bytes.

  $ size core.o.*
     text	   data	    bss	    dec	    hex	filename
    21364	   4181	   3776	  29321	   7289	core.o.old
    21348	   4181	   3776	  29305	   7279	core.o.new

No functional changes intended.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 725c1d6fb1e5..40672fe0991a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1892,7 +1892,8 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 	}
 
 	/* This should be disabled by the BIOS, but isn't always */
-	if (c->x86_vendor == X86_VENDOR_AMD) {
+	switch (c->x86_vendor) {
+	case X86_VENDOR_AMD:
 		if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
 			/*
 			 * disable GART TBL walk error reporting, which
@@ -1925,9 +1926,9 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		if (c->x86 >= 0x17 && c->x86 <= 0x1A)
 			mce_flags.zen_ifu_quirk = 1;
 
-	}
+		break;
 
-	if (c->x86_vendor == X86_VENDOR_INTEL) {
+	case X86_VENDOR_INTEL:
 		/*
 		 * SDM documents that on family 6 bank 0 should not be written
 		 * because it aliases to another special BIOS controlled
@@ -1964,9 +1965,10 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		 */
 		if (c->x86_vfm == INTEL_SKYLAKE_X)
 			mce_flags.skx_repmov_quirk = 1;
-	}
 
-	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
+		break;
+
+	case X86_VENDOR_ZHAOXIN:
 		/*
 		 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
 		 * synchronization with a one second timeout.
@@ -1975,6 +1977,8 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 			if (cfg->monarch_timeout < 0)
 				cfg->monarch_timeout = USEC_PER_SEC;
 		}
+
+		break;
 	}
 
 	if (cfg->monarch_timeout < 0)
-- 
2.17.1


