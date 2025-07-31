Return-Path: <linux-edac+bounces-4480-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 272B7B17389
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 16:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B32F1AA01F7
	for <lists+linux-edac@lfdr.de>; Thu, 31 Jul 2025 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4921AC88B;
	Thu, 31 Jul 2025 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fx1fAw2N"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0767376;
	Thu, 31 Jul 2025 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973880; cv=none; b=X0YVP1CKsHMbTY9y0Juj7lbw6Azzytzb5FIeOwW6ppo4EfLQKwBO3uDng0PAjQtqqZSRFTnP/SuK3FNd4SoahBXQfx3Q/EDe0J0wBUlm5bmu/y7F75krobBSBcPQ7a9X29RGC1ojKWlvmgy6GFW2gG3eCJsaRNarfbp6vrY0B+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973880; c=relaxed/simple;
	bh=jtzIxCjuAe722c28oO43NixgMqMHzIjgHvU43Zh3y5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFhseYCXfr/nWQIEub9GwgBUToCjxpEU1a4teOYAlqOTpqC39ENY4nSnOnScfpGwd0ZyqLUgeZ3NrWYYDZpkSu1QXNZaQvnOltFhLEkJwPVPnwPL21hcEIXvNF7aUNsg37dMHffR5mhHak6KMpooKHDbHIbZTKgXqVtwdUwuclo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fx1fAw2N; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753973879; x=1785509879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jtzIxCjuAe722c28oO43NixgMqMHzIjgHvU43Zh3y5Q=;
  b=Fx1fAw2NAyDH9H5gKBpDGv1rg355K+C37rUbXlu0wKuaoTd95iOmvaCC
   hYbYwKtMw6I+gqXjXxjTC2/s6pD+DGQoVt7k6pwRA1G2Q+z4m73qh6FUK
   iqF/Er/ZUvvMkI8j2wczkX7nvyVFeHmU+S30d4GHHG8hx/O/da9aVJN/f
   6O+ycKyiFN77ZmzzMAzHB5WVoeK5wCW4PY88SpfGfJ+fWgQf3CFcHGCnr
   1bnnRExS7logOeMzSOXs5B1XFu4doNPhzydz63QJW2ZNOos1JkTdF9kLS
   SFAZXO65qZMUnLiE6qpJvsGQ0939j2LCrmK2UaVXzDoqsJkjXe6/WNvni
   g==;
X-CSE-ConnectionGUID: +bZd9o6bQp6qyCNAWQVNkQ==
X-CSE-MsgGUID: FYO94KGsSAWgHjbpVFIgQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56231734"
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="56231734"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:57:57 -0700
X-CSE-ConnectionGUID: X4XEjVthQZ2NFEHm7PUrBQ==
X-CSE-MsgGUID: PJEvk+hVQVW3XTngy8olaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,353,1747724400"; 
   d="scan'208";a="163633341"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2025 07:57:55 -0700
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
Subject: [PATCH 1/7] EDAC/{skx_common,skx}: Use configuration data, not global macros
Date: Thu, 31 Jul 2025 22:55:28 +0800
Message-ID: <20250731145534.2759334-2-qiuxu.zhuo@intel.com>
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

Use model-specific configuration data for the number of memory controllers
per socket, channels per memory controller, and DIMMs per channel as
intended, instead of relying on global macros for maximum values.

No functional changes intended.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/skx_base.c   | 33 ++++++++++++++++++++-------------
 drivers/edac/skx_common.c | 16 +++++++++-------
 drivers/edac/skx_common.h |  1 +
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 29897b21fb8e..078ddf95cc6e 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -33,6 +33,15 @@ static unsigned int nvdimm_count;
 #define	MASK26	0x3FFFFFF		/* Mask for 2^26 */
 #define MASK29	0x1FFFFFFF		/* Mask for 2^29 */
 
+static struct res_config skx_cfg = {
+	.type			= SKX,
+	.decs_did		= 0x2016,
+	.busno_cfg_offset	= 0xcc,
+	.ddr_imc_num		= 2,
+	.ddr_chan_num		= 3,
+	.ddr_dimm_num		= 2,
+};
+
 static struct skx_dev *get_skx_dev(struct pci_bus *bus, u8 idx)
 {
 	struct skx_dev *d;
@@ -52,7 +61,7 @@ enum munittype {
 
 struct munit {
 	u16	did;
-	u16	devfn[SKX_NUM_IMC];
+	u16	devfn[2];
 	u8	busidx;
 	u8	per_socket;
 	enum munittype mtype;
@@ -89,11 +98,11 @@ static int get_all_munits(const struct munit *m)
 		if (!pdev)
 			break;
 		ndev++;
-		if (m->per_socket == SKX_NUM_IMC) {
-			for (i = 0; i < SKX_NUM_IMC; i++)
+		if (m->per_socket == skx_cfg.ddr_imc_num) {
+			for (i = 0; i < skx_cfg.ddr_imc_num; i++)
 				if (m->devfn[i] == pdev->devfn)
 					break;
-			if (i == SKX_NUM_IMC)
+			if (i == skx_cfg.ddr_imc_num)
 				goto fail;
 		}
 		d = get_skx_dev(pdev->bus, m->busidx);
@@ -157,12 +166,6 @@ static int get_all_munits(const struct munit *m)
 	return -ENODEV;
 }
 
-static struct res_config skx_cfg = {
-	.type			= SKX,
-	.decs_did		= 0x2016,
-	.busno_cfg_offset	= 0xcc,
-};
-
 static const struct x86_cpu_id skx_cpuids[] = {
 	X86_MATCH_VFM(INTEL_SKYLAKE_X, &skx_cfg),
 	{ }
@@ -186,11 +189,11 @@ static int skx_get_dimm_config(struct mem_ctl_info *mci, struct res_config *cfg)
 	/* Only the mcmtr on the first channel is effective */
 	pci_read_config_dword(imc->chan[0].cdev, 0x87c, &mcmtr);
 
-	for (i = 0; i < SKX_NUM_CHANNELS; i++) {
+	for (i = 0; i < cfg->ddr_chan_num; i++) {
 		ndimms = 0;
 		pci_read_config_dword(imc->chan[i].cdev, 0x8C, &amap);
 		pci_read_config_dword(imc->chan[i].cdev, 0x400, &mcddrtcfg);
-		for (j = 0; j < SKX_NUM_DIMMS; j++) {
+		for (j = 0; j < cfg->ddr_dimm_num; j++) {
 			dimm = edac_get_dimm(mci, i, j, 0);
 			pci_read_config_dword(imc->chan[i].cdev,
 					      0x80 + 4 * j, &mtr);
@@ -620,6 +623,7 @@ static int __init skx_init(void)
 		return -ENODEV;
 
 	cfg = (struct res_config *)id->driver_data;
+	skx_set_res_cfg(cfg);
 
 	rc = skx_get_hi_lo(0x2034, off, &skx_tolm, &skx_tohm);
 	if (rc)
@@ -652,10 +656,13 @@ static int __init skx_init(void)
 			goto fail;
 
 		edac_dbg(2, "src_id = %d\n", src_id);
-		for (i = 0; i < SKX_NUM_IMC; i++) {
+		for (i = 0; i < cfg->ddr_imc_num; i++) {
 			d->imc[i].mc = mc++;
 			d->imc[i].lmc = i;
 			d->imc[i].src_id = src_id;
+			d->imc[i].num_channels = cfg->ddr_chan_num;
+			d->imc[i].num_dimms    = cfg->ddr_dimm_num;
+
 			rc = skx_register_mci(&d->imc[i], d->imc[i].chan[0].cdev,
 					      "Skylake Socket", EDAC_MOD_STR,
 					      skx_get_dimm_config, cfg);
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index c9ade45c1a99..d0f53a3a8a0b 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -320,10 +320,10 @@ static int get_width(u32 mtr)
  */
 int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list)
 {
+	int ndev = 0, imc_num = cfg->ddr_imc_num + cfg->hbm_imc_num;
 	struct pci_dev *pdev, *prev;
 	struct skx_dev *d;
 	u32 reg;
-	int ndev = 0;
 
 	prev = NULL;
 	for (;;) {
@@ -354,8 +354,10 @@ int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list)
 			d->seg = GET_BITFIELD(reg, 16, 23);
 		}
 
-		edac_dbg(2, "busses: 0x%x, 0x%x, 0x%x, 0x%x\n",
-			 d->bus[0], d->bus[1], d->bus[2], d->bus[3]);
+		d->num_imc = imc_num;
+
+		edac_dbg(2, "busses: 0x%x, 0x%x, 0x%x, 0x%x, imcs %d\n",
+			 d->bus[0], d->bus[1], d->bus[2], d->bus[3], imc_num);
 		list_add_tail(&d->list, &dev_edac_list);
 		prev = pdev;
 
@@ -541,10 +543,10 @@ int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
 
 	/* Allocate a new MC control structure */
 	layers[0].type = EDAC_MC_LAYER_CHANNEL;
-	layers[0].size = NUM_CHANNELS;
+	layers[0].size = imc->num_channels;
 	layers[0].is_virt_csrow = false;
 	layers[1].type = EDAC_MC_LAYER_SLOT;
-	layers[1].size = NUM_DIMMS;
+	layers[1].size = imc->num_dimms;
 	layers[1].is_virt_csrow = true;
 	mci = edac_mc_alloc(imc->mc, ARRAY_SIZE(layers), layers,
 			    sizeof(struct skx_pvt));
@@ -784,7 +786,7 @@ void skx_remove(void)
 
 	list_for_each_entry_safe(d, tmp, &dev_edac_list, list) {
 		list_del(&d->list);
-		for (i = 0; i < NUM_IMC; i++) {
+		for (i = 0; i < d->num_imc; i++) {
 			if (d->imc[i].mci)
 				skx_unregister_mci(&d->imc[i]);
 
@@ -794,7 +796,7 @@ void skx_remove(void)
 			if (d->imc[i].mbase)
 				iounmap(d->imc[i].mbase);
 
-			for (j = 0; j < NUM_CHANNELS; j++) {
+			for (j = 0; j < d->imc[i].num_channels; j++) {
 				if (d->imc[i].chan[j].cdev)
 					pci_dev_put(d->imc[i].chan[j].cdev);
 			}
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index ec4966f7ea40..3f6007a97267 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -134,6 +134,7 @@ struct skx_dev {
 	struct pci_dev *uracu; /* for i10nm CPU */
 	struct pci_dev *pcu_cr3; /* for HBM memory detection */
 	u32 mcroute;
+	int num_imc;
 	/*
 	 * Some server BIOS may hide certain memory controllers, and the
 	 * EDAC driver skips those hidden memory controllers. However, the
-- 
2.43.0


