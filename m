Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F3F3A4758
	for <lists+linux-edac@lfdr.de>; Fri, 11 Jun 2021 19:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhFKRDv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Jun 2021 13:03:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:56402 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhFKRDs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Jun 2021 13:03:48 -0400
IronPort-SDR: i85QvnlqfS0lSJ3aGGP9I8E8h7zjJFOGjDO9+s+w+lHsdMJGoeSwG/Jk5Yx2TCXOQGd/+MJbzI
 ILpWLe298C5A==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="266715352"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="266715352"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:01:37 -0700
IronPort-SDR: bnpeAnruE27xQ7fAWvi2s0yr0rY3PQYLR6e1zzW56RdNS2PcWiQoBmUFHsy32ZJS+mN+CQIpPz
 Vb8vZZg9npDg==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="483329868"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:01:37 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     tony.luck@intel.com
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] EDAC/i10nm: Add support for high bandwidth memory
Date:   Fri, 11 Jun 2021 10:01:20 -0700
Message-Id: <20210611170123.1057025-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611170123.1057025-1-tony.luck@intel.com>
References: <20210611170123.1057025-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

A future Xeon processor will include in-package HBM (high bandwidth
memory). The in-package HBM memory controller shares the same
architecture with the regular DDR memory controller.

Add the HBM memory controller devices for EDAC support.

Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/i10nm_base.c | 132 ++++++++++++++++++++++++++++++++++----
 drivers/edac/skx_common.c |  15 +++--
 drivers/edac/skx_common.h |  20 +++++-
 3 files changed, 148 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 91431d8922a0..fb7e72d3fd2c 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -13,7 +13,7 @@
 #include "edac_module.h"
 #include "skx_common.h"
 
-#define I10NM_REVISION	"v0.0.4"
+#define I10NM_REVISION	"v0.0.5"
 #define EDAC_MOD_STR	"i10nm_edac"
 
 /* Debug macros */
@@ -26,19 +26,33 @@
 	pci_read_config_dword((d)->uracu, 0xd8 + (i) * 4, &(reg))
 #define I10NM_GET_SAD(d, offset, i, reg)\
 	pci_read_config_dword((d)->sad_all, (offset) + (i) * 8, &(reg))
+#define I10NM_GET_HBM_IMC_BAR(d, reg)	\
+	pci_read_config_dword((d)->uracu, 0xd4, &(reg))
+#define I10NM_GET_CAPID3_CFG(d, reg)	\
+	pci_read_config_dword((d)->pcu_cr3, 0x90, &(reg))
 #define I10NM_GET_DIMMMTR(m, i, j)	\
-	readl((m)->mbase + 0x2080c + (i) * (m)->chan_mmio_sz + (j) * 4)
+	readl((m)->mbase + ((m)->hbm_mc ? 0x80c : 0x2080c) + \
+	(i) * (m)->chan_mmio_sz + (j) * 4)
 #define I10NM_GET_MCDDRTCFG(m, i, j)	\
-	readl((m)->mbase + 0x20970 + (i) * (m)->chan_mmio_sz + (j) * 4)
+	readl((m)->mbase + ((m)->hbm_mc ? 0x970 : 0x20970) + \
+	(i) * (m)->chan_mmio_sz + (j) * 4)
 #define I10NM_GET_MCMTR(m, i)		\
-	readl((m)->mbase + 0x20ef8 + (i) * (m)->chan_mmio_sz)
+	readl((m)->mbase + ((m)->hbm_mc ? 0xef8 : 0x20ef8) + \
+	(i) * (m)->chan_mmio_sz)
 #define I10NM_GET_AMAP(m, i)		\
-	readl((m)->mbase + 0x20814 + (i) * (m)->chan_mmio_sz)
+	readl((m)->mbase + ((m)->hbm_mc ? 0x814 : 0x20814) + \
+	(i) * (m)->chan_mmio_sz)
 
 #define I10NM_GET_SCK_MMIO_BASE(reg)	(GET_BITFIELD(reg, 0, 28) << 23)
 #define I10NM_GET_IMC_MMIO_OFFSET(reg)	(GET_BITFIELD(reg, 0, 10) << 12)
 #define I10NM_GET_IMC_MMIO_SIZE(reg)	((GET_BITFIELD(reg, 13, 23) - \
 					 GET_BITFIELD(reg, 0, 10) + 1) << 12)
+#define I10NM_GET_HBM_IMC_MMIO_OFFSET(reg)	\
+	((GET_BITFIELD(reg, 0, 10) << 12) + 0x140000)
+
+#define I10NM_HBM_IMC_MMIO_SIZE		0x9000
+#define I10NM_IS_HBM_PRESENT(reg)	GET_BITFIELD(reg, 27, 30)
+#define I10NM_IS_HBM_IMC(reg)		GET_BITFIELD(reg, 29, 29)
 
 #define I10NM_MAX_SAD			16
 #define I10NM_SAD_ENABLE(reg)		GET_BITFIELD(reg, 0, 0)
@@ -94,7 +108,7 @@ static bool i10nm_check_2lm(struct res_config *cfg)
 	return false;
 }
 
-static int i10nm_get_all_munits(void)
+static int i10nm_get_ddr_munits(void)
 {
 	struct pci_dev *mdev;
 	void __iomem *mbase;
@@ -122,7 +136,7 @@ static int i10nm_get_all_munits(void)
 		edac_dbg(2, "socket%d mmio base 0x%llx (reg 0x%x)\n",
 			 j++, base, reg);
 
-		for (i = 0; i < I10NM_NUM_IMC; i++) {
+		for (i = 0; i < I10NM_NUM_DDR_IMC; i++) {
 			mdev = pci_get_dev_wrapper(d->seg, d->bus[0],
 						   12 + i, 0);
 			if (i == 0 && !mdev) {
@@ -158,6 +172,90 @@ static int i10nm_get_all_munits(void)
 	return 0;
 }
 
+static bool i10nm_check_hbm_imc(struct skx_dev *d)
+{
+	u32 reg;
+
+	if (I10NM_GET_CAPID3_CFG(d, reg)) {
+		i10nm_printk(KERN_ERR, "Failed to get capid3_cfg\n");
+		return false;
+	}
+
+	return I10NM_IS_HBM_PRESENT(reg) != 0;
+}
+
+static int i10nm_get_hbm_munits(void)
+{
+	struct pci_dev *mdev;
+	void __iomem *mbase;
+	u32 reg, off, mcmtr;
+	struct skx_dev *d;
+	int i, lmc;
+	u64 base;
+
+	list_for_each_entry(d, i10nm_edac_list, list) {
+		d->pcu_cr3 = pci_get_dev_wrapper(d->seg, d->bus[1], 30, 3);
+		if (!d->pcu_cr3)
+			return -ENODEV;
+
+		if (!i10nm_check_hbm_imc(d)) {
+			i10nm_printk(KERN_DEBUG, "No hbm memory\n");
+			return -ENODEV;
+		}
+
+		if (I10NM_GET_SCK_BAR(d, reg)) {
+			i10nm_printk(KERN_ERR, "Failed to get socket bar\n");
+			return -ENODEV;
+		}
+		base = I10NM_GET_SCK_MMIO_BASE(reg);
+
+		if (I10NM_GET_HBM_IMC_BAR(d, reg)) {
+			i10nm_printk(KERN_ERR, "Failed to get hbm mc bar\n");
+			return -ENODEV;
+		}
+		base += I10NM_GET_HBM_IMC_MMIO_OFFSET(reg);
+
+		lmc = I10NM_NUM_DDR_IMC;
+
+		for (i = 0; i < I10NM_NUM_HBM_IMC; i++) {
+			mdev = pci_get_dev_wrapper(d->seg, d->bus[0],
+						   12 + i / 4, 1 + i % 4);
+			if (i == 0 && !mdev) {
+				i10nm_printk(KERN_ERR, "No hbm mc found\n");
+				return -ENODEV;
+			}
+			if (!mdev)
+				continue;
+
+			d->imc[lmc].mdev = mdev;
+			off = i * I10NM_HBM_IMC_MMIO_SIZE;
+
+			edac_dbg(2, "hbm mc%d mmio base 0x%llx size 0x%x\n",
+				 lmc, base + off, I10NM_HBM_IMC_MMIO_SIZE);
+
+			mbase = ioremap(base + off, I10NM_HBM_IMC_MMIO_SIZE);
+			if (!mbase) {
+				i10nm_printk(KERN_ERR, "Failed to ioremap for hbm mc 0x%llx\n",
+					     base + off);
+				return -ENOMEM;
+			}
+
+			d->imc[lmc].mbase = mbase;
+			d->imc[lmc].hbm_mc = true;
+
+			mcmtr = I10NM_GET_MCMTR(&d->imc[lmc], 0);
+			if (!I10NM_IS_HBM_IMC(mcmtr)) {
+				i10nm_printk(KERN_ERR, "This isn't an hbm mc!\n");
+				return -ENODEV;
+			}
+
+			lmc++;
+		}
+	}
+
+	return 0;
+}
+
 static struct res_config i10nm_cfg0 = {
 	.type			= I10NM,
 	.decs_did		= 0x3452,
@@ -181,6 +279,7 @@ static struct res_config spr_cfg = {
 	.decs_did		= 0x3252,
 	.busno_cfg_offset	= 0xd0,
 	.ddr_chan_mmio_sz	= 0x8000,
+	.hbm_chan_mmio_sz	= 0x4000,
 	.support_ddr5		= true,
 	.sad_all_devfn		= PCI_DEVFN(10, 0),
 	.sad_all_offset		= 0x300,
@@ -216,13 +315,13 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci,
 	struct dimm_info *dimm;
 	int i, j, ndimms;
 
-	for (i = 0; i < I10NM_NUM_CHANNELS; i++) {
+	for (i = 0; i < imc->num_channels; i++) {
 		if (!imc->mbase)
 			continue;
 
 		ndimms = 0;
 		amap = I10NM_GET_AMAP(imc, i);
-		for (j = 0; j < I10NM_NUM_DIMMS; j++) {
+		for (j = 0; j < imc->num_dimms; j++) {
 			dimm = edac_get_dimm(mci, i, j, 0);
 			mtr = I10NM_GET_DIMMMTR(imc, i, j);
 			mcddrtcfg = I10NM_GET_MCDDRTCFG(imc, i, j);
@@ -335,8 +434,9 @@ static int __init i10nm_init(void)
 
 	skx_set_mem_cfg(i10nm_check_2lm(cfg));
 
-	rc = i10nm_get_all_munits();
-	if (rc < 0)
+	rc = i10nm_get_ddr_munits();
+
+	if (i10nm_get_hbm_munits() && rc)
 		goto fail;
 
 	list_for_each_entry(d, i10nm_edac_list, list) {
@@ -357,7 +457,15 @@ static int __init i10nm_init(void)
 			d->imc[i].lmc = i;
 			d->imc[i].src_id  = src_id;
 			d->imc[i].node_id = node_id;
-			d->imc[i].chan_mmio_sz = cfg->ddr_chan_mmio_sz;
+			if (d->imc[i].hbm_mc) {
+				d->imc[i].chan_mmio_sz = cfg->hbm_chan_mmio_sz;
+				d->imc[i].num_channels = I10NM_NUM_HBM_CHANNELS;
+				d->imc[i].num_dimms    = I10NM_NUM_HBM_DIMMS;
+			} else {
+				d->imc[i].chan_mmio_sz = cfg->ddr_chan_mmio_sz;
+				d->imc[i].num_channels = I10NM_NUM_DDR_CHANNELS;
+				d->imc[i].num_dimms    = I10NM_NUM_DDR_DIMMS;
+			}
 
 			rc = skx_register_mci(&d->imc[i], d->imc[i].mdev,
 					      "Intel_10nm Socket", EDAC_MOD_STR,
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index c8691abb720d..5e83f59bef8a 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -343,9 +343,9 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 
 	ranks = numrank(mtr);
 	rows = numrow(mtr);
-	cols = numcol(mtr);
+	cols = imc->hbm_mc ? 6 : numcol(mtr);
 
-	if (cfg->support_ddr5 && (amap & 0x8)) {
+	if (cfg->support_ddr5 && ((amap & 0x8) || imc->hbm_mc)) {
 		banks = 32;
 		mtype = MEM_DDR5;
 	} else {
@@ -374,8 +374,13 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 	dimm->dtype = get_width(mtr);
 	dimm->mtype = mtype;
 	dimm->edac_mode = EDAC_SECDED; /* likely better than this */
-	snprintf(dimm->label, sizeof(dimm->label), "CPU_SrcID#%u_MC#%u_Chan#%u_DIMM#%u",
-		 imc->src_id, imc->lmc, chan, dimmno);
+
+	if (imc->hbm_mc)
+		snprintf(dimm->label, sizeof(dimm->label), "CPU_SrcID#%u_HBMC#%u_Chan#%u",
+			 imc->src_id, imc->lmc, chan);
+	else
+		snprintf(dimm->label, sizeof(dimm->label), "CPU_SrcID#%u_MC#%u_Chan#%u_DIMM#%u",
+			 imc->src_id, imc->lmc, chan, dimmno);
 
 	return 1;
 }
@@ -703,6 +708,8 @@ void skx_remove(void)
 		}
 		if (d->util_all)
 			pci_dev_put(d->util_all);
+		if (d->pcu_cr3)
+			pci_dev_put(d->pcu_cr3);
 		if (d->sad_all)
 			pci_dev_put(d->sad_all);
 		if (d->uracu)
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 34e89f7ddf93..01f67e731766 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -32,9 +32,17 @@
 #define SKX_NUM_CHANNELS	3	/* Channels per memory controller */
 #define SKX_NUM_DIMMS		2	/* Max DIMMS per channel */
 
-#define I10NM_NUM_IMC		4
-#define I10NM_NUM_CHANNELS	2
-#define I10NM_NUM_DIMMS		2
+#define I10NM_NUM_DDR_IMC	4
+#define I10NM_NUM_DDR_CHANNELS	2
+#define I10NM_NUM_DDR_DIMMS	2
+
+#define I10NM_NUM_HBM_IMC	16
+#define I10NM_NUM_HBM_CHANNELS	2
+#define I10NM_NUM_HBM_DIMMS	1
+
+#define I10NM_NUM_IMC		(I10NM_NUM_DDR_IMC + I10NM_NUM_HBM_IMC)
+#define I10NM_NUM_CHANNELS	MAX(I10NM_NUM_DDR_CHANNELS, I10NM_NUM_HBM_CHANNELS)
+#define I10NM_NUM_DIMMS		MAX(I10NM_NUM_DDR_DIMMS, I10NM_NUM_HBM_DIMMS)
 
 #define MAX(a, b)	((a) > (b) ? (a) : (b))
 #define NUM_IMC		MAX(SKX_NUM_IMC, I10NM_NUM_IMC)
@@ -56,12 +64,16 @@ struct skx_dev {
 	struct pci_dev *sad_all;
 	struct pci_dev *util_all;
 	struct pci_dev *uracu; /* for i10nm CPU */
+	struct pci_dev *pcu_cr3; /* for HBM memory detection */
 	u32 mcroute;
 	struct skx_imc {
 		struct mem_ctl_info *mci;
 		struct pci_dev *mdev; /* for i10nm CPU */
 		void __iomem *mbase;  /* for i10nm CPU */
 		int chan_mmio_sz;     /* for i10nm CPU */
+		int num_channels; /* channels per memory controller */
+		int num_dimms; /* dimms per channel */
+		bool hbm_mc;
 		u8 mc;	/* system wide mc# */
 		u8 lmc;	/* socket relative mc# */
 		u8 src_id, node_id;
@@ -132,6 +144,8 @@ struct res_config {
 	int busno_cfg_offset;
 	/* Per DDR channel memory-mapped I/O size */
 	int ddr_chan_mmio_sz;
+	/* Per HBM channel memory-mapped I/O size */
+	int hbm_chan_mmio_sz;
 	bool support_ddr5;
 	/* SAD device number and function number */
 	unsigned int sad_all_devfn;
-- 
2.29.2

