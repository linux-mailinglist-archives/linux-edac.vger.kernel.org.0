Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB2C89B0B
	for <lists+linux-edac@lfdr.de>; Mon, 12 Aug 2019 12:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfHLKMc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Aug 2019 06:12:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35322 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727862AbfHLKMc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 12 Aug 2019 06:12:32 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0B55C43626E257FE43CD;
        Mon, 12 Aug 2019 18:12:25 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.45) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 12 Aug 2019 18:12:15 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <baicar@os.amperecomputing.com>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH RFC 1/4] ACPI: APEI: Add support to notify the vendor specific HW errors
Date:   Mon, 12 Aug 2019 11:11:46 +0100
Message-ID: <20190812101149.26036-2-shiju.jose@huawei.com>
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

Presently the vendor specific HW errors, in the non-standard format,
are not reported to the vendor drivers for the recovery.

This patch adds support to notify the vendor specific HW errors to the
registered kernel drivers.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 118 +++++++++++++++++++++++++++++++++++++++++++++--
 include/acpi/ghes.h      |  47 +++++++++++++++++++
 2 files changed, 160 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a66e00f..374d197 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -477,6 +477,77 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
+struct ghes_error_notify {
+	struct list_head list;
+	struct rcu_head	rcu_head;
+	guid_t sec_type; /* guid of the error record */
+	error_handle handle; /* error handler function */
+	void *data; /* handler driver's private data if any */
+};
+
+/* List to store the registered error handling functions */
+static DEFINE_MUTEX(ghes_error_notify_mutex);
+static LIST_HEAD(ghes_error_notify_list);
+static refcount_t ghes_ref_count;
+
+/**
+ * ghes_error_notify_register - register an error handling function
+ * for the hw errors.
+ * @sec_type: sec_type of the corresponding CPER to be notified.
+ * @handle: pointer to the error handling function.
+ * @data: handler driver's private data.
+ *
+ * return 0 : SUCCESS, non-zero : FAIL
+ */
+int ghes_error_notify_register(guid_t sec_type, error_handle handle, void *data)
+{
+	struct ghes_error_notify *err_notify;
+
+	mutex_lock(&ghes_error_notify_mutex);
+	err_notify = kzalloc(sizeof(*err_notify), GFP_KERNEL);
+	if (!err_notify)
+		return -ENOMEM;
+
+	err_notify->handle = handle;
+	guid_copy(&err_notify->sec_type, &sec_type);
+	err_notify->data = data;
+	list_add_rcu(&err_notify->list, &ghes_error_notify_list);
+	mutex_unlock(&ghes_error_notify_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ghes_error_notify_register);
+
+/**
+ * ghes_error_notify_unregister - unregister an error handling function.
+ * @sec_type: sec_type of the corresponding CPER.
+ * @handle: pointer to the error handling function.
+ *
+ * return none.
+ */
+void ghes_error_notify_unregister(guid_t sec_type, error_handle handle)
+{
+	struct ghes_error_notify *err_notify;
+	bool found = 0;
+
+	mutex_lock(&ghes_error_notify_mutex);
+	rcu_read_lock();
+	list_for_each_entry_rcu(err_notify, &ghes_error_notify_list, list) {
+		if (guid_equal(&err_notify->sec_type, &sec_type) &&
+		    err_notify->handle == handle) {
+			list_del_rcu(&err_notify->list);
+			found = 1;
+			break;
+		}
+	}
+	rcu_read_unlock();
+	synchronize_rcu();
+	mutex_unlock(&ghes_error_notify_mutex);
+	if (found)
+		kfree(err_notify);
+}
+EXPORT_SYMBOL_GPL(ghes_error_notify_unregister);
+
 static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -485,6 +556,8 @@ static void ghes_do_proc(struct ghes *ghes,
 	guid_t *sec_type;
 	guid_t *fru_id = &NULL_UUID_LE;
 	char *fru_text = "";
+	bool is_notify = 0;
+	struct ghes_error_notify *err_notify;
 
 	sev = ghes_severity(estatus->error_severity);
 	apei_estatus_for_each_section(estatus, gdata) {
@@ -512,11 +585,29 @@ static void ghes_do_proc(struct ghes *ghes,
 
 			log_arm_hw_error(err);
 		} else {
-			void *err = acpi_hest_get_payload(gdata);
-
-			log_non_standard_event(sec_type, fru_id, fru_text,
-					       sec_sev, err,
-					       gdata->error_data_length);
+			rcu_read_lock();
+			list_for_each_entry_rcu(err_notify,
+						&ghes_error_notify_list, list) {
+				if (guid_equal(&err_notify->sec_type,
+					       sec_type)) {
+					/* The notification is called in the
+					 * interrupt context, thus the handler
+					 * functions should be take care of it.
+					 */
+					err_notify->handle(gdata, sev,
+							   err_notify->data);
+					is_notify = 1;
+				}
+			}
+			rcu_read_unlock();
+
+			if (!is_notify) {
+				void *err = acpi_hest_get_payload(gdata);
+
+				log_non_standard_event(sec_type, fru_id,
+						       fru_text, sec_sev, err,
+						       gdata->error_data_length);
+			}
 		}
 	}
 }
@@ -1217,6 +1308,11 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 	ghes_edac_register(ghes, &ghes_dev->dev);
 
+	if (!refcount_read(&ghes_ref_count))
+		refcount_set(&ghes_ref_count, 1);
+	else
+		refcount_inc(&ghes_ref_count);
+
 	/* Handle any pending errors right away */
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
 	ghes_proc(ghes);
@@ -1237,6 +1333,7 @@ static int ghes_remove(struct platform_device *ghes_dev)
 	int rc;
 	struct ghes *ghes;
 	struct acpi_hest_generic *generic;
+	struct ghes_error_notify *err_notify, *tmp;
 
 	ghes = platform_get_drvdata(ghes_dev);
 	generic = ghes->generic;
@@ -1279,6 +1376,17 @@ static int ghes_remove(struct platform_device *ghes_dev)
 
 	ghes_fini(ghes);
 
+	if (refcount_dec_and_test(&ghes_ref_count) &&
+	    !list_empty(&ghes_error_notify_list)) {
+		mutex_lock(&ghes_error_notify_mutex);
+		list_for_each_entry_safe(err_notify, tmp,
+					 &ghes_error_notify_list, list) {
+			list_del_rcu(&err_notify->list);
+			kfree_rcu(err_notify, rcu_head);
+		}
+		mutex_unlock(&ghes_error_notify_mutex);
+	}
+
 	ghes_edac_unregister(ghes);
 
 	kfree(ghes);
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index e3f1cdd..d480537 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -50,6 +50,53 @@ enum {
 	GHES_SEV_PANIC = 0x3,
 };
 
+/**
+ * error_handle - error handling function for the hw errors.
+ * This handle function is called in the interrupt context.
+ * @gdata: acpi_hest_generic_data.
+ * @sev: error severity of the entire error event defined in the
+ * ACPI spec table generic error status block.
+ * @data: handler driver's private data.
+ *
+ * return : none.
+ */
+typedef void (*error_handle)(struct acpi_hest_generic_data *gdata, int sev,
+			     void *data);
+
+#ifdef CONFIG_ACPI_APEI_GHES
+/**
+ * ghes_error_notify_register - register an error handling function
+ * for the hw errors.
+ * @sec_type: sec_type of the corresponding CPER to be notified.
+ * @handle: pointer to the error handling function.
+ * @data: handler driver's private data.
+ *
+ * return : 0 - SUCCESS, non-zero - FAIL.
+ */
+int ghes_error_notify_register(guid_t sec_type, error_handle handle,
+			       void *data);
+
+/**
+ * ghes_error_notify_unregister - unregister an error handling function
+ * for the hw errors.
+ * @sec_type: sec_type of the corresponding CPER.
+ * @handle: pointer to the error handling function.
+ *
+ * return none.
+ */
+void ghes_error_notify_unregister(guid_t sec_type, error_handle handle);
+
+#else
+int ghes_error_notify_register(guid_t sec_type, error_handle handle, void *data)
+{
+	return -ENODEV;
+}
+
+void ghes_error_notify_unregister(guid_t sec_type, error_handle handle)
+{
+}
+#endif
+
 int ghes_estatus_pool_init(int num_ghes);
 
 /* From drivers/edac/ghes_edac.c */
-- 
1.9.1


