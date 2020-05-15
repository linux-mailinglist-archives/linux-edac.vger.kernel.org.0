Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8831D5B1F
	for <lists+linux-edac@lfdr.de>; Fri, 15 May 2020 23:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgEOVBr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 May 2020 17:01:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:29406 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgEOVBr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 15 May 2020 17:01:47 -0400
IronPort-SDR: Wc1M0Y2fnBXZKQf3AUoB+SrqPQdaIwbjIYnE3Oo1VLLljULRDWRuxCKhLkjfZtvYEGUOd8yymD
 9uTcvZZt6vJA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 14:01:47 -0700
IronPort-SDR: TgnBGLuMbj5kA+XyCXjh0BKISuxrZiAVSMLLPw0GxJr+tWEpzyzjylfjT4705qu9mESH3R0I6/
 YPhjQVBJCuiw==
X-IronPort-AV: E=Sophos;i="5.73,396,1583222400"; 
   d="scan'208";a="410588355"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 14:01:46 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Matthew Riley <mattdr@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [PATCH v1 1/1] EDAC/skx: Use the mcmtr register to retrieve close_pg/bank_xor_enable
Date:   Fri, 15 May 2020 14:01:46 -0700
Message-Id: <20200515210146.1337-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

The skx_edac driver wrongly uses the mtr register to retrieve two fields
close_pg and bank_xor_enable. Fix it by using the correct mcmtr register
to get the two fields.

Cc: <stable@vger.kernel.org>
Reported-by: Matthew Riley <mattdr@google.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>

---
 drivers/edac/i10nm_base.c |  2 +-
 drivers/edac/skx_base.c   | 20 ++++++++------------
 drivers/edac/skx_common.c |  6 +++---
 drivers/edac/skx_common.h |  2 +-
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index ea8f2127e238..c8d11da85bec 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -175,7 +175,7 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci)
 				 mtr, mcddrtcfg, imc->mc, i, j);
 
 			if (IS_DIMM_PRESENT(mtr))
-				ndimms += skx_get_dimm_info(mtr, 0, dimm,
+				ndimms += skx_get_dimm_info(mtr, 0, 0, dimm,
 							    imc, i, j);
 			else if (IS_NVDIMM_PRESENT(mcddrtcfg, j))
 				ndimms += skx_get_nvdimm_info(dimm, imc, i, j,
diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 1ff22136cf72..2c7db95df326 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -169,27 +169,23 @@ static const struct x86_cpu_id skx_cpuids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, skx_cpuids);
 
-#define SKX_GET_MTMTR(dev, reg) \
-	pci_read_config_dword((dev), 0x87c, &(reg))
-
-static bool skx_check_ecc(struct pci_dev *pdev)
+static bool skx_check_ecc(u32 mcmtr)
 {
-	u32 mtmtr;
-
-	SKX_GET_MTMTR(pdev, mtmtr);
-
-	return !!GET_BITFIELD(mtmtr, 2, 2);
+	return !!GET_BITFIELD(mcmtr, 2, 2);
 }
 
 static int skx_get_dimm_config(struct mem_ctl_info *mci)
 {
 	struct skx_pvt *pvt = mci->pvt_info;
+	u32 mtr, mcmtr, amap, mcddrtcfg;
 	struct skx_imc *imc = pvt->imc;
-	u32 mtr, amap, mcddrtcfg;
 	struct dimm_info *dimm;
 	int i, j;
 	int ndimms;
 
+	/* Only the mcmtr on the first channel is effective */
+	pci_read_config_dword(imc->chan[0].cdev, 0x87c, &mcmtr);
+
 	for (i = 0; i < SKX_NUM_CHANNELS; i++) {
 		ndimms = 0;
 		pci_read_config_dword(imc->chan[i].cdev, 0x8C, &amap);
@@ -199,14 +195,14 @@ static int skx_get_dimm_config(struct mem_ctl_info *mci)
 			pci_read_config_dword(imc->chan[i].cdev,
 					      0x80 + 4 * j, &mtr);
 			if (IS_DIMM_PRESENT(mtr)) {
-				ndimms += skx_get_dimm_info(mtr, amap, dimm, imc, i, j);
+				ndimms += skx_get_dimm_info(mtr, mcmtr, amap, dimm, imc, i, j);
 			} else if (IS_NVDIMM_PRESENT(mcddrtcfg, j)) {
 				ndimms += skx_get_nvdimm_info(dimm, imc, i, j,
 							      EDAC_MOD_STR);
 				nvdimm_count++;
 			}
 		}
-		if (ndimms && !skx_check_ecc(imc->chan[0].cdev)) {
+		if (ndimms && !skx_check_ecc(mcmtr)) {
 			skx_printk(KERN_ERR, "ECC is disabled on imc %d\n", imc->mc);
 			return -ENODEV;
 		}
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index abc9ddd2b7d1..46be1a77bd1d 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -303,7 +303,7 @@ static int skx_get_dimm_attr(u32 reg, int lobit, int hibit, int add,
 #define numrow(reg)	skx_get_dimm_attr(reg, 2, 4, 12, 1, 6, "rows")
 #define numcol(reg)	skx_get_dimm_attr(reg, 0, 1, 10, 0, 2, "cols")
 
-int skx_get_dimm_info(u32 mtr, u32 amap, struct dimm_info *dimm,
+int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 		      struct skx_imc *imc, int chan, int dimmno)
 {
 	int  banks = 16, ranks, rows, cols, npages;
@@ -323,8 +323,8 @@ int skx_get_dimm_info(u32 mtr, u32 amap, struct dimm_info *dimm,
 		 imc->mc, chan, dimmno, size, npages,
 		 banks, 1 << ranks, rows, cols);
 
-	imc->chan[chan].dimms[dimmno].close_pg = GET_BITFIELD(mtr, 0, 0);
-	imc->chan[chan].dimms[dimmno].bank_xor_enable = GET_BITFIELD(mtr, 9, 9);
+	imc->chan[chan].dimms[dimmno].close_pg = GET_BITFIELD(mcmtr, 0, 0);
+	imc->chan[chan].dimms[dimmno].bank_xor_enable = GET_BITFIELD(mcmtr, 9, 9);
 	imc->chan[chan].dimms[dimmno].fine_grain_bank = GET_BITFIELD(amap, 0, 0);
 	imc->chan[chan].dimms[dimmno].rowbits = rows;
 	imc->chan[chan].dimms[dimmno].colbits = cols;
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 19dd8c099520..78f8c1de0b71 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -135,7 +135,7 @@ int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list);
 
 int skx_get_hi_lo(unsigned int did, int off[], u64 *tolm, u64 *tohm);
 
-int skx_get_dimm_info(u32 mtr, u32 amap, struct dimm_info *dimm,
+int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 		      struct skx_imc *imc, int chan, int dimmno);
 
 int skx_get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
-- 
2.17.1

