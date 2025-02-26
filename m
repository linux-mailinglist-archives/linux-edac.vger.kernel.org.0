Return-Path: <linux-edac+bounces-3206-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BF5A452CD
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 03:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 145173A1C97
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 02:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993391FFC44;
	Wed, 26 Feb 2025 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsMpVrlr"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4DE1624C5;
	Wed, 26 Feb 2025 02:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535506; cv=none; b=f3xvhb9JOuTRYkA5LY8+Z7/HqZrYSYESqaDSVFvOyBSROlSE9M1KzUUu4quIBIjM66ElpL6Q4KXSmwCuf9zwQWyeBua9xUQxehjLVRS7qJMSzbPpawqkXxFmUE7z0Uy6DLKr+khU8cDVicK2h9eg/ss6IqZUQKFWdYJfZ01GuQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535506; c=relaxed/simple;
	bh=w72dBbrnDbiWFsnN4ftFTj+2NIjaVkLrIkSukcDB6c0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eRif17/EY3vz9zHSg86dcHR3+G4tyug5K9kZdCjbiWtbJlQtBm8FjgCXH4IJhPXj0WyZAsY4dkxb0e72UtZL/WGltpKqmX5oIdk2p4QSBpCWcUs3AWnL3owo9iFln+AbC0izlCG0ywzbR/31SSqsUHFaTzldwua0O93PFdOfxY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsMpVrlr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740535505; x=1772071505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=w72dBbrnDbiWFsnN4ftFTj+2NIjaVkLrIkSukcDB6c0=;
  b=dsMpVrlrybefZ5NoeSB+8hzE+uacu6zqxIaZbML3NaQ/HTjVQbpyQEvh
   Pc6Q0iKxyl8LPiLcHn7LzJZfra2h8/bc7uUE5objvzq34j/WdezL1Zgzs
   D/XQl/G1CDNYOPNG7qBaWlzvq6BjuKhDtx8EodankivPzfw63OVrJE2zh
   Cvg2XqRM1lmW/f8MFfq3TD187XFdEQgShMj7RF3q8jugGPFVHz/Pg4AzI
   JjZhY3j8yUuK22v6x6ys340DpDnWutQ30GN7n+j15AR39TxOpmDWvU+i5
   1PD5rZ7lPSAp0iRBMmAdtLEO9RddRK8Rn1wwg/NrJucSQUXkoKBXapm06
   A==;
X-CSE-ConnectionGUID: lrz54vjpTM2ORalf7ulCCQ==
X-CSE-MsgGUID: wbdKZQ0aTe20ykl7c2QaWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28959774"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="28959774"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:05:04 -0800
X-CSE-ConnectionGUID: W/2+Ezq5QaeP2Lkr/C/CLw==
X-CSE-MsgGUID: TrcwEt+AS++MJ5eQWYuQ/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121180271"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:05:02 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Gary Wang <gary.c.wang@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] EDAC/ie31200: Fix the 3rd parameter name of *populate_dimm_info()
Date: Wed, 26 Feb 2025 09:51:55 +0800
Message-Id: <20250226015202.36576-5-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The 3rd parameter of *populate_dimm_info() pertains to the DIMM index
within a channel, not the channel index. Fix the parameter name to dimm
to reflect its actual purpose.

No functional changes intended.

Tested-by: Gary Wang <gary.c.wang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/ie31200_edac.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index a8dd55ec52ce..35f4e8e46ca2 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -377,29 +377,29 @@ static void __iomem *ie31200_map_mchbar(struct pci_dev *pdev)
 }
 
 static void __skl_populate_dimm_info(struct dimm_data *dd, u32 addr_decode,
-				     int chan)
+				     int dimm)
 {
-	dd->size = (addr_decode >> (chan << 4)) & IE31200_MAD_DIMM_SIZE_SKL;
-	dd->dual_rank = (addr_decode & (IE31200_MAD_DIMM_A_RANK_SKL << (chan << 4))) ? 1 : 0;
-	dd->x16_width = ((addr_decode & (IE31200_MAD_DIMM_A_WIDTH_SKL << (chan << 4))) >>
-				(IE31200_MAD_DIMM_A_WIDTH_SKL_SHIFT + (chan << 4)));
+	dd->size = (addr_decode >> (dimm << 4)) & IE31200_MAD_DIMM_SIZE_SKL;
+	dd->dual_rank = (addr_decode & (IE31200_MAD_DIMM_A_RANK_SKL << (dimm << 4))) ? 1 : 0;
+	dd->x16_width = ((addr_decode & (IE31200_MAD_DIMM_A_WIDTH_SKL << (dimm << 4))) >>
+				(IE31200_MAD_DIMM_A_WIDTH_SKL_SHIFT + (dimm << 4)));
 }
 
 static void __populate_dimm_info(struct dimm_data *dd, u32 addr_decode,
-				 int chan)
+				 int dimm)
 {
-	dd->size = (addr_decode >> (chan << 3)) & IE31200_MAD_DIMM_SIZE;
-	dd->dual_rank = (addr_decode & (IE31200_MAD_DIMM_A_RANK << chan)) ? 1 : 0;
-	dd->x16_width = (addr_decode & (IE31200_MAD_DIMM_A_WIDTH << chan)) ? 1 : 0;
+	dd->size = (addr_decode >> (dimm << 3)) & IE31200_MAD_DIMM_SIZE;
+	dd->dual_rank = (addr_decode & (IE31200_MAD_DIMM_A_RANK << dimm)) ? 1 : 0;
+	dd->x16_width = (addr_decode & (IE31200_MAD_DIMM_A_WIDTH << dimm)) ? 1 : 0;
 }
 
-static void populate_dimm_info(struct dimm_data *dd, u32 addr_decode, int chan,
+static void populate_dimm_info(struct dimm_data *dd, u32 addr_decode, int dimm,
 			       bool skl)
 {
 	if (skl)
-		__skl_populate_dimm_info(dd, addr_decode, chan);
+		__skl_populate_dimm_info(dd, addr_decode, dimm);
 	else
-		__populate_dimm_info(dd, addr_decode, chan);
+		__populate_dimm_info(dd, addr_decode, dimm);
 }
 
 
-- 
2.17.1


