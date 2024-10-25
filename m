Return-Path: <linux-edac+bounces-2271-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF3B9AF7FE
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 05:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EDD6B22219
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 03:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4AF18BBA4;
	Fri, 25 Oct 2024 03:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5D5BrZ3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95AC8DF;
	Fri, 25 Oct 2024 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825852; cv=none; b=M9Jd5MILgHbfTkd94tP8+yQmAaKAuM0ebm7emOpYGbz+vBFcKqihu/gBLaB0p/2KUf5p7CuquubpeBsI2gUasBNYiyyOULXVaSawgVC/+stmiHvwomrh3AokySh3CtgvnhrwU48lYVrLYUsBHG00tLwQ0GF1lHam+3tfNRGto1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825852; c=relaxed/simple;
	bh=7MY2dukhn6XIfllaNguSXcMiM+R8/R6lEvv9bE89fko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I9P9zJY1N+gUbEYxigThYzYPeGDcNyy1ayUqvx1+kZ/3sX5rp0DBBMIn1xIx5xQLtUUNxYhBoH4J4IbqJMKjLsy681tOHwtgimyQwvqFqUdkC8JFh9mn8OV2d1H7oKiZMvWGPGSO4WZ9I4xFuliFxZ0xzrjPzp/JpcxdnNNLTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5D5BrZ3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729825851; x=1761361851;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7MY2dukhn6XIfllaNguSXcMiM+R8/R6lEvv9bE89fko=;
  b=I5D5BrZ3up1VVucG9gdscF4QeEYwSBIzrsCrUyWD2svFe6kA1W9zdxMn
   vdquk6zDCIgE5yz0MLaWUMUAJ9jHjrmiD35gjZXTChSqEVSDjTRtlJiN3
   JnUcXNsc/7LYuoObcgDIFR5uMHvnXT0oDvYE11w11h0A9pOrYdU+qNHrE
   HAyNSLDap3kNx+xqAUGaGhbeC8DtRMA3MVbJti4jg7ipdwDpE2rI2MrJ9
   jkbb5pBg4PiFz9xy7MxVrGlFrH4fy5JGR/thXS7f4fphh9GcrOpnjFx5N
   cEKLspSy7/UfHoDCcCSTnIxtzCfPUJ+54C142rssRcYj6OMj3zx/+3Sb2
   g==;
X-CSE-ConnectionGUID: eIuRBovkSuCP5xq2kmkTrQ==
X-CSE-MsgGUID: k/JNGrDbTFKugZslUKd+rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29385601"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29385601"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:10:47 -0700
X-CSE-ConnectionGUID: 5Qw8aU1KSryf8eZL3hSdUw==
X-CSE-MsgGUID: rIiwAbl1R76GWnpkf1UVBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80449756"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:10:46 -0700
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
Subject: [PATCH v3 04/10] x86/mce/threshold: Remove the redundant this_cpu_dec_return()
Date: Fri, 25 Oct 2024 10:45:56 +0800
Message-Id: <20241025024602.24318-5-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The 'storm' variable points to this_cpu_ptr(&storm_desc). Access the
'stormy_bank_count' field through the 'storm' to avoid calling
this_cpu_*() on the same per-CPU variable twice.

This minor optimization reduces the text size by 16 bytes.

  $ size threshold.o.*
     text	   data	    bss	    dec	    hex	filename
     1395	   1664	      0	   3059	    bf3	threshold.o.old
     1379	   1664	      0	   3043	    be3	threshold.o.new

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

 arch/x86/kernel/cpu/mce/threshold.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index 89e31e1e5c9c..f4a007616468 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -90,7 +90,7 @@ void cmci_storm_end(unsigned int bank)
 	storm->banks[bank].in_storm_mode = false;
 
 	/* If no banks left in storm mode, stop polling. */
-	if (!this_cpu_dec_return(storm_desc.stormy_bank_count))
+	if (!--storm->stormy_bank_count)
 		mce_timer_kick(false);
 }
 
-- 
2.17.1


