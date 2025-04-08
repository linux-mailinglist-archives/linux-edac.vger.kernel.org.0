Return-Path: <linux-edac+bounces-3488-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DABFA80C7B
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 15:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37CB886A70
	for <lists+linux-edac@lfdr.de>; Tue,  8 Apr 2025 13:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0A7374D1;
	Tue,  8 Apr 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XB3ggbkq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC5320F;
	Tue,  8 Apr 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118737; cv=none; b=nIdPEpEH8wg/qQTFwn+xSv1KQQ5zfmyWfhY4JuvsowIKPp86BF3PqTw4tJAcH8zij/Mxh5nSWNwBe1Lsx94Wbkfj5D0D/CNRBvKd2+6IWIdx6wgd7/uhJY6qk4epHIZBYaTSl7n/u2frtNmTWcmZAM9zKi6zV+bAdtVKNI5XWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118737; c=relaxed/simple;
	bh=NHSpW9e+meHIZV0X3SUJ0MZoalf/ZJrgkR4A2Jp1pqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML9P0zRzQI8f6dPf7IbX1+PRNyjkpJhFPQe70RLy1BbQKdPxaoCb1hxdpJl2O1oEcetospBkiziVkonQC6ADAGdjW8g07tQm5YzM9g5nsT3WDcvTOJJuyfCgsBl3nPZ56xSCtM5UuCwcONI9fiehkqafy2c2tXqUDAupqbACr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XB3ggbkq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744118736; x=1775654736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NHSpW9e+meHIZV0X3SUJ0MZoalf/ZJrgkR4A2Jp1pqo=;
  b=XB3ggbkq5HAnG0wXQNqx0E3FvJNYXrzwQKeP4ZQq/+ddr5Ss+qcf+j7M
   WwYVXBedIOQTyup38/7ZC9LfmFZqdw+LF9WmusNwb9vEC3Mz5Bho7t5dS
   voejiSdGh+e6muIhmvvjYkR2pTTBByXJvNBxiQsIGCU7sIWIHLLxCyCx8
   ubvhbVLkgNwGoURFZ9uQQQH4SO1AT32Xukg3RdLiYVqF7/npYK5E/WQQF
   OdYeAdDN9WqMVhENExOH5qtyDSSNrswxxCUkZWe0L2KuBq96ZDMqFQV9k
   /0D1v/65TpRe5QzUejmdMtx1gd03COlZwasJFOt77XX5fsAFHi7WEnVBU
   Q==;
X-CSE-ConnectionGUID: smrjaQg8QniwB4dmbNMw0w==
X-CSE-MsgGUID: v+Rmu2V7Re+HE97/3zaEAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44799620"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="44799620"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:25:35 -0700
X-CSE-ConnectionGUID: 6ZFuHMXzTzaLHH/c9Q9jzw==
X-CSE-MsgGUID: 8IEWc3TDQfen9GuS5PwKSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="159258212"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:25:33 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] EDAC/igen6: Skip the absent memory controllers
Date: Tue,  8 Apr 2025 21:24:53 +0800
Message-ID: <20250408132455.489046-2-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250408132455.489046-1-qiuxu.zhuo@intel.com>
References: <20250408132455.489046-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some BIOS versions may fuse off certain memory controllers and set the
registers of these absent memory controllers to ~0. The current igen6_edac
mistakenly enumerates these absent memory controllers and registers them
with the EDAC core.

Skip the absent memory controllers to avoid mistakenly enumerating them.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 78 +++++++++++++++++++++++++++++++--------
 1 file changed, 62 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 5807517ee32d..ec64bff8236f 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -127,6 +127,7 @@
 
 static const struct res_config {
 	bool machine_check;
+	/* The number of present memory controllers. */
 	int num_imc;
 	u32 imc_base;
 	u32 cmf_base;
@@ -1201,23 +1202,21 @@ static void igen6_check(struct mem_ctl_info *mci)
 		irq_work_queue(&ecclog_irq_work);
 }
 
-static int igen6_register_mci(int mc, u64 mchbar, struct pci_dev *pdev)
+/* Check whether the memory controller is absent. */
+static bool igen6_imc_absent(void __iomem *window)
+{
+	return readl(window + MAD_INTER_CHANNEL_OFFSET) == ~0;
+}
+
+static int igen6_register_mci(int mc, void __iomem *window, struct pci_dev *pdev)
 {
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
 	struct igen6_imc *imc;
-	void __iomem *window;
 	int rc;
 
 	edac_dbg(2, "\n");
 
-	mchbar += mc * MCHBAR_SIZE;
-	window = ioremap(mchbar, MCHBAR_SIZE);
-	if (!window) {
-		igen6_printk(KERN_ERR, "Failed to ioremap 0x%llx\n", mchbar);
-		return -ENODEV;
-	}
-
 	layers[0].type = EDAC_MC_LAYER_CHANNEL;
 	layers[0].size = NUM_CHANNELS;
 	layers[0].is_virt_csrow = false;
@@ -1283,7 +1282,6 @@ static int igen6_register_mci(int mc, u64 mchbar, struct pci_dev *pdev)
 fail2:
 	edac_mc_free(mci);
 fail:
-	iounmap(window);
 	return rc;
 }
 
@@ -1309,6 +1307,56 @@ static void igen6_unregister_mcis(void)
 	}
 }
 
+static int igen6_register_mcis(struct pci_dev *pdev, u64 mchbar)
+{
+	void __iomem *window;
+	int lmc, pmc, rc;
+	u64 base;
+
+	for (lmc = 0, pmc = 0; pmc < NUM_IMC; pmc++) {
+		base   = mchbar + pmc * MCHBAR_SIZE;
+		window = ioremap(base, MCHBAR_SIZE);
+		if (!window) {
+			igen6_printk(KERN_ERR, "Failed to ioremap 0x%llx for mc%d\n", base, pmc);
+			rc = -ENOMEM;
+			goto out_unregister_mcis;
+		}
+
+		if (igen6_imc_absent(window)) {
+			iounmap(window);
+			edac_dbg(2, "Skip absent mc%d\n", pmc);
+			continue;
+		}
+
+		rc = igen6_register_mci(lmc, window, pdev);
+		if (rc)
+			goto out_iounmap;
+
+		/* Done, if all present MCs are detected and registered. */
+		if (++lmc >= res_cfg->num_imc)
+			break;
+	}
+
+	if (!lmc) {
+		igen6_printk(KERN_ERR, "No mc found.\n");
+		return -ENODEV;
+	}
+
+	if (lmc < res_cfg->num_imc)
+		igen6_printk(KERN_WARNING, "Expected %d mcs, but only %d detected.",
+			     res_cfg->num_imc, lmc);
+
+	return 0;
+
+out_iounmap:
+	iounmap(window);
+
+out_unregister_mcis:
+	igen6_unregister_mcis();
+
+	return rc;
+}
+
 static int igen6_mem_slice_setup(u64 mchbar)
 {
 	struct igen6_imc *imc = &igen6_pvt->imc[0];
@@ -1405,7 +1453,7 @@ static void opstate_set(const struct res_config *cfg, const struct pci_device_id
 static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	u64 mchbar;
-	int i, rc;
+	int rc;
 
 	edac_dbg(2, "\n");
 
@@ -1421,11 +1469,9 @@ static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	opstate_set(res_cfg, ent);
 
-	for (i = 0; i < res_cfg->num_imc; i++) {
-		rc = igen6_register_mci(i, mchbar, pdev);
-		if (rc)
-			goto fail2;
-	}
+	rc = igen6_register_mcis(pdev, mchbar);
+	if (rc)
+		goto fail;
 
 	if (res_cfg->num_imc > 1) {
 		rc = igen6_mem_slice_setup(mchbar);
-- 
2.43.0


