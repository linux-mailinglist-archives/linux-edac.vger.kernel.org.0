Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E92A7840
	for <lists+linux-edac@lfdr.de>; Thu,  5 Nov 2020 08:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725287AbgKEHtI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Nov 2020 02:49:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:23474 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgKEHtH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 5 Nov 2020 02:49:07 -0500
IronPort-SDR: Gqg8IlD2GsL/h9Cdp/s45emkWyK1wf/UbhC4H2MgBwC3uwnXYSFuio/bl2B90ih8KBKgreYTeK
 AdJXd9GnQIrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="169486368"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="169486368"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 23:49:01 -0800
IronPort-SDR: FuLPPA88pnxTiice8cAeomAFDQ/ljJNWM9pvCtBUVzoF7mhct1CEL/hcIQikF42XYQt+2MGbgU
 xUhQVFHKN9vg==
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="306443642"
Received: from qiuxu-lab.sh.intel.com ([10.239.53.133])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 23:48:59 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     bp@alien8.de
Cc:     tony.luck@intel.com, aris@redhat.com, mchehab@kernel.org,
        linux-edac@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH v1 3/3] EDAC/igen6: Add debugfs interface for Intel client SoC EDAC driver
Date:   Thu,  5 Nov 2020 15:49:34 +0800
Message-Id: <20201105074934.3915-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add debugfs support to fake memory correctable errors to test the
error reporting path and the error address decoding logic in the
igen6_edac driver.

Please note that the fake errors are also reported to EDAC core and
then the CE counter in EDAC sysfs is also increased.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/edac/igen6_edac.c | 59 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index b8a6d692c1e4..5a5e7e9ffcb7 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -612,6 +612,10 @@ static int igen6_get_dimm_config(struct mem_ctl_info *mci)
 }
 
 #ifdef CONFIG_EDAC_DEBUG
+/* Top of upper usable DRAM */
+static u64 igen6_touud;
+#define TOUUD_OFFSET	0xa8
+
 static void igen6_reg_dump(struct igen6_imc *imc)
 {
 	int i;
@@ -632,10 +636,54 @@ static void igen6_reg_dump(struct igen6_imc *imc)
 			 readl(imc->window + MAD_DIMM_CH0_OFFSET + i * 4));
 	}
 	edac_dbg(2, "TOLUD            : 0x%x", igen6_tolud);
+	edac_dbg(2, "TOUUD            : 0x%llx", igen6_touud);
 	edac_dbg(2, "TOM              : 0x%llx", igen6_tom);
 }
+
+static struct dentry *igen6_test;
+
+static int debugfs_u64_set(void *data, u64 val)
+{
+	u64 ecclog;
+
+	if ((val >= igen6_tolud && val < _4GB) || val >= igen6_touud) {
+		edac_dbg(0, "Address 0x%llx out of range\n", val);
+		return 0;
+	}
+
+	pr_warn_once("Fake error to 0x%llx injected via debugfs\n", val);
+
+	val  >>= ECC_ERROR_LOG_ADDR_SHIFT;
+	ecclog = (val << ECC_ERROR_LOG_ADDR_SHIFT) | ECC_ERROR_LOG_CE;
+
+	if (!ecclog_gen_pool_add(0, ecclog))
+		irq_work_queue(&ecclog_irq_work);
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(fops_u64_wo, NULL, debugfs_u64_set, "%llu\n");
+
+static void igen6_debug_setup(void)
+{
+	igen6_test = edac_debugfs_create_dir("igen6_test");
+	if (!igen6_test)
+		return;
+
+	if (!edac_debugfs_create_file("addr", 0200, igen6_test,
+				      NULL, &fops_u64_wo)) {
+		debugfs_remove(igen6_test);
+		igen6_test = NULL;
+	}
+}
+
+static void igen6_debug_teardown(void)
+{
+	debugfs_remove_recursive(igen6_test);
+}
 #else
 static void igen6_reg_dump(struct igen6_imc *imc) {}
+static void igen6_debug_setup(void) {}
+static void igen6_debug_teardown(void) {}
 #endif
 
 static int igen6_pci_setup(struct pci_dev *pdev, u64 *mchbar)
@@ -691,6 +739,15 @@ static int igen6_pci_setup(struct pci_dev *pdev, u64 *mchbar)
 
 	*mchbar = MCHBAR_BASE(u.v);
 
+#ifdef CONFIG_EDAC_DEBUG
+	if (pci_read_config_dword(pdev, TOUUD_OFFSET, &u.v_lo))
+		edac_dbg(2, "Failed to read lower TOUUD\n");
+	else if (pci_read_config_dword(pdev, TOUUD_OFFSET + 4, &u.v_hi))
+		edac_dbg(2, "Failed to read upper TOUUD\n");
+	else
+		igen6_touud = u.v & GENMASK_ULL(38, 20);
+#endif
+
 	return 0;
 fail:
 	return -ENODEV;
@@ -849,6 +906,7 @@ static int igen6_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto fail4;
 	}
 
+	igen6_debug_setup();
 	return 0;
 fail4:
 	unregister_nmi_handler(NMI_SERR, IGEN6_NMI_NAME);
@@ -865,6 +923,7 @@ static void igen6_remove(struct pci_dev *pdev)
 {
 	edac_dbg(2, "\n");
 
+	igen6_debug_teardown();
 	errcmd_enable_error_reporting(false);
 	unregister_nmi_handler(NMI_SERR, IGEN6_NMI_NAME);
 	irq_work_sync(&ecclog_irq_work);
-- 
2.17.1

