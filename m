Return-Path: <linux-edac+bounces-2102-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECA69A0AD2
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 14:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C5FB28A8D
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 12:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4458420C004;
	Wed, 16 Oct 2024 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4/8JC+W"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683B20C00B;
	Wed, 16 Oct 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083267; cv=none; b=EkmgGxR8NWUOjzJV0+cB7FHk3gCGe6gruY26oSpdVS+OJcDUSAY6RPg3zDAB9dEgDn0ssX56+NwD3sOG12HAGFmVvp33FtCzDX52oYL1F+0rfvQc6zAQ3DZvUNrLe01C156FyIgiStE+n3x02WpiZVSOLGeR8FRuJFHHq2wbJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083267; c=relaxed/simple;
	bh=4/1Gq/tVFvmxsVFCu0/VVT606I6xtz69U4T1o8zM6Oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tqRISUc1FZGD3c1ATPQh0LHZHckf30xsdJ90uZoGwzMJ90unXyC4XPMxTgOp1GJc4S/BTrMMN7Sumuz78+lmRmAA6QHOndj44QnYy8DTRKAA18SLcF9HbF0z5iYe+0Yx9CU49y3gZ3W6zcsWHvFaQ9IMKxPH/W2SlJz+L2ul+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4/8JC+W; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729083266; x=1760619266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=4/1Gq/tVFvmxsVFCu0/VVT606I6xtz69U4T1o8zM6Oc=;
  b=C4/8JC+WhMNyKQKbRJbN+vz64W/p+CtSxB5ffLBhX9SL8MtM9eGf1Zi9
   fPOfyZRGBPoBLgsFcW9fnUK8Ow6O48FN65lenxH9vdn8LNhXTwdNOhx0b
   tSTwnAexsL3Vioi5kZbtkt4wp+8IJ0ooh8isrT4HSWoLnRhJeqX8NeU6i
   iFZChCX7sjCIJssNJKmstGT8BUusEvPKk1K8YzTsMBkquqmZ5IdIjLO7O
   vbr81ehuuJrBcCQc+hS2BXw3YKo3QrrhDGgIFX0IKPI2f2BSlAZ1xOVlK
   ZrygP493/ZbG4nOf8lm6fdi3Ka2BXBTtN2jYGngQ7LaJEjdUxtzHYtOS9
   A==;
X-CSE-ConnectionGUID: ZxKe/tbtTP+Zx2MzTQPFPg==
X-CSE-MsgGUID: 3NJAYPyqS4eXatbTkzyaGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32217546"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32217546"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:26 -0700
X-CSE-ConnectionGUID: AnuGBmWYQBuzwUGsNbUesA==
X-CSE-MsgGUID: behf7h16ToCWiTr1N++56Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82761725"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:23 -0700
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
Subject: [PATCH v2 06/10] x86/mce: Convert multiple if () statements into a switch() statement
Date: Wed, 16 Oct 2024 20:30:32 +0800
Message-Id: <20241016123036.21366-7-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
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

Reviewed-by: Tony Luck <tony.luck@intel.com>
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


