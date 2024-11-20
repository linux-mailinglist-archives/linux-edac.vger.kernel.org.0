Return-Path: <linux-edac+bounces-2571-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AE89D37C7
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 11:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DDA1F23AE0
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 10:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD7C1A257C;
	Wed, 20 Nov 2024 10:00:30 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A311A0734;
	Wed, 20 Nov 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096830; cv=none; b=bWqo+NeZ3Oe65DSDQT9hxD2c6g8ENhJaofWa0EZEOm6EM3mQ7xe9hQKzvXlI5gO69obEgjEMnWjUghI51rmR3ZW1MoxTuekuzS61clEpr+LUJP+NEmp6yNAklZP04VOVsk+r+ryxMavIC7mWE6mddOi5PCWlzzO6B+JO0p/HG/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096830; c=relaxed/simple;
	bh=Jrqt4mVKGsicxRtMUqib57UOqRZD/I/8bhFcq1jVmNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTbZrQ+IaGxjLBRCSId+hIPFo+qA/E5D3JTeD2Hni0svSyzd9pqkIfzSxGLU/aEBrW5BCFKKEf3TZSucJU2pYJKso8SqyzUMX12Qu37h1qC8APSPu2AVDbYRGJdXl9O58j3mQHB6rw+HAdKdibx5sEFP9MeWL+0gw2lBJyL7KrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtcGH4L97z6J6Zc;
	Wed, 20 Nov 2024 17:56:55 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 6917F140D1A;
	Wed, 20 Nov 2024 18:00:26 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:00:25 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 07/13] rasdaemon: cxl: Update CXL DRAM event to CXL spec rev 3.1
Date: Wed, 20 Nov 2024 09:59:17 +0000
Message-ID: <20241120095923.1891-8-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20241120095923.1891-1-shiju.jose@huawei.com>
References: <20241120095923.1891-1-shiju.jose@huawei.com>
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

CXL spec 3.1 section 8.2.9.2.1.2 Table 8-46, DRAM Event Record has updated
with following new fields and new types for Memory Event Type, Transaction
Type and Validity Flags fields.
1. Component Identifier
2. Sub-channel
3. Advanced Programmable Corrected Memory Error Threshold Event Flags
4. Corrected Memory Error Count at Event
5. Memory Event Sub-Type

Update the parsing, logging and recording of DRAM event for the above
spec rev 3.1 changes.

Example rasdaemon log for CXL DRAM event,

cxl_dram 2024-11-20 00:18:53 +0000 memdev:mem0 host:0000:0f:00.0 serial:0x3 \
log type:Informational hdr_uuid:601dcbb3-9c06-4eab-b8af-4e9bfb5c9624 \
hdr_handle:0x1 hdr_related_handle:0x0 hdr_timestamp:1970-01-01 00:00:58 +0000 \
hdr_length:128 hdr_maint_op_class:1 hdr_maint_op_sub_class:3 dpa:0x18680 \
dpa_flags:descriptor:'UNCORRECTABLE EVENT' 'THRESHOLD EVENT' \
memory_event_type:Data Path Error memory_event_sub_type:Media Link CRC Error \
transaction_type:Internal Media Scrub hpa:0xffffffffffffffff region: \
region_uuid:00000000-0000-0000-0000-000000000000 channel:3 rank:17 \
nibble_mask:3866802 bank_group:7 bank:11 row:2 column:77
correction_mask:21 00 00 00 00 00 00 00 2c 00 00 00 00 00 00 00 37 00 00 \
00 00 00 00 00 42 00 00 00 00 00 00 00 comp_id:01 74 c5 08 9a 1a 0b fc d2 \
7e 2f 31 9b 3c 81 4d comp_id_pldm_valid_flags:'PLDM Entity ID' \
PLDM Entity ID:74 c5 08 9a 1a 0b \
Advanced Programmable CME threshold Event Flags:'Corrected Memory Errors \
in Multiple Media Components' 'Exceeded Programmable Threshold' \
CVME Count:0x94

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 67 +++++++++++++++++++++++++++++++++++++++++++++--
 ras-record.c      | 18 +++++++++++++
 ras-record.h      |  7 +++++
 ras-report.c      | 12 +++++++--
 4 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index c64c540..c028203 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -1003,7 +1003,7 @@ int ras_cxl_general_media_event_handler(struct trace_seq *s,
 /*
  * DRAM Event Record - DER
  *
- * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ * CXL rev 3.1 section 8.2.9.2.1.2; Table 8-46
  */
 #define CXL_DER_VALID_CHANNEL			BIT(0)
 #define CXL_DER_VALID_RANK			BIT(1)
@@ -1013,19 +1013,25 @@ int ras_cxl_general_media_event_handler(struct trace_seq *s,
 #define CXL_DER_VALID_ROW			BIT(5)
 #define CXL_DER_VALID_COLUMN			BIT(6)
 #define CXL_DER_VALID_CORRECTION_MASK		BIT(7)
+#define CXL_DER_VALID_COMPONENT_ID		BIT(8)
+#define CXL_DER_VALID_COMPONENT_ID_FORMAT	BIT(9)
+#define CXL_DER_VALID_SUB_CHANNEL		BIT(10)
 
 static const char * const cxl_der_mem_event_type[] = {
 	"Media ECC Error",
 	"Scrub Media ECC Error",
 	"Invalid Address",
 	"Data Path Error",
+	"TE State Violation",
+	"Advanced Programmable CME Counter Expiration",
+	"CKID Violation",
 };
 
 int ras_cxl_dram_event_handler(struct trace_seq *s,
 			       struct tep_record *record,
 			       struct tep_event *event, void *context)
 {
-	int len, i;
+	int len, i, rc;
 	unsigned long long val;
 	struct ras_events *ras = context;
 	struct ras_cxl_dram_event ev;
@@ -1067,6 +1073,15 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
 					      ev.type)) <= 0)
 		return -1;
 
+	if (tep_get_field_val(s,  event, "sub_type", record, &val, 1) < 0)
+		return -1;
+	ev.sub_type = val;
+	if (trace_seq_printf(s, "memory_event_sub_type:%s ",
+			     get_cxl_type_str(cxl_mem_event_sub_type,
+					      ARRAY_SIZE(cxl_mem_event_sub_type),
+					      ev.sub_type)) <= 0)
+		return -1;
+
 	if (tep_get_field_val(s,  event, "transaction_type", record, &val, 1) < 0)
 		return -1;
 	ev.transaction_type = val;
@@ -1108,6 +1123,14 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
 			return -1;
 	}
 
+	if (ev.validity_flags & CXL_DER_VALID_SUB_CHANNEL) {
+		if (tep_get_field_val(s,  event, "sub_channel", record, &val, 1) < 0)
+			return -1;
+		ev.sub_channel = val;
+		if (trace_seq_printf(s, "sub_channel:%u ", ev.sub_channel) <= 0)
+			return -1;
+	}
+
 	if (ev.validity_flags & CXL_DER_VALID_RANK) {
 		if (tep_get_field_val(s,  event, "rank", record, &val, 1) < 0)
 			return -1;
@@ -1168,6 +1191,46 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
 		}
 	}
 
+	if (ev.validity_flags & CXL_DER_VALID_COMPONENT_ID) {
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
+		if (ev.validity_flags & CXL_DER_VALID_COMPONENT_ID_FORMAT) {
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
+
+	if (tep_get_field_val(s,  event, "cme_threshold_ev_flags", record, &val, 1) < 0)
+		return -1;
+	ev.cme_threshold_ev_flags = val;
+	if (trace_seq_printf(s, "Advanced Programmable CME threshold Event Flags:") <= 0)
+		return -1;
+	if (decode_cxl_event_flags(s, ev.cme_threshold_ev_flags,
+				   cxl_cme_threshold_ev_flags,
+				   ARRAY_SIZE(cxl_cme_threshold_ev_flags)) < 0)
+		return -1;
+
+	if (tep_get_field_val(s,  event, "cvme_count", record, &val, 1) < 0)
+		return -1;
+	ev.cvme_count = val;
+	if (trace_seq_printf(s, "CVME Count:0x%x ", ev.cvme_count) <= 0)
+		return -1;
+
 	/* Insert data into the SGBD */
 #ifdef HAVE_SQLITE3
 	ras_store_cxl_dram_event(ras, &ev);
diff --git a/ras-record.c b/ras-record.c
index e24562e..82939e7 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -985,6 +985,13 @@ static const struct db_fields cxl_dram_event_fields[] = {
 	{ .name = "hpa",		.type = "INTEGER" },
 	{ .name = "region",		.type = "TEXT" },
 	{ .name = "region_uuid",	.type = "TEXT" },
+	{ .name = "comp_id",		.type = "BLOB" },
+	{ .name = "pldm_entity_id",	.type = "BLOB" },
+	{ .name = "pldm_resource_id",	.type = "BLOB" },
+	{ .name = "sub_type",		.type = "INTEGER" },
+	{ .name = "sub_channel",	.type = "INTEGER" },
+	{ .name = "cme_threshold_ev_flags",	.type = "INTEGER" },
+	{ .name = "cvme_count",		.type = "INTEGER" },
 };
 
 static const struct db_table_descriptor cxl_dram_event_tab = {
@@ -1024,6 +1031,17 @@ int ras_store_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *
 	sqlite3_bind_int64(priv->stmt_cxl_dram_event, idx++, ev->hpa);
 	sqlite3_bind_text(priv->stmt_cxl_dram_event, idx++, ev->region, -1, NULL);
 	sqlite3_bind_text(priv->stmt_cxl_dram_event, idx++, ev->region_uuid, -1, NULL);
+	sqlite3_bind_blob(priv->stmt_cxl_dram_event, idx++, ev->comp_id,
+			  CXL_EVENT_GEN_MED_COMP_ID_SIZE, NULL);
+	sqlite3_bind_blob(priv->stmt_cxl_dram_event, idx++, ev->entity_id,
+			  CXL_PLDM_ENTITY_ID_LEN, NULL);
+	sqlite3_bind_blob(priv->stmt_cxl_dram_event, idx++, ev->res_id,
+			  CXL_PLDM_RES_ID_LEN, NULL);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->sub_type);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->sub_channel);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++,
+			 ev->cme_threshold_ev_flags);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->cvme_count);
 
 	rc = sqlite3_step(priv->stmt_cxl_dram_event);
 	if (rc != SQLITE_OK && rc != SQLITE_DONE)
diff --git a/ras-record.h b/ras-record.h
index 12e693b..3aec063 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -218,8 +218,10 @@ struct ras_cxl_dram_event {
 	uint8_t dpa_flags;
 	uint8_t descriptor;
 	uint8_t type;
+	uint8_t sub_type;
 	uint8_t transaction_type;
 	uint8_t channel;
+	uint8_t sub_channel;
 	uint8_t rank;
 	uint32_t nibble_mask;
 	uint8_t bank_group;
@@ -231,6 +233,11 @@ struct ras_cxl_dram_event {
 	uint64_t hpa;
 	const char *region;
 	const char *region_uuid;
+	uint8_t *comp_id;
+	uint8_t entity_id[CXL_PLDM_ENTITY_ID_LEN];
+	uint8_t res_id[CXL_PLDM_RES_ID_LEN];
+	uint8_t cme_threshold_ev_flags;
+	uint32_t cvme_count;
 };
 
 struct ras_cxl_memory_module_event {
diff --git a/ras-report.c b/ras-report.c
index ed1f4b8..8e343fc 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -624,17 +624,21 @@ static int set_cxl_dram_event_backtrace(char *buf, struct ras_cxl_dram_event *ev
 		"dpa_flags=%u\n"
 		"descriptor=%u\n"
 		"type=%u\n"
+		"sub_type=0x%x\n"
 		"transaction_type=%u\n"
 		"hpa=0x%lx\n"
 		"region=%s\n"
 		"region_uuid=%s\n"
 		"channel=%u\n"
+		"sub_channel=%u\n"
 		"rank=%u\n"
 		"nibble_mask=%u\n"
 		"bank_group=%u\n"
 		"bank=%u\n"
 		"row=%u\n"
-		"column=%u\n",
+		"column=%u\n"
+		"cme_threshold_ev_flags=0x%x\n"
+		"cvme_count=0x%x\n",
 		ev->hdr.timestamp,
 		ev->hdr.memdev,
 		ev->hdr.host,
@@ -651,17 +655,21 @@ static int set_cxl_dram_event_backtrace(char *buf, struct ras_cxl_dram_event *ev
 		ev->dpa_flags,
 		ev->descriptor,
 		ev->type,
+		ev->sub_type,
 		ev->transaction_type,
 		ev->hpa,
 		ev->region,
 		ev->region_uuid,
 		ev->channel,
+		ev->sub_channel,
 		ev->rank,
 		ev->nibble_mask,
 		ev->bank_group,
 		ev->bank,
 		ev->row,
-		ev->column);
+		ev->column,
+		ev->cme_threshold_ev_flags,
+		ev->cvme_count);
 
 	return 0;
 }
-- 
2.43.0


