Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9AB2812BF
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 14:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbgJBMbz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 08:31:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2949 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbgJBMbz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 08:31:55 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 6DD1FBE0408B33BD3372;
        Fri,  2 Oct 2020 13:31:54 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.84.119) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 2 Oct 2020 13:31:53 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <tony.luck@intel.com>, <rjw@rjwysocki.net>, <james.morse@arm.com>,
        <lenb@kernel.org>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 7/7] ACPI / APEI: Add reporting ARM64 CPU correctable errors to the CEC
Date:   Fri, 2 Oct 2020 13:22:35 +0100
Message-ID: <20201002122235.1280-8-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201002122235.1280-1-shiju.jose@huawei.com>
References: <20201002122235.1280-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.84.119]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add reporting ARM64 CPU correctable errors to the RAS correctable
errors collector(CEC).

ARM processor error types are cache/TLB/bus errors.
Any of the above error types should not be consider for the
error collection and CPU core isolation?

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 81bf71b10d44..3cecb457d352 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -511,6 +511,38 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
+static void ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata)
+{
+	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
+	struct cper_arm_err_info *err_info;
+	int sec_sev;
+	int cpu, i, ret;
+
+	log_arm_hw_error(err);
+
+	sec_sev = ghes_severity(gdata->error_severity);
+	if (sec_sev != GHES_SEV_CORRECTED)
+		return;
+
+#if defined(CONFIG_ARM64)
+	cpu = get_logical_index(err->mpidr);
+	if (cpu == -EINVAL)
+		return;
+
+	/* ARM processor error types are cache/tlb/bus errors.
+	 * Any of the above error types should not be consider for the
+	 * error collection and CPU core isolation?
+	 */
+	err_info = (struct cper_arm_err_info *)(err + 1);
+	for (i = 0; i < err->err_info_num; i++) {
+		ret = cec_cpu_add_elem(cpu, err_info->multiple_error + 1);
+		if (ret)
+			break;
+		err_info += 1;
+	}
+#endif
+}
+
 static bool ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -543,9 +575,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
-
-			log_arm_hw_error(err);
+			ghes_handle_arm_hw_error(gdata);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
-- 
2.17.1


