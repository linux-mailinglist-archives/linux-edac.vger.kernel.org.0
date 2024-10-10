Return-Path: <linux-edac+bounces-1994-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03793998C72
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 17:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1136D1C2440D
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0CB1CC89F;
	Thu, 10 Oct 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFU/h6r/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA301C7B68;
	Thu, 10 Oct 2024 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575724; cv=none; b=P3ik2SFiuqJT5yZk5OuqBQbf7Q6kKm7XzuW9k4NvEYKkua6hqD3imH9LaUIahiwmYBfQS7v5c4IcmHTy0E69D9CGR3MMJCqDK/Uaiw4sX5OxiANVR7iLRdNxVWCXovKqtqWglUnFv9sE6ctKrAyOcw1/AUCre1W9RbHyx2eVl/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575724; c=relaxed/simple;
	bh=BMNK5iWgnrtok45sdEr4evWdiRWQlKExtRudo8k9bE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=t9EOuPcag699LJuQO19DYCJDDFkEH8mqNb016vU0ms7yyJ9KzKRb9rmN1dOLGYIRsM3TvaQBrfcijS24LIwXonkT1p1M1e/q3vDGgAGQa/BpM52HEVp9r1aXt6Lha8urX8VPVHsmp5RpGdg/MCs7Ih+ip+mcrbNSg6xOEgFYeFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFU/h6r/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728575723; x=1760111723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BMNK5iWgnrtok45sdEr4evWdiRWQlKExtRudo8k9bE4=;
  b=YFU/h6r/R/cO/Wlq++p5lofmHvnXCP9tX4IDEktkkW+RpDcrvLlMiUdp
   VK/Uk8ZTIroeJDABZ/lBJfsEAW4FD/iB9WL/izQVEdcvAD5mXgQz0AV4l
   ybvfj80LTILdGgs7/JvAicpMGtQP6ZPkv3FQpCqeWmbK9CogNNY998oYE
   nkJsyOr82b0fBQRJmeYrP6zH+n0WG0u9dTYxJS1cZ8d3S1PxAOaeAQq6m
   VxPsTdn5m9yfeeXTIi9r5xSMhz/bjxEJ0wXKfaTRolKgPmQl1x0YDE22g
   +zBwbJsIocOcz00ezZ25pYhK4s3dOF6SYPCFWAD/+G8fpHcliZNNVz6oI
   w==;
X-CSE-ConnectionGUID: y0wmHGQ8TBG5DSIS3QMyvw==
X-CSE-MsgGUID: tvt/UzDrQ1CzSJRP16Vh3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31643871"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="31643871"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:55:23 -0700
X-CSE-ConnectionGUID: NqibyQLaTPywmMm5dsawOg==
X-CSE-MsgGUID: B25iujqmRiy1uqt4FB5BCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81222178"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:54:54 -0700
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
Subject: [PATCH 02/10] x86/mce/intel: Use MCG_BANKCNT_MASK instead of 0xff
Date: Thu, 10 Oct 2024 23:31:54 +0800
Message-Id: <20241010153202.30876-3-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Use the predefined MCG_BANKCNT_MASK macro instead of the hardcoded
0xff to mask the bank number bits.

No functional changes intended.

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


