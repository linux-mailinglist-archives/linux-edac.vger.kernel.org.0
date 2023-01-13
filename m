Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B8F668A24
	for <lists+linux-edac@lfdr.de>; Fri, 13 Jan 2023 04:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjAMDaa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 12 Jan 2023 22:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjAMD2e (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 12 Jan 2023 22:28:34 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6925F12A8F;
        Thu, 12 Jan 2023 19:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673580512; x=1705116512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=SfG3ozcyJz5sswjTxHO4twfKJj2mwK5n2nHU0LuJZsQ=;
  b=h4+f7S6voCJdyH1klDfox1IgvPkpT/WE03ASjOCzeof8YnB1HKOE9Npr
   2x5GpTu1P6xJJbpnCYe3duNeiIzx3+WBzre8c2yp0ZThzjiD5NY3PWEfq
   3GC1hkIvrtndtJXsiiJa4bRTLV2y8R+uMwvr3n//R7Zqs9JFjesguSuob
   dd5A/4iJTz2NQcJTachaBFV8ccfwxx0uxoudPuiT/FYcBcwjLqIIVTOyo
   Atn4VO0sJ2GCfSdGGBT+3JJi1mRYVfZEqwI9TdrXGaobwPHo/ivv0WTqc
   90B7Sl+MbeX6ExuF5JDRq2RYlWsTujFYAyaeCbW8lfmPNIwe0NgJsGYN3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="410138865"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="410138865"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 19:28:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="651386241"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="651386241"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.105])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 19:28:28 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Youquan Song <youquan.song@intel.com>,
        Li Zhang <li4.zhang@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] EDAC/i10nm: Make more configurations CPU model specific
Date:   Fri, 13 Jan 2023 11:28:01 +0800
Message-Id: <20230113032802.41752-5-qiuxu.zhuo@intel.com>
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

The numbers of memory controllers per socket, channels per memory
controller, DIMMs per channel and the triples of bus/device/function
of PCI devices used in i10nm_edac can be CPU model specific.
Add new fields to the structure res_config for above numbers and
triples to make them CPU model specific.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 131 ++++++++++++++++++++++++++------------
 drivers/edac/skx_common.h |  32 +++++++++-
 2 files changed, 121 insertions(+), 42 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index e11726f7fe36..5682d64cceb6 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -148,35 +148,47 @@ static void __enable_retry_rd_err_log(struct skx_imc *imc, int chan, bool enable
 
 static void enable_retry_rd_err_log(bool enable)
 {
+	int i, j, imc_num, chan_num;
 	struct skx_imc *imc;
 	struct skx_dev *d;
-	int i, j;
 
 	edac_dbg(2, "\n");
 
-	list_for_each_entry(d, i10nm_edac_list, list)
-		for (i = 0; i < I10NM_NUM_IMC; i++) {
+	list_for_each_entry(d, i10nm_edac_list, list) {
+		imc_num  = res_cfg->ddr_imc_num;
+		chan_num = res_cfg->ddr_chan_num;
+
+		for (i = 0; i < imc_num; i++) {
 			imc = &d->imc[i];
 			if (!imc->mbase)
 				continue;
 
-			for (j = 0; j < I10NM_NUM_CHANNELS; j++) {
-				if (imc->hbm_mc) {
-					__enable_retry_rd_err_log(imc, j, enable,
-								  res_cfg->offsets_scrub_hbm0,
-								  res_cfg->offsets_demand_hbm0,
-								  NULL);
-					__enable_retry_rd_err_log(imc, j, enable,
-								  res_cfg->offsets_scrub_hbm1,
-								  res_cfg->offsets_demand_hbm1,
-								  NULL);
-				} else {
-					__enable_retry_rd_err_log(imc, j, enable,
-								  res_cfg->offsets_scrub,
-								  res_cfg->offsets_demand,
-								  res_cfg->offsets_demand2);
-				}
+			for (j = 0; j < chan_num; j++)
+				__enable_retry_rd_err_log(imc, j, enable,
+							  res_cfg->offsets_scrub,
+							  res_cfg->offsets_demand,
+							  res_cfg->offsets_demand2);
+		}
+
+		imc_num += res_cfg->hbm_imc_num;
+		chan_num = res_cfg->hbm_chan_num;
+
+		for (; i < imc_num; i++) {
+			imc = &d->imc[i];
+			if (!imc->mbase || !imc->hbm_mc)
+				continue;
+
+			for (j = 0; j < chan_num; j++) {
+				__enable_retry_rd_err_log(imc, j, enable,
+							  res_cfg->offsets_scrub_hbm0,
+							  res_cfg->offsets_demand_hbm0,
+							  NULL);
+				__enable_retry_rd_err_log(imc, j, enable,
+							  res_cfg->offsets_scrub_hbm1,
+							  res_cfg->offsets_demand_hbm1,
+							  NULL);
 			}
+		}
 	}
 }
 
@@ -318,9 +330,9 @@ static bool i10nm_check_2lm(struct res_config *cfg)
 	int i;
 
 	list_for_each_entry(d, i10nm_edac_list, list) {
-		d->sad_all = pci_get_dev_wrapper(d->seg, d->bus[1],
-						 PCI_SLOT(cfg->sad_all_devfn),
-						 PCI_FUNC(cfg->sad_all_devfn));
+		d->sad_all = pci_get_dev_wrapper(d->seg, d->bus[res_cfg->sad_all_bdf.bus],
+						 res_cfg->sad_all_bdf.dev,
+						 res_cfg->sad_all_bdf.fun);
 		if (!d->sad_all)
 			continue;
 
@@ -444,11 +456,15 @@ static int i10nm_get_ddr_munits(void)
 	u64 base;
 
 	list_for_each_entry(d, i10nm_edac_list, list) {
-		d->util_all = pci_get_dev_wrapper(d->seg, d->bus[1], 29, 1);
+		d->util_all = pci_get_dev_wrapper(d->seg, d->bus[res_cfg->util_all_bdf.bus],
+						  res_cfg->util_all_bdf.dev,
+						  res_cfg->util_all_bdf.fun);
 		if (!d->util_all)
 			return -ENODEV;
 
-		d->uracu = pci_get_dev_wrapper(d->seg, d->bus[0], 0, 1);
+		d->uracu = pci_get_dev_wrapper(d->seg, d->bus[res_cfg->uracu_bdf.bus],
+					       res_cfg->uracu_bdf.dev,
+					       res_cfg->uracu_bdf.fun);
 		if (!d->uracu)
 			return -ENODEV;
 
@@ -461,9 +477,10 @@ static int i10nm_get_ddr_munits(void)
 		edac_dbg(2, "socket%d mmio base 0x%llx (reg 0x%x)\n",
 			 j++, base, reg);
 
-		for (i = 0; i < I10NM_NUM_DDR_IMC; i++) {
-			mdev = pci_get_dev_wrapper(d->seg, d->bus[0],
-						   12 + i, 0);
+		for (i = 0; i < res_cfg->ddr_imc_num; i++) {
+			mdev = pci_get_dev_wrapper(d->seg, d->bus[res_cfg->ddr_mdev_bdf.bus],
+						   res_cfg->ddr_mdev_bdf.dev + i,
+						   res_cfg->ddr_mdev_bdf.fun);
 			if (i == 0 && !mdev) {
 				i10nm_printk(KERN_ERR, "No IMC found\n");
 				return -ENODEV;
@@ -519,7 +536,9 @@ static int i10nm_get_hbm_munits(void)
 	u64 base;
 
 	list_for_each_entry(d, i10nm_edac_list, list) {
-		d->pcu_cr3 = pci_get_dev_wrapper(d->seg, d->bus[1], 30, 3);
+		d->pcu_cr3 = pci_get_dev_wrapper(d->seg, d->bus[res_cfg->pcu_cr3_bdf.bus],
+						 res_cfg->pcu_cr3_bdf.dev,
+						 res_cfg->pcu_cr3_bdf.fun);
 		if (!d->pcu_cr3)
 			return -ENODEV;
 
@@ -540,11 +559,13 @@ static int i10nm_get_hbm_munits(void)
 		}
 		base += I10NM_GET_HBM_IMC_MMIO_OFFSET(reg);
 
-		lmc = I10NM_NUM_DDR_IMC;
+		lmc = res_cfg->ddr_imc_num;
+
+		for (i = 0; i < res_cfg->hbm_imc_num; i++) {
+			mdev = pci_get_dev_wrapper(d->seg, d->bus[res_cfg->hbm_mdev_bdf.bus],
+						   res_cfg->hbm_mdev_bdf.dev + i / 4,
+						   res_cfg->hbm_mdev_bdf.fun + i % 4);
 
-		for (i = 0; i < I10NM_NUM_HBM_IMC; i++) {
-			mdev = pci_get_dev_wrapper(d->seg, d->bus[0],
-						   12 + i / 4, 1 + i % 4);
 			if (i == 0 && !mdev) {
 				i10nm_printk(KERN_ERR, "No hbm mc found\n");
 				return -ENODEV;
@@ -594,8 +615,16 @@ static struct res_config i10nm_cfg0 = {
 	.type			= I10NM,
 	.decs_did		= 0x3452,
 	.busno_cfg_offset	= 0xcc,
+	.ddr_imc_num		= 4,
+	.ddr_chan_num		= 2,
+	.ddr_dimm_num		= 2,
 	.ddr_chan_mmio_sz	= 0x4000,
-	.sad_all_devfn		= PCI_DEVFN(29, 0),
+	.sad_all_bdf		= {1, 29, 0},
+	.pcu_cr3_bdf		= {1, 30, 3},
+	.util_all_bdf		= {1, 29, 1},
+	.uracu_bdf		= {0, 0, 1},
+	.ddr_mdev_bdf		= {0, 12, 0},
+	.hbm_mdev_bdf		= {0, 12, 1},
 	.sad_all_offset		= 0x108,
 	.offsets_scrub		= offsets_scrub_icx,
 	.offsets_demand		= offsets_demand_icx,
@@ -605,8 +634,16 @@ static struct res_config i10nm_cfg1 = {
 	.type			= I10NM,
 	.decs_did		= 0x3452,
 	.busno_cfg_offset	= 0xd0,
+	.ddr_imc_num		= 4,
+	.ddr_chan_num		= 2,
+	.ddr_dimm_num		= 2,
 	.ddr_chan_mmio_sz	= 0x4000,
-	.sad_all_devfn		= PCI_DEVFN(29, 0),
+	.sad_all_bdf		= {1, 29, 0},
+	.pcu_cr3_bdf		= {1, 30, 3},
+	.util_all_bdf		= {1, 29, 1},
+	.uracu_bdf		= {0, 0, 1},
+	.ddr_mdev_bdf		= {0, 12, 0},
+	.hbm_mdev_bdf		= {0, 12, 1},
 	.sad_all_offset		= 0x108,
 	.offsets_scrub		= offsets_scrub_icx,
 	.offsets_demand		= offsets_demand_icx,
@@ -616,10 +653,21 @@ static struct res_config spr_cfg = {
 	.type			= SPR,
 	.decs_did		= 0x3252,
 	.busno_cfg_offset	= 0xd0,
+	.ddr_imc_num		= 4,
+	.ddr_chan_num		= 2,
+	.ddr_dimm_num		= 2,
+	.hbm_imc_num		= 16,
+	.hbm_chan_num		= 2,
+	.hbm_dimm_num		= 1,
 	.ddr_chan_mmio_sz	= 0x8000,
 	.hbm_chan_mmio_sz	= 0x4000,
 	.support_ddr5		= true,
-	.sad_all_devfn		= PCI_DEVFN(10, 0),
+	.sad_all_bdf		= {1, 10, 0},
+	.pcu_cr3_bdf		= {1, 30, 3},
+	.util_all_bdf		= {1, 29, 1},
+	.uracu_bdf		= {0, 0, 1},
+	.ddr_mdev_bdf		= {0, 12, 0},
+	.hbm_mdev_bdf		= {0, 12, 1},
 	.sad_all_offset		= 0x300,
 	.offsets_scrub		= offsets_scrub_spr,
 	.offsets_scrub_hbm0	= offsets_scrub_spr_hbm0,
@@ -753,6 +801,7 @@ static int __init i10nm_init(void)
 	struct skx_dev *d;
 	int rc, i, off[3] = {0xd0, 0xc8, 0xcc};
 	u64 tolm, tohm;
+	int imc_num;
 
 	edac_dbg(2, "\n");
 
@@ -793,6 +842,8 @@ static int __init i10nm_init(void)
 	if (i10nm_get_hbm_munits() && rc)
 		goto fail;
 
+	imc_num = res_cfg->ddr_imc_num + res_cfg->hbm_imc_num;
+
 	list_for_each_entry(d, i10nm_edac_list, list) {
 		rc = skx_get_src_id(d, 0xf8, &src_id);
 		if (rc < 0)
@@ -803,7 +854,7 @@ static int __init i10nm_init(void)
 			goto fail;
 
 		edac_dbg(2, "src_id = %d node_id = %d\n", src_id, node_id);
-		for (i = 0; i < I10NM_NUM_IMC; i++) {
+		for (i = 0; i < imc_num; i++) {
 			if (!d->imc[i].mdev)
 				continue;
 
@@ -813,12 +864,12 @@ static int __init i10nm_init(void)
 			d->imc[i].node_id = node_id;
 			if (d->imc[i].hbm_mc) {
 				d->imc[i].chan_mmio_sz = cfg->hbm_chan_mmio_sz;
-				d->imc[i].num_channels = I10NM_NUM_HBM_CHANNELS;
-				d->imc[i].num_dimms    = I10NM_NUM_HBM_DIMMS;
+				d->imc[i].num_channels = cfg->hbm_chan_num;
+				d->imc[i].num_dimms    = cfg->hbm_dimm_num;
 			} else {
 				d->imc[i].chan_mmio_sz = cfg->ddr_chan_mmio_sz;
-				d->imc[i].num_channels = I10NM_NUM_DDR_CHANNELS;
-				d->imc[i].num_dimms    = I10NM_NUM_DDR_DIMMS;
+				d->imc[i].num_channels = cfg->ddr_chan_num;
+				d->imc[i].num_dimms    = cfg->ddr_dimm_num;
 			}
 
 			rc = skx_register_mci(&d->imc[i], d->imc[i].mdev,
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 312032657264..982e1bcb1edf 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -173,19 +173,47 @@ struct decoded_addr {
 	bool	decoded_by_adxl;
 };
 
+struct pci_bdf {
+	u32 bus : 8;
+	u32 dev : 5;
+	u32 fun : 3;
+};
+
 struct res_config {
 	enum type type;
 	/* Configuration agent device ID */
 	unsigned int decs_did;
 	/* Default bus number configuration register offset */
 	int busno_cfg_offset;
+	/* DDR memory controllers per socket */
+	int ddr_imc_num;
+	/* DDR channels per DDR memory controller */
+	int ddr_chan_num;
+	/* DDR DIMMs per DDR memory channel */
+	int ddr_dimm_num;
 	/* Per DDR channel memory-mapped I/O size */
 	int ddr_chan_mmio_sz;
+	/* HBM memory controllers per socket */
+	int hbm_imc_num;
+	/* HBM channels per HBM memory controller */
+	int hbm_chan_num;
+	/* HBM DIMMs per HBM memory channel */
+	int hbm_dimm_num;
 	/* Per HBM channel memory-mapped I/O size */
 	int hbm_chan_mmio_sz;
 	bool support_ddr5;
-	/* SAD device number and function number */
-	unsigned int sad_all_devfn;
+	/* SAD device BDF */
+	struct pci_bdf sad_all_bdf;
+	/* PCU device BDF */
+	struct pci_bdf pcu_cr3_bdf;
+	/* UTIL device BDF */
+	struct pci_bdf util_all_bdf;
+	/* URACU device BDF */
+	struct pci_bdf uracu_bdf;
+	/* DDR mdev device BDF */
+	struct pci_bdf ddr_mdev_bdf;
+	/* HBM mdev device BDF */
+	struct pci_bdf hbm_mdev_bdf;
 	int sad_all_offset;
 	/* Offsets of retry_rd_err_log registers */
 	u32 *offsets_scrub;
-- 
2.17.1

