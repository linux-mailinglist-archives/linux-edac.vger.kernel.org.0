Return-Path: <linux-edac+bounces-3326-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D03C3A589FE
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 02:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACBA188CAAF
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 01:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7AB155398;
	Mon, 10 Mar 2025 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGLfCGk1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51E155C97;
	Mon, 10 Mar 2025 01:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741570128; cv=none; b=T5yswIAG+ZwnBVmXvBbgE5D93W546JtreB0PRMwq5wA70cKOT0OENKaZHWJwbZN0TlGXxgtVFdUplLMa3h8iRDnhDMXvoHK7bk33rHtiNY6qAcvzRpowO4Ag5zd2rKVzPbwdPU0DVlN9/PdVTI/ars/YJI9bd/c3XvpJXexhZ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741570128; c=relaxed/simple;
	bh=w72dBbrnDbiWFsnN4ftFTj+2NIjaVkLrIkSukcDB6c0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=e2de6Oyvezbvjv7w1GT4ULfhpEIG+O0wn7FwRMr/ZM/2EWqizs+XIZT4OxYdTHsYQCwPwukJUseFwYdIHpau1J+8L568eyTD3Rbr30Ww4lQ0O8jqcgLupTcRu/6UJKy6WTbtrPbnQm6PKP4TEpSvB78m1hlQqvo9R7WZzHaueFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGLfCGk1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741570127; x=1773106127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=w72dBbrnDbiWFsnN4ftFTj+2NIjaVkLrIkSukcDB6c0=;
  b=CGLfCGk1YbiR2I9oKQ2IyL57NLcMiJTHPIRG+IH/Ly/3YYEOad3Y0bap
   5fEDDKbuyjisJtHXPAJTAg7+AyN9EAOLhh2g6WUUK61qqoq1jfGIuA+iA
   L3GIHkdwnFUJLdItOU9gBR86aZW2ywQXEIJ38GKBkXys+avn99J3pVZH9
   34Qr4Mz31wA9ZtFlJaIA+OEKgF9FV9qtLygb5U5kTPGTBj+h+Ec3yHAoW
   QVYYwyNWW8rwHDSFM717ImBNmJ0mM3WDElgjUvA/cv9mEBobPjzieNvTq
   cfpgnObLNuEKYLCcfoNDj1WUg71j1pkxAK+fPA5VzvEYey37ZRCCFEUlS
   Q==;
X-CSE-ConnectionGUID: G/UtOWYhStS2Bo3hINSWJw==
X-CSE-MsgGUID: Ns3aj1HmTV2LqdG5RXdf0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="67914574"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="67914574"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:28:46 -0700
X-CSE-ConnectionGUID: hSAUBM1CQaW9HlXRiYjatA==
X-CSE-MsgGUID: EoCmjiZ7QxakmRNedNwhRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124925519"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:28:43 -0700
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
Subject: [PATCH v2 04/11] EDAC/ie31200: Fix the 3rd parameter name of *populate_dimm_info()
Date: Mon, 10 Mar 2025 09:14:04 +0800
Message-Id: <20250310011411.31685-5-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250310011411.31685-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
 <20250310011411.31685-1-qiuxu.zhuo@intel.com>
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


