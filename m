Return-Path: <linux-edac+bounces-2570-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C28D9D37C6
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 11:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56E81F2315E
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 10:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FF61A0BE3;
	Wed, 20 Nov 2024 10:00:29 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EFB1A0711;
	Wed, 20 Nov 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096829; cv=none; b=q823LEKaQG67ciaX3UKKeislQbOea9yNGbq2MCMQji3HRs528iSppANjV6Dt8EMehsZsDTU40g3PEDq47+RYbikrQ07+NXnwSUVQuxtBw9yHb1/dBoa5eQRvH1gppegnNnzKI/vgn4fSDy+bc65ZXa81s37jv1ZwdI9ZDRE9uNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096829; c=relaxed/simple;
	bh=VpEIoevUndmR+SawF19/VvgHmd1CpKGjViQokrKuU6k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDmoAE5KBcZUFt/p9APzOWlsCrPFMDgp7hJ4y2IxchSufxx4VV9uo2fHv9bDiGGV3OoTZU7s1kTkMphYRUXLMYRCkTcJy6qUh/axyP3isXKSJIEDNxRxL3WJFbV4RZiaAwWpL8kJt5r6DKloAy4c8uCsHGXEJdGrcZCg+j3GA6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtcGG3N03z6J6X0;
	Wed, 20 Nov 2024 17:56:54 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 46E49140F39;
	Wed, 20 Nov 2024 18:00:25 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:00:24 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 06/13] rasdaemon: cxl: Update CXL general media event to CXL spec rev 3.1
Date: Wed, 20 Nov 2024 09:59:16 +0000
Message-ID: <20241120095923.1891-7-shiju.jose@huawei.com>
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

CXL spec rev 3.1 section 8.2.9.2.1.1 Table 8-45, General Media Event
Record has updated with following new fields and new types for Memory
Event Type and Transaction Type fields.
1. Advanced Programmable Corrected Memory Error Threshold Event Flags
2. Corrected Memory Error Count at Event
3. Memory Event Sub-Type

The format of component identifier has changed (CXL spec 3.1 section
8.2.9.2.1 Table 8-44).

Update the parsing, logging and recording of general media event for
the above spec changes.

Example rasdaemon log for CXL general media event,

cxl_general_media 2024-11-20 00:00:49 +0000 memdev:mem1 host:0000:0f:00.0 \
serial:0x3 log type:Fatal hdr_uuid:fbcd0a77-c260-417f-85a9-088b1621eba6 \
hdr_handle:0x1 hdr_related_handle:0x0 hdr_timestamp:1970-01-01 00:00:49 +0000 \
hdr_length:128 hdr_maint_op_class:2 hdr_maint_op_sub_class:4 dpa:0x30d40 \
dpa_flags:descriptor:'UNCORRECTABLE EVENT' 'THRESHOLD EVENT' 'POISON LIST OVERFLOW' \
memory_event_type:TE State Violation memory_event_sub_type:Media Link Command \
Training Error transaction_type:Host Inject Poison hpa:0xffffffffffffffff \
region: region_uuid:00000000-0000-0000-0000-000000000000 channel:3 rank:33 \
device:5 comp_id:03 74 c5 08 9a 1a 0b fc d2 7e 2f 31 9b 3c 81 4d \
comp_id_pldm_valid_flags:'PLDM Entity ID' 'Resource ID' \
PLDM Entity ID:74 c5 08 9a 1a 0b Resource ID:fc d2 7e 2f \
Advanced Programmable CME threshold Event Flags:'Corrected Memory Errors in \
Multiple Media Components' 'Exceeded Programmable Threshold' \
Corrected Memory Error Count:0x78

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 73 +++++++++++++++++++++++++++++++++++++++++++++--
 ras-record.c      | 13 +++++++++
 ras-record.h      |  5 ++++
 ras-report.c      | 10 +++++--
 4 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index 80afa9f..c64c540 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -772,9 +772,32 @@ static const struct cxl_event_flags cxl_dpa_flags[] = {
 	{ .bit = CXL_DPA_NOT_REPAIRABLE, .flag = "NOT_REPAIRABLE" },
 };
 
+/* CXL rev 3.1 Section 8.2.9.2.1.1; Table 8-45 */
+static const char * const cxl_mem_event_sub_type[] = {
+	"Not Reported",
+	"Internal Datapath Error",
+	"Media Link Command Training Error",
+	"Media Link Control Training Error",
+	"Media Link Data Training Error",
+	"Media Link CRC Error",
+};
+
+#define CXL_CME_EV_FLAG_CME_MULTIPLE_MEDIA	BIT(0)
+#define CXL_CME_EV_FLAG_THRESHOLD_EXCEEDED	BIT(1)
+static const struct cxl_event_flags cxl_cme_threshold_ev_flags[] = {
+	{
+		.bit = CXL_CME_EV_FLAG_CME_MULTIPLE_MEDIA,
+		.flag = "Corrected Memory Errors in Multiple Media Components"
+	},
+	{
+		.bit = CXL_CME_EV_FLAG_THRESHOLD_EXCEEDED,
+		.flag = "Exceeded Programmable Threshold"
+	},
+};
+
 /*
  * General Media Event Record - GMER
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ * CXL rev 3.1 Section 8.2.9.2.1.1; Table 8-45
  */
 #define CXL_GMER_EVT_DESC_UNCORRECTABLE_EVENT		BIT(0)
 #define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
@@ -790,11 +813,16 @@ static const struct cxl_event_flags cxl_gmer_event_desc_flags[] = {
 #define CXL_GMER_VALID_RANK			BIT(1)
 #define CXL_GMER_VALID_DEVICE			BIT(2)
 #define CXL_GMER_VALID_COMPONENT		BIT(3)
+#define CXL_GMER_VALID_COMPONENT_ID_FORMAT	BIT(4)
 
 static const char * const cxl_gmer_mem_event_type[] = {
 	"ECC Error",
 	"Invalid Address",
 	"Data Path Error",
+	"TE State Violation",
+	"Scrub Media ECC Error",
+	"Advanced Programmable CME Counter Expiration",
+	"CKID Violation",
 };
 
 static const char * const cxl_gmer_trans_type[] = {
@@ -805,13 +833,15 @@ static const char * const cxl_gmer_trans_type[] = {
 	"Host Inject Poison",
 	"Internal Media Scrub",
 	"Internal Media Management",
+	"Internal Media Error Check Scrub",
+	"Media Initialization",
 };
 
 int ras_cxl_general_media_event_handler(struct trace_seq *s,
 					struct tep_record *record,
 					struct tep_event *event, void *context)
 {
-	int len, i;
+	int len, i, rc;
 	unsigned long long val;
 	struct ras_events *ras = context;
 	struct ras_cxl_general_media_event ev;
@@ -846,11 +876,20 @@ int ras_cxl_general_media_event_handler(struct trace_seq *s,
 	if (tep_get_field_val(s,  event, "type", record, &val, 1) < 0)
 		return -1;
 	ev.type = val;
-	if (trace_seq_printf(s, "type:%s ",
+	if (trace_seq_printf(s, "memory_event_type:%s ",
 			     get_cxl_type_str(cxl_gmer_mem_event_type,
 					      ARRAY_SIZE(cxl_gmer_mem_event_type), ev.type)) <= 0)
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
@@ -918,8 +957,36 @@ int ras_cxl_general_media_event_handler(struct trace_seq *s,
 			if (trace_seq_printf(s, "%02x ", ev.comp_id[i]) <= 0)
 				break;
 		}
+
+		if (ev.validity_flags & CXL_GMER_VALID_COMPONENT_ID_FORMAT) {
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
 	}
 
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
+	if (tep_get_field_val(s,  event, "cme_count", record, &val, 1) < 0)
+		return -1;
+	ev.cme_count = val;
+	if (trace_seq_printf(s, "Corrected Memory Error Count:0x%x ", ev.cme_count) <= 0)
+		return -1;
+
 	/* Insert data into the SGBD */
 #ifdef HAVE_SQLITE3
 	ras_store_cxl_general_media_event(ras, &ev);
diff --git a/ras-record.c b/ras-record.c
index b52973f..e24562e 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -888,6 +888,11 @@ static const struct db_fields cxl_general_media_event_fields[] = {
 	{ .name = "hpa",		.type = "INTEGER" },
 	{ .name = "region",		.type = "TEXT" },
 	{ .name = "region_uuid",	.type = "TEXT" },
+	{ .name = "pldm_entity_id",	.type = "BLOB" },
+	{ .name = "pldm_resource_id",	.type = "BLOB" },
+	{ .name = "sub_type",		.type = "INTEGER" },
+	{ .name = "cme_threshold_ev_flags",	.type = "INTEGER" },
+	{ .name = "cme_count",		.type = "INTEGER" },
 };
 
 static const struct db_table_descriptor cxl_general_media_event_tab = {
@@ -924,6 +929,14 @@ int ras_store_cxl_general_media_event(struct ras_events *ras,
 	sqlite3_bind_int64(priv->stmt_cxl_general_media_event, idx++, ev->hpa);
 	sqlite3_bind_text(priv->stmt_cxl_general_media_event, idx++, ev->region, -1, NULL);
 	sqlite3_bind_text(priv->stmt_cxl_general_media_event, idx++, ev->region_uuid, -1, NULL);
+	sqlite3_bind_blob(priv->stmt_cxl_general_media_event, idx++, ev->entity_id,
+			  CXL_PLDM_ENTITY_ID_LEN, NULL);
+	sqlite3_bind_blob(priv->stmt_cxl_general_media_event, idx++, ev->res_id,
+			  CXL_PLDM_RES_ID_LEN, NULL);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev->sub_type);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++,
+			 ev->cme_threshold_ev_flags);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev->cme_count);
 
 	rc = sqlite3_step(priv->stmt_cxl_general_media_event);
 	if (rc != SQLITE_OK && rc != SQLITE_DONE)
diff --git a/ras-record.h b/ras-record.h
index a3a88eb..12e693b 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -196,15 +196,20 @@ struct ras_cxl_general_media_event {
 	uint8_t dpa_flags;
 	uint8_t descriptor;
 	uint8_t type;
+	uint8_t sub_type;
 	uint8_t transaction_type;
 	uint8_t channel;
 	uint8_t rank;
 	uint32_t device;
 	uint8_t *comp_id;
+	uint8_t entity_id[CXL_PLDM_ENTITY_ID_LEN];
+	uint8_t res_id[CXL_PLDM_RES_ID_LEN];
 	uint16_t validity_flags;
 	uint64_t hpa;
 	const char *region;
 	const char *region_uuid;
+	uint8_t cme_threshold_ev_flags;
+	uint32_t cme_count;
 };
 
 struct ras_cxl_dram_event {
diff --git a/ras-report.c b/ras-report.c
index 7e974b9..ed1f4b8 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -555,13 +555,16 @@ static int set_cxl_general_media_event_backtrace(char *buf, struct ras_cxl_gener
 		"dpa_flags=%u\n"
 		"descriptor=%u\n"
 		"type=%u\n"
+		"sub_type=0x%x\n"
 		"transaction_type=%u\n"
 		"hpa=0x%lx\n"
 		"region=%s\n"
 		"region_uuid=%s\n"
 		"channel=%u\n"
 		"rank=%u\n"
-		"device=0x%x\n",
+		"device=0x%x\n"
+		"cme_threshold_ev_flags=0x%x\n"
+		"cme_count=0x%x\n",
 		ev->hdr.timestamp,
 		ev->hdr.memdev,
 		ev->hdr.host,
@@ -578,13 +581,16 @@ static int set_cxl_general_media_event_backtrace(char *buf, struct ras_cxl_gener
 		ev->dpa_flags,
 		ev->descriptor,
 		ev->type,
+		ev->sub_type,
 		ev->transaction_type,
 		ev->hpa,
 		ev->region,
 		ev->region_uuid,
 		ev->channel,
 		ev->rank,
-		ev->device);
+		ev->device,
+		ev->cme_threshold_ev_flags,
+		ev->cme_count);
 
 	return 0;
 }
-- 
2.43.0


