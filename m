Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93D5B89B0D
	for <lists+linux-edac@lfdr.de>; Mon, 12 Aug 2019 12:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfHLKMe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Aug 2019 06:12:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727703AbfHLKMe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 12 Aug 2019 06:12:34 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 528D31947E2185D4EE0C;
        Mon, 12 Aug 2019 18:12:30 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.45) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 12 Aug 2019 18:12:19 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <baicar@os.amperecomputing.com>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH RFC 2/4] ACPI: APEI: Add ghes_handle_memory_failure to the new notification method
Date:   Mon, 12 Aug 2019 11:11:47 +0100
Message-ID: <20190812101149.26036-3-shiju.jose@huawei.com>
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

This patch adds ghes_handle_memory_failure to the new error
notification method.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 51 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 374d197..4400d56 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -401,14 +401,18 @@ static void ghes_clear_estatus(struct ghes *ghes,
 		ghes_ack_error(ghes->generic_v2);
 }
 
-static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int sev)
+static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
+				       int sev, void *data)
 {
-#ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
+	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
+	int sec_sev = ghes_severity(gdata->error_severity);
 	unsigned long pfn;
 	int flags = -1;
-	int sec_sev = ghes_severity(gdata->error_severity);
-	struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
 
+	ghes_edac_report_mem_error(sev, mem_err);
+	arch_apei_report_mem_error(sev, mem_err);
+
+#ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
 	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
 		return;
 
@@ -569,15 +573,7 @@ static void ghes_do_proc(struct ghes *ghes,
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
 			fru_text = gdata->fru_text;
 
-		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
-			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
-
-			ghes_edac_report_mem_error(sev, mem_err);
-
-			arch_apei_report_mem_error(sev, mem_err);
-			ghes_handle_memory_failure(gdata, sev);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
+		if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
@@ -1190,11 +1186,25 @@ static int apei_sdei_unregister_ghes(struct ghes *ghes)
 	return sdei_unregister_ghes(ghes);
 }
 
+struct ghes_err_handler_tab {
+	guid_t sec_type;
+	error_handle handle;
+};
+
+static struct ghes_err_handler_tab handler_tab[] = {
+	{
+		.sec_type = CPER_SEC_PLATFORM_MEM,
+		.handle = ghes_handle_memory_failure,
+	},
+	{ /* sentinel */ }
+};
+
 static int ghes_probe(struct platform_device *ghes_dev)
 {
 	struct acpi_hest_generic *generic;
 	struct ghes *ghes = NULL;
 	unsigned long flags;
+	int i;
 
 	int rc = -EINVAL;
 
@@ -1308,9 +1318,20 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 	ghes_edac_register(ghes, &ghes_dev->dev);
 
-	if (!refcount_read(&ghes_ref_count))
+	if (!refcount_read(&ghes_ref_count)) {
 		refcount_set(&ghes_ref_count, 1);
-	else
+		/* register handler functions for the standard errors.
+		 * This may be done from the corresponding drivers.
+		 */
+		for (i = 0; handler_tab[i].handle; i++) {
+			if (ghes_error_notify_register(handler_tab[i].sec_type,
+						handler_tab[i].handle, NULL)) {
+				ghes_edac_unregister(ghes);
+				platform_set_drvdata(ghes_dev, NULL);
+				goto err;
+			}
+		}
+	} else
 		refcount_inc(&ghes_ref_count);
 
 	/* Handle any pending errors right away */
-- 
1.9.1


