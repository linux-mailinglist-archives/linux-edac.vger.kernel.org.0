Return-Path: <linux-edac+bounces-3331-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3E3A58A09
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 02:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3AB188C8BF
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 01:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C4D1C6B4;
	Mon, 10 Mar 2025 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bn5L+3IM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D015ECD7;
	Mon, 10 Mar 2025 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741570206; cv=none; b=VMV5qQ68PsZYBH4MPv89W1XgqVdLyU+eViPxN1ZFUkMOx1IEx3xdHSWOurZpxGB8fRiM8mwGYbAtjfYEldzAHGhMP649mATy7jw4F0ZiXDh6Ns6tiK9CchpezQn3+ahCHKGXsmiJHrCrVyUPDP3ESmdmrFR6mG/KqKXgeURIUpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741570206; c=relaxed/simple;
	bh=gSiQOl+wvFw1Ua1z4mx/o8qFeIX/jcAhxyxCHsTRDr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qEZvcfVn/PoB1WYxxqfTyah5sEe7/sEClu6XbyS+X/jq9Af65bytagID3tSWm9Ec1ZF3fkpJPzqRVyWi5lMYoaBfVaEBsKeHZqoVHOp94ilz4yRgkx35W+fC40dOfFhT+dZb4Fz6eOSYQC1QVHJP6cIJMA8ULon25gCW7FGn1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bn5L+3IM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741570205; x=1773106205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gSiQOl+wvFw1Ua1z4mx/o8qFeIX/jcAhxyxCHsTRDr8=;
  b=bn5L+3IMn3kA111Z5Lw9ym/TQCM88hk09thQIcQ8c9nTxtXwECSm/IWq
   nwNHc/M9hhxy4aP84apV376EnIqOUhij11LHh0ttJlbrjQh39LKjs0T1e
   jkHhp0dW8RSbRkquhze367QhQNVrhKdTPzYF0liOzROACsjyHshuARJBK
   RFXRenP27XOF5mjAb//oAA3Jue85QS5cPHHHpq8ngwFZK0yzUnp6PiOir
   QUVZZW6rvdyoBzEg6pvLuh9iT/wotHAOXnCgn87OUHKzH/u+St6PwO4/q
   QKxlYBY6rkm6osk6pOX0gVZ7AR4uoUI2xd58Oec+pp60EWQ24xGgvM5oI
   Q==;
X-CSE-ConnectionGUID: Ri7ReGTEQm6KoWS+VQPpQg==
X-CSE-MsgGUID: bU82RArJSPaphOZzhj7MLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="67914643"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="67914643"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:30:05 -0700
X-CSE-ConnectionGUID: Jospx8uSScihWA1VsmEVYw==
X-CSE-MsgGUID: Bk1e4wrlTQKTM4OR5N5uRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124925667"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:30:01 -0700
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
Subject: [PATCH v2 09/11] EDAC/ie31200: Break up ie31200_probe1()
Date: Mon, 10 Mar 2025 09:14:09 +0800
Message-Id: <20250310011411.31685-10-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250310011411.31685-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
 <20250310011411.31685-1-qiuxu.zhuo@intel.com>
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


