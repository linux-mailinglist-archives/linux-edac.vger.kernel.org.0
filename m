Return-Path: <linux-edac+bounces-5469-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 372F8C6F1A9
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 15:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE74735E4CC
	for <lists+linux-edac@lfdr.de>; Wed, 19 Nov 2025 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5DC3612E8;
	Wed, 19 Nov 2025 13:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akDNtFw7"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB993587D1;
	Wed, 19 Nov 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560344; cv=none; b=GOxMC6ii0yElswpqrqPRppVw1Bnq7M56qQtPYK8hdHPaojI39V7GnNrGMx+pf1FlTGv6yTbG624Qo1ZJOZl47X/3aZPIiIvMtMQG5zrVraSAoJ6FEXJApdqRi37CnLwaKv6NAWH0C57K3fxbwbd8o4AdFhVBl6KVk2z9k+t3Ur4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560344; c=relaxed/simple;
	bh=CLCDritYqwWsg3vQUUO094s+CUEvzMPPOabvLZY+O40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyAd4N/fOlejkdTHAqxsiXPxfVWATy3znfmP9v/SSgTKmaiYooZKDCJdTPr3S4BkRRaQ2bWoO7I/vSeiP42+s8QLxCRzJH5m9tzjVENO2QsOowfmTkRg6gBZdbp3X54XCTt/dc4QzLUgtUvb6HjPnAd9mYsslAtvczx0WDUimZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akDNtFw7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763560343; x=1795096343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CLCDritYqwWsg3vQUUO094s+CUEvzMPPOabvLZY+O40=;
  b=akDNtFw73PI4J1MEcC04c9APnNTO8SHc4QQWZ4HDh+VTrAhbXaTVMBE8
   o2UTO+SXXBsOFUni4K2qdu4FqM0ZbhypWr7rl3r9PNQbSzlyHgI8Lafdk
   t9176iA337MpB02zDUAhKFX4KunRfLedTn/7m/Pk5UutGAlS/wiA7AfRw
   ZqGB72qPzC/ipSaLWL5IP3m3TvUE1AcEczIsAaFyYAMShXmCh7DXXgN8D
   5zjub6gpcXYCAnqk3OIW5Wp9SRi631H/EbWmJnQe+QTrwy3I6PgyWey2f
   W8V05bLmT/UMMR0EyroRYn8dZVCiRiQQ3mDJ0QieZMyNg7P2wLeOD4/Hf
   Q==;
X-CSE-ConnectionGUID: gm93DUqAS5asmGQT3jlNaQ==
X-CSE-MsgGUID: ZfzD0QuNT8S041zswvRU9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="64607310"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="64607310"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:52:22 -0800
X-CSE-ConnectionGUID: Jo6yM6OaTUGlnMivuHfhcA==
X-CSE-MsgGUID: Mcq9B/krSwqw56BwhuJ8Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="214439471"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 05:52:18 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	Lai Yi <yi1.lai@linux.intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] EDAC/{skx_common,skx,i10nm}: Make skx_register_mci() independent of pci_dev
Date: Wed, 19 Nov 2025 21:41:25 +0800
Message-ID: <20251119134132.2389472-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
References: <20251119134132.2389472-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory controllers in the new Intel server CPUs, such as Diamond Rapids,
are presented as MMIO-based devices rather than PCI devices.
Modify skx_register_mci() to be independent of 'pci_dev' and use a generic
'dev' of 'struct device' to prepare for support of such MMIO-based memory
controllers.

Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c |  3 ++-
 drivers/edac/skx_base.c   |  4 ++--
 drivers/edac/skx_common.c | 10 +++++-----
 drivers/edac/skx_common.h |  2 +-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 2010a47149f4..89b3e8cc38b1 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -1198,7 +1198,8 @@ static int __init i10nm_init(void)
 				d->imc[i].num_dimms    = cfg->ddr_dimm_num;
 			}
 
-			rc = skx_register_mci(&d->imc[i], d->imc[i].mdev,
+			rc = skx_register_mci(&d->imc[i], &d->imc[i].mdev->dev,
+					      pci_name(d->imc[i].mdev),
 					      "Intel_10nm Socket", EDAC_MOD_STR,
 					      i10nm_get_dimm_config, cfg);
 			if (rc < 0)
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 078ddf95cc6e..aa6593ccda2d 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -662,8 +662,8 @@ static int __init skx_init(void)
 			d->imc[i].src_id = src_id;
 			d->imc[i].num_channels = cfg->ddr_chan_num;
 			d->imc[i].num_dimms    = cfg->ddr_dimm_num;
-
-			rc = skx_register_mci(&d->imc[i], d->imc[i].chan[0].cdev,
+			rc = skx_register_mci(&d->imc[i], &d->imc[i].chan[0].cdev->dev,
+					      pci_name(d->imc[i].chan[0].cdev),
 					      "Skylake Socket", EDAC_MOD_STR,
 					      skx_get_dimm_config, cfg);
 			if (rc < 0)
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 724842f512ac..cf58cb5951ab 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -545,9 +545,9 @@ int skx_get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
 }
 EXPORT_SYMBOL_GPL(skx_get_nvdimm_info);
 
-int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
-		     const char *ctl_name, const char *mod_str,
-		     get_dimm_config_f get_dimm_config,
+int skx_register_mci(struct skx_imc *imc, struct device *dev,
+		     const char *dev_name, const char *ctl_name,
+		     const char *mod_str, get_dimm_config_f get_dimm_config,
 		     struct res_config *cfg)
 {
 	struct mem_ctl_info *mci;
@@ -588,7 +588,7 @@ int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
 	mci->edac_ctl_cap = EDAC_FLAG_NONE;
 	mci->edac_cap = EDAC_FLAG_NONE;
 	mci->mod_name = mod_str;
-	mci->dev_name = pci_name(pdev);
+	mci->dev_name = dev_name;
 	mci->ctl_page_to_phys = NULL;
 
 	rc = get_dimm_config(mci, cfg);
@@ -596,7 +596,7 @@ int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
 		goto fail;
 
 	/* Record ptr to the generic device */
-	mci->pdev = &pdev->dev;
+	mci->pdev = dev;
 
 	/* Add this new MC control structure to EDAC's list of MCs */
 	if (unlikely(edac_mc_add_mc(mci))) {
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 73ba89786cdf..0be088f47587 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -302,7 +302,7 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 int skx_get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
 			int chan, int dimmno, const char *mod_str);
 
-int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
+int skx_register_mci(struct skx_imc *imc, struct device *dev, const char *dev_name,
 		     const char *ctl_name, const char *mod_str,
 		     get_dimm_config_f get_dimm_config,
 		     struct res_config *cfg);
-- 
2.43.0


