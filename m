Return-Path: <linux-edac+bounces-3212-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A745EA452BF
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 03:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CB8189848A
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 02:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EE0212B3B;
	Wed, 26 Feb 2025 02:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BgF4EdLN"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77889213222;
	Wed, 26 Feb 2025 02:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535574; cv=none; b=FUSAqtMUwwpHq79sJOXZ4tMDcGGeQSfVTGMR3njnYM+e269A18UZfz2RrKZnQMrOWBhGudeq9R+LezQaSgcMMwvRGZ0B4snpXmcTcvUvK+PzJ+8yJ7dsLkqE/4fF0f59nX1rGcttt1N3yhcYFDIIBo0poH+6NotIUxcYCTj71pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535574; c=relaxed/simple;
	bh=TbquSdQipnifkRTw70Pv3JzVUb0kE1lS9VYG1SF/MEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=okib7swK/FMshPbfz0RdaN+T8A1R549BUW2YQkGVVAOcUncxhghDNKIiY1JRnSuLyOWgpT+CRs3pLE/+09kATDu9C9k29SQHIVu0ctQp/RZ6v6Jbz2EkMHYbfItnrHmmPijWG8RRG3hk6WSxhnRcus+gvYPPxSj4czROarizANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BgF4EdLN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740535573; x=1772071573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=TbquSdQipnifkRTw70Pv3JzVUb0kE1lS9VYG1SF/MEA=;
  b=BgF4EdLN+RJpp82F/iBE9gjg4DvShCgM85aCVSE908dEphFv9t4JVEIn
   aPnuksILXqFIweOpyNQ+iIUIk6whNhLFlNXlBfp/tNqIWlk0h0gcXgGna
   mB25ZaDKcxu1NXhQO59I6tZ9E/vL97yiTZXJeVQEXtXuzbhy+7t17eWG9
   lcwoiiECgz8YhiuUp24MABkU9Cfsj/4wGgnAo661YqPXUFcMsbEFEM4tj
   YdpIVo3uomRb3T7tRlV5P+mXQ9BHL9UeSBDP2wTcCE7KsiLB70qBKw6zW
   RXL1TrgO46eKlOJm3ol5tB817GA6i+iH61QWzFYNNEqyXjFO/F0DKqdT5
   g==;
X-CSE-ConnectionGUID: DYJ8ZTAnR1axoZcPkOgxSg==
X-CSE-MsgGUID: 3px1OzhzTjuiN7n45JvnJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28959932"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="28959932"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:06:12 -0800
X-CSE-ConnectionGUID: wK28/oUjSMa+Xd01CObXGA==
X-CSE-MsgGUID: zcK4XrgcQNuuxZ7ptA50Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121180725"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:06:09 -0800
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
Subject: [PATCH 10/11] EDAC/ie31200: Add Intel Raptor Lake-S SoCs support
Date: Wed, 26 Feb 2025 09:52:01 +0800
Message-Id: <20250226015202.36576-11-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The Intel Raptor Lake-S SoC contains two memory controllers with DDR5
memory type and out-of-band ECC capability. The resource definitions of
the memory controller are different from previous generations. One notable
difference is that the PCI ERRSTS register is deprecated and is not used
to indicate the presence of errors or to clear the MMIO-mapped ECC error
log regsiters.

Extend the ie31200_edac driver to support multiple memory controllers,
add a resource configuration table and use an MSR register to clear the
ECC error log registers to provide EDAC support for Raptor Lake-S SoCs.

Tested-by: Gary Wang <gary.c.wang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/ie31200_edac.c | 182 +++++++++++++++++++++++++++++-------
 1 file changed, 149 insertions(+), 33 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 70be0d00a188..8c0a2beec537 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -84,9 +84,15 @@
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_9    0x3ec6
 #define PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_10   0x3eca
 
-#define IE31200_RANKS_PER_CHANNEL	4
+/* Raptor Lake-S */
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_1	0xa703
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_2	0x4640
+#define PCI_DEVICE_ID_INTEL_IE31200_RPL_S_3	0x4630
+
+#define IE31200_RANKS_PER_CHANNEL	8
 #define IE31200_DIMMS_PER_CHANNEL	2
 #define IE31200_CHANNELS		2
+#define IE31200_IMC_NUM			2
 
 /* Intel IE31200 register addresses - device 0 function 0 - DRAM Controller */
 #define IE31200_MCHBAR_LOW		0x48
@@ -117,15 +123,20 @@ static int ie31200_registered = 1;
 
 struct res_config {
 	enum mem_type mtype;
+	int imc_num;
 	/* Host MMIO configuration register */
 	u64 reg_mchbar_mask;
 	u64 reg_mchbar_window_size;
 	/* ECC error log register */
 	u64 reg_eccerrlog_offset[IE31200_CHANNELS];
 	u64 reg_eccerrlog_ce_mask;
+	u64 reg_eccerrlog_ce_ovfl_mask;
 	u64 reg_eccerrlog_ue_mask;
+	u64 reg_eccerrlog_ue_ovfl_mask;
 	u64 reg_eccerrlog_rank_mask;
 	u64 reg_eccerrlog_syndrome_mask;
+	/* MSR to clear ECC error log register */
+	u32 msr_clear_eccerrlog_offset;
 	/* DIMM characteristics register */
 	u64 reg_mad_dimm_size_granularity;
 	u64 reg_mad_dimm_offset[IE31200_CHANNELS];
@@ -139,10 +150,18 @@ struct ie31200_priv {
 	void __iomem *c0errlog;
 	void __iomem *c1errlog;
 	struct res_config *cfg;
+	struct mem_ctl_info *mci;
+	struct pci_dev *pdev;
+	struct device dev;
 };
 
+static struct ie31200_pvt {
+	struct ie31200_priv *priv[IE31200_IMC_NUM];
+} ie31200_pvt;
+
 enum ie31200_chips {
 	IE31200 = 0,
+	IE31200_1 = 1,
 };
 
 struct ie31200_dev_info {
@@ -159,6 +178,9 @@ static const struct ie31200_dev_info ie31200_devs[] = {
 	[IE31200] = {
 		.ctl_name = "IE31200"
 	},
+	[IE31200_1] = {
+		.ctl_name = "IE31200_1"
+	},
 };
 
 struct dimm_data {
@@ -202,23 +224,54 @@ static bool ecc_capable(struct pci_dev *pdev)
 	return true;
 }
 
+#define mci_to_pci_dev(mci)	(((struct ie31200_priv *)(mci)->pvt_info)->pdev)
+
 static void ie31200_clear_error_info(struct mem_ctl_info *mci)
 {
+	struct ie31200_priv *priv = mci->pvt_info;
+	struct res_config *cfg = priv->cfg;
+
+	/*
+	 * The PCI ERRSTS register is deprecated. Write the MSR to clear
+	 * the ECC error log registers in all memory controllers.
+	 */
+	if (cfg->msr_clear_eccerrlog_offset) {
+		if (wrmsr_safe(cfg->msr_clear_eccerrlog_offset,
+			       cfg->reg_eccerrlog_ce_mask |
+			       cfg->reg_eccerrlog_ce_ovfl_mask |
+			       cfg->reg_eccerrlog_ue_mask |
+			       cfg->reg_eccerrlog_ue_ovfl_mask, 0) < 0)
+			ie31200_printk(KERN_ERR, "Failed to wrmsr.\n");
+
+		return;
+	}
+
 	/*
 	 * Clear any error bits.
 	 * (Yes, we really clear bits by writing 1 to them.)
 	 */
-	pci_write_bits16(to_pci_dev(mci->pdev), IE31200_ERRSTS,
+	pci_write_bits16(mci_to_pci_dev(mci), IE31200_ERRSTS,
 			 IE31200_ERRSTS_BITS, IE31200_ERRSTS_BITS);
 }
 
 static void ie31200_get_and_clear_error_info(struct mem_ctl_info *mci,
 					     struct ie31200_error_info *info)
 {
-	struct pci_dev *pdev;
+	struct pci_dev *pdev = mci_to_pci_dev(mci);
 	struct ie31200_priv *priv = mci->pvt_info;
 
-	pdev = to_pci_dev(mci->pdev);
+	/*
+	 * The PCI ERRSTS register is deprecated, directly read the
+	 * MMIO-mapped ECC error log registers.
+	 */
+	if (priv->cfg->msr_clear_eccerrlog_offset) {
+		info->eccerrlog[0] = lo_hi_readq(priv->c0errlog);
+		if (nr_channels == 2)
+			info->eccerrlog[1] = lo_hi_readq(priv->c1errlog);
+
+		ie31200_clear_error_info(mci);
+		return;
+	}
 
 	/*
 	 * This is a mess because there is no atomic way to read all the
@@ -259,13 +312,15 @@ static void ie31200_process_error_info(struct mem_ctl_info *mci,
 	int channel;
 	u64 log;
 
-	if (!(info->errsts & IE31200_ERRSTS_BITS))
-		return;
+	if (!cfg->msr_clear_eccerrlog_offset) {
+		if (!(info->errsts & IE31200_ERRSTS_BITS))
+			return;
 
-	if ((info->errsts ^ info->errsts2) & IE31200_ERRSTS_BITS) {
-		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1, 0, 0, 0,
-				     -1, -1, -1, "UE overwrote CE", "");
-		info->errsts = info->errsts2;
+		if ((info->errsts ^ info->errsts2) & IE31200_ERRSTS_BITS) {
+			edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1, 0, 0, 0,
+					     -1, -1, -1, "UE overwrote CE", "");
+			info->errsts = info->errsts2;
+		}
 	}
 
 	for (channel = 0; channel < nr_channels; channel++) {
@@ -295,7 +350,7 @@ static void ie31200_check(struct mem_ctl_info *mci)
 	ie31200_process_error_info(mci, &info);
 }
 
-static void __iomem *ie31200_map_mchbar(struct pci_dev *pdev, struct res_config *cfg)
+static void __iomem *ie31200_map_mchbar(struct pci_dev *pdev, struct res_config *cfg, int mc)
 {
 	union {
 		u64 mchbar;
@@ -309,6 +364,7 @@ static void __iomem *ie31200_map_mchbar(struct pci_dev *pdev, struct res_config
 	pci_read_config_dword(pdev, IE31200_MCHBAR_LOW, &u.mchbar_low);
 	pci_read_config_dword(pdev, IE31200_MCHBAR_HIGH, &u.mchbar_high);
 	u.mchbar &= cfg->reg_mchbar_mask;
+	u.mchbar += cfg->reg_mchbar_window_size * mc;
 
 	if (u.mchbar != (resource_size_t)u.mchbar) {
 		ie31200_printk(KERN_ERR, "mmio space beyond accessible range (0x%llx)\n",
@@ -333,7 +389,7 @@ static void populate_dimm_info(struct dimm_data *dd, u32 addr_decode, int dimm,
 }
 
 static void ie31200_get_dimm_config(struct mem_ctl_info *mci, void __iomem *window,
-				    struct res_config *cfg)
+				    struct res_config *cfg, int mc)
 {
 	struct dimm_data dimm_info;
 	struct dimm_info *dimm;
@@ -347,8 +403,8 @@ static void ie31200_get_dimm_config(struct mem_ctl_info *mci, void __iomem *wind
 
 		for (j = 0; j < IE31200_DIMMS_PER_CHANNEL; j++) {
 			populate_dimm_info(&dimm_info, addr_decode, j, cfg);
-			edac_dbg(0, "channel: %d, dimm: %d, size: %lld MiB, ranks: %d, DRAM chip type: %d\n",
-				 i, j, dimm_info.size >> 20,
+			edac_dbg(0, "mc: %d, channel: %d, dimm: %d, size: %lld MiB, ranks: %d, DRAM chip type: %d\n",
+				 mc, i, j, dimm_info.size >> 20,
 				 dimm_info.ranks,
 				 dimm_info.dtype);
 
@@ -370,7 +426,7 @@ static void ie31200_get_dimm_config(struct mem_ctl_info *mci, void __iomem *wind
 	}
 }
 
-static int ie31200_register_mci(struct pci_dev *pdev, struct res_config *cfg)
+static int ie31200_register_mci(struct pci_dev *pdev, struct res_config *cfg, int mc)
 {
 	struct edac_mc_layer layers[2];
 	struct ie31200_priv *priv;
@@ -385,24 +441,23 @@ static int ie31200_register_mci(struct pci_dev *pdev, struct res_config *cfg)
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 	layers[1].size = nr_channels;
 	layers[1].is_virt_csrow = false;
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
+	mci = edac_mc_alloc(mc, ARRAY_SIZE(layers), layers,
 			    sizeof(struct ie31200_priv));
 	if (!mci)
 		return -ENOMEM;
 
-	window = ie31200_map_mchbar(pdev, cfg);
+	window = ie31200_map_mchbar(pdev, cfg, mc);
 	if (!window) {
 		ret = -ENODEV;
 		goto fail_free;
 	}
 
 	edac_dbg(3, "MC: init mci\n");
-	mci->pdev = &pdev->dev;
 	mci->mtype_cap = BIT(cfg->mtype);
 	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
 	mci->edac_cap = EDAC_FLAG_SECDED;
 	mci->mod_name = EDAC_MOD_STR;
-	mci->ctl_name = ie31200_devs[0].ctl_name;
+	mci->ctl_name = ie31200_devs[mc].ctl_name;
 	mci->dev_name = pci_name(pdev);
 	mci->edac_check = ie31200_check;
 	mci->ctl_page_to_phys = NULL;
@@ -411,8 +466,22 @@ static int ie31200_register_mci(struct pci_dev *pdev, struct res_config *cfg)
 	priv->c0errlog = window + cfg->reg_eccerrlog_offset[0];
 	priv->c1errlog = window + cfg->reg_eccerrlog_offset[1];
 	priv->cfg = cfg;
+	priv->mci = mci;
+	priv->pdev = pdev;
+	device_initialize(&priv->dev);
+	/*
+	 * The EDAC core uses mci->pdev (pointer to the structure device)
+	 * as the memory controller ID. The SoCs attach one or more memory
+	 * controllers to a single pci_dev (a single pci_dev->dev can
+	 * correspond to multiple memory controllers).
+	 *
+	 * To make mci->pdev unique, assign pci_dev->dev to mci->pdev
+	 * for the first memory controller and assign a unique priv->dev
+	 * to mci->pdev for each additional memory controller.
+	 */
+	mci->pdev = mc ? &priv->dev : &pdev->dev;
 
-	ie31200_get_dimm_config(mci, window, cfg);
+	ie31200_get_dimm_config(mci, window, cfg, mc);
 	ie31200_clear_error_info(mci);
 
 	if (edac_mc_add_mc(mci)) {
@@ -421,6 +490,7 @@ static int ie31200_register_mci(struct pci_dev *pdev, struct res_config *cfg)
 		goto fail_unmap;
 	}
 
+	ie31200_pvt.priv[mc] = priv;
 	return 0;
 fail_unmap:
 	iounmap(window);
@@ -429,9 +499,27 @@ static int ie31200_register_mci(struct pci_dev *pdev, struct res_config *cfg)
 	return ret;
 }
 
+static void ie31200_unregister_mcis(void)
+{
+	struct ie31200_priv *priv;
+	struct mem_ctl_info *mci;
+	int i;
+
+	for (i = 0; i < IE31200_IMC_NUM; i++) {
+		priv = ie31200_pvt.priv[i];
+		if (!priv)
+			continue;
+
+		mci = priv->mci;
+		edac_mc_del_mc(mci->pdev);
+		iounmap(priv->window);
+		edac_mc_free(mci);
+	}
+}
+
 static int ie31200_probe1(struct pci_dev *pdev, struct res_config *cfg)
 {
-	int ret;
+	int i, ret;
 
 	edac_dbg(0, "MC:\n");
 
@@ -440,13 +528,19 @@ static int ie31200_probe1(struct pci_dev *pdev, struct res_config *cfg)
 		return -ENODEV;
 	}
 
-	ret = ie31200_register_mci(pdev, cfg);
-	if (ret)
-		return ret;
+	for (i = 0; i < cfg->imc_num; i++) {
+		ret = ie31200_register_mci(pdev, cfg, i);
+		if (ret)
+			goto fail_register;
+	}
 
 	/* get this far and it's successful. */
 	edac_dbg(3, "MC: success\n");
 	return 0;
+
+fail_register:
+	ie31200_unregister_mcis();
+	return ret;
 }
 
 static int ie31200_init_one(struct pci_dev *pdev,
@@ -466,22 +560,15 @@ static int ie31200_init_one(struct pci_dev *pdev,
 
 static void ie31200_remove_one(struct pci_dev *pdev)
 {
-	struct mem_ctl_info *mci;
-	struct ie31200_priv *priv;
-
 	edac_dbg(0, "\n");
 	pci_dev_put(mci_pdev);
 	mci_pdev = NULL;
-	mci = edac_mc_del_mc(&pdev->dev);
-	if (!mci)
-		return;
-	priv = mci->pvt_info;
-	iounmap(priv->window);
-	edac_mc_free(mci);
+	ie31200_unregister_mcis();
 }
 
 static struct res_config snb_cfg = {
 	.mtype				= MEM_DDR3,
+	.imc_num			= 1,
 	.reg_mchbar_mask		= GENMASK_ULL(38, 15),
 	.reg_mchbar_window_size		= BIT_ULL(15),
 	.reg_eccerrlog_offset[0]	= 0x40c8,
@@ -503,6 +590,7 @@ static struct res_config snb_cfg = {
 
 static struct res_config skl_cfg = {
 	.mtype				= MEM_DDR4,
+	.imc_num			= 1,
 	.reg_mchbar_mask		= GENMASK_ULL(38, 15),
 	.reg_mchbar_window_size		= BIT_ULL(15),
 	.reg_eccerrlog_offset[0]	= 0x4048,
@@ -522,6 +610,31 @@ static struct res_config skl_cfg = {
 	.reg_mad_dimm_width_mask[1]	= GENMASK(25, 24),
 };
 
+struct res_config rpl_s_cfg = {
+	.mtype				= MEM_DDR5,
+	.imc_num			= 2,
+	.reg_mchbar_mask		= GENMASK_ULL(41, 17),
+	.reg_mchbar_window_size		= BIT_ULL(16),
+	.reg_eccerrlog_offset[0]	= 0xe048,
+	.reg_eccerrlog_offset[1]	= 0xe848,
+	.reg_eccerrlog_ce_mask		= BIT_ULL(0),
+	.reg_eccerrlog_ce_ovfl_mask	= BIT_ULL(1),
+	.reg_eccerrlog_ue_mask		= BIT_ULL(2),
+	.reg_eccerrlog_ue_ovfl_mask	= BIT_ULL(3),
+	.reg_eccerrlog_rank_mask	= GENMASK_ULL(28, 27),
+	.reg_eccerrlog_syndrome_mask	= GENMASK_ULL(23, 16),
+	.msr_clear_eccerrlog_offset	= 0x791,
+	.reg_mad_dimm_offset[0]		= 0xd80c,
+	.reg_mad_dimm_offset[1]		= 0xd810,
+	.reg_mad_dimm_size_granularity	= BIT_ULL(29),
+	.reg_mad_dimm_size_mask[0]	= GENMASK(6, 0),
+	.reg_mad_dimm_size_mask[1]	= GENMASK(22, 16),
+	.reg_mad_dimm_rank_mask[0]	= GENMASK(10, 9),
+	.reg_mad_dimm_rank_mask[1]	= GENMASK(27, 26),
+	.reg_mad_dimm_width_mask[0]	= GENMASK(8, 7),
+	.reg_mad_dimm_width_mask[1]	= GENMASK(25, 24),
+};
+
 static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_1), (kernel_ulong_t)&snb_cfg },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_2), (kernel_ulong_t)&snb_cfg },
@@ -545,6 +658,9 @@ static const struct pci_device_id ie31200_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_8), (kernel_ulong_t)&skl_cfg },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_9), (kernel_ulong_t)&skl_cfg },
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_HB_CFL_10), (kernel_ulong_t)&skl_cfg },
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_1), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_2), (kernel_ulong_t)&rpl_s_cfg},
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_IE31200_RPL_S_3), (kernel_ulong_t)&rpl_s_cfg},
 	{ 0, } /* 0 terminated list. */
 };
 MODULE_DEVICE_TABLE(pci, ie31200_pci_tbl);
-- 
2.17.1


