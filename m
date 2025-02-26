Return-Path: <linux-edac+bounces-3210-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC32FA452B4
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 03:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9586818989B2
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 02:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A0A2153FF;
	Wed, 26 Feb 2025 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RyEcvuJQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C921519C;
	Wed, 26 Feb 2025 02:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535557; cv=none; b=tw5PrzZOqtVFbLxuHQdkFb2nYYgzPOBmN0yuIvphv9qYhfP9gbzTlBN54K4ji4jkhtVYj+Z+mbeb0XwMJjdnBuE5i7WQ7QMObl62YFoOrls5n640flipmFa8KkeAtnbe9L9NYiUguI0kUXEhRNdeXB2bZlEYQALIX92OKPY2Dn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535557; c=relaxed/simple;
	bh=IOIng+x1xe1y41PeWkJy6fvN05gN4aXvjig8aUSVVAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KjeEXzjs/TTMmn4zY9fRoXxk1zfhfETxaufD0CuUfH+VIxOOtts/6oxzdjmNK3Z1/mq3qq8rqi/oxVoojEZVydvumOSx6WNtCoIobgnXh5msNx5hB35OYnpAhCCaZ9EizNE8K5k/Q7yWXgf6ibB44oFBtMa3P8UHTr7UzHGl0xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RyEcvuJQ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740535556; x=1772071556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=IOIng+x1xe1y41PeWkJy6fvN05gN4aXvjig8aUSVVAA=;
  b=RyEcvuJQbOFQKt9gqQKuG4w+/82Ku0hw4jGdIyIsvTTaoyyVgXkTF4fI
   9GyGNkWLuf3Z01zwc5hK2h8EsBj8eFJv6DNAUEJDL/lRG5a5uQL2IHKVW
   7PaxkjexewDvh8Ru00/Ztl8K0Wy7njDq3lWyfgwR806DXksFBbSs+LCJn
   mQtMKIEhXytOt4EKXnyMle8V4dInI2dJK3S7JuDhqsb9sZTj8l6h0KUH3
   uw/qr5FMEpF81I+/GYcu5nddjqx+QgNAzOAIXcM7VtPP8I8eRmPIPoAXB
   F56AASuWqbydWsU+Xbpacj0un1cVGLei6QG/vUErQngHtYQRjBx7TFkRM
   g==;
X-CSE-ConnectionGUID: 2Yn6xWq8ROunZhixeTNmeA==
X-CSE-MsgGUID: ById5NEuQ7qbtzM4IYiyGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28959902"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="28959902"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:05:51 -0800
X-CSE-ConnectionGUID: bu7wCRKDRiKm/PKGVBgE1Q==
X-CSE-MsgGUID: Nclv97N6StSP2t0SJUEotQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121180595"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:05:48 -0800
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
Subject: [PATCH 08/11] EDAC/ie31200: Fold the two channel loops into one loop
Date: Wed, 26 Feb 2025 09:51:59 +0800
Message-Id: <20250226015202.36576-9-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
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


