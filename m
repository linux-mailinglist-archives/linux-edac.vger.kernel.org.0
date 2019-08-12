Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D615589B14
	for <lists+linux-edac@lfdr.de>; Mon, 12 Aug 2019 12:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfHLKMk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Aug 2019 06:12:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35576 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727703AbfHLKMh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 12 Aug 2019 06:12:37 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2AF2EF66CD59304F08B0;
        Mon, 12 Aug 2019 18:12:35 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.45) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 12 Aug 2019 18:12:26 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <baicar@os.amperecomputing.com>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH RFC 4/4] ACPI: APEI: Add log_arm_hw_error to the new notification method
Date:   Mon, 12 Aug 2019 11:11:49 +0100
Message-ID: <20190812101149.26036-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190812101149.26036-1-shiju.jose@huawei.com>
References: <Shiju Jose>
 <20190812101149.26036-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch adds log_arm_hw_error to the new error notification
method.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 47 ++++++++++++++++++++++-------------------------
 drivers/ras/ras.c        |  5 ++++-
 include/linux/ras.h      |  7 +++++--
 3 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ffc309c..013fea0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -574,34 +574,27 @@ static void ghes_do_proc(struct ghes *ghes,
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
 			fru_text = gdata->fru_text;
 
-		if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
-
-			log_arm_hw_error(err);
-		} else {
-			rcu_read_lock();
-			list_for_each_entry_rcu(err_notify,
-						&ghes_error_notify_list, list) {
-				if (guid_equal(&err_notify->sec_type,
-					       sec_type)) {
-					/* The notification is called in the
-					 * interrupt context, thus the handler
-					 * functions should be take care of it.
-					 */
-					err_notify->handle(gdata, sev,
-							   err_notify->data);
-					is_notify = 1;
-				}
+		rcu_read_lock();
+		list_for_each_entry_rcu(err_notify, &ghes_error_notify_list,
+					list) {
+			if (guid_equal(&err_notify->sec_type, sec_type)) {
+				/* The notification is called in the
+				 * interrupt context, thus the handler
+				 * functions should be take care of it.
+				 */
+				err_notify->handle(gdata, sev,
+						   err_notify->data);
+				is_notify = 1;
 			}
-			rcu_read_unlock();
+		}
+		rcu_read_unlock();
 
-			if (!is_notify) {
-				void *err = acpi_hest_get_payload(gdata);
+		if (!is_notify) {
+			void *err = acpi_hest_get_payload(gdata);
 
-				log_non_standard_event(sec_type, fru_id,
-						       fru_text, sec_sev, err,
-						       gdata->error_data_length);
-			}
+			log_non_standard_event(sec_type, fru_id,
+					       fru_text, sec_sev, err,
+					       gdata->error_data_length);
 		}
 	}
 }
@@ -1198,6 +1191,10 @@ struct ghes_err_handler_tab {
 		.sec_type = CPER_SEC_PCIE,
 		.handle = ghes_handle_aer,
 	},
+	{
+		.sec_type = CPER_SEC_PROC_ARM,
+		.handle = log_arm_hw_error,
+	},
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index 95540ea..7ec3eeb 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -21,8 +21,11 @@ void log_non_standard_event(const guid_t *sec_type, const guid_t *fru_id,
 	trace_non_standard_event(sec_type, fru_id, fru_text, sev, err, len);
 }
 
-void log_arm_hw_error(struct cper_sec_proc_arm *err)
+void log_arm_hw_error(struct acpi_hest_generic_data *gdata,
+		      int sev, void *data)
 {
+	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
+
 	trace_arm_event(err);
 }
 
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 7c3debb..05b662d 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -5,6 +5,7 @@
 #include <asm/errno.h>
 #include <linux/uuid.h>
 #include <linux/cper.h>
+#include <acpi/ghes.h>
 
 #ifdef CONFIG_DEBUG_FS
 int ras_userspace_consumers(void);
@@ -29,7 +30,8 @@ static inline void __init cec_init(void)	{ }
 void log_non_standard_event(const guid_t *sec_type,
 			    const guid_t *fru_id, const char *fru_text,
 			    const u8 sev, const u8 *err, const u32 len);
-void log_arm_hw_error(struct cper_sec_proc_arm *err);
+void log_arm_hw_error(struct acpi_hest_generic_data *gdata,
+		      int sev, void *data);
 #else
 static inline void
 log_non_standard_event(const guid_t *sec_type,
@@ -37,7 +39,8 @@ void log_non_standard_event(const guid_t *sec_type,
 		       const u8 sev, const u8 *err, const u32 len)
 { return; }
 static inline void
-log_arm_hw_error(struct cper_sec_proc_arm *err) { return; }
+log_arm_hw_error(struct acpi_hest_generic_data *gdata,
+		 int sev, void *data) { return; }
 #endif
 
 #endif /* __RAS_H__ */
-- 
1.9.1


