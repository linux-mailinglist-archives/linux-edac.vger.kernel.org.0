Return-Path: <linux-edac+bounces-2277-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6679AF809
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 05:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E42B2270C
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 03:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2FF18BC30;
	Fri, 25 Oct 2024 03:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYCp1dmD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9810F18BBB6;
	Fri, 25 Oct 2024 03:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825905; cv=none; b=kTeq83xijreDv4PVLyvVShxv5PGrShRhIkIZ6jf4ltSiMmoMnQjJDc4NV/129yS5cgLOOi2U80vePVL2E5UvPJUet6+PPjOXfVSrl9QTKHnJLqPO3/2tA+hh8LPnUWUGT5PRAEx1dtvUmgyB+GjY+NB8wK+SY2cMVXGVwvi6Ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825905; c=relaxed/simple;
	bh=V8zzovwYy1ulp14Q8Qe/O8aSZptBzsbTOCd71cVBp4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OOkp/9U6onfwObjC0mgcG5sYxgLvujBRapakIwOFgwNoAYiBL99hmn8XHz2YS++ozbaM0up+ZeV+30ssszAJOuiEdOz8cXgrdq/I9u01aFCetiQORwN1pXPjvEX9oS20x0Gw+fB1mxkfxAYPAqde2f/HRiNgIUtyDKUnz760fR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYCp1dmD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729825904; x=1761361904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=V8zzovwYy1ulp14Q8Qe/O8aSZptBzsbTOCd71cVBp4I=;
  b=bYCp1dmDgzLmkdq2+lJgamKzEkp7EvM0RIY+XpA6LRkPEQvd23UX/MJ5
   /7vy6Ux6V4sd29VsW16XfCYMnqloPZPQn9imULyjrsapRvKGPl8KRolet
   ph3C/Eej2kK735v1qbMsxVgvkLQysmC2QaVtvac5X7igE6GU8I91Oj2Jc
   xkC4HorF/snc4YuM/1NO5d2xMNJOB3GDlG2YvGlytbdGMEsLDLFkWNg8+
   yJhYQ1OZERkvssGlbfzfgMUxXxlkMQLy3lXIQ+8FjNA5oveYwZd4qB71v
   0zPUkuQpTh8ABgyKw+MWAN9iatAs1CXb9qB90kwSKKE2xhS5Q9Dxg29vc
   A==;
X-CSE-ConnectionGUID: VaPi1RcWRYKXJb8S3nSQew==
X-CSE-MsgGUID: vR6pP9ldQz+ZWsOokuNM1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29385719"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="29385719"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:11:43 -0700
X-CSE-ConnectionGUID: 94i8JjGsSQCes6WDUO6cgg==
X-CSE-MsgGUID: FNjHbGCwTWWVLrjUzfpr2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80449907"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 20:11:42 -0700
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
Subject: [PATCH v3 10/10] x86/mce: Fix typos
Date: Fri, 25 Oct 2024 10:46:02 +0800
Message-Id: <20241025024602.24318-11-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
References: <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241025024602.24318-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Fix typos in comments.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Changes in v3:
  - Collect "Reviewed-by:" from Nikolay & Sohil.
  - Remove the detail typos from the commit message (Sohil).

Changes in v2:
  - Collect "Reviewed-by:" from Tony.

 arch/x86/kernel/cpu/mce/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f57a68b53f29..4c4558ed4736 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1120,7 +1120,7 @@ static noinstr int mce_start(int *no_way_out)
 	} else {
 		/*
 		 * Subject: Now start the scanning loop one by one in
-		 * the original callin order.
+		 * the original calling order.
 		 * This way when there are any shared banks it will be
 		 * only seen by one CPU before cleared, avoiding duplicates.
 		 */
@@ -1888,7 +1888,7 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
 	/* This should be disabled by the BIOS, but isn't always */
 	if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
 		/*
-		 * disable GART TBL walk error reporting, which
+		 * disable GART TLB walk error reporting, which
 		 * trips off incorrectly with the IOMMU & 3ware
 		 * & Cerberus:
 		 */
-- 
2.17.1


