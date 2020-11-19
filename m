Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCC82B9CE8
	for <lists+linux-edac@lfdr.de>; Thu, 19 Nov 2020 22:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgKSVW3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Nov 2020 16:22:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:60831 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgKSVW3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Nov 2020 16:22:29 -0500
IronPort-SDR: e1smBxLxC/VagWzFpFmVcl1Uey0aGudJn960i9OJJtl9EPh3urgTr05AMLSUfGh/vyuESECL6t
 LTjICo4XJZiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="171535897"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="171535897"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 13:22:27 -0800
IronPort-SDR: VLwvFGW4ER2m5jMFPRSPiBI4OUZnDQcz9WojjJq89qDDfjfqJ2r6uTDqBSe6UzEByZ+odBOSwQ
 MY/00xbqo0jw==
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="476968896"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 13:22:27 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     linux-edac@vger.kernel.org
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 3/3] EDAC/i10nm: Add Intel Sapphire Rapids server support
Date:   Thu, 19 Nov 2020 13:22:19 -0800
Message-Id: <20201119212219.1335-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20201119212219.1335-1-tony.luck@intel.com>
References: <20201119212219.1335-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

The Sapphire Rapids CPU model shares the same memory controller
architecture with Ice Lake server. There are some configurations
different from Ice Lake server as below:
- The device ID for configuration agent.
- The size for per channel memory-mapped I/O.
- The DDR5 memory support.
So add the above configurations and the Sapphire Rapids CPU model
ID for EDAC support.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/i10nm_base.c | 34 +++++++++++++++++++++++++---------
 drivers/edac/skx_base.c   |  6 +++---
 drivers/edac/skx_common.c | 23 ++++++++++++++++++-----
 drivers/edac/skx_common.h | 16 ++++++++++++----
 4 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 7b52691c45d2..238a4ad1e526 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -13,7 +13,7 @@
 #include "edac_module.h"
 #include "skx_common.h"
 
-#define I10NM_REVISION	"v0.0.3"
+#define I10NM_REVISION	"v0.0.4"
 #define EDAC_MOD_STR	"i10nm_edac"
 
 /* Debug macros */
@@ -25,11 +25,13 @@
 #define I10NM_GET_IMC_BAR(d, i, reg)	\
 	pci_read_config_dword((d)->uracu, 0xd8 + (i) * 4, &(reg))
 #define I10NM_GET_DIMMMTR(m, i, j)	\
-	readl((m)->mbase + 0x2080c + (i) * 0x4000 + (j) * 4)
+	readl((m)->mbase + 0x2080c + (i) * (m)->chan_mmio_sz + (j) * 4)
 #define I10NM_GET_MCDDRTCFG(m, i, j)	\
-	readl((m)->mbase + 0x20970 + (i) * 0x4000 + (j) * 4)
+	readl((m)->mbase + 0x20970 + (i) * (m)->chan_mmio_sz + (j) * 4)
 #define I10NM_GET_MCMTR(m, i)		\
-	readl((m)->mbase + 0x20ef8 + (i) * 0x4000)
+	readl((m)->mbase + 0x20ef8 + (i) * (m)->chan_mmio_sz)
+#define I10NM_GET_AMAP(m, i)		\
+	readl((m)->mbase + 0x20814 + (i) * (m)->chan_mmio_sz)
 
 #define I10NM_GET_SCK_MMIO_BASE(reg)	(GET_BITFIELD(reg, 0, 28) << 23)
 #define I10NM_GET_IMC_MMIO_OFFSET(reg)	(GET_BITFIELD(reg, 0, 10) << 12)
@@ -129,12 +131,22 @@ static struct res_config i10nm_cfg0 = {
 	.type			= I10NM,
 	.decs_did		= 0x3452,
 	.busno_cfg_offset	= 0xcc,
+	.ddr_chan_mmio_sz	= 0x4000,
 };
 
 static struct res_config i10nm_cfg1 = {
 	.type			= I10NM,
 	.decs_did		= 0x3452,
 	.busno_cfg_offset	= 0xd0,
+	.ddr_chan_mmio_sz	= 0x4000,
+};
+
+static struct res_config spr_cfg = {
+	.type			= SPR,
+	.decs_did		= 0x3252,
+	.busno_cfg_offset	= 0xd0,
+	.ddr_chan_mmio_sz	= 0x8000,
+	.support_ddr5		= true,
 };
 
 static const struct x86_cpu_id i10nm_cpuids[] = {
@@ -143,6 +155,7 @@ static const struct x86_cpu_id i10nm_cpuids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ICELAKE_X,		X86_STEPPINGS(0x0, 0x3), &i10nm_cfg0),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ICELAKE_X,		X86_STEPPINGS(0x4, 0xf), &i10nm_cfg1),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ICELAKE_D,		X86_STEPPINGS(0x0, 0xf), &i10nm_cfg1),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SAPPHIRERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
@@ -157,12 +170,13 @@ static bool i10nm_check_ecc(struct skx_imc *imc, int chan)
 	return !!GET_BITFIELD(mcmtr, 2, 2);
 }
 
-static int i10nm_get_dimm_config(struct mem_ctl_info *mci)
+static int i10nm_get_dimm_config(struct mem_ctl_info *mci,
+				 struct res_config *cfg)
 {
 	struct skx_pvt *pvt = mci->pvt_info;
 	struct skx_imc *imc = pvt->imc;
+	u32 mtr, amap, mcddrtcfg;
 	struct dimm_info *dimm;
-	u32 mtr, mcddrtcfg;
 	int i, j, ndimms;
 
 	for (i = 0; i < I10NM_NUM_CHANNELS; i++) {
@@ -170,6 +184,7 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci)
 			continue;
 
 		ndimms = 0;
+		amap = I10NM_GET_AMAP(imc, i);
 		for (j = 0; j < I10NM_NUM_DIMMS; j++) {
 			dimm = edac_get_dimm(mci, i, j, 0);
 			mtr = I10NM_GET_DIMMMTR(imc, i, j);
@@ -178,8 +193,8 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci)
 				 mtr, mcddrtcfg, imc->mc, i, j);
 
 			if (IS_DIMM_PRESENT(mtr))
-				ndimms += skx_get_dimm_info(mtr, 0, 0, dimm,
-							    imc, i, j);
+				ndimms += skx_get_dimm_info(mtr, 0, amap, dimm,
+							    imc, i, j, cfg);
 			else if (IS_NVDIMM_PRESENT(mcddrtcfg, j))
 				ndimms += skx_get_nvdimm_info(dimm, imc, i, j,
 							      EDAC_MOD_STR);
@@ -303,10 +318,11 @@ static int __init i10nm_init(void)
 			d->imc[i].lmc = i;
 			d->imc[i].src_id  = src_id;
 			d->imc[i].node_id = node_id;
+			d->imc[i].chan_mmio_sz = cfg->ddr_chan_mmio_sz;
 
 			rc = skx_register_mci(&d->imc[i], d->imc[i].mdev,
 					      "Intel_10nm Socket", EDAC_MOD_STR,
-					      i10nm_get_dimm_config);
+					      i10nm_get_dimm_config, cfg);
 			if (rc < 0)
 				goto fail;
 		}
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 2c7db95df326..6a4f0b27c654 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -174,7 +174,7 @@ static bool skx_check_ecc(u32 mcmtr)
 	return !!GET_BITFIELD(mcmtr, 2, 2);
 }
 
-static int skx_get_dimm_config(struct mem_ctl_info *mci)
+static int skx_get_dimm_config(struct mem_ctl_info *mci, struct res_config *cfg)
 {
 	struct skx_pvt *pvt = mci->pvt_info;
 	u32 mtr, mcmtr, amap, mcddrtcfg;
@@ -195,7 +195,7 @@ static int skx_get_dimm_config(struct mem_ctl_info *mci)
 			pci_read_config_dword(imc->chan[i].cdev,
 					      0x80 + 4 * j, &mtr);
 			if (IS_DIMM_PRESENT(mtr)) {
-				ndimms += skx_get_dimm_info(mtr, mcmtr, amap, dimm, imc, i, j);
+				ndimms += skx_get_dimm_info(mtr, mcmtr, amap, dimm, imc, i, j, cfg);
 			} else if (IS_NVDIMM_PRESENT(mcddrtcfg, j)) {
 				ndimms += skx_get_nvdimm_info(dimm, imc, i, j,
 							      EDAC_MOD_STR);
@@ -702,7 +702,7 @@ static int __init skx_init(void)
 			d->imc[i].node_id = node_id;
 			rc = skx_register_mci(&d->imc[i], d->imc[i].chan[0].cdev,
 					      "Skylake Socket", EDAC_MOD_STR,
-					      skx_get_dimm_config);
+					      skx_get_dimm_config, cfg);
 			if (rc < 0)
 				goto fail;
 		}
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 2b4ce8e5ac2f..81c3e2ec6f56 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -304,15 +304,25 @@ static int skx_get_dimm_attr(u32 reg, int lobit, int hibit, int add,
 #define numcol(reg)	skx_get_dimm_attr(reg, 0, 1, 10, 0, 2, "cols")
 
 int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
-		      struct skx_imc *imc, int chan, int dimmno)
+		      struct skx_imc *imc, int chan, int dimmno,
+		      struct res_config *cfg)
 {
-	int  banks = 16, ranks, rows, cols, npages;
+	int  banks, ranks, rows, cols, npages;
+	enum mem_type mtype;
 	u64 size;
 
 	ranks = numrank(mtr);
 	rows = numrow(mtr);
 	cols = numcol(mtr);
 
+	if (cfg->support_ddr5 && (amap & 0x8)) {
+		banks = 32;
+		mtype = MEM_DDR5;
+	} else {
+		banks = 16;
+		mtype = MEM_DDR4;
+	}
+
 	/*
 	 * Compute size in 8-byte (2^3) words, then shift to MiB (2^20)
 	 */
@@ -332,7 +342,7 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 	dimm->nr_pages = npages;
 	dimm->grain = 32;
 	dimm->dtype = get_width(mtr);
-	dimm->mtype = MEM_DDR4;
+	dimm->mtype = mtype;
 	dimm->edac_mode = EDAC_SECDED; /* likely better than this */
 	snprintf(dimm->label, sizeof(dimm->label), "CPU_SrcID#%u_MC#%u_Chan#%u_DIMM#%u",
 		 imc->src_id, imc->lmc, chan, dimmno);
@@ -390,7 +400,8 @@ int skx_get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
 
 int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
 		     const char *ctl_name, const char *mod_str,
-		     get_dimm_config_f get_dimm_config)
+		     get_dimm_config_f get_dimm_config,
+		     struct res_config *cfg)
 {
 	struct mem_ctl_info *mci;
 	struct edac_mc_layer layers[2];
@@ -425,13 +436,15 @@ int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
 	}
 
 	mci->mtype_cap = MEM_FLAG_DDR4 | MEM_FLAG_NVDIMM;
+	if (cfg->support_ddr5)
+		mci->mtype_cap |= MEM_FLAG_DDR5;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE;
 	mci->edac_cap = EDAC_FLAG_NONE;
 	mci->mod_name = mod_str;
 	mci->dev_name = pci_name(pdev);
 	mci->ctl_page_to_phys = NULL;
 
-	rc = get_dimm_config(mci);
+	rc = get_dimm_config(mci, cfg);
 	if (rc < 0)
 		goto fail;
 
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 78f8c1de0b71..bf56bebff138 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -59,6 +59,7 @@ struct skx_dev {
 		struct mem_ctl_info *mci;
 		struct pci_dev *mdev; /* for i10nm CPU */
 		void __iomem *mbase;  /* for i10nm CPU */
+		int chan_mmio_sz;     /* for i10nm CPU */
 		u8 mc;	/* system wide mc# */
 		u8 lmc;	/* socket relative mc# */
 		u8 src_id, node_id;
@@ -82,7 +83,8 @@ struct skx_pvt {
 
 enum type {
 	SKX,
-	I10NM
+	I10NM,
+	SPR
 };
 
 enum {
@@ -118,9 +120,13 @@ struct res_config {
 	unsigned int decs_did;
 	/* Default bus number configuration register offset */
 	int busno_cfg_offset;
+	/* Per DDR channel memory-mapped I/O size */
+	int ddr_chan_mmio_sz;
+	bool support_ddr5;
 };
 
-typedef int (*get_dimm_config_f)(struct mem_ctl_info *mci);
+typedef int (*get_dimm_config_f)(struct mem_ctl_info *mci,
+				 struct res_config *cfg);
 typedef bool (*skx_decode_f)(struct decoded_addr *res);
 typedef void (*skx_show_retry_log_f)(struct decoded_addr *res, char *msg, int len);
 
@@ -136,14 +142,16 @@ int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list);
 int skx_get_hi_lo(unsigned int did, int off[], u64 *tolm, u64 *tohm);
 
 int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
-		      struct skx_imc *imc, int chan, int dimmno);
+		      struct skx_imc *imc, int chan, int dimmno,
+		      struct res_config *cfg);
 
 int skx_get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
 			int chan, int dimmno, const char *mod_str);
 
 int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
 		     const char *ctl_name, const char *mod_str,
-		     get_dimm_config_f get_dimm_config);
+		     get_dimm_config_f get_dimm_config,
+		     struct res_config *cfg);
 
 int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 			void *data);
-- 
2.21.1

