Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420C374C99F
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jul 2023 03:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjGJBh5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 9 Jul 2023 21:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjGJBh4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 9 Jul 2023 21:37:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB49F1;
        Sun,  9 Jul 2023 18:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688953062; x=1720489062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=7wSBK4N8j7ayhRfNDW/D4i6cAQi0AIQIDpCI8hZX3s8=;
  b=MrajgvgOYfwcHJxTp0UZA6QhnF3akYNB6/mfAOJUHyLQaAvEG/MU9Eq3
   cEHdz0X/hICbLZfWk+UEe0f9zqvfoE0RyRfx9ID/2PATcDY9xlr7Zz+Gp
   U5DuiCQq9Q1mtd6ERsPImQBCiMF4Yd+Ur8hTLt2qKX2tyCI5CJr3OGCgr
   gKeZVUq56a5KwTvXIQ0BeJKC/yke14Pd0aCLoP8J1XlzeUoJpqpwCp+Y7
   iZp4mFstWklAhuz2lMfxs7pwop3KybDG7PPGT4dDECOzNaR0udPuo495/
   JeGtmTKpKUw+ip5E1BhX/FJmvt/7Ul14yUj45IcKRuit8o8V3XYF1HeJD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="364273925"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="364273925"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 18:37:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="844723906"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="844723906"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 18:37:39 -0700
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Borislav Petkov <bp@alien8.de>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Koba Ko <koba.ko@canonical.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] EDAC/i10nm: Skip the absent memory controllers
Date:   Mon, 10 Jul 2023 09:32:32 +0800
Message-Id: <20230710013232.59712-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAAd53p6J8usSi+rHnd9+714mUqZ2zTdhFSEWUtiK7aNzcAZ8CA@mail.gmail.com>
References: <CAAd53p6J8usSi+rHnd9+714mUqZ2zTdhFSEWUtiK7aNzcAZ8CA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Some Sapphire Rapids workstations' absent memory controllers
still appear as PCIe devices that fool the i10nm_edac driver
and result in "shift exponent -66 is negative" call traces
from skx_get_dimm_info().

Skip the absent memory controllers to avoid the call traces.

Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Closes: https://lore.kernel.org/linux-edac/CAAd53p41Ku1m1rapeqb1xtD+kKuk+BaUW=dumuoF0ZO3GhFjFA@mail.gmail.com/T/#m5de16dce60a8c836ec235868c7c16e3fefad0cc2
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reported-by: Koba Ko <koba.ko@canonical.com>
Closes: https://lore.kernel.org/linux-edac/SA1PR11MB71305B71CCCC3D9305835202892AA@SA1PR11MB7130.namprd11.prod.outlook.com/T/#t
Tested-by: Koba Ko <koba.ko@canonical.com>
Fixes: d4dc89d069aa ("EDAC, i10nm: Add a driver for Intel 10nm server processors")
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
v1->v2:
 - No function changes.
 - s/exponet/exponent/ in the commit message.
 - Add two tags of "Tested-by".

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

