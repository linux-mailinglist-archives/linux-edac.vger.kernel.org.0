Return-Path: <linux-edac+bounces-3324-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA0CA589F8
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 02:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4031C188D731
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 01:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B2114D70E;
	Mon, 10 Mar 2025 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AIbZX3FO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9533412A177;
	Mon, 10 Mar 2025 01:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741570112; cv=none; b=XI4xhEMs5HHssth8D+Uo/Be7PlfKh0NNOfE5c23gZoMC7Dsl4wvhIGslR8meMJVOllzY0yBtFuCdGT0ae1SAdORC7r5yu1b1M3ac9RDQ4iOltDyayIA4fMXOVer0JQ6lYHumtJgoE5B0CrXH0Sra2vXzHWCzM1CW3GP8VCvP14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741570112; c=relaxed/simple;
	bh=/plrjoiyViL8qm20mRh5hX1XMCaQmgbUZ0EyqHHpfrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AOACDxSiwEt4iMRaaPCfb/9HiCxS0mmLYtq1urIE02CAP6V3N2QajgLsifw9IKrkAtCaJ/fxC1yNqsb89OUFiQbDNFPIuJU6MnuXsjFOgNrxBwKXXqC5m2yG2BxJOoG6IgWKMJ8xrFpVZ3B+Y6VDVvuvPevttso9pXDq8xIsA/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AIbZX3FO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741570111; x=1773106111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/plrjoiyViL8qm20mRh5hX1XMCaQmgbUZ0EyqHHpfrc=;
  b=AIbZX3FO9AaP84GFR1ss5x2FPnNkjN9LxCHV6HYhZX8K58nOm2pjWiGD
   s+/pA571M3RZVcmIYNYM3UG7EeJ7A3R6leDel4JdOMD3CBD0ZTVkv4zPc
   jIT8rIVDiAzydT3c3bCvDf0AIYQY8eVUqkz0+H7Pu12gm47haoiFY0WWd
   6Dok6C5/UfsN2YVWGRiXbwIjslKrZhbkF6gpXgUkRwcckeklYyWA5lebx
   Z2IRi9Mm1FYVPH5TPK4Ja9lQxMqqrQm5YgtU1kl09+RpvJilwux3536Mf
   MZs+gjdTneHL2BAfaUhBeMr4jWvhXKTMspkUEhdY+K13ME7FZbGk+/zkL
   A==;
X-CSE-ConnectionGUID: InOHoP3cT3C0bUeLzSdlCg==
X-CSE-MsgGUID: apQYonB5QfWPCAyNl7gUvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="67914560"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="67914560"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:28:30 -0700
X-CSE-ConnectionGUID: 2NT+JRmQTeKHcOooObF4fw==
X-CSE-MsgGUID: ib56WAH6TYiltA0dr8zK5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124925498"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 18:28:27 -0700
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
Subject: [PATCH v2 02/11] EDAC/ie31200: Fix the DIMM size mask for several SoCs
Date: Mon, 10 Mar 2025 09:14:02 +0800
Message-Id: <20250310011411.31685-3-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250310011411.31685-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
 <20250310011411.31685-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

The DIMM size mask for {Sky, Kaby, Coffee} Lake is not bits{7:0},
but bits{5:0}. Fix it.

Fixes: 953dee9bbd24 ("EDAC, ie31200_edac: Add Skylake support")
Tested-by: Gary Wang <gary.c.wang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/ie31200_edac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 10301e17014c..2886866cb457 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -165,6 +165,7 @@
 #define IE31200_MAD_DIMM_0_OFFSET		0x5004
 #define IE31200_MAD_DIMM_0_OFFSET_SKL		0x500C
 #define IE31200_MAD_DIMM_SIZE			GENMASK_ULL(7, 0)
+#define IE31200_MAD_DIMM_SIZE_SKL		GENMASK_ULL(5, 0)
 #define IE31200_MAD_DIMM_A_RANK			BIT(17)
 #define IE31200_MAD_DIMM_A_RANK_SHIFT		17
 #define IE31200_MAD_DIMM_A_RANK_SKL		BIT(10)
@@ -378,7 +379,7 @@ static void __iomem *ie31200_map_mchbar(struct pci_dev *pdev)
 static void __skl_populate_dimm_info(struct dimm_data *dd, u32 addr_decode,
 				     int chan)
 {
-	dd->size = (addr_decode >> (chan << 4)) & IE31200_MAD_DIMM_SIZE;
+	dd->size = (addr_decode >> (chan << 4)) & IE31200_MAD_DIMM_SIZE_SKL;
 	dd->dual_rank = (addr_decode & (IE31200_MAD_DIMM_A_RANK_SKL << (chan << 4))) ? 1 : 0;
 	dd->x16_width = ((addr_decode & (IE31200_MAD_DIMM_A_WIDTH_SKL << (chan << 4))) >>
 				(IE31200_MAD_DIMM_A_WIDTH_SKL_SHIFT + (chan << 4)));
-- 
2.17.1


