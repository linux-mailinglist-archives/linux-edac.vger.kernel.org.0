Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED5E089B10
	for <lists+linux-edac@lfdr.de>; Mon, 12 Aug 2019 12:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfHLKMg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Aug 2019 06:12:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35434 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727910AbfHLKMg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 12 Aug 2019 06:12:36 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48D7E7B952D90A652941;
        Mon, 12 Aug 2019 18:12:30 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.45) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Mon, 12 Aug 2019 18:12:22 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <baicar@os.amperecomputing.com>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH RFC 3/4] ACPI: APEI: Add ghes_handle_aer to the new notification method
Date:   Mon, 12 Aug 2019 11:11:48 +0100
Message-ID: <20190812101149.26036-4-shiju.jose@huawei.com>
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

This patch adds ghes_handle_aer to the new error notification method.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 4400d56..ffc309c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -450,7 +450,8 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata,
  * GHES_SEV_PANIC does not make it to this handling since the kernel must
  *     panic.
  */
-static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
+static void ghes_handle_aer(struct acpi_hest_generic_data *gdata,
+			    int sev, void *data)
 {
 #ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
@@ -573,10 +574,7 @@ static void ghes_do_proc(struct ghes *ghes,
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
 			fru_text = gdata->fru_text;
 
-		if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
-			ghes_handle_aer(gdata);
-		}
-		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
+		if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 
 			log_arm_hw_error(err);
@@ -1196,6 +1194,10 @@ struct ghes_err_handler_tab {
 		.sec_type = CPER_SEC_PLATFORM_MEM,
 		.handle = ghes_handle_memory_failure,
 	},
+	{
+		.sec_type = CPER_SEC_PCIE,
+		.handle = ghes_handle_aer,
+	},
 	{ /* sentinel */ }
 };
 
-- 
1.9.1


