Return-Path: <linux-edac+bounces-3209-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6ADA452B9
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 03:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB2116BD36
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 02:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BED212FA2;
	Wed, 26 Feb 2025 02:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKuOfJKX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF7019ADA2;
	Wed, 26 Feb 2025 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535554; cv=none; b=KvmcB2hAjNVOvy5UMBIjejD+gb1TpZG7c9ELVpzO7ezdy4+WXEwVWwVbGQ4jeqG499rLyMsXm7A5KGsX/f/T+n7CTzfOT+VW9IpMe3rfe7ZbAoLg2dKzBB1KX7zArrO9KjCIzN6dziuVi0Z6nIzshrNrj1tWJebU2DWFP0pTnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535554; c=relaxed/simple;
	bh=8nIQCroNj8bmdX5dtu3NN+9AEUCNOwUvPxEJurSqoGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VlD/1mJcoABLMcPZ0bDinexy1936fHguKBw53wkHLixdmrLi6BZSthxT0ndtf8eS6pJafpxAj+izSc6MkIudRzHG6FRqRtqoiD1Nx7p5IqTzbkVErUcpG5a1sWzZVOoO8msA9nzMQgVnS3psWZRAIBzHtedMHErhHyw4Q9qsDTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKuOfJKX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740535553; x=1772071553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=8nIQCroNj8bmdX5dtu3NN+9AEUCNOwUvPxEJurSqoGs=;
  b=OKuOfJKXe9JO6trQEs1XHEBSX2AsPy9IGso1l6dnQexgzuITshin1RYf
   itNuT6NcX14JMFoSMpwA/7wsNvLHI74YgbyfNSKkLMN5wRyiYJX8QOHFL
   blApxilcweUNWKcP5ylQ5bydJe9TDi0vspyNLw0xJJhdNtvA/ghxLwqwc
   rkPadKAqilHNcKzd3z7PuGCiMsSPMcN1hODG3j9ny0LyskqflhV3J+2Mz
   dDLGoY5ajR5OV9rJOXPvgW/n9+RgSg7DC5YWGhWhyEi/CXahmGUvxbADl
   6th9dJeELIeSNQDT6BM9txmEitJcE2gePDZdN2YpJXKoV26cdvi84cz+4
   Q==;
X-CSE-ConnectionGUID: m2d1IktcTouor1785ueJIg==
X-CSE-MsgGUID: AIDP3Fc0SQKXPJDhVqf4yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28959880"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="28959880"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:05:42 -0800
X-CSE-ConnectionGUID: AIIcymILSbyD8pJu67xjtA==
X-CSE-MsgGUID: V4VgbstcQUSWkRtop7lAYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121180535"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:05:39 -0800
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
Subject: [PATCH 07/11] EDAC/ie31200: Make struct dimm_data contain decoded information
Date: Wed, 26 Feb 2025 09:51:58 +0800
Message-Id: <20250226015202.36576-8-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The current dimm_data structure contains encoded DIMM information,
which needs to be decoded for a given SoC when it is used. Make it
contain decoded information when it's initialized so that the places
where it is used do not need to decode it again, thereby simplifying
the code.

No functional changes intended.

Tested-by: Gary Wang <gary.c.wang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/ie31200_edac.c | 62 ++++++++++++-------------------------
 1 file changed, 19 insertions(+), 43 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 71061ab5fa91..865a2f838317 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -84,16 +84,6 @@
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_9    0x3ec6
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_10   0x3eca
 
-/* Test if HB is for Skylake or later. */
-#define DEVICE_ID_SKYLAKE_OR_LATER(did)                                        \
-	(((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_8) ||                        \
-	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_9) ||                        \
-	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_10) ||                       \
-	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_11) ||                       \
-	 ((did) == PCI_DEVICE_ID_INTEL_IE31200_HB_12) ||                       \
-	 (((did) & PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK) ==                 \
-	  PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_MASK))
-
 #define IE31200_RANKS_PER_CHANNEL	4
 #define IE31200_DIMMS_PER_CHANNEL	2
 #define IE31200_CHANNELS		2
@@ -118,10 +108,6 @@
 #define IE31200_CAPID0_DDPCD		BIT(6)
 #define IE31200_CAPID0_ECC		BIT(1)
 
-/* Skylake reports 1GB increments, everything else is 256MB */
-#define IE31200_PAGES(n, skl)	\
-	(n << (28 + (2 * skl) - PAGE_SHIFT))
-
 /* Non-constant mask variant of FIELD_GET() */
 #define field_get(_mask, _reg)  (((_reg) & (_mask)) >> (ffs(_mask) - 1))
 
@@ -141,6 +127,7 @@ struct res_config {
 	u64 reg_eccerrlog_rank_mask;
 	u64 reg_eccerrlog_syndrome_mask;
 	/* DIMM characteristics register */
+	u64 reg_mad_dimm_size_granularity;
 	u64 reg_mad_dimm_offset[IE31200_CHANNELS];
 	u32 reg_mad_dimm_size_mask[IE31200_DIMMS_PER_CHANNEL];
 	u32 reg_mad_dimm_rank_mask[IE31200_DIMMS_PER_CHANNEL];
@@ -175,9 +162,9 @@ static const struct ie31200_dev_info ie31200_devs[] = {
 };
 
 struct dimm_data {
-	u8 size; /* in multiples of 256MB, except Skylake is 1GB */
-	u8 dual_rank : 1,
-	   x16_width : 2; /* 0 means x8 width */
+	u64 size; /* in bytes */
+	u8  ranks;
+	enum dev_type dtype;
 };
 
 static int how_many_channels(struct pci_dev *pdev)
@@ -340,26 +327,20 @@ static void __iomem *ie31200_map_mchbar(struct pci_dev *pdev, struct res_config
 static void populate_dimm_info(struct dimm_data *dd, u32 addr_decode, int dimm,
 			       struct res_config *cfg)
 {
-	dd->size = field_get(cfg->reg_mad_dimm_size_mask[dimm], addr_decode);
-	dd->dual_rank = field_get(cfg->reg_mad_dimm_rank_mask[dimm], addr_decode);
-	dd->x16_width = field_get(cfg->reg_mad_dimm_width_mask[dimm], addr_decode);
+	dd->size = field_get(cfg->reg_mad_dimm_size_mask[dimm], addr_decode) * cfg->reg_mad_dimm_size_granularity;
+	dd->ranks = field_get(cfg->reg_mad_dimm_rank_mask[dimm], addr_decode) + 1;
+	dd->dtype = field_get(cfg->reg_mad_dimm_width_mask[dimm], addr_decode) + DEV_X8;
 }
 
 static int ie31200_probe1(struct pci_dev *pdev, struct res_config *cfg)
 {
-	int i, j, ret;
+	int i, j, k, ret;
 	struct mem_ctl_info *mci = NULL;
 	struct edac_mc_layer layers[2];
 	void __iomem *window;
 	struct ie31200_priv *priv;
 	u32 addr_decode[IE31200_CHANNELS];
 
-	/*
-	 * Kaby Lake, Coffee Lake seem to work like Skylake. Please re-visit
-	 * this logic when adding new CPU support.
-	 */
-	bool skl = DEVICE_ID_SKYLAKE_OR_LATER(pdev->device);
-
 	edac_dbg(0, "MC:\n");
 
 	if (!ecc_capable(pdev)) {
@@ -419,32 +400,25 @@ static int ie31200_probe1(struct pci_dev *pdev, struct res_config *cfg)
 			unsigned long nr_pages;
 
 			populate_dimm_info(&dimm_info, addr_decode[j], i, cfg);
-			edac_dbg(0, "size: 0x%x, rank: %d, width: %d\n",
-				 dimm_info.size,
-				 dimm_info.dual_rank,
-				 dimm_info.x16_width);
+			edac_dbg(0, "channel: %d, dimm: %d, size: %lld MiB, ranks: %d, DRAM chip type: %d\n",
+				 j, i, dimm_info.size >> 20,
+				 dimm_info.ranks,
+				 dimm_info.dtype);
 
-			nr_pages = IE31200_PAGES(dimm_info.size, skl);
+			nr_pages = MiB_TO_PAGES(dimm_info.size >> 20);
 			if (nr_pages == 0)
 				continue;
 
-			if (dimm_info.dual_rank) {
-				nr_pages = nr_pages / 2;
-				dimm = edac_get_dimm(mci, (i * 2) + 1, j, 0);
+			nr_pages = nr_pages / dimm_info.ranks;
+			for (k = 0; k < dimm_info.ranks; k++) {
+				dimm = edac_get_dimm(mci, (i * dimm_info.ranks) + k, j, 0);
 				dimm->nr_pages = nr_pages;
 				edac_dbg(0, "set nr pages: 0x%lx\n", nr_pages);
 				dimm->grain = 8; /* just a guess */
 				dimm->mtype = cfg->mtype;
-				dimm->dtype = DEV_UNKNOWN;
+				dimm->dtype = dimm_info.dtype;
 				dimm->edac_mode = EDAC_UNKNOWN;
 			}
-			dimm = edac_get_dimm(mci, i * 2, j, 0);
-			dimm->nr_pages = nr_pages;
-			edac_dbg(0, "set nr pages: 0x%lx\n", nr_pages);
-			dimm->grain = 8; /* same guess */
-			dimm->mtype = cfg->mtype;
-			dimm->dtype = DEV_UNKNOWN;
-			dimm->edac_mode = EDAC_UNKNOWN;
 		}
 	}
 
@@ -510,6 +484,7 @@ static struct res_config snb_cfg = {
 	.reg_eccerrlog_ue_mask		= BIT_ULL(1),
 	.reg_eccerrlog_rank_mask	= GENMASK_ULL(28, 27),
 	.reg_eccerrlog_syndrome_mask	= GENMASK_ULL(23, 16),
+	.reg_mad_dimm_size_granularity	= BIT_ULL(28),
 	.reg_mad_dimm_offset[0]		= 0x5004,
 	.reg_mad_dimm_offset[1]		= 0x5008,
 	.reg_mad_dimm_size_mask[0]	= GENMASK(7, 0),
@@ -530,6 +505,7 @@ static struct res_config skl_cfg = {
 	.reg_eccerrlog_ue_mask		= BIT_ULL(1),
 	.reg_eccerrlog_rank_mask	= GENMASK_ULL(28, 27),
 	.reg_eccerrlog_syndrome_mask	= GENMASK_ULL(23, 16),
+	.reg_mad_dimm_size_granularity	= BIT_ULL(30),
 	.reg_mad_dimm_offset[0]		= 0x500c,
 	.reg_mad_dimm_offset[1]		= 0x5010,
 	.reg_mad_dimm_size_mask[0]	= GENMASK(5, 0),
-- 
2.17.1


