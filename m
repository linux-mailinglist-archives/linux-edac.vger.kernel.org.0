Return-Path: <linux-edac+bounces-2106-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A61169A0ADC
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 14:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FF04B290F1
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7829820B1FA;
	Wed, 16 Oct 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwi56KRj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9620E009;
	Wed, 16 Oct 2024 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083298; cv=none; b=LhuBbcwL66zv/RDRfwQR3G1HNT+pkzybE8ZqkVpr9TOwzD0Ue2IhJY1R0lAXlWcjhYhqz7HsWYpA+KKf2ImgWmE1wAQnMaNWUp102apsdoy/l8K02BtZSpYJ/gs84P3vkGuAYZYJ8ZcZgo/F8NEydfnL5oxzW2elJ0FUTadETPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083298; c=relaxed/simple;
	bh=KPF0KACT9F/lCJwJBKf87gsgKAHCs8rYUmtPTv/KkxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=axlsMUkhPxWbI1uF8U7hrBWfd3YJGGi4hYK3sNEY9k4JNCoZByt4TPGQZklrAmhZ1Qq1WpVODQt3nvm5hTKoEMYx70nP2CkZ9pbBHbTVZ73iw+LTo3SQ1Dukz9D7DMN/dMMQLco04V3zlMzYUqQHS+DtVEBf2U0xq9mH6Tgk4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwi56KRj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729083298; x=1760619298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=KPF0KACT9F/lCJwJBKf87gsgKAHCs8rYUmtPTv/KkxQ=;
  b=iwi56KRj/FEE/MdK1kjaJLfOXHeqVzjTOpZ9YHu9jmucEMy38uFxRyBF
   3FdEU/M9wMQCa1k9daUsQ+Jy5sp8vSlM0X1XRBmqgVhjz1vmE29iGPQGL
   GK6jF4LZ6COiZfl4NShXRqBzyP2Z3L7+XyAxvqBGKqc58AxxkRsz727d/
   JLwNlzqyictAA+dKbCJRF5vNQnlRI4EKl3zh7F+LnGPh7mB1mvm70lqwi
   k8Uhep6zLX1Zzf1rTATdRUPpZcIV+oi8+OakfUpdyv8PDgfXRBPAg+GKz
   CxrQzS87vUIhZIAjLNcCxEyYTn0tm2pPlwP4F6A2mEVYhPMYpqroeb7PM
   g==;
X-CSE-ConnectionGUID: BQ+TnEiVRvmZRBXVM/GHtQ==
X-CSE-MsgGUID: 9SE9jshRRQuoZVip+PFOrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32217654"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32217654"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:57 -0700
X-CSE-ConnectionGUID: zaX0CHllRP+E2NiHohI2Zg==
X-CSE-MsgGUID: d54RCjMzRJ+vNid0sTGXig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82761777"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 05:54:54 -0700
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
Subject: [PATCH v2 10/10] x86/mce: Fix typos in comments
Date: Wed, 16 Oct 2024 20:30:36 +0800
Message-Id: <20241016123036.21366-11-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Fix the following typos in comments:

  s/callin/calling/
  s/TBL/TLB/

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 844a6f8d6f39..19e6730e7c22 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1118,7 +1118,7 @@ static noinstr int mce_start(int *no_way_out)
 	} else {
 		/*
 		 * Subject: Now start the scanning loop one by one in
-		 * the original callin order.
+		 * the original calling order.
 		 * This way when there are any shared banks it will be
 		 * only seen by one CPU before cleared, avoiding duplicates.
 		 */
@@ -1892,7 +1892,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 	case X86_VENDOR_AMD:
 		if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
 			/*
-			 * disable GART TBL walk error reporting, which
+			 * disable GART TLB walk error reporting, which
 			 * trips off incorrectly with the IOMMU & 3ware
 			 * & Cerberus:
 			 */
-- 
2.17.1


