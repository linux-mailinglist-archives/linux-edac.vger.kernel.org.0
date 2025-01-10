Return-Path: <linux-edac+bounces-2869-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA90A09053
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 13:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFA9188E1E3
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2025 12:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F27A20FA88;
	Fri, 10 Jan 2025 12:27:11 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69120D4F6;
	Fri, 10 Jan 2025 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736512031; cv=none; b=TeKr35Zcg6LFa/8/onhA4O9zijAKfMgDpH//WTiNLkI9IhqkoA/UiWh90zWljEyi8n/TzSPtRmdxSB5MAi01UOQvBKmWfeVpPbVH0nXjXhAO+olZQyAl1fYSaPYsUpZ3CXE5BpWstaAVdzzvxFI5cMM7L8R0kcjq/LLvtxuGDDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736512031; c=relaxed/simple;
	bh=J5jZjiCLw6YiUisW2hJm3K3QwlO4Cr41/v694YG57KQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Evy2s5rvP7a+6o/gH3aK97CPJys5oaAjX1V9FrWAejTj3nY3WVYyBCeNBSkITKrl5Wf7m3cQDLS310Bd/4OgxQXBMGYD+qgNKAdnHAm2BOnVjPk5eGaZlF+6evyIPrziYrqS5PLyf5UAkGdjyaImuuUXBIgDC7npyiWiRi8I8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YV18c2lQmz67mJg;
	Fri, 10 Jan 2025 20:25:52 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C6401406AC;
	Fri, 10 Jan 2025 20:27:06 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.170.14) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 10 Jan 2025 13:27:05 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 09/14] rasdaemon: cxl: Update memory module event to CXL spec rev 3.1
Date: Fri, 10 Jan 2025 12:26:35 +0000
Message-ID: <20250110122641.1668-10-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250110122641.1668-1-shiju.jose@huawei.com>
References: <20250110122641.1668-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.2.1.3 Table 8-47, Memory Module Event Record
has updated with following new fields and new info for Device Event Type
and Device Health Information fields.
1. Validity Flags
2. Component Identifier
3. Device Event Sub-Type

Update the parsing, logging and recording of memory module event for the
above spec rev 3.1 changes.

Example rasdaemon log for CXL memory module event,

cxl_memory_module 2024-11-19 18:43:15 +0000 memdev:mem3 host:0000:0f:00.0 \
serial:0x3 log type:Fatal hdr_uuid:fe927475-dd59-4339-a586-79bab113b774 \
hdr_handle:0x2 hdr_related_handle:0x0 hdr_timestamp:1970-01-01 00:09:36 +0000 \
hdr_length:128 hdr_maint_op_class:0 hdr_maint_op_sub_class:1 \
event_type:Temperature Change event_sub_type:Unsupported Config Data \
health_status:'MAINTENANCE_NEEDED' 'REPLACEMENT_NEEDED' \
media_status:All Data Loss in Event of Power Loss as_life_used:Unknown \
as_dev_temp:Normal as_cor_vol_err_cnt:Normal as_cor_per_err_cnt:Normal \
life_used:8 device_temp:3 dirty_shutdown_cnt:33 cor_vol_err_cnt:25 \
cor_per_err_cnt:45 comp_id:02 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
comp_id_pldm_valid_flags:'Resource ID' Resource ID:fc d2 7e 2f

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 56 +++++++++++++++++++++++++++++++++++++++++++++--
 ras-record.c      | 11 ++++++++++
 ras-record.h      |  5 +++++
 ras-report.c      |  2 ++
 4 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index 3dd795e..cb95fa6 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -1247,7 +1247,7 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
 /*
  * Memory Module Event Record - MMER
  *
- * CXL res 3.0 section 8.2.9.2.1.3; Table 8-45
+ * CXL res 3.1 section 8.2.9.2.1.3; Table 8-47
  */
 static const char * const cxl_dev_evt_type[] = {
 	"Health Status Change",
@@ -1256,21 +1256,33 @@ static const char * const cxl_dev_evt_type[] = {
 	"Temperature Change",
 	"Data Path Error",
 	"LSA Error",
+	"Unrecoverable Internal Sideband Bus Error",
+	"Memory Media FRU Error",
+	"Power Management Fault",
+};
+
+static const char * const cxl_dev_evt_sub_type[] = {
+	"Not Reported",
+	"Invalid Config Data",
+	"Unsupported Config Data",
+	"Unsupported Memory Media FRU",
 };
 
 /*
  * Device Health Information - DHI
  *
- * CXL res 3.0 section 8.2.9.8.3.1; Table 8-100
+ * CXL res 3.1 section 8.2.9.9.3.1; Table 8-133
  */
 #define CXL_DHI_HS_MAINTENANCE_NEEDED				BIT(0)
 #define CXL_DHI_HS_PERFORMANCE_DEGRADED				BIT(1)
 #define CXL_DHI_HS_HW_REPLACEMENT_NEEDED			BIT(2)
+#define CXL_DHI_HS_MEM_CAPACITY_DEGRADED			BIT(3)
 
 static const struct cxl_event_flags cxl_health_status[] = {
 	{ .bit = CXL_DHI_HS_MAINTENANCE_NEEDED, .flag = "MAINTENANCE_NEEDED" },
 	{ .bit = CXL_DHI_HS_PERFORMANCE_DEGRADED, .flag = "PERFORMANCE_DEGRADED" },
 	{ .bit = CXL_DHI_HS_HW_REPLACEMENT_NEEDED, .flag = "REPLACEMENT_NEEDED" },
+	{ .bit = CXL_DHI_HS_MEM_CAPACITY_DEGRADED, .flag = "MEM_CAPACITY_DEGRADED" },
 };
 
 static const char * const cxl_media_status[] = {
@@ -1302,10 +1314,14 @@ static const char * const cxl_one_bit_status[] = {
 #define CXL_DHI_AS_COR_VOL_ERR_CNT(as)	(((as) & 0x10) >> 4)
 #define CXL_DHI_AS_COR_PER_ERR_CNT(as)	(((as) & 0x20) >> 5)
 
+#define CXL_MMER_VALID_COMPONENT_ID		BIT(0)
+#define CXL_MMER_VALID_COMPONENT_ID_FORMAT	BIT(1)
+
 int ras_cxl_memory_module_event_handler(struct trace_seq *s,
 					struct tep_record *record,
 					struct tep_event *event, void *context)
 {
+	int len, i, rc;
 	unsigned long long val;
 	struct ras_events *ras = context;
 	struct ras_cxl_memory_module_event ev;
@@ -1323,6 +1339,15 @@ int ras_cxl_memory_module_event_handler(struct trace_seq *s,
 					      ev.event_type)) <= 0)
 		return -1;
 
+	if (tep_get_field_val(s, event, "event_sub_type", record, &val, 1) < 0)
+		return -1;
+	ev.event_sub_type = val;
+	if (trace_seq_printf(s, "event_sub_type:%s ",
+			     get_cxl_type_str(cxl_dev_evt_sub_type,
+					      ARRAY_SIZE(cxl_dev_evt_sub_type),
+					      ev.event_sub_type)) <= 0)
+		return -1;
+
 	if (tep_get_field_val(s, event, "health_status", record, &val, 1) < 0)
 		return -1;
 	ev.health_status = val;
@@ -1395,6 +1420,33 @@ int ras_cxl_memory_module_event_handler(struct trace_seq *s,
 	if (trace_seq_printf(s, "cor_per_err_cnt:%u ", ev.cor_per_err_cnt) <= 0)
 		return -1;
 
+	if (tep_get_field_val(s,  event, "validity_flags", record, &val, 1) < 0)
+		return -1;
+	ev.validity_flags = val;
+
+	if (ev.validity_flags & CXL_MMER_VALID_COMPONENT_ID) {
+		ev.comp_id = tep_get_field_raw(s, event, "comp_id", record, &len, 1);
+		if (!ev.comp_id)
+			return -1;
+		if (trace_seq_printf(s, "comp_id:") <= 0)
+			return -1;
+		for (i = 0; i < CXL_EVENT_GEN_MED_COMP_ID_SIZE; i++) {
+			if (trace_seq_printf(s, "%02x ", ev.comp_id[i]) <= 0)
+				break;
+		}
+
+		if (ev.validity_flags & CXL_MMER_VALID_COMPONENT_ID_FORMAT) {
+			if (trace_seq_printf(s, "comp_id_pldm_valid_flags:") <= 0)
+				return -1;
+			if (decode_cxl_event_flags(s, ev.comp_id[0], cxl_pldm_comp_id_flags,
+						   ARRAY_SIZE(cxl_pldm_comp_id_flags)) < 0)
+				return -1;
+
+			rc = ras_cxl_print_component_id(s, ev.comp_id, ev.entity_id, ev.res_id);
+			if (rc)
+				return rc;
+		}
+	}
 	/* Insert data into the SGBD */
 #ifdef HAVE_SQLITE3
 	ras_store_cxl_memory_module_event(ras, &ev);
diff --git a/ras-record.c b/ras-record.c
index 9799d7e..eed7aca 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -1084,6 +1084,10 @@ static const struct db_fields cxl_memory_module_event_fields[] = {
 	{ .name = "cor_per_err_cnt",	.type = "INTEGER" },
 	{ .name = "device_temp",	.type = "INTEGER" },
 	{ .name = "add_status",		.type = "INTEGER" },
+	{ .name = "event_sub_type",	.type = "INTEGER" },
+	{ .name = "comp_id",		.type = "BLOB" },
+	{ .name = "pldm_entity_id",	.type = "BLOB" },
+	{ .name = "pldm_resource_id",	.type = "BLOB" },
 };
 
 static const struct db_table_descriptor cxl_memory_module_event_tab = {
@@ -1116,6 +1120,13 @@ int ras_store_cxl_memory_module_event(struct ras_events *ras,
 	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev->cor_per_err_cnt);
 	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev->device_temp);
 	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev->add_status);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev->event_sub_type);
+	sqlite3_bind_blob(priv->stmt_cxl_memory_module_event, idx++, ev->comp_id,
+			  CXL_EVENT_GEN_MED_COMP_ID_SIZE, NULL);
+	sqlite3_bind_blob(priv->stmt_cxl_memory_module_event, idx++, ev->entity_id,
+			  CXL_PLDM_ENTITY_ID_LEN, NULL);
+	sqlite3_bind_blob(priv->stmt_cxl_memory_module_event, idx++, ev->res_id,
+			  CXL_PLDM_RES_ID_LEN, NULL);
 
 	rc = sqlite3_step(priv->stmt_cxl_memory_module_event);
 	if (rc != SQLITE_OK && rc != SQLITE_DONE)
diff --git a/ras-record.h b/ras-record.h
index 3aec063..5eab62c 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -243,6 +243,7 @@ struct ras_cxl_dram_event {
 struct ras_cxl_memory_module_event {
 	struct ras_cxl_event_common_hdr hdr;
 	uint8_t event_type;
+	uint8_t event_sub_type;
 	uint8_t health_status;
 	uint8_t media_status;
 	uint8_t life_used;
@@ -251,6 +252,10 @@ struct ras_cxl_memory_module_event {
 	uint32_t cor_per_err_cnt;
 	int16_t device_temp;
 	uint8_t add_status;
+	uint16_t validity_flags;
+	uint8_t *comp_id;
+	uint8_t entity_id[CXL_PLDM_ENTITY_ID_LEN];
+	uint8_t res_id[CXL_PLDM_RES_ID_LEN];
 };
 
 struct ras_mc_event;
diff --git a/ras-report.c b/ras-report.c
index 8e343fc..4535421 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -700,6 +700,7 @@ static int set_cxl_memory_module_event_backtrace(char *buf, struct ras_cxl_memor
 		"hdr_length=%u\n"
 		"hdr_maint_op_class=%u\n"
 		"event_type=%u\n"
+		"event_sub_type=0x%x\n"
 		"health_status=%u\n"
 		"media_status=%u\n"
 		"life_used=%u\n"
@@ -721,6 +722,7 @@ static int set_cxl_memory_module_event_backtrace(char *buf, struct ras_cxl_memor
 		ev->hdr.hdr_length,
 		ev->hdr.hdr_maint_op_class,
 		ev->event_type,
+		ev->event_sub_type,
 		ev->health_status,
 		ev->media_status,
 		ev->life_used,
-- 
2.43.0


