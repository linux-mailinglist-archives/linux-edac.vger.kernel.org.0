Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351AD2A8588
	for <lists+linux-edac@lfdr.de>; Thu,  5 Nov 2020 19:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbgKESBZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Nov 2020 13:01:25 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2057 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKESBY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Nov 2020 13:01:24 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CRrVl2nfhz67J3M;
        Fri,  6 Nov 2020 01:44:15 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 5 Nov 2020 18:45:30 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.87.221) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 5 Nov 2020 17:45:29 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <bp@alien8.de>, <tony.luck@intel.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <rrichter@marvell.com>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [RFC PATCH 4/4] ACPI / APEI: Add reporting ARM64 CPU cache corrected error count
Date:   Thu, 5 Nov 2020 17:42:33 +0000
Message-ID: <20201105174233.1146-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201105174233.1146-1-shiju.jose@huawei.com>
References: <20201105174233.1146-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.87.221]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add reporting ARM64 CPU cache corrected error count to the ghes_edac.
The error count would be updated in the EDAC CPU cache sysfs
interface.

Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 79 ++++++++++++++++++++++++++++++++++++++--
 include/linux/cper.h     |  4 ++
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fce7ade2aba9..b17173312087 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -523,6 +523,81 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
+/*
+ * arm_err_trans_type_to_acpi_cache_type: Function to convert transaction type
+ * in the CPER's ARM cache error structure to the ACPI PPTT cache type.
+ *
+ * @type - transaction type. Type of cache error instruction/data/generic.
+ *
+ * Return: Success: ACPI PPTT cache type. Failure: Negative value.
+ */
+static u8 arm_err_trans_type_to_acpi_cache_type(u8 type)
+{
+	switch (type) {
+	case CPER_ARM_CACHE_TRANS_TYPE_INSTRUCTION:
+		return ACPI_PPTT_CACHE_TYPE_INSTR;
+	case CPER_ARM_CACHE_TRANS_TYPE_DATA:
+		return ACPI_PPTT_CACHE_TYPE_DATA;
+	case CPER_ARM_CACHE_TRANS_TYPE_GENERIC:
+		return ACPI_PPTT_CACHE_TYPE_UNIFIED;
+	default:
+		pr_warn_ratelimited("FW_WARN GHES_PFX ARM CPER: Invalid cache transaction type\n");
+		return -EINVAL;
+	}
+}
+
+static void ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata)
+{
+	struct cper_sec_proc_arm *error = acpi_hest_get_payload(gdata);
+	struct cper_arm_err_info *err_info;
+	struct ghes_einfo_cpu einfo;
+	u8 trans_type;
+	u64 error_info;
+	int sec_sev;
+	int i, cache_type;
+
+	log_arm_hw_error(error);
+
+	sec_sev = ghes_severity(gdata->error_severity);
+
+#if defined(CONFIG_ARM64)
+	if (sec_sev == GHES_SEV_CORRECTED) {
+		memset(&einfo, 0, sizeof(einfo));
+		einfo.cpu = get_logical_index(error->mpidr);
+		if (einfo.cpu == -EINVAL)
+			return;
+
+		/* ARM processor error types are cache/TLB/bus errors.
+		 * Presently corrected error count for caches only
+		 * is reported.
+		 */
+		err_info = (struct cper_arm_err_info *)(error + 1);
+
+		for (i = 0; i < error->err_info_num; i++) {
+			if (err_info->type != CPER_ARM_CACHE_ERROR)
+				continue;
+			einfo.ce_count = err_info->multiple_error + 1;
+
+			error_info = err_info->error_info;
+			if (!(error_info & CPER_ARM_ERR_VALID_TRANSACTION_TYPE) ||
+			    !(error_info & CPER_ARM_ERR_VALID_LEVEL))
+				continue;
+
+			trans_type = ((error_info >> CPER_ARM_ERR_TRANSACTION_SHIFT)
+					& CPER_ARM_ERR_TRANSACTION_MASK);
+			cache_type = arm_err_trans_type_to_acpi_cache_type(trans_type);
+			if (cache_type < 0)
+				continue;
+			einfo.cache_type = cache_type;
+			einfo.cache_level = ((error_info >> CPER_ARM_ERR_LEVEL_SHIFT)
+					& CPER_ARM_ERR_LEVEL_MASK);
+			ghes_edac_report_cpu_error(&einfo);
+			err_info += 1;
+		}
+	}
+#endif
+}
+
 static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
 
 int ghes_register_vendor_record_notifier(struct notifier_block *nb)
@@ -605,9 +680,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
-
-			log_arm_hw_error(err);
+			ghes_handle_arm_hw_error(gdata);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 6a511a1078ca..0ea966af6ad9 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -314,6 +314,10 @@ enum {
 #define CPER_ARM_ERR_ACCESS_MODE_SHIFT		43
 #define CPER_ARM_ERR_ACCESS_MODE_MASK		GENMASK(0,0)
 
+#define CPER_ARM_CACHE_TRANS_TYPE_INSTRUCTION	0
+#define CPER_ARM_CACHE_TRANS_TYPE_DATA		1
+#define CPER_ARM_CACHE_TRANS_TYPE_GENERIC	2
+
 /*
  * All tables and structs must be byte-packed to match CPER
  * specification, since the tables are provided by the system BIOS
-- 
2.17.1

