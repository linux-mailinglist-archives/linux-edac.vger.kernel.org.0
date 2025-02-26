Return-Path: <linux-edac+bounces-3211-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B12A8A452BD
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 03:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96A9189A0AD
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 02:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7561220F06C;
	Wed, 26 Feb 2025 02:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c4d7bzhp"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1114212B3B;
	Wed, 26 Feb 2025 02:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535564; cv=none; b=P7d4IdQ3lUB4NHAfF5Nblj7EBilxITp8ssw/z9MgLdOzszAxJIYH3b/pOaIUecvlwppf8YYvwQ9Iu/o5wRO+OIA3ivmyS7qzhp0QufuVAiBl7lKrtwz7B29zq1tAdZkn/Fl000TVNBFC96F4X88XX3h2qmtdv+Fn7EQilWL17/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535564; c=relaxed/simple;
	bh=gSiQOl+wvFw1Ua1z4mx/o8qFeIX/jcAhxyxCHsTRDr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UWJ3ZC3p9V6+2Q3p639MZGIYOhDbRwH3y7NpoR0K+JqVnStqNukNbBbb+tZ+o6+OdY4jNTevZEfzX7hDO+2tdltb8LLcYPEr66nl3HR+QOGV8JPcD+ow+hi8gLR1e6mrN/EplcPoIi8SGxu/UzNzKSOUSdwVKh1TmNRDXAnYl+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c4d7bzhp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740535563; x=1772071563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gSiQOl+wvFw1Ua1z4mx/o8qFeIX/jcAhxyxCHsTRDr8=;
  b=c4d7bzhpvJrVTzmXRL0bM7mRQfT/gOX8tMeVosNthd+tu+UESm8Vt1Xw
   x6Qy2CRRdkvdy12Mvw9O/lWTYd4SgPc4oUIpgzkf3+IeSoVq10jyFSX82
   WfNLyB6lcFzE/CcinPkKzR3J4FRbi/MgoHNS4LDB6n3Xmj0Z6FiAdS3+q
   vXvVxuHNWiTXjP5qesa86g1d/CLwEBx3OSsqly4LGiutzuf2voBjsuqje
   SNyM7uN/AERt3LlDD9sM5WdYzt6ZJxOlABD8IuKTd0V+0Nk4Dk5KJ7T7w
   SWwih6mpgzKgFzwmnEM7CjVCJrdcyJxSBJedxQy0Wa4Q4iwezfi3vErz4
   Q==;
X-CSE-ConnectionGUID: n9nY72AbRFSeLFXwL396yw==
X-CSE-MsgGUID: Sl4Of8bnSJWSKJbno4XdhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28959913"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="28959913"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:06:02 -0800
X-CSE-ConnectionGUID: 7Y1nIlgrTgGR3oIX8Vm6DA==
X-CSE-MsgGUID: W5zt0TB1Rka2xbWCdZx1Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121180661"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:06:00 -0800
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
Subject: [PATCH 09/11] EDAC/ie31200: Break up ie31200_probe1()
Date: Wed, 26 Feb 2025 09:52:00 +0800
Message-Id: <20250226015202.36576-10-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Split ie31200_probe1() into two helper functions to easily extend support
for multiple memory controllers.

No functional changes intended.

Tested-by: Gary Wang <gary.c.wang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/ie31200_edac.c | 108 ++++++++++++++++++++----------------
 1 file changed, 61 insertions(+), 47 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 01d719845a88..70be0d00a188 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -332,21 +332,51 @@ static void populate_dimm_info(struct dimm_data *dd, u32 addr_decode, int dimm,
 	dd->dtype = field_get(cfg->reg_mad_dimm_width_mask[dimm], addr_decode) + DEV_X8;
 }
 
-static int ie31200_probe1(struct pci_dev *pdev, struct res_config *cfg)
+static void ie31200_get_dimm_config(struct mem_ctl_info *mci, void __iomem *window,
+				    struct res_config *cfg)
 {
-	int i, j, k, ret;
-	struct mem_ctl_info *mci = NULL;
-	struct edac_mc_layer layers[2];
-	void __iomem *window;
-	struct ie31200_priv *priv;
+	struct dimm_data dimm_info;
+	struct dimm_info *dimm;
+	unsigned long nr_pages;
 	u32 addr_decode;
+	int i, j, k;
 
-	edac_dbg(0, "MC:\n");
+	for (i = 0; i < IE31200_CHANNELS; i++) {
+		addr_decode = readl(window + cfg->reg_mad_dimm_offset[i]);
+		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode);
 
-	if (!ecc_capable(pdev)) {
-		ie31200_printk(KERN_INFO, "No ECC support\n");
-		return -ENODEV;
+		for (j = 0; j < IE31200_DIMMS_PER_CHANNEL; j++) {
+			populate_dimm_info(&dimm_info, addr_decode, j, cfg);
+			edac_dbg(0, "channel: %d, dimm: %d, size: %lld MiB, ranks: %d, DRAM chip type: %d\n",
+				 i, j, dimm_info.size >> 20,
+				 dimm_info.ranks,
+				 dimm_info.dtype);
+
+			nr_pages = MiB_TO_PAGES(dimm_info.size >> 20);
+			if (nr_pages == 0)
+				continue;
+
+			nr_pages = nr_pages / dimm_info.ranks;
+			for (k = 0; k < dimm_info.ranks; k++) {
+				dimm = edac_get_dimm(mci, (j * dimm_info.ranks) + k, i, 0);
+				dimm->nr_pages = nr_pages;
+				edac_dbg(0, "set nr pages: 0x%lx\n", nr_pages);
+				dimm->grain = 8; /* just a guess */
+				dimm->mtype = cfg->mtype;
+				dimm->dtype = dimm_info.dtype;
+				dimm->edac_mode = EDAC_UNKNOWN;
+			}
+		}
 	}
+}
+
+static int ie31200_register_mci(struct pci_dev *pdev, struct res_config *cfg)
+{
+	struct edac_mc_layer layers[2];
+	struct ie31200_priv *priv;
+	struct mem_ctl_info *mci;
+	void __iomem *window;
+	int ret;
 
 	nr_channels = how_many_channels(pdev);
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
@@ -382,38 +412,7 @@ static int ie31200_probe1(struct pci_dev *pdev, struct res_config *cfg)
 	priv->c1errlog = window + cfg->reg_eccerrlog_offset[1];
 	priv->cfg = cfg;
 
-	for (i = 0; i < IE31200_CHANNELS; i++) {
-		addr_decode = readl(window + cfg->reg_mad_dimm_offset[i]);
-		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode);
-
-		for (j = 0; j < IE31200_DIMMS_PER_CHANNEL; j++) {
-			struct dimm_data dimm_info;
-			struct dimm_info *dimm;
-			unsigned long nr_pages;
-
-			populate_dimm_info(&dimm_info, addr_decode, j, cfg);
-			edac_dbg(0, "channel: %d, dimm: %d, size: %lld MiB, ranks: %d, DRAM chip type: %d\n",
-				 i, j, dimm_info.size >> 20,
-				 dimm_info.ranks,
-				 dimm_info.dtype);
-
-			nr_pages = MiB_TO_PAGES(dimm_info.size >> 20);
-			if (nr_pages == 0)
-				continue;
-
-			nr_pages = nr_pages / dimm_info.ranks;
-			for (k = 0; k < dimm_info.ranks; k++) {
-				dimm = edac_get_dimm(mci, (j * dimm_info.ranks) + k, i, 0);
-				dimm->nr_pages = nr_pages;
-				edac_dbg(0, "set nr pages: 0x%lx\n", nr_pages);
-				dimm->grain = 8; /* just a guess */
-				dimm->mtype = cfg->mtype;
-				dimm->dtype = dimm_info.dtype;
-				dimm->edac_mode = EDAC_UNKNOWN;
-			}
-		}
-	}
-
+	ie31200_get_dimm_config(mci, window, cfg);
 	ie31200_clear_error_info(mci);
 
 	if (edac_mc_add_mc(mci)) {
@@ -422,19 +421,34 @@ static int ie31200_probe1(struct pci_dev *pdev, struct res_config *cfg)
 		goto fail_unmap;
 	}
 
-	/* get this far and it's successful */
-	edac_dbg(3, "MC: success\n");
 	return 0;
-
 fail_unmap:
 	iounmap(window);
-
 fail_free:
 	edac_mc_free(mci);
-
 	return ret;
 }
 
+static int ie31200_probe1(struct pci_dev *pdev, struct res_config *cfg)
+{
+	int ret;
+
+	edac_dbg(0, "MC:\n");
+
+	if (!ecc_capable(pdev)) {
+		ie31200_printk(KERN_INFO, "No ECC support\n");
+		return -ENODEV;
+	}
+
+	ret = ie31200_register_mci(pdev, cfg);
+	if (ret)
+		return ret;
+
+	/* get this far and it's successful. */
+	edac_dbg(3, "MC: success\n");
+	return 0;
+}
+
 static int ie31200_init_one(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
-- 
2.17.1


