Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E0C2D3126
	for <lists+linux-edac@lfdr.de>; Tue,  8 Dec 2020 18:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgLHRci (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Dec 2020 12:32:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2224 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730671AbgLHRci (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 8 Dec 2020 12:32:38 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cr6cK0d9Cz67NZG;
        Wed,  9 Dec 2020 01:29:21 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 18:31:55 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.26.232) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 8 Dec 2020 17:31:53 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <james.morse@arm.com>,
        <mchehab+huawei@kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>, <rrichter@marvell.com>
CC:     <linuxarm@huawei.com>, <xuwei5@huawei.com>,
        <jonathan.cameron@huawei.com>, <john.garry@huawei.com>,
        <tanxiaofei@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
        <salil.mehta@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 2/2] ACPI / APEI: Add reporting ARM64 CPU cache corrected error count
Date:   Tue, 8 Dec 2020 17:29:59 +0000
Message-ID: <20201208172959.1249-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201208172959.1249-1-shiju.jose@huawei.com>
References: <20201208172959.1249-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.26.232]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add reporting ARM64 CPU cache corrected error count to the ghes_edac.
The error count would be updated in the EDAC CPU cache sysfs
interface.

Note: This patch would be recreated after the patch
"ACPI / APEI: do memory failure on the physical address reported by ARM processor error section"
would be merged on the mainline.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 68 ++++++++++++++++++++++++++++++++++++++--
 include/linux/cper.h     |  4 +++
 2 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e7b0edbda0f8..37f8b09d810d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -41,6 +41,7 @@
 #include <linux/uuid.h>
 #include <linux/ras.h>
 #include <linux/task_work.h>
+#include <linux/cacheinfo.h>
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
@@ -523,6 +524,69 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
+static u8 arm_err_transaction_type_to_cache_type(u8 trans_type)
+{
+	switch (trans_type) {
+	case CPER_ARM_CACHE_TRANS_TYPE_INSTRUCTION:
+		return CACHE_TYPE_INST;
+	case CPER_ARM_CACHE_TRANS_TYPE_DATA:
+		return CACHE_TYPE_DATA;
+	case CPER_ARM_CACHE_TRANS_TYPE_GENERIC:
+	default:
+		return CACHE_TYPE_UNIFIED;
+	}
+}
+
+static void ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata)
+{
+	struct cper_sec_proc_arm *error = acpi_hest_get_payload(gdata);
+	struct cper_arm_err_info *err_info;
+	struct ghes_einfo_cpu einfo;
+	u8 transaction_type;
+	u64 error_info;
+	int sec_sev;
+	int i;
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
+		/*
+		 * ARM processor error types are cache/TLB/bus errors.
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
+			transaction_type = ((error_info >> CPER_ARM_ERR_TRANSACTION_SHIFT)
+					& CPER_ARM_ERR_TRANSACTION_MASK);
+			einfo.cache_type = arm_err_transaction_type_to_cache_type(transaction_type);
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
@@ -605,9 +669,7 @@ static bool ghes_do_proc(struct ghes *ghes,
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

