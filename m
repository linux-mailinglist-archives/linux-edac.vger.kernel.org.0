Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DF64CE1EE
	for <lists+linux-edac@lfdr.de>; Sat,  5 Mar 2022 02:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiCEBjf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Mar 2022 20:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiCEBjf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 4 Mar 2022 20:39:35 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8622554695;
        Fri,  4 Mar 2022 17:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646444325; x=1677980325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T1BLLpcj77s9dl2kYpzLwwHh62xO9d6FgWuFJjNZukw=;
  b=Z+YMJ0zn+VcEamc/u78Y7VBYBlryljjNxwMOjbqvSXP6zkcUEfH929CB
   Nq/NHfXdHAY1f0VgT/JJXddVLidS/Hgvn71NEJWkwRFJHcvoszxoXmkJZ
   htnf/C7MEuah4caxLb9cQM/b4QdXDqhPQfkuweik4lJawE9v9MSYpPeDb
   qz67qzxNzWD1tdD/XAFoJiGYz8wRTes4JvsL2pDnF7U7aIu4xZxnBhjot
   la/+BNbqBGEtaTW+73/qdbbeDueBbnHWUKZOOt75Rj+o5dGFy2CwHHItx
   rZTCNG5NxAoPqd+NTiwuBpxznpA6ynHPGGbX83mRd9fbMNGEEd8R4jeon
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="254035892"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="254035892"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 17:38:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="779805083"
Received: from pglc00012.png.intel.com ([10.221.207.32])
  by fmsmga006.fm.intel.com with ESMTP; 04 Mar 2022 17:38:42 -0800
From:   niravkumar.l.rabara@intel.com
To:     dinh.nguyen@kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org,
        niravkumar.l.rabara@intel.com, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC: altera: Add SDRAM ECC check for U-Boot
Date:   Sat,  5 Mar 2022 09:38:39 +0800
Message-Id: <20220305013839.30740-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Rabara Niravkumar L <niravkumar.l.rabara@intel.com>

A bug in legacy U-Boot causes a crash during SDRAM boot if ECC
is not enabled in the bitstream but enabled in the Linux config.

Memory mapped read of the ECC Enabled bit was only enabled
if U-Boot determined ECC was enabled in the bitstream.

The Linux driver checks the ECC enable bit using a memory map
read. In the ECC disabled bitstream case, U-Boot didn't
enable ECC register memory map reads and since they are not
allowed this results in a crash.

This patch always reads the ECC Enable register through a
SMC call which is always allowed and it works with legacy
and current U-Boot.

Signed-off-by: Rabara Niravkumar L <niravkumar.l.rabara@intel.com>
---
 drivers/edac/altera_edac.c | 40 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 5dd29789f97d..e7e8e624a436 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1083,8 +1083,46 @@ static int __init __maybe_unused altr_init_a10_ecc_device_type(char *compat)
 
 #ifdef CONFIG_EDAC_ALTERA_SDRAM
 
+/*
+ * A legacy U-Boot bug only enabled memory mapped access to the ECC Enable
+ * register if ECC is enabled. Linux checks the ECC Enable register to
+ * determine ECC status.
+ * Use an SMC call (which always works) to determine ECC enablement.
+ */
+static int altr_s10_sdram_check_ecc_deps(struct altr_edac_device_dev *device)
+{
+	const struct edac_device_prv_data *prv = device->data;
+	unsigned long sdram_ecc_addr;
+	struct arm_smccc_res result;
+	struct device_node *np;
+	phys_addr_t sdram_addr;
+	u32 read_reg;
+	int ret;
+
+	np = of_find_compatible_node(NULL, NULL, "altr,sdr-ctl");
+	if (!np)
+		goto sdram_err;
+
+	sdram_addr = of_translate_address(np, of_get_address(np, 0,
+							     NULL, NULL));
+	of_node_put(np);
+	sdram_ecc_addr = (unsigned long)sdram_addr + prv->ecc_en_ofst;
+	arm_smccc_smc(INTEL_SIP_SMC_REG_READ, sdram_ecc_addr,
+		      0, 0, 0, 0, 0, 0, &result);
+	read_reg = (unsigned int)result.a1;
+	ret = (int)result.a0;
+	if (!ret && (read_reg & prv->ecc_enable_mask))
+		return 0;
+
+sdram_err:
+	edac_printk(KERN_ERR, EDAC_DEVICE,
+		    "%s: No ECC present or ECC disabled.\n",
+		    device->edac_dev_name);
+	return -ENODEV;
+}
+
 static const struct edac_device_prv_data s10_sdramecc_data = {
-	.setup = altr_check_ecc_deps,
+	.setup = altr_s10_sdram_check_ecc_deps,
 	.ce_clear_mask = ALTR_S10_ECC_SERRPENA,
 	.ue_clear_mask = ALTR_S10_ECC_DERRPENA,
 	.ecc_enable_mask = ALTR_S10_ECC_EN,
-- 
2.19.0

