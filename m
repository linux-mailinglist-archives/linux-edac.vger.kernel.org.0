Return-Path: <linux-edac+bounces-3328-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93810A589FF
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 02:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DA4166BCC
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 01:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD7214B08A;
	Mon, 10 Mar 2025 01:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StXTyuN0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1AE14A098;
	Mon, 10 Mar 2025 01:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741570161; cv=none; b=jv+IyLr48D4P8FkChIOPoDNbqRvRlLMkj40iHXH69CuuiwWUrTS20m4pB4Tj/AVaGk7bPHSEz4Yx8xUeb7AiyLnyvRfeMcQAMJ3ICmT/iqo5njPRkKfQnmuqXXi1bM5C9eXjOcClh3ZVt3s5mTGzQ9Fm8olf0RRcvwbagzLdqAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741570161; c=relaxed/simple;
	bh=XG23fZykDcb2GdkimQAFbMgfqn35qe2SvJU2DBJDxa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=D2cDfq9W7YLBVwh/30IK8a6TQt5741UOf7Ff/SyJTLJl++BsaOIr6n4qDH8gMpqthghxPhnlr8Kj8DYIchPMw9VN9w8r1aEvkgNi2CSXEvR6zXBL2wwaZj5RhnZlvEX0I9zpTcxgXh42yOu4PePrm8U1d0P9YeuxUsf4+dxCZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StXTyuN0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741570160; x=1773106160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XG23fZykDcb2GdkimQAFbMgfqn35qe2SvJU2DBJDxa0=;
  b=StXTyuN0GHqUOUwP7HA5C2L0MQnOKxKXG8NJHtuGFmkv7t4Tc56ah+X+
   zm/umPJcgCOPAjgPpfKOn0QuFQHzRXbTvmP4busS4E1je4YZfO/HwyZhv
   6Ij2vpV4BxrTa6Nh+lm8PeOPPFZXpjpMJQdPEk1VBj6j7EtIhDi19K4c7
   EM5irXXRLfhysN+JqYyAzocU0QvcMH2I1qsq43QRtqx5Im0vsOWmDcZ4s
   LeB/9jolVxfwr0ZX1Y30A5C8d+r5LfdoY4hSckF8kKT16VNju3Q0iil/H
   eHuqdr+h7uiku+exM8OxyIvpTLgBXWPHg7LI4MFjz0SbmA5OTdtfODaOl
   g==;
X-CSE-ConnectionGUID: QMIPaCCHTbK9ORxvtKtP4Q==
X-CSE-MsgGUID: oHvcTZCQRmOU5bNX3lsZtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="67914598"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="67914598"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:29:19 -0700
X-CSE-ConnectionGUID: kVKCCyz0SbWBADXeOIasBg==
X-CSE-MsgGUID: 16Bs9AsuQ4G9rdtRp3/qHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124925570"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:29:16 -0700
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
Subject: [PATCH v2 06/11] EDAC/ie31200: Make the memory controller resources configurable
Date: Mon, 10 Mar 2025 09:14:06 +0800
Message-Id: <20250310011411.31685-7-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250310011411.31685-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
 <20250310011411.31685-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The resources such as MMIO, register offset, register mask, memory DIMM
information, ECC error log location, etc., of the memory controller, and
the number of memory controllers can be device-ID-specific. It requires
adding numerous 'if (device_id == new_id)' special handling cases to the
code to support a new SoC.

Make these kinds of resources configurable and separate them from the code
to facilitate the addition of new SoC support.

No functional changes intended.

Tested-by: Gary Wang <gary.c.wang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/ie31200_edac.c | 257 ++++++++++++++++--------------------
 1 file changed, 111 insertions(+), 146 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 4e1f85dc1679..71061ab5fa91 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -101,25 +101,10 @@
 /* Intel IE31200 register addresses - device 0 function 0 - DRAM Controller */
 #define IE31200_MCHBAR_LOW		0x48
 #define IE31200_MCHBAR_HIGH		0x4c
-#define IE31200_MCHBAR_MASK		GENMASK_ULL(38, 15)
-#define IE31200_MMR_WINDOW_SIZE		BIT(15)
 
 /*
  * Error Status Register (16b)
  *
- * 15    reserved
- * 14    Isochronous TBWRR Run Behind FIFO Full
- *       (ITCV)
- * 13    Isochronous TBWRR Run Behind FIFO Put
- *       (ITSTV)
- * 12    reserved
- * 11    MCH Thermal Sensor Event
- *       for SMI/SCI/SERR (GTSE)
- * 10    reserved
- *  9    LOCK to non-DRAM Memory Flag (LCKF)
- *  8    reserved
- *  7    DRAM Throttle Flag (DTF)
- *  6:2  reserved
  *  1    Multi-bit DRAM ECC Error Flag (DMERR)
  *  0    Single-bit DRAM ECC Error Flag (DSERR)
  */
@@ -128,65 +113,45 @@
 #define IE31200_ERRSTS_CE		BIT(0)
 #define IE31200_ERRSTS_BITS		(IE31200_ERRSTS_UE | IE31200_ERRSTS_CE)
 
-/*
- * Channel 0 ECC Error Log (64b)
- *
- * 63:48 Error Column Address (ERRCOL)
- * 47:32 Error Row Address (ERRROW)
- * 31:29 Error Bank Address (ERRBANK)
- * 28:27 Error Rank Address (ERRRANK)
- * 26:24 reserved
- * 23:16 Error Syndrome (ERRSYND)
- * 15: 2 reserved
- *    1  Multiple Bit Error Status (MERRSTS)
- *    0  Correctable Error Status (CERRSTS)
- */
-
-#define IE31200_C0ECCERRLOG			0x40c8
-#define IE31200_C1ECCERRLOG			0x44c8
-#define IE31200_C0ECCERRLOG_SKL			0x4048
-#define IE31200_C1ECCERRLOG_SKL			0x4448
-#define IE31200_ECCERRLOG_CE			BIT(0)
-#define IE31200_ECCERRLOG_UE			BIT(1)
-#define IE31200_ECCERRLOG_RANK_BITS		GENMASK_ULL(28, 27)
-#define IE31200_ECCERRLOG_RANK_SHIFT		27
-#define IE31200_ECCERRLOG_SYNDROME_BITS		GENMASK_ULL(23, 16)
-#define IE31200_ECCERRLOG_SYNDROME_SHIFT	16
-
-#define IE31200_ECCERRLOG_SYNDROME(log)		   \
-	((log & IE31200_ECCERRLOG_SYNDROME_BITS) >> \
-	 IE31200_ECCERRLOG_SYNDROME_SHIFT)
-
 #define IE31200_CAPID0			0xe4
 #define IE31200_CAPID0_PDCD		BIT(4)
 #define IE31200_CAPID0_DDPCD		BIT(6)
 #define IE31200_CAPID0_ECC		BIT(1)
 
-#define IE31200_MAD_DIMM_0_OFFSET		0x5004
-#define IE31200_MAD_DIMM_0_OFFSET_SKL		0x500C
-#define IE31200_MAD_DIMM_SIZE			GENMASK_ULL(7, 0)
-#define IE31200_MAD_DIMM_SIZE_SKL		GENMASK_ULL(5, 0)
-#define IE31200_MAD_DIMM_A_RANK			BIT(17)
-#define IE31200_MAD_DIMM_A_RANK_SHIFT		17
-#define IE31200_MAD_DIMM_A_RANK_SKL		BIT(10)
-#define IE31200_MAD_DIMM_A_RANK_SKL_SHIFT	10
-#define IE31200_MAD_DIMM_A_WIDTH		BIT(19)
-#define IE31200_MAD_DIMM_A_WIDTH_SHIFT		19
-#define IE31200_MAD_DIMM_A_WIDTH_SKL		GENMASK_ULL(9, 8)
-#define IE31200_MAD_DIMM_A_WIDTH_SKL_SHIFT	8
-
 /* Skylake reports 1GB increments, everything else is 256MB */
 #define IE31200_PAGES(n, skl)	\
 	(n << (28 + (2 * skl) - PAGE_SHIFT))
 
+/* Non-constant mask variant of FIELD_GET() */
+#define field_get(_mask, _reg)  (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+
 static int nr_channels;
 static struct pci_dev *mci_pdev;
 static int ie31200_registered = 1;
 
+struct res_config {
+	enum mem_type mtype;
+	/* Host MMIO configuration register */
+	u64 reg_mchbar_mask;
+	u64 reg_mchbar_window_size;
+	/* ECC error log register */
+	u64 reg_eccerrlog_offset[IE31200_CHANNELS];
+	u64 reg_eccerrlog_ce_mask;
+	u64 reg_eccerrlog_ue_mask;
+	u64 reg_eccerrlog_rank_mask;
+	u64 reg_eccerrlog_syndrome_mask;
+	/* DIMM characteristics register */
+	u64 reg_mad_dimm_offset[IE31200_CHANNELS];
+	u32 reg_mad_dimm_size_mask[IE31200_DIMMS_PER_CHANNEL];
+	u32 reg_mad_dimm_rank_mask[IE31200_DIMMS_PER_CHANNEL];
+	u32 reg_mad_dimm_width_mask[IE31200_DIMMS_PER_CHANNEL];
+};
+
 struct ie31200_priv {
 	void __iomem *window;
 	void __iomem *c0errlog;
 	void __iomem *c1errlog;
+	struct res_config *cfg;
 };
 
 enum ie31200_chips {
@@ -250,12 +215,6 @@ static bool ecc_capable(struct pci_dev *pdev)
 	return true;
 }
 
-static int eccerrlog_row(u64 log)
-{
-	return ((log & IE31200_ECCERRLOG_RANK_BITS) >>
-				IE31200_ECCERRLOG_RANK_SHIFT);
-}
-
 static void ie31200_clear_error_info(struct mem_ctl_info *mci)
 {
 	/*
@@ -308,6 +267,8 @@ static void ie31200_get_and_clear_error_info(struct mem_ctl_info *mci,
 static void ie31200_process_error_info(struct mem_ctl_info *mci,
 				       struct ie31200_error_info *info)
 {
+	struct ie31200_priv *priv = mci->pvt_info;
+	struct res_config *cfg = priv->cfg;
 	int channel;
 	u64 log;
 
@@ -322,17 +283,17 @@ static void ie31200_process_error_info(struct mem_ctl_info *mci,
 
 	for (channel = 0; channel < nr_channels; channel++) {
 		log = info->eccerrlog[channel];
-		if (log & IE31200_ECCERRLOG_UE) {
+		if (log & cfg->reg_eccerrlog_ue_mask) {
 			edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
 					     0, 0, 0,
-					     eccerrlog_row(log),
+					     field_get(cfg->reg_eccerrlog_rank_mask, log),
 					     channel, -1,
 					     "ie31200 UE", "");
-		} else if (log & IE31200_ECCERRLOG_CE) {
+		} else if (log & cfg->reg_eccerrlog_ce_mask) {
 			edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1,
 					     0, 0,
-					     IE31200_ECCERRLOG_SYNDROME(log),
-					     eccerrlog_row(log),
+					     field_get(cfg->reg_eccerrlog_syndrome_mask, log),
+					     field_get(cfg->reg_eccerrlog_rank_mask, log),
 					     channel, -1,
 					     "ie31200 CE", "");
 		}
@@ -347,7 +308,7 @@ static void ie31200_check(struct mem_ctl_info *mci)
 	ie31200_process_error_info(mci, &info);
 }
 
-static void __iomem *ie31200_map_mchbar(struct pci_dev *pdev)
+static void __iomem *ie31200_map_mchbar(struct pci_dev *pdev, struct res_config *cfg)
 {
 	union {
 		u64 mchbar;
@@ -360,7 +321,7 @@ static void __iomem *ie31200_map_mchbar(struct pci_dev *pdev)
 
 	pci_read_config_dword(pdev, IE31200_MCHBAR_LOW, &u.mchbar_low);
 	pci_read_config_dword(pdev, IE31200_MCHBAR_HIGH, &u.mchbar_high);
-	u.mchbar &= IE31200_MCHBAR_MASK;
+	u.mchbar &= cfg->reg_mchbar_mask;
 
 	if (u.mchbar != (resource_size_t)u.mchbar) {
 		ie31200_printk(KERN_ERR, "mmio space beyond accessible range (0x%llx)\n",
@@ -368,7 +329,7 @@ static void __iomem *ie31200_map_mchbar(struct pci_dev *pdev)
 		return NULL;
 	}
 
-	window = ioremap(u.mchbar, IE31200_MMR_WINDOW_SIZE);
+	window = ioremap(u.mchbar, cfg->reg_mchbar_window_size);
 	if (!window)
 		ie31200_printk(KERN_ERR, "Cannot map mmio space at 0x%llx\n",
 			       (unsigned long long)u.mchbar);
@@ -376,41 +337,22 @@ static void __iomem *ie31200_map_mchbar(struct pci_dev *pdev)
 	return window;
 }
 
-static void __skl_populate_dimm_info(struct dimm_data *dd, u32 addr_decode,
-				     int dimm)
-{
-	dd->size = (addr_decode >> (dimm << 4)) & IE31200_MAD_DIMM_SIZE_SKL;
-	dd->dual_rank = (addr_decode & (IE31200_MAD_DIMM_A_RANK_SKL << (dimm << 4))) ? 1 : 0;
-	dd->x16_width = ((addr_decode & (IE31200_MAD_DIMM_A_WIDTH_SKL << (dimm << 4))) >>
-				(IE31200_MAD_DIMM_A_WIDTH_SKL_SHIFT + (dimm << 4)));
-}
-
-static void __populate_dimm_info(struct dimm_data *dd, u32 addr_decode,
-				 int dimm)
-{
-	dd->size = (addr_decode >> (dimm << 3)) & IE31200_MAD_DIMM_SIZE;
-	dd->dual_rank = (addr_decode & (IE31200_MAD_DIMM_A_RANK << dimm)) ? 1 : 0;
-	dd->x16_width = (addr_decode & (IE31200_MAD_DIMM_A_WIDTH << dimm)) ? 1 : 0;
-}
-
 static void populate_dimm_info(struct dimm_data *dd, u32 addr_decode, int dimm,
-			       bool skl)
+			       struct res_config *cfg)
 {
-	if (skl)
-		__skl_populate_dimm_info(dd, addr_decode, dimm);
-	else
-		__populate_dimm_info(dd, addr_decode, dimm);
+	dd->size = field_get(cfg->reg_mad_dimm_size_mask[dimm], addr_decode);
+	dd->dual_rank = field_get(cfg->reg_mad_dimm_rank_mask[dimm], addr_decode);
+	dd->x16_width = field_get(cfg->reg_mad_dimm_width_mask[dimm], addr_decode);
 }
 
-
-static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
+static int ie31200_probe1(struct pci_dev *pdev, struct res_config *cfg)
 {
 	int i, j, ret;
 	struct mem_ctl_info *mci = NULL;
 	struct edac_mc_layer layers[2];
 	void __iomem *window;
 	struct ie31200_priv *priv;
-	u32 addr_decode[IE31200_CHANNELS], mad_offset;
+	u32 addr_decode[IE31200_CHANNELS];
 
 	/*
 	 * Kaby Lake, Coffee Lake seem to work like Skylake. Please re-visit
@@ -437,7 +379,7 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 	if (!mci)
 		return -ENOMEM;
 
-	window = ie31200_map_mchbar(pdev);
+	window = ie31200_map_mchbar(pdev, cfg);
 	if (!window) {
 		ret = -ENODEV;
 		goto fail_free;
@@ -445,32 +387,22 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 
 	edac_dbg(3, "MC: init mci\n");
 	mci->pdev = &pdev->dev;
-	if (skl)
-		mci->mtype_cap = MEM_FLAG_DDR4;
-	else
-		mci->mtype_cap = MEM_FLAG_DDR3;
+	mci->mtype_cap = BIT(cfg->mtype);
 	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
 	mci->edac_cap = EDAC_FLAG_SECDED;
 	mci->mod_name = EDAC_MOD_STR;
-	mci->ctl_name = ie31200_devs[dev_idx].ctl_name;
+	mci->ctl_name = ie31200_devs[0].ctl_name;
 	mci->dev_name = pci_name(pdev);
 	mci->edac_check = ie31200_check;
 	mci->ctl_page_to_phys = NULL;
 	priv = mci->pvt_info;
 	priv->window = window;
-	if (skl) {
-		priv->c0errlog = window + IE31200_C0ECCERRLOG_SKL;
-		priv->c1errlog = window + IE31200_C1ECCERRLOG_SKL;
-		mad_offset = IE31200_MAD_DIMM_0_OFFSET_SKL;
-	} else {
-		priv->c0errlog = window + IE31200_C0ECCERRLOG;
-		priv->c1errlog = window + IE31200_C1ECCERRLOG;
-		mad_offset = IE31200_MAD_DIMM_0_OFFSET;
-	}
+	priv->c0errlog = window + cfg->reg_eccerrlog_offset[0];
+	priv->c1errlog = window + cfg->reg_eccerrlog_offset[1];
+	priv->cfg = cfg;
 
 	for (i = 0; i < IE31200_CHANNELS; i++) {
-		addr_decode[i] = readl(window + mad_offset +
-					(i * 4));
+		addr_decode[i] = readl(window + cfg->reg_mad_dimm_offset[i]);
 		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode[i]);
 	}
 
@@ -486,8 +418,7 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 			struct dimm_info *dimm;
 			unsigned long nr_pages;
 
-			populate_dimm_info(&dimm_info, addr_decode[j], i,
-					   skl);
+			populate_dimm_info(&dimm_info, addr_decode[j], i, cfg);
 			edac_dbg(0, "size: 0x%x, rank: %d, width: %d\n",
 				 dimm_info.size,
 				 dimm_info.dual_rank,
@@ -503,10 +434,7 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 				dimm->nr_pages = nr_pages;
 				edac_dbg(0, "set nr pages: 0x%lx\n", nr_pages);
 				dimm->grain = 8; /* just a guess */
-				if (skl)
-					dimm->mtype = MEM_DDR4;
-				else
-					dimm->mtype = MEM_DDR3;
+				dimm->mtype = cfg->mtype;
 				dimm->dtype = DEV_UNKNOWN;
 				dimm->edac_mode = EDAC_UNKNOWN;
 			}
@@ -514,10 +442,7 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 			dimm->nr_pages = nr_pages;
 			edac_dbg(0, "set nr pages: 0x%lx\n", nr_pages);
 			dimm->grain = 8; /* same guess */
-			if (skl)
-				dimm->mtype = MEM_DDR4;
-			else
-				dimm->mtype = MEM_DDR3;
+			dimm->mtype = cfg->mtype;
 			dimm->dtype = DEV_UNKNOWN;
 			dimm->edac_mode = EDAC_UNKNOWN;
 		}
@@ -552,7 +477,7 @@ static int ie31200_init_one(struct pci_dev *pdev,
 	edac_dbg(0, "MC:\n");
 	if (pci_enable_device(pdev) < 0)
 		return -EIO;
-	rc = ie31200_probe1(pdev, ent->driver_data);
+	rc = ie31200_probe1(pdev, (struct res_config *)ent->driver_data);
 	if (rc == 0 && !mci_pdev)
 		mci_pdev = pci_dev_get(pdev);
 
@@ -575,29 +500,69 @@ static void ie31200_remove_one(struct pci_dev *pdev)
 	edac_mc_free(mci);
 }
 
+static struct res_config snb_cfg = {
+	.mtype				= MEM_DDR3,
+	.reg_mchbar_mask		= GENMASK_ULL(38, 15),
+	.reg_mchbar_window_size		= BIT_ULL(15),
+	.reg_eccerrlog_offset[0]	= 0x40c8,
+	.reg_eccerrlog_offset[1]	= 0x44c8,
+	.reg_eccerrlog_ce_mask		= BIT_ULL(0),
+	.reg_eccerrlog_ue_mask		= BIT_ULL(1),
+	.reg_eccerrlog_rank_mask	= GENMASK_ULL(28, 27),
+	.reg_eccerrlog_syndrome_mask	= GENMASK_ULL(23, 16),
+	.reg_mad_dimm_offset[0]		= 0x5004,
+	.reg_mad_dimm_offset[1]		= 0x5008,
+	.reg_mad_dimm_size_mask[0]	= GENMASK(7, 0),
+	.reg_mad_dimm_size_mask[1]	= GENMASK(15, 8),
+	.reg_mad_dimm_rank_mask[0]	= BIT(17),
+	.reg_mad_dimm_rank_mask[1]	= BIT(18),
+	.reg_mad_dimm_width_mask[0]	= BIT(19),
+	.reg_mad_dimm_width_mask[1]	= BIT(20),
+};
+
+static struct res_config skl_cfg = {
+	.mtype				= MEM_DDR4,
+	.reg_mchbar_mask		= GENMASK_ULL(38, 15),
+	.reg_mchbar_window_size		= BIT_ULL(15),
+	.reg_eccerrlog_offset[0]	= 0x4048,
+	.reg_eccerrlog_offset[1]	= 0x4448,
+	.reg_eccerrlog_ce_mask		= BIT_ULL(0),
+	.reg_eccerrlog_ue_mask		= BIT_ULL(1),
+	.reg_eccerrlog_rank_mask	= GENMASK_ULL(28, 27),
+	.reg_eccerrlog_syndrome_mask	= GENMASK_ULL(23, 16),
+	.reg_mad_dimm_offset[0]		= 0x500c,
+	.reg_mad_dimm_offset[1]		= 0x5010,
+	.reg_mad_dimm_size_mask[0]	= GENMASK(5, 0),
+	.reg_mad_dimm_size_mask[1]	= GENMASK(21, 16),
+	.reg_mad_dimm_rank_mask[0]	= BIT(10),
+	.reg_mad_dimm_rank_mask[1]	= BIT(26),
+	.reg_mad_dimm_width_mask[0]	= GENMASK(9, 8),
+	.reg_mad_dimm_width_mask[1]	= GENMASK(25, 24),
+};
+
 static const struct pci_device_id ie31200_pci_tbl[] = {
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_1), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_2), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_3), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_4), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_5), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_6), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_7), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_8), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_9), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_10), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_11), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_12), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_1), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_2), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_3), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_4), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_5), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_6), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_7), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_8), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_9), IE31200 },
-	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_10), IE31200 },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_1), (kernel_ulong_t)&snb_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_2), (kernel_ulong_t)&snb_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_3), (kernel_ulong_t)&snb_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_4), (kernel_ulong_t)&snb_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_5), (kernel_ulong_t)&snb_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_6), (kernel_ulong_t)&snb_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_7), (kernel_ulong_t)&snb_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_8), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_9), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_10), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_11), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_12), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_1), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_2), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_3), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_4), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_5), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_6), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_7), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_8), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_9), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_10), (kernel_ulong_t)&skl_cfg },
 	{ 0, } /* 0 terminated list. */
 };
 MODULE_DEVICE_TABLE(pci, ie31200_pci_tbl);
-- 
2.17.1


