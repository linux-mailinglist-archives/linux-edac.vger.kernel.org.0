Return-Path: <linux-edac+bounces-2098-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00259A0AC7
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 14:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5708E281E63
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA0A208D92;
	Wed, 16 Oct 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gamnV1Rt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A76208D9B;
	Wed, 16 Oct 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083234; cv=none; b=IhVXaaMfClenndkyuv1OIaC/u4EwiSwBfhwt8M64krPuiM1AJ0tAH6CjxMRVMSN5pxAGOEypPgbKkplSK6yKOmg0DUbGFEtSzePw4IuKUbl+iodk1Hp19wlSHBW5+0NJrg5wPDrri66+w/a7wd8O4t/NYctTZZlBPVQy0XpAe8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083234; c=relaxed/simple;
	bh=STq49VgFTjC4bsmrekCYbkUCId2+j1NN0xhOE6YrKbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=W+umLppO7i2ZFrnTYJ011OvGTsgDhDSMJ1MUfaTGa++fhimv8CjOAwJqxPs+8hsKnq6x2k+lo8mY1E3IkWWnXYM6tTubWPtIKud2G6pMSTBl0R4odMPnqqB/JdDu8s23bKFb3qenBy9ySTsfa6T0dgN0/V/IzmVQFzEG859XiA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gamnV1Rt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729083234; x=1760619234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=STq49VgFTjC4bsmrekCYbkUCId2+j1NN0xhOE6YrKbU=;
  b=gamnV1Rtw6N7MjJcRPLVqwTir5XyLMLknC81wwt5ZjtFDQkUtBvBJxO2
   ee7j/j6hPqmQZDhfB8ka6Yhx+CB2mzQV8+LnkJyo1QfmRqgp/ag1Z89Y1
   VKLaxeAif8UivgrNYvp5P6A1BbMUjcqWFPqKgvzirSvS6wM6QuKMZjKmZ
   r7xHKGYVm/OYXvF5u2+0p7KgpdUpOfdsFiT4wT8lzGzStyFBJ4EvdvyBH
   4eacYO+5ycg54jaJoRWc1hgJ4lcT/sIzEvCNQGzsLvcA3/1K8BUvGr9ja
   qQpkHWqQUAEAnqD/FQbHb+SnYYljUYnhU72vmZmaYLISlO61g0KIw8kjy
   w==;
X-CSE-ConnectionGUID: Ox/PTSZwRI+u8wEvKLHdGg==
X-CSE-MsgGUID: Ivhb6GYsSNm0sljAOWgarQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32217455"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32217455"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:53:54 -0700
X-CSE-ConnectionGUID: p2on59plT9C3dwkRvVzGAw==
X-CSE-MsgGUID: ls2+J2bsQjWhJkWPQ8OB8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82761596"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:53:50 -0700
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
Subject: [PATCH v2 02/10] x86/mce/intel: Use MCG_BANKCNT_MASK instead of 0xff
Date: Wed, 16 Oct 2024 20:30:28 +0800
Message-Id: <20241016123036.21366-3-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Use the predefined MCG_BANKCNT_MASK macro instead of the hardcoded
0xff to mask the bank number bits.

No functional changes intended.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/kernel/cpu/mce/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index f6103e6bf69a..b3cd2c61b11d 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -94,7 +94,7 @@ static int cmci_supported(int *banks)
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
 		return 0;
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
-	*banks = min_t(unsigned, MAX_NR_BANKS, cap & 0xff);
+	*banks = min_t(unsigned, MAX_NR_BANKS, cap & MCG_BANKCNT_MASK);
 	return !!(cap & MCG_CMCI_P);
 }
 
-- 
2.17.1


