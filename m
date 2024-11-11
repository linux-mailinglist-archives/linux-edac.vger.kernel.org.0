Return-Path: <linux-edac+bounces-2493-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7B89C3873
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 07:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45D81F2204D
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 06:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033D5156654;
	Mon, 11 Nov 2024 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FW/fxHuY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88A156230;
	Mon, 11 Nov 2024 06:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306858; cv=none; b=Jifh4Ju/luSOmshYy6nblCBkCvMjN56Hd5vfevr91SXHai5vm+n11yXrBRQD4d6rhIX8+W8scF408yrfh3nYROjqCw+Ezl4MgATOqjYE0vvPM5FCjSPKjRd9ctOMn+7XtK8dRM95VUV3J7QvbpEZ0/uHa+8Q7Rpu2ehslYQg2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306858; c=relaxed/simple;
	bh=L6aBYdUFJ+8rtjgXcrfup8W0UgsAFwzRbXo0gbeZSpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RHiC7HmCNnoNJMpWg+zftWnlyFoRo9+Gtq9Z0l70VEcANxADdptH1q12gDoarIvZizlX7rJuLsFsk7MpfajzSUQ5TKJZ8ICpkf1BovCALCewTc1m+EF/Q0EN964PwPY7ZpqVNR+PnpAgwOEugkmK/baS+mtNSPTj65LCHAiO5ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FW/fxHuY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731306857; x=1762842857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=L6aBYdUFJ+8rtjgXcrfup8W0UgsAFwzRbXo0gbeZSpg=;
  b=FW/fxHuYMZ7wAXR4Xt25E/qhvLYfR34YCKm8v1ZJq4FHuUuvAVG3qsyv
   Hs5piM5YFiRxH5F/O6VuwsYjUro5VqPT8AZupOETahd24BYSqa2tKeryH
   pqbZTP+ge4ckQFyZ5tZBbrLuhz1+xB7YUbFIqGbG/N0GzxGr9fTNgYSri
   xnae3I/rG4o10aa7ReRYMR8Ncfr86r8HCNLDFYhUsRWrqyEjCm4HEyTd7
   8i76myb1/wsaPyoj4dKoaiTd3LSh+Ozn6IRNjKgcXAorndH5NUtlssyZU
   OcIUULi6eZyFS1lV4t7GH0k8pFTplgcSZGbOgwO4DKpwbUWoQXtRAo5Va
   A==;
X-CSE-ConnectionGUID: 97Kn9+SoTBefvY63QMODcg==
X-CSE-MsgGUID: lO4iju5PSvWUGtaWSlxx5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="41715634"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="41715634"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:34:17 -0800
X-CSE-ConnectionGUID: YvgAcfbUStSx7H7HpQgFrA==
X-CSE-MsgGUID: d2yujnEgQ2GKrrD6H2w/cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="117684706"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 22:34:14 -0800
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
Subject: [PATCH v4 8/8] x86/mce: Fix typos
Date: Mon, 11 Nov 2024 14:04:28 +0800
Message-Id: <20241111060428.44258-9-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241111060428.44258-1-qiuxu.zhuo@intel.com>
References: <20241025024602.24318-1-qiuxu.zhuo@intel.com>
 <20241111060428.44258-1-qiuxu.zhuo@intel.com>
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
Changes in v4:
  - No changes.

Changes in v3:
  - Collect "Reviewed-by:" from Nikolay & Sohil.
  - Remove the detail typos from the commit message (Sohil).

Changes in v2:
  - Collect "Reviewed-by:" from Tony.

 arch/x86/kernel/cpu/mce/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0f0c6e9d9183..6e194ccffc7c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1144,7 +1144,7 @@ static noinstr int mce_start(int *no_way_out)
 	} else {
 		/*
 		 * Subject: Now start the scanning loop one by one in
-		 * the original callin order.
+		 * the original calling order.
 		 * This way when there are any shared banks it will be
 		 * only seen by one CPU before cleared, avoiding duplicates.
 		 */
@@ -1917,7 +1917,7 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
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


