Return-Path: <linux-edac+bounces-2103-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6B09A0AD3
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 14:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C289928299E
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 12:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFE0209F3E;
	Wed, 16 Oct 2024 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grwNFr5n"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427C208D96;
	Wed, 16 Oct 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083274; cv=none; b=QXj1SDWL5cRDkXqKJrB9EAiBgasCnfekjxx5OF0vdq6DEMl9UqBpOIJc5KEGvjqkwzJvgIVIIcYx1Kp+hygpjEc6AiBSHpOeO0aVdMTbJsvYgIQWulntfo3+Rp5N984QTfL3xwxvXdnayU3dSrx3MLph9Hc9O9qwZXw2COQ3Ac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083274; c=relaxed/simple;
	bh=Lu2yXq/iVgwWk6JO6I4lyOArDv2F7LCVIqz5PYCiwv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=n8up7aGPTNq9DJgfnLMpl6l3r7lSphy+td4il7IdClkdl2SR2XId4ClUW2gMlD44/hQjwnuej39PYGR+AK5q5bLJ1gTHUbk0dUjNVT+87Xn/2e82q/owtjUvCFJZm5EmHieTMNRWm6AzAPiOsVeAZqVmi2XZNg/w7+dcFfqebrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grwNFr5n; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729083274; x=1760619274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Lu2yXq/iVgwWk6JO6I4lyOArDv2F7LCVIqz5PYCiwv8=;
  b=grwNFr5n/1LPnuvKmZuL4jDSYN68RPP6FvRkTXmDQ6tO0bckn4wOlApz
   LImucOwxOwTuD3koqWw2jQEZpKkK9GKEB1FtzijrZJj+qyv6AeIuKDQw8
   CGhank0Eqp54iQEjJNMfvfYNX9TPMYYeGbs6Ld37rX7gvk1A/TU7RO5hn
   lX1ppMPwNk4wjnQUYJmEsPpeR0fHKywNYodphH1UHOtBaTTFcp9MJmES1
   c2J3fj4z7zOg0RBMJHPTM2O5STrLYTHXlhoqdXEx+NlbNEZcpTqCpEW+k
   WeXh39iW41K6othRNogoljiw7xzYGgigLrLUExAQkK6xuL8fzmO8w3rI9
   g==;
X-CSE-ConnectionGUID: HEbt3Ro8REmQdYLFtl6SsA==
X-CSE-MsgGUID: fvVQr7p8REmrQsPr0T4aug==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32217570"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32217570"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:34 -0700
X-CSE-ConnectionGUID: qeNRCg39QKydcZZVRVQCWw==
X-CSE-MsgGUID: FpEh9+IaQhSZ4qmPeZoEeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82761733"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:30 -0700
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
Subject: [PATCH v2 07/10] x86/mce: Remove the unnecessary {}
Date: Wed, 16 Oct 2024 20:30:33 +0800
Message-Id: <20241016123036.21366-8-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Remove the unnecessary {} from the case statement.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 40672fe0991a..e718b9bbe8e5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2073,10 +2073,9 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_intel_feature_init(c);
 		break;
 
-	case X86_VENDOR_AMD: {
+	case X86_VENDOR_AMD:
 		mce_amd_feature_init(c);
 		break;
-		}
 
 	case X86_VENDOR_HYGON:
 		mce_hygon_feature_init(c);
-- 
2.17.1


