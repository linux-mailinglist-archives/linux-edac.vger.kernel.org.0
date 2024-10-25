Return-Path: <linux-edac+bounces-2275-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA089AF805
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 05:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6883EB2259D
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 03:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE80518BBB7;
	Fri, 25 Oct 2024 03:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQ5o0bAF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E0118BBB6;
	Fri, 25 Oct 2024 03:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825889; cv=none; b=foGbEN2rfkNEMJMSyfGnLLsRWm9UdglIsjqVpjxB1qb4wIMDYeWSS+owzAucElXC3vqt4k3wkkBTSwnwnAtpsJEhL3hc0ZvpL9S5TYMDSqSP+1y6TCLEtL42v0hNTrBaANhqw7o84SqTqccltQ/dIWw414KDbhvK/ZsZPCJ1qxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825889; c=relaxed/simple;
	bh=yPW+pXi/w6LIFQbfvTmAIQnUmxbbp9VsSfQp4S0XJSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=D0VCIipDjyxyDUClixgXRLJXrRQFv8LZe2oYTMe4+wL5qs+Ugcz+D/DanVEUKS5lYmMv3o43S67r7XcTeBufu9XmOONrpAnDkujN0hplN+RPMD3h9CCAny1tE5kv+REYca9XB9v1XuzotmDe6johcRIrLcOtXDWWBgutSGTFT0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQ5o0bAF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729825888; x=1761361888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yPW+pXi/w6LIFQbfvTmAIQnUmxbbp9VsSfQp4S0XJSE=;
  b=HQ5o0bAF73KzxoVOobvfs3Mn3JYCM9l607YbRO5T7uKQClYfBlsVAA4F
   RQXkGD2cUxCw5m/eBMfi09P8ixyVa9w2hOnZieocA8wZbTcbMGeppAqcl
   HFRP4pHJ7IFfmEkmve08WuxHKHjq1gnOo2kA6JtbPc1qWO7dDpVVthbti
   0C61THu51MpDX7px3KvKJJtxARdxv9Dryc5C0uNFYOh04malLYTbUgtYz
   RBVcRYlCBXdq5WggiPJurHCBHddhWu3KKoOkx6cAjlebSzGoxudY0eAX9
   QHxmPQcQLKpRK/9RKhUeQMs0dvj4XD7xkn2W+yU0gClPS5kmhYo9WIUGr
   w==;
X-CSE-ConnectionGUID: NeqzbkgNTNuZIIz7A4ROwA==
X-CSE-MsgGUID: 1uN3c6pMT3C7fFVm+h19Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29385672"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29385672"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:11:25 -0700
X-CSE-ConnectionGUID: wQ2VafpZTJK4mEyR6ybwJQ==
X-CSE-MsgGUID: TLWjSfgvRQi7FSOdwjXeIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80449876"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:11:24 -0700
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
Subject: [PATCH v3 08/10] x86/mce: Remove the unnecessary {}
Date: Fri, 25 Oct 2024 10:46:00 +0800
Message-Id: <20241025024602.24318-9-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Remove the unnecessary {} from the case statement.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v3:
  - Collect "Reviewed-by:" from Nikolay & Sohil.

Changes in v2:
  - Collect "Reviewed-by:" from Tony.

 arch/x86/kernel/cpu/mce/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 936804a5a0b9..f57a68b53f29 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2090,10 +2090,9 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
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


