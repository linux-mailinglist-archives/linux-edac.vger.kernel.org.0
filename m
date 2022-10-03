Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3B15F3345
	for <lists+linux-edac@lfdr.de>; Mon,  3 Oct 2022 18:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJCQSB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Oct 2022 12:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJCQRv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Oct 2022 12:17:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E171E356E2
        for <linux-edac@vger.kernel.org>; Mon,  3 Oct 2022 09:17:42 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mh5Yb0d5Sz67yc5;
        Tue,  4 Oct 2022 00:16:19 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Mon, 3 Oct 2022 18:17:39 +0200
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.152.147) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 17:17:39 +0100
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <luoshengwei@huawei.com>, <panjunchong@hisilicon.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 03/10] rasdaemon: Modify recording Hisilicon common error data
Date:   Mon, 3 Oct 2022 17:17:35 +0100
Message-ID: <20221003161742.1697-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20221003161742.1697-1-shiju.jose@huawei.com>
References: <20221003161742.1697-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.152.147]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

The error statistics for the Hisilicon common
error need to do based on module, error severity etc.

Modify recording Hisilicon common error data as separate fields
in the sql db table instead of the combined single field.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 non-standard-hisilicon.c | 126 ++++++++++++++++++++++++++++++++-------
 1 file changed, 104 insertions(+), 22 deletions(-)

diff --git a/non-standard-hisilicon.c b/non-standard-hisilicon.c
index 1432163..d1e1774 100644
--- a/non-standard-hisilicon.c
+++ b/non-standard-hisilicon.c
@@ -17,6 +17,7 @@
 #include "non-standard-hisilicon.h"
 
 #define HISI_BUF_LEN	2048
+#define HISI_PCIE_INFO_BUF_LEN	256
 
 struct hisi_common_error_section {
 	uint32_t   val_bits;
@@ -63,12 +64,25 @@ enum {
 enum {
 	HISI_COMMON_FIELD_ID,
 	HISI_COMMON_FIELD_TIMESTAMP,
-	HISI_COMMON_FIELD_ERR_INFO,
+	HISI_COMMON_FIELD_VERSION,
+	HISI_COMMON_FIELD_SOC_ID,
+	HISI_COMMON_FIELD_SOCKET_ID,
+	HISI_COMMON_FIELD_TOTEM_ID,
+	HISI_COMMON_FIELD_NIMBUS_ID,
+	HISI_COMMON_FIELD_SUB_SYSTEM_ID,
+	HISI_COMMON_FIELD_MODULE_ID,
+	HISI_COMMON_FIELD_SUB_MODULE_ID,
+	HISI_COMMON_FIELD_CORE_ID,
+	HISI_COMMON_FIELD_PORT_ID,
+	HISI_COMMON_FIELD_ERR_TYPE,
+	HISI_COMMON_FIELD_PCIE_INFO,
+	HISI_COMMON_FIELD_ERR_SEVERITY,
 	HISI_COMMON_FIELD_REGS_DUMP,
 };
 
 struct hisi_event {
 	char error_msg[HISI_BUF_LEN];
+	char pcie_info[HISI_PCIE_INFO_BUF_LEN];
 	char reg_msg[HISI_BUF_LEN];
 };
 
@@ -132,14 +146,26 @@ int step_vendor_data_tab(struct ras_ns_ev_decoder *ev_decoder, const char *name)
 
 #ifdef HAVE_SQLITE3
 static const struct db_fields hisi_common_section_fields[] = {
-	{ .name = "id",                 .type = "INTEGER PRIMARY KEY" },
-	{ .name = "timestamp",          .type = "TEXT" },
-	{ .name = "err_info",		.type = "TEXT" },
+	{ .name = "id",			.type = "INTEGER PRIMARY KEY" },
+	{ .name = "timestamp",		.type = "TEXT" },
+	{ .name = "version",		.type = "INTEGER" },
+	{ .name = "soc_id",		.type = "INTEGER" },
+	{ .name = "socket_id",		.type = "INTEGER" },
+	{ .name = "totem_id",		.type = "INTEGER" },
+	{ .name = "nimbus_id",		.type = "INTEGER" },
+	{ .name = "sub_system_id",	.type = "INTEGER" },
+	{ .name = "module_id",		.type = "TEXT" },
+	{ .name = "sub_module_id",	.type = "INTEGER" },
+	{ .name = "core_id",		.type = "INTEGER" },
+	{ .name = "port_id",		.type = "INTEGER" },
+	{ .name = "err_type",		.type = "INTEGER" },
+	{ .name = "pcie_info",		.type = "TEXT" },
+	{ .name = "err_severity",	.type = "TEXT" },
 	{ .name = "regs_dump",		.type = "TEXT" },
 };
 
 static const struct db_table_descriptor hisi_common_section_tab = {
-	.name = "hisi_common_section",
+	.name = "hisi_common_section_v2",
 	.fields = hisi_common_section_fields,
 	.num_fields = ARRAY_SIZE(hisi_common_section_fields),
 };
@@ -199,12 +225,20 @@ static const char* get_soc_desc(uint8_t soc_id)
 	return soc_desc[soc_id];
 }
 
-static void decode_module(struct hisi_event *event, uint8_t module_id)
+static void decode_module(struct ras_ns_ev_decoder *ev_decoder,
+			  struct hisi_event *event, uint8_t module_id)
 {
-	if (module_id >= sizeof(module_name)/sizeof(char *))
+	if (module_id >= sizeof(module_name)/sizeof(char *)) {
 		HISI_SNPRINTF(event->error_msg, "module=unknown(id=%hhu) ", module_id);
-	else
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
+				   HISI_COMMON_FIELD_MODULE_ID,
+				   0, "unknown");
+	} else {
 		HISI_SNPRINTF(event->error_msg, "module=%s ", module_name[module_id]);
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
+				   HISI_COMMON_FIELD_MODULE_ID,
+				   0, module_name[module_id]);
+	}
 }
 
 static void decode_hisi_common_section_hdr(struct ras_ns_ev_decoder *ev_decoder,
@@ -212,43 +246,93 @@ static void decode_hisi_common_section_hdr(struct ras_ns_ev_decoder *ev_decoder,
 					  struct hisi_event *event)
 {
 	HISI_SNPRINTF(event->error_msg, "[ table_version=%hhu", err->version);
-	if (err->val_bits & BIT(HISI_COMMON_VALID_SOC_ID))
+	record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
+			   HISI_COMMON_FIELD_VERSION,
+			   err->version, NULL);
+	if (err->val_bits & BIT(HISI_COMMON_VALID_SOC_ID)) {
 		HISI_SNPRINTF(event->error_msg, "soc=%s", get_soc_desc(err->soc_id));
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
+				   HISI_COMMON_FIELD_SOC_ID,
+				   err->soc_id, NULL);
+	}
 
-	if (err->val_bits & BIT(HISI_COMMON_VALID_SOCKET_ID))
+	if (err->val_bits & BIT(HISI_COMMON_VALID_SOCKET_ID)) {
 		HISI_SNPRINTF(event->error_msg, "socket_id=%hhu", err->socket_id);
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
+				   HISI_COMMON_FIELD_SOCKET_ID,
+				   err->socket_id, NULL);
+	}
 
-	if (err->val_bits & BIT(HISI_COMMON_VALID_TOTEM_ID))
+	if (err->val_bits & BIT(HISI_COMMON_VALID_TOTEM_ID)) {
 		HISI_SNPRINTF(event->error_msg, "totem_id=%hhu", err->totem_id);
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
+				   HISI_COMMON_FIELD_TOTEM_ID,
+				   err->totem_id, NULL);
+	}
 
-	if (err->val_bits & BIT(HISI_COMMON_VALID_NIMBUS_ID))
+	if (err->val_bits & BIT(HISI_COMMON_VALID_NIMBUS_ID)) {
 		HISI_SNPRINTF(event->error_msg, "nimbus_id=%hhu", err->nimbus_id);
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
+				   HISI_COMMON_FIELD_NIMBUS_ID,
+				   err->nimbus_id, NULL);
+	}
 
-	if (err->val_bits & BIT(HISI_COMMON_VALID_SUBSYSTEM_ID))
+	if (err->val_bits & BIT(HISI_COMMON_VALID_SUBSYSTEM_ID)) {
 		HISI_SNPRINTF(event->error_msg, "subsystem_id=%hhu", err->subsystem_id);
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
+				   HISI_COMMON_FIELD_SUB_SYSTEM_ID,
+				   err->subsystem_id, NULL);
+	}
 
 	if (err->val_bits & BIT(HISI_COMMON_VALID_MODULE_ID))
-		decode_module(event, err->module_id);
+		decode_module(ev_decoder, event, err->module_id);
 
-	if (err->val_bits & BIT(HISI_COMMON_VALID_SUBMODULE_ID))
+	if (err->val_bits & BIT(HISI_COMMON_VALID_SUBMODULE_ID)) {
 		HISI_SNPRINTF(event->error_msg, "submodule_id=%hhu", err->submodule_id);
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
+				   HISI_COMMON_FIELD_SUB_MODULE_ID,
+				   err->submodule_id, NULL);
+	}
 
-	if (err->val_bits & BIT(HISI_COMMON_VALID_CORE_ID))
+	if (err->val_bits & BIT(HISI_COMMON_VALID_CORE_ID)) {
 		HISI_SNPRINTF(event->error_msg, "core_id=%hhu", err->core_id);
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
+				   HISI_COMMON_FIELD_CORE_ID,
+				   err->core_id, NULL);
+	}
 
-	if (err->val_bits & BIT(HISI_COMMON_VALID_PORT_ID))
+	if (err->val_bits & BIT(HISI_COMMON_VALID_PORT_ID)) {
 		HISI_SNPRINTF(event->error_msg, "port_id=%hhu", err->port_id);
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
+				   HISI_COMMON_FIELD_PORT_ID,
+				   err->port_id, NULL);
+	}
 
-	if (err->val_bits & BIT(HISI_COMMON_VALID_ERR_TYPE))
+	if (err->val_bits & BIT(HISI_COMMON_VALID_ERR_TYPE)) {
 		HISI_SNPRINTF(event->error_msg, "err_type=%hu", err->err_type);
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
+				   HISI_COMMON_FIELD_ERR_TYPE,
+				   err->err_type, NULL);
+	}
 
-	if (err->val_bits & BIT(HISI_COMMON_VALID_PCIE_INFO))
+	if (err->val_bits & BIT(HISI_COMMON_VALID_PCIE_INFO)) {
 		HISI_SNPRINTF(event->error_msg, "pcie_device_id=%04x:%02x:%02x.%x",
 			      err->pcie_info.segment, err->pcie_info.bus,
 			      err->pcie_info.device, err->pcie_info.function);
+		HISI_SNPRINTF(event->pcie_info, "%04x:%02x:%02x.%x",
+			      err->pcie_info.segment, err->pcie_info.bus,
+			      err->pcie_info.device, err->pcie_info.function);
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
+				   HISI_COMMON_FIELD_PCIE_INFO,
+				   0, event->pcie_info);
+	}
 
-	if (err->val_bits & BIT(HISI_COMMON_VALID_ERR_SEVERITY))
+	if (err->val_bits & BIT(HISI_COMMON_VALID_ERR_SEVERITY)) {
 		HISI_SNPRINTF(event->error_msg, "err_severity=%s", err_severity(err->err_severity));
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
+				   HISI_COMMON_FIELD_ERR_SEVERITY,
+				   0, err_severity(err->err_severity));
+	}
 
 	HISI_SNPRINTF(event->error_msg, "]");
 }
@@ -293,8 +377,6 @@ static int decode_hisi_common_section(struct ras_events *ras,
 		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 				   HISI_COMMON_FIELD_TIMESTAMP,
 				   0, event->timestamp);
-		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
-				   HISI_COMMON_FIELD_ERR_INFO, 0, hevent.error_msg);
 		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 				   HISI_COMMON_FIELD_REGS_DUMP, 0, hevent.reg_msg);
 		step_vendor_data_tab(ev_decoder, "hisi_common_section_tab");
-- 
2.25.1

