Return-Path: <linux-edac+bounces-2002-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED26998CF4
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 18:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8026FB39D84
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2024 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9F41CCEC5;
	Thu, 10 Oct 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4UlfQig"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1619E1CCEC7;
	Thu, 10 Oct 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728575791; cv=none; b=uIABWKcC+2hf6Pqvl1BNamgXPzCKnfL0zY2X//zBr31ip/AqnvTw8kHlZSXZY+hZnmRspCvjzjrUvdjs5VKH/7ibN4cs4qyN02OlUJyWHGivcq1jkv5012wO+bHCud1cn4tc3PQd4S7PyQqPoTtHXX8B2EqCgwZvsRprb/1S1+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728575791; c=relaxed/simple;
	bh=PNjkL74Tdpas2X+jz0pbVU2iCpkA0u1uF4KLAUanT3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=U3die5/pFvsn9rAAkzP0JW3tlbuio6K4hcZgNXF48KCH7WlxDX25VL83Pq6qrQVHrCWGQK1lFcbwXkldXNdc1/aWlmXyjRO54q4LitHqkt9vQIy9LkZCQrwP1iD3QdEY+xt3MwgB3IbKCVKCyUBASrtvz1z0JPqsr91ADNASbNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4UlfQig; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728575790; x=1760111790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=PNjkL74Tdpas2X+jz0pbVU2iCpkA0u1uF4KLAUanT3I=;
  b=b4UlfQiggKKHdtM2otwQmVq2dQBJnaWJ/nzNIrKeBxEGzeJ80r+7THWG
   ZP9C9EDAJ3Y0QZhrYYgH63b6CpZMyXx7NpnHzVj8mHyt0OAAheOcD4+OW
   bO0QI7RzLBNgy1+LcufD7uXgqnn//W9LC3zPBPiaMUIV7XmcW/4aO7+db
   wgWDoPKm7cpLrYfpq23rOhI6RpZ5cH+5ZnLIlz18GI3WyP6LKGsvlNaMK
   yJIwhE1artOXwzAXfvpxm2zdcPi2591iCW8LIwuDXYbz1uvCPp3Vow5A9
   iyrDS36tVKqLZ8b9tkGvXtK7jv1GZL8Y9xT6ZsV6n9h6qqLdQoV93bdos
   w==;
X-CSE-ConnectionGUID: 9kSEgjRLTAOH5vAvb/fsUw==
X-CSE-MsgGUID: V58IyFJGRCu5r/QURsb/Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="45423314"
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="45423314"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:56:28 -0700
X-CSE-ConnectionGUID: 3wczDe8CRMWPkkN578YmDQ==
X-CSE-MsgGUID: ux5466TKS3q0sDXKScWsZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,193,1725346800"; 
   d="scan'208";a="81222905"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 08:56:26 -0700
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
Subject: [PATCH 10/10] x86/mce: Fix typos in comments
Date: Thu, 10 Oct 2024 23:32:02 +0800
Message-Id: <20241010153202.30876-11-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Fix the following typos in comments:

  s/callin/calling/
  s/TBL/TLB/

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


