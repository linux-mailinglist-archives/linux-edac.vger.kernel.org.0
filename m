Return-Path: <linux-edac+bounces-2701-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DFF9EE84E
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 15:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D7B21682F6
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 14:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6A42153EF;
	Thu, 12 Dec 2024 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6d7QD9E"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D60215188;
	Thu, 12 Dec 2024 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012266; cv=none; b=ruOJQgVK+6wH35c0gOYU3k/662j2lqzyN6A0B2pM1WlPmYYFgm2u6lvMHWjFxYQh4cqRFa8gWpkRq8ggRv1cMaopxv+/VJsipjIKPWzMcSHiIlMz9x2WTHoO0yRaj5iXzIpAQID9l8LvnMwdoNub/rGHI11kKWgM8/KSMd6s/FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012266; c=relaxed/simple;
	bh=JAjG1ocGNBjy11UcEoLMWl8vcDfQWxElwDAlTf8j6nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=kxWycNMqoU5VrvqNxh8fV15OUMEmf2BmPHCffVVa12sDn5PYBAJl3D2jkL9QYkVXPhcUfhdLWp5SiBmfoGxKuSI1i+Ptc8iyHibxQnC8DQhhWvaSjeXffFP2hJSTRpOyEnOgItjUzgMBomLPcc7oKKNRSH+VTWBMie8c+uqnS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6d7QD9E; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734012265; x=1765548265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JAjG1ocGNBjy11UcEoLMWl8vcDfQWxElwDAlTf8j6nw=;
  b=H6d7QD9EHWmeRBdeYDUrAXPTs3E6T0wFSXNFXnJGMFS9KFxwdKmG67yo
   ard+1PaU44SjBFwxl9vIUZjqd5phXNrbUKpieqo4Ttemc2YpgyWbn7JB0
   nUFLZMhoh8hC6MI+VQl/gHl/i3jg8FkgmU1kw+rMBv26OpKXYRAMr0L8S
   YahXbQu+wu+KJgdwNeYDLSdKBWfmtcvd+s2phoKDRy0/j5aLx+MefpMWo
   TSuglJMerkc30RpGHJ99ZJEbJcLZ5JH19znUxZdDZOCCykraZhPnaHV0S
   +bQXm1QmjafLl5nLl4+kusUQSCoyWF21oDpxR+dOaqWVFn9I/p2SsMmn0
   A==;
X-CSE-ConnectionGUID: nskkjHhqSu678MgTT3A43w==
X-CSE-MsgGUID: TPtYfHCBS5GL/2zaFumbxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34155268"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34155268"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:03:53 -0800
X-CSE-ConnectionGUID: uJq4lcnFTcWHf167sw/7BQ==
X-CSE-MsgGUID: lGvI3aS+RkWkFGukAX/LQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="96465605"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 06:03:49 -0800
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
Subject: [PATCH v5 6/7] x86/mce: Remove the redundant mce_hygon_feature_init()
Date: Thu, 12 Dec 2024 22:01:02 +0800
Message-Id: <20241212140103.66964-7-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241212140103.66964-1-qiuxu.zhuo@intel.com>
References: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
 <20241212140103.66964-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Get HYGON to directly call mce_amd_feature_init() and remove the
redundant mce_hygon_feature_init().

Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v5:
  - New patch.

 arch/x86/include/asm/mce.h     | 2 --
 arch/x86/kernel/cpu/mce/core.c | 8 ++------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index ea9ca7689f6b..eb2db07ef39c 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -386,8 +386,6 @@ static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 #endif
 
-static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
-
 unsigned long copy_mc_fragile_handle_tail(char *to, char *from, unsigned len);
 
 #endif /* _ASM_X86_MCE_H */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f90cbcb31a62..0dc00c9894c7 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2118,14 +2118,10 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_intel_feature_init(c);
 		break;
 
-	case X86_VENDOR_AMD: {
+	case X86_VENDOR_AMD:
+	case X86_VENDOR_HYGON:
 		mce_amd_feature_init(c);
 		break;
-		}
-
-	case X86_VENDOR_HYGON:
-		mce_hygon_feature_init(c);
-		break;
 
 	case X86_VENDOR_CENTAUR:
 		mce_centaur_feature_init(c);
-- 
2.17.1


