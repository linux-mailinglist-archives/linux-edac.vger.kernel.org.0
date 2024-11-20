Return-Path: <linux-edac+bounces-2568-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE2D9D3812
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 11:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05F66B26391
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B641A073A;
	Wed, 20 Nov 2024 10:00:28 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3666419EEBD;
	Wed, 20 Nov 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096828; cv=none; b=KnR0JJGexBzq3jt8eFAH31XX8aua7Hh1sdGJhzHxnmxKgsR5Ex6D09z8eXEIPVj6TQl0KZyWhTuZiZwxpo+UYXrjR9/ZuUaoEu7P6Fwd8Uliw97sPbpa9TYSrnpzan91uhh+OaPeBXQ+TInRKISY/xjwvZscKYaL0rTmCJd/LrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096828; c=relaxed/simple;
	bh=NkWFOVxMosRl1G/2ptzkVO7oa4XwSHp5SLr4bZcOefU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uFPKt0n72oEpHLBK1wAYxVhnTSW9lm1UA+3mG6CgtRcuFWQ9kXPl+YAOF7PG7ZZ2Pv5Mm2Vz4oX9jmcNrJ3Tbt6QOtzXcCvuIpgoGuSb5rVTS8xFO+7upm6C9k60BG3wqT1jbcdzJHUh0Oeo0XUqLRBB32/uSZ7TA76c0Oi9dq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtcKr5Kywz6L7B4;
	Wed, 20 Nov 2024 18:00:00 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id ECC3F140B55;
	Wed, 20 Nov 2024 18:00:22 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:00:22 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 04/13] rasdaemon: cxl: Update common event to CXL spec rev 3.1
Date: Wed, 20 Nov 2024 09:59:14 +0000
Message-ID: <20241120095923.1891-5-shiju.jose@huawei.com>
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

CXL spec 3.1 section 8.2.9.2.1 Table 8-42, Common Event Record format has
updated with Maintenance Operation Subclass information.

Add updates in rasdaemon CXL event handler for the above spec change
and for the corresponding changes in kernel CXL common trace event
implementation.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 10 +++++++++-
 ras-record.c      |  5 +++++
 ras-record.h      |  1 +
 ras-report.c      |  6 ++++--
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index 7d4fc9f..d16eaef 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -575,18 +575,20 @@ int ras_cxl_overflow_event_handler(struct trace_seq *s,
 
 /*
  * Common Event Record Format
- * CXL 3.0 section 8.2.9.2.1; Table 8-42
+ * CXL 3.1 section 8.2.9.2.1; Table 8-43
  */
 #define CXL_EVENT_RECORD_FLAG_PERMANENT		BIT(2)
 #define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
 #define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
 #define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
+#define CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID	BIT(6)
 
 static const struct  cxl_event_flags cxl_hdr_flags[] = {
 	{ .bit = CXL_EVENT_RECORD_FLAG_PERMANENT, .flag = "PERMANENT_CONDITION" },
 	{ .bit = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED, .flag = "MAINTENANCE_NEEDED" },
 	{ .bit = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED, .flag = "PERFORMANCE_DEGRADED" },
 	{ .bit = CXL_EVENT_RECORD_FLAG_HW_REPLACE, .flag = "HARDWARE_REPLACEMENT_NEEDED" },
+	{ .bit = CXL_EVENT_RECORD_FLAG_MAINT_OP_SUB_CLASS_VALID, .flag = "MAINT_OP_SUB_CLASS_VALID" },
 };
 
 static int handle_ras_cxl_common_hdr(struct trace_seq *s,
@@ -670,6 +672,12 @@ static int handle_ras_cxl_common_hdr(struct trace_seq *s,
 	if (trace_seq_printf(s, "hdr_maint_op_class:%u ", hdr->hdr_maint_op_class) <= 0)
 		return -1;
 
+	if (tep_get_field_val(s,  event, "hdr_maint_op_sub_class", record, &val, 1) < 0)
+		return -1;
+	hdr->hdr_maint_op_sub_class = val;
+	if (trace_seq_printf(s, "hdr_maint_op_sub_class:%u ", hdr->hdr_maint_op_sub_class) <= 0)
+		return -1;
+
 	return 0;
 }
 
diff --git a/ras-record.c b/ras-record.c
index 9e68158..b52973f 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -797,6 +797,7 @@ static int ras_store_cxl_common_hdr(sqlite3_stmt *stmt, struct ras_cxl_event_com
 	sqlite3_bind_text(stmt, idx++, hdr->hdr_timestamp, -1, NULL);
 	sqlite3_bind_int(stmt, idx++, hdr->hdr_length);
 	sqlite3_bind_int(stmt, idx++, hdr->hdr_maint_op_class);
+	sqlite3_bind_int(stmt, idx++, hdr->hdr_maint_op_sub_class);
 
 	return idx;
 }
@@ -818,6 +819,7 @@ static const struct db_fields cxl_generic_event_fields[] = {
 	{ .name = "hdr_ts",		.type = "TEXT" },
 	{ .name = "hdr_length",		.type = "INTEGER" },
 	{ .name = "hdr_maint_op_class",	.type = "INTEGER" },
+	{ .name = "hdr_maint_op_sub_class",	.type = "INTEGER" },
 	{ .name = "data",		.type = "BLOB" },
 };
 
@@ -873,6 +875,7 @@ static const struct db_fields cxl_general_media_event_fields[] = {
 	{ .name = "hdr_ts",		.type = "TEXT" },
 	{ .name = "hdr_length",		.type = "INTEGER" },
 	{ .name = "hdr_maint_op_class",	.type = "INTEGER" },
+	{ .name = "hdr_maint_op_sub_class",	.type = "INTEGER" },
 	{ .name = "dpa",		.type = "INTEGER" },
 	{ .name = "dpa_flags",		.type = "INTEGER" },
 	{ .name = "descriptor",		.type = "INTEGER" },
@@ -952,6 +955,7 @@ static const struct db_fields cxl_dram_event_fields[] = {
 	{ .name = "hdr_ts",		.type = "TEXT" },
 	{ .name = "hdr_length",		.type = "INTEGER" },
 	{ .name = "hdr_maint_op_class",	.type = "INTEGER" },
+	{ .name = "hdr_maint_op_sub_class",	.type = "INTEGER" },
 	{ .name = "dpa",		.type = "INTEGER" },
 	{ .name = "dpa_flags",		.type = "INTEGER" },
 	{ .name = "descriptor",		.type = "INTEGER" },
@@ -1038,6 +1042,7 @@ static const struct db_fields cxl_memory_module_event_fields[] = {
 	{ .name = "hdr_ts",		.type = "TEXT" },
 	{ .name = "hdr_length",		.type = "INTEGER" },
 	{ .name = "hdr_maint_op_class",	.type = "INTEGER" },
+	{ .name = "hdr_maint_op_sub_class",	.type = "INTEGER" },
 	{ .name = "event_type",		.type = "INTEGER" },
 	{ .name = "health_status",	.type = "INTEGER" },
 	{ .name = "media_status",	.type = "INTEGER" },
diff --git a/ras-record.h b/ras-record.h
index cd549a1..2a0124a 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -179,6 +179,7 @@ struct ras_cxl_event_common_hdr {
 	char hdr_timestamp[64];
 	uint8_t hdr_length;
 	uint8_t hdr_maint_op_class;
+	uint8_t hdr_maint_op_sub_class;
 };
 
 struct ras_cxl_generic_event {
diff --git a/ras-report.c b/ras-report.c
index bc77d04..7e974b9 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -507,7 +507,8 @@ static int set_cxl_generic_event_backtrace(char *buf, struct ras_cxl_generic_eve
 		"hdr_related_handle=0x%x\n"
 		"hdr_timestamp=%s\n"
 		"hdr_length=%u\n"
-		"hdr_maint_op_class=%u\n",
+		"hdr_maint_op_class=%u\n"
+		"hdr_maint_op_sub_class=%u\n",
 		ev->hdr.timestamp,
 		ev->hdr.memdev,
 		ev->hdr.host,
@@ -519,7 +520,8 @@ static int set_cxl_generic_event_backtrace(char *buf, struct ras_cxl_generic_eve
 		ev->hdr.hdr_related_handle,
 		ev->hdr.hdr_timestamp,
 		ev->hdr.hdr_length,
-		ev->hdr.hdr_maint_op_class);
+		ev->hdr.hdr_maint_op_class,
+		ev->hdr.hdr_maint_op_sub_class);
 
 	return 0;
 }
-- 
2.43.0


