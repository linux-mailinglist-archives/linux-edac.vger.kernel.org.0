Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56483A4755
	for <lists+linux-edac@lfdr.de>; Fri, 11 Jun 2021 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhFKRDu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Jun 2021 13:03:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:56284 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231459AbhFKRDt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Jun 2021 13:03:49 -0400
IronPort-SDR: PRmtbWUGwrEujnn/9perHqeuh1Out4A8aDnV38MEloeM58+p3r8gocGqMNbYDdWN+RDJICN3Z8
 gW6iEcYCF99A==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="266715353"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="266715353"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:01:37 -0700
IronPort-SDR: 2y/3jazTNf9fK36WhAP1wWeLB/lRWw6Dj5mJk4JABy394QA8aYYrP4mKoXnHVpkMWAlavT3hIP
 qbHKrpfoUiZA==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="483329872"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:01:37 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     tony.luck@intel.com
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] EDAC/igen6: Add Intel ICL-NNPI SoC support
Date:   Fri, 11 Jun 2021 10:01:21 -0700
Message-Id: <20210611170123.1057025-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611170123.1057025-1-tony.luck@intel.com>
References: <20210611170123.1057025-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

The Ice Lake Neural Network Processor for Deep Learning Inference
(ICL-NNPI) SoC shares the same memory controller and In-Band ECC with
Elkhart Lake SoC. Add the ICL-NNPI compute die IDs for EDAC support.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/igen6_edac.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 6be9986fc6bd..0fedf2d206d3 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -183,6 +183,12 @@ static struct work_struct ecclog_work;
 #define DID_EHL_SKU14	0x4534
 #define DID_EHL_SKU15	0x4536
 
+/* Compute die IDs for ICL-NNPI with IBECC */
+#define DID_ICL_SKU8	0x4581
+#define DID_ICL_SKU10	0x4585
+#define DID_ICL_SKU11	0x4589
+#define DID_ICL_SKU12	0x458d
+
 static bool ehl_ibecc_available(struct pci_dev *pdev)
 {
 	u32 v;
@@ -212,6 +218,17 @@ static u64 ehl_err_addr_to_imc_addr(u64 eaddr)
 	return eaddr;
 }
 
+static bool icl_ibecc_available(struct pci_dev *pdev)
+{
+	u32 v;
+
+	if (pci_read_config_dword(pdev, CAPID_C_OFFSET, &v))
+		return false;
+
+	return !(CAPID_C_IBECC & v) &&
+		(boot_cpu_data.x86_stepping >= 1);
+}
+
 static struct res_config ehl_cfg = {
 	.num_imc	 = 1,
 	.ibecc_base	 = 0xdc00,
@@ -220,6 +237,14 @@ static struct res_config ehl_cfg = {
 	.err_addr_to_imc_addr  = ehl_err_addr_to_imc_addr,
 };
 
+static struct res_config icl_cfg = {
+	.num_imc	 = 1,
+	.ibecc_base	 = 0xd800,
+	.ibecc_available = icl_ibecc_available,
+	.err_addr_to_sys_addr  = ehl_err_addr_to_sys_addr,
+	.err_addr_to_imc_addr  = ehl_err_addr_to_imc_addr,
+};
+
 static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU5), (kernel_ulong_t)&ehl_cfg },
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU6), (kernel_ulong_t)&ehl_cfg },
@@ -232,6 +257,10 @@ static const struct pci_device_id igen6_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU13), (kernel_ulong_t)&ehl_cfg },
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU14), (kernel_ulong_t)&ehl_cfg },
 	{ PCI_VDEVICE(INTEL, DID_EHL_SKU15), (kernel_ulong_t)&ehl_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ICL_SKU8), (kernel_ulong_t)&icl_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ICL_SKU10), (kernel_ulong_t)&icl_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ICL_SKU11), (kernel_ulong_t)&icl_cfg },
+	{ PCI_VDEVICE(INTEL, DID_ICL_SKU12), (kernel_ulong_t)&icl_cfg },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, igen6_pci_tbl);
-- 
2.29.2

