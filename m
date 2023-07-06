Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F01F749E17
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jul 2023 15:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjGFNqy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jul 2023 09:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGFNqx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jul 2023 09:46:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344D31995;
        Thu,  6 Jul 2023 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688651212; x=1720187212;
  h=from:to:cc:subject:date:message-id;
  bh=6EkHj8Bw4Z3C5EBn0opLRl9Jl1oeMCrRcvJqQmW0exk=;
  b=btCJIlDjuW5j+ACuy8qcs301rJvkK1jWHuWiLX3ESKfw+YcEVqkQbIhk
   Az3xXMA6wh7T5DkS3XcbwgT+FGFLi6J2263eNp7OJlWEEU3178uD2jVl+
   Rc8jYd2mJjuSw6NiQRLymopeE7AHQZ9ve5M5s3wAfm9DgIS2wbzhwOHq3
   AEs901QzGC8Uj7BHJbXNqHA2OpVgj9kGF9CZk+FNUcEh1Ht0X3G4jOYMV
   XYKOqFhrsjv1hNPrdqa0gamqWSgtfgbO8OXEFoOmx9vT8ES/0KQf47BTj
   MJAzbIFoaBaaonmFZT8EYLzAhN7JJD15WwvB1j/HM+X1c1BHWihSJt80O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="362474720"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="362474720"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 06:46:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="832950424"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="832950424"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 06:46:48 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Koba Ko <koba.ko@canonical.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] EDAC/i10nm: Skip the absent memory controllers
Date:   Thu,  6 Jul 2023 21:42:16 +0800
Message-Id: <20230706134216.37044-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Some Sapphire Rapids workstations' absent memory controllers
still appear as PCIe devices that fool the i10nm_edac driver
and result in "shift exponet -66 is negative" call traces
from skx_get_dimm_info().

Skip the absent memory controllers to avoid the call traces.

Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Closes: https://lore.kernel.org/linux-edac/CAAd53p41Ku1m1rapeqb1xtD+kKuk+BaUW=dumuoF0ZO3GhFjFA@mail.gmail.com/T/#m5de16dce60a8c836ec235868c7c16e3fefad0cc2
Reported-by: Koba Ko <koba.ko@canonical.com>
Closes: https://lore.kernel.org/linux-edac/SA1PR11MB71305B71CCCC3D9305835202892AA@SA1PR11MB7130.namprd11.prod.outlook.com/T/#t
Fixes: d4dc89d069aa ("EDAC, i10nm: Add a driver for Intel 10nm server processors")
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/i10nm_base.c | 54 +++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index a897b6aff368..349ff6cfb379 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -658,13 +658,49 @@ static struct pci_dev *get_ddr_munit(struct skx_dev *d, int i, u32 *offset, unsi
 	return mdev;
 }
 
+/**
+ * i10nm_imc_absent() - Check whether the memory controller @imc is absent
+ *
+ * @imc    : The pointer to the structure of memory controller EDAC device.
+ *
+ * RETURNS : true if the memory controller EDAC device is absent, false otherwise.
+ */
+static bool i10nm_imc_absent(struct skx_imc *imc)
+{
+	u32 mcmtr;
+	int i;
+
+	switch (res_cfg->type) {
+	case SPR:
+		for (i = 0; i < res_cfg->ddr_chan_num; i++) {
+			mcmtr = I10NM_GET_MCMTR(imc, i);
+			edac_dbg(1, "ch%d mcmtr reg %x\n", i, mcmtr);
+			if (mcmtr != ~0)
+				return false;
+		}
+
+		/*
+		 * Some workstations' absent memory controllers still
+		 * appear as PCIe devices, misleading the EDAC driver.
+		 * By observing that the MMIO registers of these absent
+		 * memory controllers consistently hold the value of ~0.
+		 *
+		 * We identify a memory controller as absent by checking
+		 * if its MMIO register "mcmtr" == ~0 in all its channels.
+		 */
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int i10nm_get_ddr_munits(void)
 {
 	struct pci_dev *mdev;
 	void __iomem *mbase;
 	unsigned long size;
 	struct skx_dev *d;
-	int i, j = 0;
+	int i, lmc, j = 0;
 	u32 reg, off;
 	u64 base;
 
@@ -690,7 +726,7 @@ static int i10nm_get_ddr_munits(void)
 		edac_dbg(2, "socket%d mmio base 0x%llx (reg 0x%x)\n",
 			 j++, base, reg);
 
-		for (i = 0; i < res_cfg->ddr_imc_num; i++) {
+		for (lmc = 0, i = 0; i < res_cfg->ddr_imc_num; i++) {
 			mdev = get_ddr_munit(d, i, &off, &size);
 
 			if (i == 0 && !mdev) {
@@ -700,8 +736,6 @@ static int i10nm_get_ddr_munits(void)
 			if (!mdev)
 				continue;
 
-			d->imc[i].mdev = mdev;
-
 			edac_dbg(2, "mc%d mmio base 0x%llx size 0x%lx (reg 0x%x)\n",
 				 i, base + off, size, reg);
 
@@ -712,7 +746,17 @@ static int i10nm_get_ddr_munits(void)
 				return -ENODEV;
 			}
 
-			d->imc[i].mbase = mbase;
+			d->imc[lmc].mbase = mbase;
+			if (i10nm_imc_absent(&d->imc[lmc])) {
+				pci_dev_put(mdev);
+				iounmap(mbase);
+				d->imc[lmc].mbase = NULL;
+				edac_dbg(2, "Skip absent mc%d\n", i);
+				continue;
+			} else {
+				d->imc[lmc].mdev = mdev;
+				lmc++;
+			}
 		}
 	}
 
-- 
2.17.1

