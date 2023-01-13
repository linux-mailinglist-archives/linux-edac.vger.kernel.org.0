Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18B2668A1A
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jan 2023 04:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjAMD24 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Jan 2023 22:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjAMD2f (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 Jan 2023 22:28:35 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A31EE022;
        Thu, 12 Jan 2023 19:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673580514; x=1705116514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Bk0fjGmO2d9Z7XoPVIf07Ztde5YEsSXHRYr1RRENKaY=;
  b=Z7yOm1RsCPtTT9bdSdh00uhASwIDXUmmS0jt8M72ua1QI4PTaDJZaxNX
   fcvKomswh8vyQNkXeiUWOwwSIYWGOnoQhAmJSu+HMquWM7CAt/ySKTM+n
   3X33zsufAJXY9po0NbNHW0X199Mr09XywxMLocJtFg7KWNchmtex/ruuk
   LS4zkTjLnYG3+bRDux3CkF+cr5eMJAxlRlEJnzOrr7obRUjmJi8JOty6U
   eZR5Pzlu6ips0oEHxUNM8OrsxyCQd/22NVgiYnBCpcNdM0uiqibo7l7Vg
   fu+Lf5mymdu3B5sOWbwuG5I48ifNM1ctR9z3P96L7KKXrRIWd0g8AlgVW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="410138881"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="410138881"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 19:28:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="651386255"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="651386255"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.105])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 19:28:31 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Youquan Song <youquan.song@intel.com>,
        Li Zhang <li4.zhang@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] EDAC/i10nm: Add Intel Granite Rapids server support
Date:   Fri, 13 Jan 2023 11:28:02 +0800
Message-Id: <20230113032802.41752-6-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230113032802.41752-1-qiuxu.zhuo@intel.com>
References: <20230113032802.41752-1-qiuxu.zhuo@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Granite Rapids CPU model uses similar memory controller registers
as Sapphire Rapids server but with some different configurations:

- Various memory controller numbers for different Granite Rapids CPUs.
  So detect the number of present memory controllers at run time.

- Different MMIO offsets of memory controllers.

- Different triples of bus/dev/fun of some PCI devices used in i10nm_edac.

Add above configurations and Granite Rapids CPU model ID for EDAC support.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 237 ++++++++++++++++++++++++++++++++++----
 drivers/edac/skx_common.h |   5 +-
 2 files changed, 217 insertions(+), 25 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 5682d64cceb6..bf51239aa53e 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -13,7 +13,7 @@
 #include "edac_module.h"
 #include "skx_common.h"
 
-#define I10NM_REVISION	"v0.0.5"
+#define I10NM_REVISION	"v0.0.6"
 #define EDAC_MOD_STR	"i10nm_edac"
 
 /* Debug macros */
@@ -22,25 +22,34 @@
 
 #define I10NM_GET_SCK_BAR(d, reg)	\
 	pci_read_config_dword((d)->uracu, 0xd0, &(reg))
-#define I10NM_GET_IMC_BAR(d, i, reg)	\
-	pci_read_config_dword((d)->uracu, 0xd8 + (i) * 4, &(reg))
+#define I10NM_GET_IMC_BAR(d, i, reg)		\
+	pci_read_config_dword((d)->uracu,	\
+	(res_cfg->type == GNR ? 0xd4 : 0xd8) + (i) * 4, &(reg))
 #define I10NM_GET_SAD(d, offset, i, reg)\
-	pci_read_config_dword((d)->sad_all, (offset) + (i) * 8, &(reg))
+	pci_read_config_dword((d)->sad_all, (offset) + (i) * \
+	(res_cfg->type == GNR ? 12 : 8), &(reg))
 #define I10NM_GET_HBM_IMC_BAR(d, reg)	\
 	pci_read_config_dword((d)->uracu, 0xd4, &(reg))
 #define I10NM_GET_CAPID3_CFG(d, reg)	\
-	pci_read_config_dword((d)->pcu_cr3, 0x90, &(reg))
+	pci_read_config_dword((d)->pcu_cr3,	\
+	res_cfg->type == GNR ? 0x290 : 0x90, &(reg))
+#define I10NM_GET_CAPID5_CFG(d, reg)	\
+	pci_read_config_dword((d)->pcu_cr3,	\
+	res_cfg->type == GNR ? 0x298 : 0x98, &(reg))
 #define I10NM_GET_DIMMMTR(m, i, j)	\
-	readl((m)->mbase + ((m)->hbm_mc ? 0x80c : 0x2080c) + \
+	readl((m)->mbase + ((m)->hbm_mc ? 0x80c :	\
+	(res_cfg->type == GNR ? 0xc0c : 0x2080c)) +	\
 	(i) * (m)->chan_mmio_sz + (j) * 4)
 #define I10NM_GET_MCDDRTCFG(m, i)	\
 	readl((m)->mbase + ((m)->hbm_mc ? 0x970 : 0x20970) + \
 	(i) * (m)->chan_mmio_sz)
 #define I10NM_GET_MCMTR(m, i)		\
-	readl((m)->mbase + ((m)->hbm_mc ? 0xef8 : 0x20ef8) + \
+	readl((m)->mbase + ((m)->hbm_mc ? 0xef8 :	\
+	(res_cfg->type == GNR ? 0xaf8 : 0x20ef8)) +	\
 	(i) * (m)->chan_mmio_sz)
 #define I10NM_GET_AMAP(m, i)		\
-	readl((m)->mbase + ((m)->hbm_mc ? 0x814 : 0x20814) + \
+	readl((m)->mbase + ((m)->hbm_mc ? 0x814 :	\
+	(res_cfg->type == GNR ? 0xc14 : 0x20814)) +	\
 	(i) * (m)->chan_mmio_sz)
 #define I10NM_GET_REG32(m, i, offset)	\
 	readl((m)->mbase + (i) * (m)->chan_mmio_sz + (offset))
@@ -56,7 +65,10 @@
 #define I10NM_GET_HBM_IMC_MMIO_OFFSET(reg)	\
 	((GET_BITFIELD(reg, 0, 10) << 12) + 0x140000)
 
+#define I10NM_GNR_IMC_MMIO_OFFSET	0x24c000
+#define I10NM_GNR_IMC_MMIO_SIZE		0x4000
 #define I10NM_HBM_IMC_MMIO_SIZE		0x9000
+#define I10NM_DDR_IMC_CH_CNT(reg)	GET_BITFIELD(reg, 21, 24)
 #define I10NM_IS_HBM_PRESENT(reg)	GET_BITFIELD(reg, 27, 30)
 #define I10NM_IS_HBM_IMC(reg)		GET_BITFIELD(reg, 29, 29)
 
@@ -323,6 +335,79 @@ static struct pci_dev *pci_get_dev_wrapper(int dom, unsigned int bus,
 	return pdev;
 }
 
+/**
+ * i10nm_get_imc_num() - Get the number of present DDR memory controllers.
+ *
+ * @cfg : The pointer to the structure of EDAC resource configurations.
+ *
+ * For Granite Rapids CPUs, the number of present DDR memory controllers read
+ * at runtime overwrites the value statically configured in @cfg->ddr_imc_num.
+ * For other CPUs, the number of present DDR memory controllers is statically
+ * configured in @cfg->ddr_imc_num.
+ *
+ * RETURNS : 0 on success, < 0 on failure.
+ */
+static int i10nm_get_imc_num(struct res_config *cfg)
+{
+	int n, imc_num, chan_num = 0;
+	struct skx_dev *d;
+	u32 reg;
+
+	list_for_each_entry(d, i10nm_edac_list, list) {
+		d->pcu_cr3 = pci_get_dev_wrapper(d->seg, d->bus[res_cfg->pcu_cr3_bdf.bus],
+						 res_cfg->pcu_cr3_bdf.dev,
+						 res_cfg->pcu_cr3_bdf.fun);
+		if (!d->pcu_cr3)
+			continue;
+
+		if (I10NM_GET_CAPID5_CFG(d, reg))
+			continue;
+
+		n = I10NM_DDR_IMC_CH_CNT(reg);
+
+		if (!chan_num) {
+			chan_num = n;
+			edac_dbg(2, "Get DDR CH number: %d\n", chan_num);
+		} else if (chan_num != n) {
+			i10nm_printk(KERN_NOTICE, "Get DDR CH numbers: %d, %d\n", chan_num, n);
+		}
+	}
+
+	switch (cfg->type) {
+	case GNR:
+		/*
+		 * One channel per DDR memory controller for Granite Rapids CPUs.
+		 */
+		imc_num = chan_num;
+
+		if (!imc_num) {
+			i10nm_printk(KERN_ERR, "Invalid DDR MC number\n");
+			return -ENODEV;
+		}
+
+		if (imc_num > I10NM_NUM_DDR_IMC) {
+			i10nm_printk(KERN_ERR, "Need to make I10NM_NUM_DDR_IMC >= %d\n", imc_num);
+			return -EINVAL;
+		}
+
+		if (cfg->ddr_imc_num != imc_num) {
+			/*
+			 * Store the number of present DDR memory controllers.
+			 */
+			cfg->ddr_imc_num = imc_num;
+			edac_dbg(2, "Set DDR MC number: %d", imc_num);
+		}
+
+		return 0;
+	default:
+		/*
+		 * For other CPUs, the number of present DDR memory controllers
+		 * is statically pre-configured in cfg->ddr_imc_num.
+		 */
+		return 0;
+	}
+}
+
 static bool i10nm_check_2lm(struct res_config *cfg)
 {
 	struct skx_dev *d;
@@ -445,6 +530,98 @@ static bool i10nm_mc_decode(struct decoded_addr *res)
 	return true;
 }
 
+/**
+ * get_gnr_mdev() - Get the PCI device of the @logical_idx-th DDR memory controller.
+ *
+ * @d            : The pointer to the strcture of CPU socket EDAC device.
+ * @logical_idx  : The logical index of the present memory controller (0 ~ max present MC# - 1).
+ * @physical_idx : To store the corresponding physical index of @logical_idx.
+ *
+ * RETURNS       : The PCI device of the @logical_idx-th DDR memory controller, NULL on failure.
+ */
+static struct pci_dev *get_gnr_mdev(struct skx_dev *d, int logical_idx, int *physical_idx)
+{
+#define GNR_MAX_IMC_PCI_CNT	28
+
+	struct pci_dev *mdev;
+	int i, logical = 0;
+
+	/*
+	 * Detect present memory controllers from { PCI device: 8-5, function 7-1 }
+	 */
+	for (i = 0; i < GNR_MAX_IMC_PCI_CNT; i++) {
+		mdev = pci_get_dev_wrapper(d->seg,
+					   d->bus[res_cfg->ddr_mdev_bdf.bus],
+					   res_cfg->ddr_mdev_bdf.dev + i / 7,
+					   res_cfg->ddr_mdev_bdf.fun + i % 7);
+
+		if (mdev) {
+			if (logical == logical_idx) {
+				*physical_idx = i;
+				return mdev;
+			}
+
+			pci_dev_put(mdev);
+			logical++;
+		}
+	}
+
+	return NULL;
+}
+
+/**
+ * get_ddr_munit() - Get the resource of the i-th DDR memory controller.
+ *
+ * @d      : The pointer to the strcture of CPU socket EDAC device.
+ * @i      : The index of the CPU socket relative DDR memory controller.
+ * @offset : To store the MMIO offset of the i-th DDR memory controller.
+ * @size   : To store the MMIO size of the i-th DDR memory controller.
+ *
+ * RETURNS : The PCI device of the i-th DDR memory controller, NULL on failure.
+ */
+static struct pci_dev *get_ddr_munit(struct skx_dev *d, int i, u32 *offset, unsigned long *size)
+{
+	struct pci_dev *mdev;
+	int physical_idx;
+	u32 reg;
+
+	switch (res_cfg->type) {
+	case GNR:
+		if (I10NM_GET_IMC_BAR(d, 0, reg)) {
+			i10nm_printk(KERN_ERR, "Failed to get mc0 bar\n");
+			return NULL;
+		}
+
+		mdev = get_gnr_mdev(d, i, &physical_idx);
+		if (!mdev)
+			return NULL;
+
+		*offset = I10NM_GET_IMC_MMIO_OFFSET(reg) +
+			  I10NM_GNR_IMC_MMIO_OFFSET +
+			  physical_idx * I10NM_GNR_IMC_MMIO_SIZE;
+		*size   = I10NM_GNR_IMC_MMIO_SIZE;
+
+		break;
+	default:
+		if (I10NM_GET_IMC_BAR(d, i, reg)) {
+			i10nm_printk(KERN_ERR, "Failed to get mc%d bar\n", i);
+			return NULL;
+		}
+
+		mdev = pci_get_dev_wrapper(d->seg,
+					   d->bus[res_cfg->ddr_mdev_bdf.bus],
+					   res_cfg->ddr_mdev_bdf.dev + i,
+					   res_cfg->ddr_mdev_bdf.fun);
+		if (!mdev)
+			return NULL;
+
+		*offset  = I10NM_GET_IMC_MMIO_OFFSET(reg);
+		*size    = I10NM_GET_IMC_MMIO_SIZE(reg);
+	}
+
+	return mdev;
+}
+
 static int i10nm_get_ddr_munits(void)
 {
 	struct pci_dev *mdev;
@@ -478,9 +655,8 @@ static int i10nm_get_ddr_munits(void)
 			 j++, base, reg);
 
 		for (i = 0; i < res_cfg->ddr_imc_num; i++) {
-			mdev = pci_get_dev_wrapper(d->seg, d->bus[res_cfg->ddr_mdev_bdf.bus],
-						   res_cfg->ddr_mdev_bdf.dev + i,
-						   res_cfg->ddr_mdev_bdf.fun);
+			mdev = get_ddr_munit(d, i, &off, &size);
+
 			if (i == 0 && !mdev) {
 				i10nm_printk(KERN_ERR, "No IMC found\n");
 				return -ENODEV;
@@ -490,13 +666,6 @@ static int i10nm_get_ddr_munits(void)
 
 			d->imc[i].mdev = mdev;
 
-			if (I10NM_GET_IMC_BAR(d, i, reg)) {
-				i10nm_printk(KERN_ERR, "Failed to get mc bar\n");
-				return -ENODEV;
-			}
-
-			off  = I10NM_GET_IMC_MMIO_OFFSET(reg);
-			size = I10NM_GET_IMC_MMIO_SIZE(reg);
 			edac_dbg(2, "mc%d mmio base 0x%llx size 0x%lx (reg 0x%x)\n",
 				 i, base + off, size, reg);
 
@@ -536,9 +705,6 @@ static int i10nm_get_hbm_munits(void)
 	u64 base;
 
 	list_for_each_entry(d, i10nm_edac_list, list) {
-		d->pcu_cr3 = pci_get_dev_wrapper(d->seg, d->bus[res_cfg->pcu_cr3_bdf.bus],
-						 res_cfg->pcu_cr3_bdf.dev,
-						 res_cfg->pcu_cr3_bdf.fun);
 		if (!d->pcu_cr3)
 			return -ENODEV;
 
@@ -678,6 +844,23 @@ static struct res_config spr_cfg = {
 	.offsets_demand_hbm1	= offsets_demand_spr_hbm1,
 };
 
+static struct res_config gnr_cfg = {
+	.type			= GNR,
+	.decs_did		= 0x3252,
+	.busno_cfg_offset	= 0xd0,
+	.ddr_imc_num		= 12,
+	.ddr_chan_num		= 1,
+	.ddr_dimm_num		= 2,
+	.ddr_chan_mmio_sz	= 0x4000,
+	.support_ddr5		= true,
+	.sad_all_bdf		= {0, 13, 0},
+	.pcu_cr3_bdf		= {0, 5, 0},
+	.util_all_bdf		= {0, 13, 1},
+	.uracu_bdf		= {0, 0, 1},
+	.ddr_mdev_bdf		= {0, 5, 1},
+	.sad_all_offset		= 0x300,
+};
+
 static const struct x86_cpu_id i10nm_cpuids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPINGS(0x0, 0x3), &i10nm_cfg0),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ATOM_TREMONT_D,	X86_STEPPINGS(0x4, 0xf), &i10nm_cfg1),
@@ -686,6 +869,7 @@ static const struct x86_cpu_id i10nm_cpuids[] = {
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(ICELAKE_D,		X86_STEPPINGS(0x0, 0xf), &i10nm_cfg1),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SAPPHIRERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
 	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(EMERALDRAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &spr_cfg),
+	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(GRANITERAPIDS_X,	X86_STEPPINGS(0x0, 0xf), &gnr_cfg),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, i10nm_cpuids);
@@ -705,7 +889,7 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci,
 {
 	struct skx_pvt *pvt = mci->pvt_info;
 	struct skx_imc *imc = pvt->imc;
-	u32 mtr, amap, mcddrtcfg;
+	u32 mtr, amap, mcddrtcfg = 0;
 	struct dimm_info *dimm;
 	int i, j, ndimms;
 
@@ -715,7 +899,10 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci,
 
 		ndimms = 0;
 		amap = I10NM_GET_AMAP(imc, i);
-		mcddrtcfg = I10NM_GET_MCDDRTCFG(imc, i);
+
+		if (res_cfg->type != GNR)
+			mcddrtcfg = I10NM_GET_MCDDRTCFG(imc, i);
+
 		for (j = 0; j < imc->num_dimms; j++) {
 			dimm = edac_get_dimm(mci, i, j, 0);
 			mtr = I10NM_GET_DIMMMTR(imc, i, j);
@@ -834,6 +1021,10 @@ static int __init i10nm_init(void)
 		return -ENODEV;
 	}
 
+	rc = i10nm_get_imc_num(cfg);
+	if (rc < 0)
+		goto fail;
+
 	mem_cfg_2lm = i10nm_check_2lm(cfg);
 	skx_set_mem_cfg(mem_cfg_2lm);
 
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 982e1bcb1edf..b6d3607dffe2 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -33,7 +33,7 @@
 #define SKX_NUM_CHANNELS	3	/* Channels per memory controller */
 #define SKX_NUM_DIMMS		2	/* Max DIMMS per channel */
 
-#define I10NM_NUM_DDR_IMC	4
+#define I10NM_NUM_DDR_IMC	12
 #define I10NM_NUM_DDR_CHANNELS	2
 #define I10NM_NUM_DDR_DIMMS	2
 
@@ -129,7 +129,8 @@ struct skx_pvt {
 enum type {
 	SKX,
 	I10NM,
-	SPR
+	SPR,
+	GNR
 };
 
 enum {
-- 
2.17.1

