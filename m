Return-Path: <linux-edac+bounces-222-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAED807E16
	for <lists+linux-edac@lfdr.de>; Thu,  7 Dec 2023 02:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CA41C209BA
	for <lists+linux-edac@lfdr.de>; Thu,  7 Dec 2023 01:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5FD1399;
	Thu,  7 Dec 2023 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCv1hmmT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755E819E;
	Wed,  6 Dec 2023 17:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701913533; x=1733449533;
  h=from:to:cc:subject:date:message-id;
  bh=KiFqkDFxamxUcRrbdcfuGE7EYU7NwqcueANUY2UM/s4=;
  b=DCv1hmmT5u7iHdRD3T4RZL8nio79GM35ANZ0jCvl4zsiwvVW178DMnt3
   pS0GYldCX0/7PFkFaYfkqFz7ZGuGYWeI2WKDCgl6Bu7u/o6cOvutKdYeK
   bpuG0mmILCZms86zpjYszkZRji/XwGFB6LnJVEawEVBMnG4zVbDf+SL+G
   erY1+yNphe8UgjkpB1+wZFSCEPOt8LgJvKl+b2cjrz6QcHvFGFJbdZ7Rv
   2Ih7k1u8y2O1iXNTqEO1vus6TZEtbIOBKpR5Cz6JK4FWfwiZ32HMI1lnY
   8h5GiV4A4tBWkAOaVE9CBW/OLQVBkAuzmecuPsvDsxN6/HHwp2g+LBteE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="374328473"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="374328473"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 17:45:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="805839984"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="805839984"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 17:45:30 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Aristeu Rozanski <aris@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/skx_common: Filter out the invalid address
Date: Thu,  7 Dec 2023 09:45:12 +0800
Message-Id: <20231207014512.78564-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Decoding an invalid address with certain firmware decoders could
cause a #PF (Page Fault) in the EFI runtime context, which could
subsequently hang the system. To make {i10nm,skx}_edac more robust
against such bogus firmware decoders, filter out invalid addresses
before allowing the firmware decoder to process them.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index ce3e0069e028..9c5b6f8bd8bd 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -648,6 +648,10 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	memset(&res, 0, sizeof(res));
 	res.mce  = mce;
 	res.addr = mce->addr & MCI_ADDR_PHYSADDR;
+	if (!pfn_to_online_page(res.addr >> PAGE_SHIFT)) {
+		pr_err("Invalid address 0x%llx in IA32_MC%d_ADDR\n", mce->addr, mce->bank);
+		return NOTIFY_DONE;
+	}
 
 	/* Try driver decoder first */
 	if (!(driver_decode && driver_decode(&res))) {
-- 
2.17.1


