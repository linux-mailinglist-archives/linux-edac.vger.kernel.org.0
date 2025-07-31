Return-Path: <linux-edac+bounces-4481-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC57B1738B
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 16:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5413556071B
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 14:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D79A1D86FB;
	Thu, 31 Jul 2025 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PVpJ3Eoe"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99E376;
	Thu, 31 Jul 2025 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973886; cv=none; b=Vwvr3pufwEIZJY91xo3MLuBAEk6mX9cEaGRY4PtnsnUeCAob5HxECbkdnElm9nOYu40EICN+dSWYtYNoX9FkkbmBRFNs+bSBn0X/dzCnfwj34SkugbfrVIQvxnVvPC3cD+z/VoBeMB5MLB6DZkZ1Flr4igx7bj5LAfVRDpjAQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973886; c=relaxed/simple;
	bh=zcL5VXzwVfXhToPCB0a/rPyyNUTsdB6lMBQ9Nh5hb9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhysuZFpQIMEnnmQMowlLqV4OQVw0WtgKxlPMDO12dUMr+A3/Be1/0A0Wp0xuOAxjJQJLjPDasygt1zusLD+rZpsvNfCl2yJRC3k4e6Cwzd+mO7W+cryt17aA8CgZx/VO4CA0yrfGGlPz8ulAK4rqUr1+7TYULqfnz9FStnO5yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PVpJ3Eoe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753973885; x=1785509885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zcL5VXzwVfXhToPCB0a/rPyyNUTsdB6lMBQ9Nh5hb9U=;
  b=PVpJ3Eoe/gN8IjE2Y4USPnYWel40VN0XnAq0wm094EVVjUXduYclIzZi
   Z7QGP68V4dGJLL2GuGpj49GayvIUam4M64nVOQ9mtdndPz0PXdBxme+yn
   rJ022YirFL/258U0gpmtv/sRHVtTQ6jdXF3ojsIeFyuBozkjCmbwQ6Shy
   jh6aZO2apn4UvKCNh+Z3wjOdBJl5BfKNB9SlSKTYF4PRcD/umBJ5Ykqsj
   lcb3w6Yzwc0JnOOfCQ65Q8CU7amEHFSA7EmSoa31N7X0u8wGDQY8O5riT
   Xf8GV0WG1GAzXox3vlCepc5RIQ5UBt/8gKmYmH/NEwqWLA+7NorqgvyvP
   A==;
X-CSE-ConnectionGUID: 7WscelNARQGUh7vQkjZETg==
X-CSE-MsgGUID: KoygJrd8S0C3ndhkA08SjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56231755"
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="56231755"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:58:04 -0700
X-CSE-ConnectionGUID: Q4GMS4AATW2+f3Xbdrheig==
X-CSE-MsgGUID: CZ8pHwweTlOt0W1PGRxEig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="163633398"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:58:02 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Lai Yi <yi1.lai@linux.intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] EDAC/skx_common: Move mc_mapping to be a field inside struct skx_imc
Date: Thu, 31 Jul 2025 22:55:29 +0800
Message-ID: <20250731145534.2759334-3-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731145534.2759334-1-qiuxu.zhuo@intel.com>
References: <20250731145534.2759334-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mc_mapping and imc fields of struct skx_dev have the same size,
NUM_IMC. Move mc_mapping to be a field inside struct skx_imc to prepare
for making the imc array of memory controller instances a flexible array.

No functional changes intended.

Suggested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_common.c |  8 ++++----
 drivers/edac/skx_common.h | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index d0f53a3a8a0b..94a66b28751a 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -131,7 +131,7 @@ static void skx_init_mc_mapping(struct skx_dev *d)
 	 * EDAC driver.
 	 */
 	for (int i = 0; i < NUM_IMC; i++)
-		d->mc_mapping[i] = i;
+		d->imc[i].mc_mapping = i;
 }
 
 void skx_set_mc_mapping(struct skx_dev *d, u8 pmc, u8 lmc)
@@ -139,16 +139,16 @@ void skx_set_mc_mapping(struct skx_dev *d, u8 pmc, u8 lmc)
 	edac_dbg(0, "Set the mapping of mc phy idx to logical idx: %02d -> %02d\n",
 		 pmc, lmc);
 
-	d->mc_mapping[pmc] = lmc;
+	d->imc[pmc].mc_mapping = lmc;
 }
 EXPORT_SYMBOL_GPL(skx_set_mc_mapping);
 
 static u8 skx_get_mc_mapping(struct skx_dev *d, u8 pmc)
 {
 	edac_dbg(0, "Get the mapping of mc phy idx to logical idx: %02d -> %02d\n",
-		 pmc, d->mc_mapping[pmc]);
+		 pmc, d->imc[pmc].mc_mapping);
 
-	return d->mc_mapping[pmc];
+	return d->imc[pmc].mc_mapping;
 }
 
 static bool skx_adxl_decode(struct decoded_addr *res, enum error_source err_src)
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 3f6007a97267..95d61d23f89e 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -135,16 +135,6 @@ struct skx_dev {
 	struct pci_dev *pcu_cr3; /* for HBM memory detection */
 	u32 mcroute;
 	int num_imc;
-	/*
-	 * Some server BIOS may hide certain memory controllers, and the
-	 * EDAC driver skips those hidden memory controllers. However, the
-	 * ADXL still decodes memory error address using physical memory
-	 * controller indices. The mapping table is used to convert the
-	 * physical indices (reported by ADXL) to the logical indices
-	 * (used the EDAC driver) of present memory controllers during the
-	 * error handling process.
-	 */
-	u8 mc_mapping[NUM_IMC];
 	struct skx_imc {
 		struct mem_ctl_info *mci;
 		struct pci_dev *mdev; /* for i10nm CPU */
@@ -156,6 +146,16 @@ struct skx_dev {
 		u8 mc;	/* system wide mc# */
 		u8 lmc;	/* socket relative mc# */
 		u8 src_id;
+		/*
+		 * Some server BIOS may hide certain memory controllers, and the
+		 * EDAC driver skips those hidden memory controllers. However, the
+		 * ADXL still decodes memory error address using physical memory
+		 * controller indices. The mapping table is used to convert the
+		 * physical indices (reported by ADXL) to the logical indices
+		 * (used the EDAC driver) of present memory controllers during the
+		 * error handling process.
+		 */
+		u8 mc_mapping;
 		struct skx_channel {
 			struct pci_dev	*cdev;
 			struct pci_dev	*edev;
-- 
2.43.0


