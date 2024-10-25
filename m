Return-Path: <linux-edac+bounces-2268-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A19AF7F6
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 05:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48051F21AEE
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 03:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1A018A6AA;
	Fri, 25 Oct 2024 03:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cux4YTx2"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112EF12B143;
	Fri, 25 Oct 2024 03:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825790; cv=none; b=VfwPjsCoK0vdyGVeT2ADnTtCn2Zb4KTMZgMS53c4HqT8QBm/auNQBZsOmhsyxARBxXthFCvJJJeBJacG3hr3agzf9nzTauU6WBHhvBqKspRUvdBSbfZv6TjxWsaqsxWBBajBVGrUHlLwT7bYYbYzqn/BtNpSmxeKD0Qi6zTyD7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825790; c=relaxed/simple;
	bh=0uEOgm/q4BVQvk6tMSgZrhriA8QBf3GJlomzmqz2PLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IXhrsJt/gCKu7xSSa96EGRlYNmvfl/rDshK+6HbZ4aUSL5yrLvNlZlm0tfgq6UARiR5TfrS5jpakDd9Id8cRv5OtVFlCdl5aLIIGwZWKGUAXSCo6KkiczG6XZ7yckVqe/yO2277y6WP0tsY2Bup7SlBjbsKaUzDRwWPo16118FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cux4YTx2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729825788; x=1761361788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=0uEOgm/q4BVQvk6tMSgZrhriA8QBf3GJlomzmqz2PLU=;
  b=Cux4YTx2oeIV4CPNxw9cng/6FccMPNBk1FhaW+R5olKSmrZN1ufS8ENs
   Pj+AgfzLCzZx5uuhrwy7H62UhEuam1lJ7b/8cBFWgWYPNl3dHeijS0Xr8
   Mx4gfwlfw2oytGMpRp+Q59FEslHx3+62VFJprRiM8HVFU87hcqy/UnS3I
   SbQQO+BzOCbz+XPD0ze3B+FhOCucLTP1+5XwPUd3yQe3UXiqJCL9w/y8f
   3aqKDbjX4XGkrMixQI/oMzZzWMPwdFjR+D4R2puksJxyS5d1WtwxWQ4t2
   v8z2b8/694CqIACfhEGfYC2UK/rRlCaPgqwh1sEfWsypcuuaE3TyoaQmJ
   w==;
X-CSE-ConnectionGUID: d5LRwnVqR0CvypabEu5L3Q==
X-CSE-MsgGUID: pxf7dSFqQY6f5jOTU5Y6Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29385518"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29385518"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:09:48 -0700
X-CSE-ConnectionGUID: cZWjJfduT8qZtsLzYsBT8w==
X-CSE-MsgGUID: 8TqFGheqQbOTRxTug3zgmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80449138"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:09:44 -0700
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
Subject: [PATCH v3 01/10] x86/mce/dev-mcelog: Use xchg() to get and clear the flags
Date: Fri, 25 Oct 2024 10:45:53 +0800
Message-Id: <20241025024602.24318-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Using xchg() to atomically get and clear the MCE log buffer flags,
streamlines the code and reduces the text size by 20 bytes.

  $ size dev-mcelog.o.*

       text	   data	    bss	    dec	    hex	filename
       3013	    360	    160	   3533	    dcd	dev-mcelog.o.old
       2993	    360	    160	   3513	    db9	dev-mcelog.o.new

No functional changes intended.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v3:
  - Collect "Reviewed-by:" from Nikolay & Sohil.

Changes in v2:
  - Collect "Reviewed-by:" from Tony.

 arch/x86/kernel/cpu/mce/dev-mcelog.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index af44fd5dbd7c..8d023239ce18 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -264,15 +264,8 @@ static long mce_chrdev_ioctl(struct file *f, unsigned int cmd,
 		return put_user(sizeof(struct mce), p);
 	case MCE_GET_LOG_LEN:
 		return put_user(mcelog->len, p);
-	case MCE_GETCLEAR_FLAGS: {
-		unsigned flags;
-
-		do {
-			flags = mcelog->flags;
-		} while (cmpxchg(&mcelog->flags, flags, 0) != flags);
-
-		return put_user(flags, p);
-	}
+	case MCE_GETCLEAR_FLAGS:
+		return put_user(xchg(&mcelog->flags, 0), p);
 	default:
 		return -ENOTTY;
 	}
-- 
2.17.1


