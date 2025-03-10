Return-Path: <linux-edac+bounces-3330-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8A8A58A04
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 02:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A85188C110
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 01:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBFF14A629;
	Mon, 10 Mar 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7QLR7qG"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F48C07;
	Mon, 10 Mar 2025 01:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741570197; cv=none; b=BG5WTPYQkhD9nLAggtAHEMxAwFtLQXKfUK500TZXlkX9Z0Lg9xrKQb5G1TJayr5evzBC/q9DytLPNNo0nP2bn5DwsLr481gbPXsDgzDzodQ4Tlx/1FDO8bPC53zZsdwxQVDBu1S5r2tqFptctzKDS1HRaHBkE08kycC2NWQRc2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741570197; c=relaxed/simple;
	bh=IOIng+x1xe1y41PeWkJy6fvN05gN4aXvjig8aUSVVAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Gq3hkWMs8vXG69I4YlAF5P31q1TwMPf4YLYKNxp8lofjGwzxHX2AIrrXlgSJopI3plw2Y3bXcwJmQdRiIxmJzkvO1U+xZ0cF51zCJyG+I6V1Ei5I4v1VfcNdwnnkyXFH9dWLad34WaV0D4kxSJs43g4kIVfH4XMOb9AAfdIacB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7QLR7qG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741570196; x=1773106196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IOIng+x1xe1y41PeWkJy6fvN05gN4aXvjig8aUSVVAA=;
  b=b7QLR7qGOTLEgSvqal43UDHY+GNAIoxbvT62kwUcxV9mzZnE+mnKx3/a
   v/HbA4gB6RO94kxoInbAnxKR2WPaMGOpPG0j2DbAuWJS1LdFnMojNshx6
   LGdgtB5nDhyYvbEmPqQEtcQ3NavA8GYPjyz+aKy4xrqCq3Azo1OLwdTWi
   SVaCGRqJAkUy2RBfvAhXCv6C5FOiW4Brmv9G5YnxOWdzMQHKdL0RCTzvU
   ah4RoktfGbcqxeR+4T8JIFVJzIiu3O+OF3gRqEr5fN8qqu4JBghjmpmU5
   kkjyEF02nGfspr8IVG443wdbvrVA4nLaL476fbS00H5+NFhonqwx7jFel
   Q==;
X-CSE-ConnectionGUID: u/Pf6Vw5SkWbtMDXwKBjiw==
X-CSE-MsgGUID: nJwYb6YASamK4gPpxMbzUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="67914625"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="67914625"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:29:55 -0700
X-CSE-ConnectionGUID: GQMQqadZQsmx4vmqe0YKYA==
X-CSE-MsgGUID: CVo9hXPTSlaKWp9g5xsj+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124925640"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:29:52 -0700
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
Subject: [PATCH v2 08/11] EDAC/ie31200: Fold the two channel loops into one loop
Date: Mon, 10 Mar 2025 09:14:08 +0800
Message-Id: <20250310011411.31685-9-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250310011411.31685-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
 <20250310011411.31685-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Fold the two channel loops to simplify the code and improve readability.
Also, delete the comments related to the DRB register, as this register
is not used here.

 No functional changes intended.

Tested-by: Gary Wang <gary.c.wang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/ie31200_edac.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 865a2f838317..01d719845a88 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -339,7 +339,7 @@ static int ie31200_probe1(struct pci_dev *pdev, struct res_config *cfg)
 	struct edac_mc_layer layers[2];
 	void __iomem *window;
 	struct ie31200_priv *priv;
-	u32 addr_decode[IE31200_CHANNELS];
+	u32 addr_decode;
 
 	edac_dbg(0, "MC:\n");
 
@@ -383,25 +383,17 @@ static int ie31200_probe1(struct pci_dev *pdev, struct res_config *cfg)
 	priv->cfg = cfg;
 
 	for (i = 0; i < IE31200_CHANNELS; i++) {
-		addr_decode[i] = readl(window + cfg->reg_mad_dimm_offset[i]);
-		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode[i]);
-	}
+		addr_decode = readl(window + cfg->reg_mad_dimm_offset[i]);
+		edac_dbg(0, "addr_decode: 0x%x\n", addr_decode);
 
-	/*
-	 * The dram rank boundary (DRB) reg values are boundary addresses
-	 * for each DRAM rank with a granularity of 64MB.  DRB regs are
-	 * cumulative; the last one will contain the total memory
-	 * contained in all ranks.
-	 */
-	for (i = 0; i < IE31200_DIMMS_PER_CHANNEL; i++) {
-		for (j = 0; j < IE31200_CHANNELS; j++) {
+		for (j = 0; j < IE31200_DIMMS_PER_CHANNEL; j++) {
 			struct dimm_data dimm_info;
 			struct dimm_info *dimm;
 			unsigned long nr_pages;
 
-			populate_dimm_info(&dimm_info, addr_decode[j], i, cfg);
+			populate_dimm_info(&dimm_info, addr_decode, j, cfg);
 			edac_dbg(0, "channel: %d, dimm: %d, size: %lld MiB, ranks: %d, DRAM chip type: %d\n",
-				 j, i, dimm_info.size >> 20,
+				 i, j, dimm_info.size >> 20,
 				 dimm_info.ranks,
 				 dimm_info.dtype);
 
@@ -411,7 +403,7 @@ static int ie31200_probe1(struct pci_dev *pdev, struct res_config *cfg)
 
 			nr_pages = nr_pages / dimm_info.ranks;
 			for (k = 0; k < dimm_info.ranks; k++) {
-				dimm = edac_get_dimm(mci, (i * dimm_info.ranks) + k, j, 0);
+				dimm = edac_get_dimm(mci, (j * dimm_info.ranks) + k, i, 0);
 				dimm->nr_pages = nr_pages;
 				edac_dbg(0, "set nr pages: 0x%lx\n", nr_pages);
 				dimm->grain = 8; /* just a guess */
-- 
2.17.1


