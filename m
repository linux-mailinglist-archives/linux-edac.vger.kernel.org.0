Return-Path: <linux-edac+bounces-3204-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1969DA452AA
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 03:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519CA164DEE
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 02:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ACF1C8637;
	Wed, 26 Feb 2025 02:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liHXNcTA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8E199385;
	Wed, 26 Feb 2025 02:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535473; cv=none; b=sDlcXS8oiietzSOFOLt9R6Hw9QYv57ixkefK7xMHzWH+WRGivOE1L9hEB7BER42jWH+6KFe0DfxBA3WhtaYtab/lZemP9nAhiDx/yHAcJBpHE5do+bYJgd39PB4saFGn/UmzVb0IARnEW/ZNCJA12OXLWYyrUHNkpSzs7G0gPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535473; c=relaxed/simple;
	bh=/plrjoiyViL8qm20mRh5hX1XMCaQmgbUZ0EyqHHpfrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ImCulm/RynY32slB1mV2oXUgbid1gNzqwyvw+mfLdsQ+rj9lUZLU9ixX/JiDQjdmEzlju0uQK7Cfx24m8YrObFyZgrzsG2S1Zhj9op9Kc2Gv/nhtomk3jyJSlY/5oxlkby6OnAkcAj54Ft8c+L+IQzQOfmpWLU/WEA4D+3C49+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liHXNcTA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740535472; x=1772071472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/plrjoiyViL8qm20mRh5hX1XMCaQmgbUZ0EyqHHpfrc=;
  b=liHXNcTARzmlgPgqefOTn9/S8YMLkwzjpG5/Z23dLgbK5nkhaD5gMjux
   77d4X0d6KAswCNC3cHyZyMlZ+MDGRdOMTv3d1Dcy26lplF7yI8WxnV5d1
   w2F4V0zpwLlYRhuGMET7DktsrHnp9v1/OiBTptDj3k9eMFvX0JgmJy6MQ
   99jkklCj4wpbumTgTNmq1aFQbji7fXpG7M5MmPx5z5PhzoXpUlyv81PHo
   x05nAbzkdlGsBVfGy46QzK3a+nIa3H/HrfFg4iUItpYTGmNVr9sA3AOrY
   WZ5S0goDGM+K7FDffvb8t8W05fkfxxNA5i8p8xeDI/e2OQTylKjld52eM
   w==;
X-CSE-ConnectionGUID: M5BH4evRTsuy7+O8H0wf9Q==
X-CSE-MsgGUID: n0TfKTxRQnCuACjAmK1Zww==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28959696"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="28959696"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:04:31 -0800
X-CSE-ConnectionGUID: ucqXGFujTau9UhWJ1Q1fXA==
X-CSE-MsgGUID: nZFKpUpOQk6lVWlwIDBY8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121180058"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:04:29 -0800
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
Subject: [PATCH 02/11] EDAC/ie31200: Fix the DIMM size mask for several SoCs
Date: Wed, 26 Feb 2025 09:51:53 +0800
Message-Id: <20250226015202.36576-3-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
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


