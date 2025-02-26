Return-Path: <linux-edac+bounces-3213-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDC6A452C1
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 03:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102131884FCB
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2025 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260422135B5;
	Wed, 26 Feb 2025 02:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJGShOrz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D796213E69;
	Wed, 26 Feb 2025 02:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535583; cv=none; b=PXHJjBYNaUANNp3yPp4IcBKMIM/Kdp3lEEMPV0yOgxI8XV24tFG7RKcU0MsggQ0G+mpZ6U5s4nH2cwpGx6kHtPRdhLGqCLF/6z63VUIFwcNZAD/ZMYt72UrYHFX/OE8iBJnf4goDtGgDSy3q5IzwYk4yk1FLN7fEFxtJeMBWXq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535583; c=relaxed/simple;
	bh=zCU1KwQqk62ncCELy9cRfbYxTJAHGVH1TscUOTGPg2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I++sq4Ud4qSh97Yoym3z4MislIg+fMe/hbGWXtkHasIv9qrM5IL1Om3xQIs4iBQLh6xGks+SU39PoQTOuBo5MK32vFGvBePAGnBfbYcJ0wMZFwWXpD3ZtwRerXN3S8CN7+MMDWA9Mqja341/B5s2GoYTchDZR9WI8wlp4D7Uhws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJGShOrz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740535581; x=1772071581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=zCU1KwQqk62ncCELy9cRfbYxTJAHGVH1TscUOTGPg2M=;
  b=kJGShOrzfZOMVfc9+HtuHHT7QoI4qVVJpoqK0DWBG+xfI5fCE3NXJu3V
   EAeOBacIeWvf5tI3YVDCtFQpuNV8g1sUzE5vjsdSrQWqDzO1k4EldY8sR
   bv+ICUo5grwVL7EjFxL42O2iHQELMdU4L65P9Bj9A415DEozH7vfn5Ax8
   a52Wg5133Ox6pwvZye7/6oHRIfYt7JEhYyd0vrVDseIQqi7GUjVEzXpV0
   xrCqknt+9kCV5DS04/kW4xHPpJJ07dhSWTmpmNcJ85Wys3yw1Nxo0Xw+T
   A2rzca8TI8PSYuPwDE+95WywrTu6tjNf9FPZYWv+3AIf2MVFx6tEDDIqm
   A==;
X-CSE-ConnectionGUID: duvJX/fnSWmD6NMrCbZeqg==
X-CSE-MsgGUID: CyjDRKB1QX+Cy0Ppoo99pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="28959961"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="28959961"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:06:20 -0800
X-CSE-ConnectionGUID: KkZDRt/2R5OueWSB2C63xg==
X-CSE-MsgGUID: iY6ihvOLRYudXUVuBQTsTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="121180779"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:06:17 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Jason Baron <jbaron@akamai.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Gary Wang <gary.c.wang@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] EDAC/ie31200: Switch Raptor Lake-S to interrupt mode
Date: Wed, 26 Feb 2025 09:52:02 +0800
Message-Id: <20250226015202.36576-12-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
References: <20250226015202.36576-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>

Raptor Lake-S SoCs notify memory errors via Machine Check. Add interrupt
mode support and switch Raptor Lake-S EDAC from polling to interrupt mode.

Tested-by: Gary Wang <gary.c.wang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/Kconfig        |  2 +-
 drivers/edac/ie31200_edac.c | 83 ++++++++++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 2051a7c944a5..b908a118fb32 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -168,7 +168,7 @@ config EDAC_I3200
 
 config EDAC_IE31200
 	tristate "Intel e312xx"
-	depends on PCI && X86
+	depends on PCI && X86 && X86_MCE_INTEL
 	help
 	  Support for error detection and correction on the Intel
 	  E3-1200 based DRAM controllers.
diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 8c0a2beec537..4abcf7b322c2 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -51,6 +51,7 @@
 #include <linux/edac.h>
 
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <asm/mce.h>
 #include "edac_module.h"
 
 #define EDAC_MOD_STR "ie31200_edac"
@@ -123,6 +124,7 @@ static int ie31200_registered = 1;
 
 struct res_config {
 	enum mem_type mtype;
+	bool machine_check;
 	int imc_num;
 	/* Host MMIO configuration register */
 	u64 reg_mchbar_mask;
@@ -172,6 +174,7 @@ struct ie31200_error_info {
 	u16 errsts;
 	u16 errsts2;
 	u64 eccerrlog[IE31200_CHANNELS];
+	u64 erraddr;
 };
 
 static const struct ie31200_dev_info ie31200_devs[] = {
@@ -327,13 +330,13 @@ static void ie31200_process_error_info(struct mem_ctl_info *mci,
 		log = info->eccerrlog[channel];
 		if (log & cfg->reg_eccerrlog_ue_mask) {
 			edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, 1,
-					     0, 0, 0,
+					     info->erraddr >> PAGE_SHIFT, 0, 0,
 					     field_get(cfg->reg_eccerrlog_rank_mask, log),
 					     channel, -1,
 					     "ie31200 UE", "");
 		} else if (log & cfg->reg_eccerrlog_ce_mask) {
 			edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, 1,
-					     0, 0,
+					     info->erraddr >> PAGE_SHIFT, 0,
 					     field_get(cfg->reg_eccerrlog_syndrome_mask, log),
 					     field_get(cfg->reg_eccerrlog_rank_mask, log),
 					     channel, -1,
@@ -342,14 +345,20 @@ static void ie31200_process_error_info(struct mem_ctl_info *mci,
 	}
 }
 
-static void ie31200_check(struct mem_ctl_info *mci)
+static void __ie31200_check(struct mem_ctl_info *mci, struct mce *mce)
 {
 	struct ie31200_error_info info;
 
+	info.erraddr = mce ? mce->addr : 0;
 	ie31200_get_and_clear_error_info(mci, &info);
 	ie31200_process_error_info(mci, &info);
 }
 
+static void ie31200_check(struct mem_ctl_info *mci)
+{
+	__ie31200_check(mci, NULL);
+}
+
 static void __iomem *ie31200_map_mchbar(struct pci_dev *pdev, struct res_config *cfg, int mc)
 {
 	union {
@@ -459,7 +468,7 @@ static int ie31200_register_mci(struct pci_dev *pdev, struct res_config *cfg, in
 	mci->mod_name = EDAC_MOD_STR;
 	mci->ctl_name = ie31200_devs[mc].ctl_name;
 	mci->dev_name = pci_name(pdev);
-	mci->edac_check = ie31200_check;
+	mci->edac_check = cfg->machine_check ? NULL : ie31200_check;
 	mci->ctl_page_to_phys = NULL;
 	priv = mci->pvt_info;
 	priv->window = window;
@@ -499,6 +508,58 @@ static int ie31200_register_mci(struct pci_dev *pdev, struct res_config *cfg, in
 	return ret;
 }
 
+static void mce_check(struct mce *mce)
+{
+	struct ie31200_priv *priv;
+	int i;
+
+	for (i = 0; i < IE31200_IMC_NUM; i++) {
+		priv = ie31200_pvt.priv[i];
+		if (!priv)
+			continue;
+
+		__ie31200_check(priv->mci, mce);
+	}
+}
+
+static int mce_handler(struct notifier_block *nb, unsigned long val, void *data)
+{
+	struct mce *mce = (struct mce *)data;
+	char *type;
+
+	if (mce->kflags & MCE_HANDLED_CEC)
+		return NOTIFY_DONE;
+
+	/*
+	 * Ignore unless this is a memory related error.
+	 * Don't check MCI_STATUS_ADDRV since it's not set on some CPUs.
+	 */
+	if ((mce->status & 0xefff) >> 7 != 1)
+		return NOTIFY_DONE;
+
+	type = mce->mcgstatus & MCG_STATUS_MCIP ?  "Exception" : "Event";
+
+	edac_dbg(0, "CPU %d: Machine Check %s: 0x%llx Bank %d: 0x%llx\n",
+		 mce->extcpu, type, mce->mcgstatus,
+		 mce->bank, mce->status);
+	edac_dbg(0, "TSC 0x%llx\n", mce->tsc);
+	edac_dbg(0, "ADDR 0x%llx\n", mce->addr);
+	edac_dbg(0, "MISC 0x%llx\n", mce->misc);
+	edac_dbg(0, "PROCESSOR %u:0x%x TIME %llu SOCKET %u APIC 0x%x\n",
+		 mce->cpuvendor, mce->cpuid, mce->time,
+		 mce->socketid, mce->apicid);
+
+	mce_check(mce);
+	mce->kflags |= MCE_HANDLED_EDAC;
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ie31200_mce_dec = {
+	.notifier_call	= mce_handler,
+	.priority	= MCE_PRIO_EDAC,
+};
+
 static void ie31200_unregister_mcis(void)
 {
 	struct ie31200_priv *priv;
@@ -534,6 +595,13 @@ static int ie31200_probe1(struct pci_dev *pdev, struct res_config *cfg)
 			goto fail_register;
 	}
 
+	if (cfg->machine_check) {
+		mce_register_decode_chain(&ie31200_mce_dec);
+		edac_op_state = EDAC_OPSTATE_INT;
+	} else {
+		edac_op_state = EDAC_OPSTATE_POLL;
+	}
+
 	/* get this far and it's successful. */
 	edac_dbg(3, "MC: success\n");
 	return 0;
@@ -560,9 +628,13 @@ static int ie31200_init_one(struct pci_dev *pdev,
 
 static void ie31200_remove_one(struct pci_dev *pdev)
 {
+	struct ie31200_priv *priv = ie31200_pvt.priv[0];
+
 	edac_dbg(0, "\n");
 	pci_dev_put(mci_pdev);
 	mci_pdev = NULL;
+	if (priv->cfg->machine_check)
+		mce_unregister_decode_chain(&ie31200_mce_dec);
 	ie31200_unregister_mcis();
 }
 
@@ -612,6 +684,7 @@ static struct res_config skl_cfg = {
 
 struct res_config rpl_s_cfg = {
 	.mtype				= MEM_DDR5,
+	.machine_check			= true,
 	.imc_num			= 2,
 	.reg_mchbar_mask		= GENMASK_ULL(41, 17),
 	.reg_mchbar_window_size		= BIT_ULL(16),
@@ -677,8 +750,6 @@ static int __init ie31200_init(void)
 	int pci_rc, i;
 
 	edac_dbg(3, "MC:\n");
-	/* Ensure that the OPSTATE is set correctly for POLL or NMI */
-	opstate_init();
 
 	pci_rc = pci_register_driver(&ie31200_driver);
 	if (pci_rc < 0)
-- 
2.17.1


