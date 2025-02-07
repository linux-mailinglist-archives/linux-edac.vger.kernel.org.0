Return-Path: <linux-edac+bounces-2975-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81622A2C56F
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 15:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A94118889D3
	for <lists+linux-edac@lfdr.de>; Fri,  7 Feb 2025 14:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C0D246336;
	Fri,  7 Feb 2025 14:31:01 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC1323ED5A;
	Fri,  7 Feb 2025 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938661; cv=none; b=qVulnyWRT3dWOzLjsdqDpP0ScK4/epYyXtccsrtYQfbjL9j1p3Uj/rYjN+8qXWam2ZRPSKxxTEkziLmMGeOo4D8g0yePj3Q3sCZn7OW08lI/sZIAmeGK27rgMaw0Y2mhF+SEKwygBpUc1WhyEsKp9zc6Anp8bqXgdQcoCWHoyiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938661; c=relaxed/simple;
	bh=C7JSQoQzYhI5wXqkE1GUE3HNs7V2oCGTnCERl6QP33M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHUaAYWFhBkRdJUNUBwCnkP/ENWxl9tIrz69TsQO0V6MCk2XLt8Q/XvLHiQ999SGFeTpvQHhcTRlkNAfSnEFUXccGQBFge0ueoAz7J6s7uhdoHplNDBtRcGVUusNLIjwTtxI0C94yU8Jjk6MtGfLSDomnAkSTALAnHAE5LEmiiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YqGZr2jXMz6HJZN;
	Fri,  7 Feb 2025 22:29:56 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id A5842140B55;
	Fri,  7 Feb 2025 22:30:57 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.5) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Feb 2025 15:30:56 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<bp@alien8.de>, <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 3/4] rasdaemon: cxl: Add storing memory repair needed info in the DRAM event record
Date: Fri, 7 Feb 2025 14:30:24 +0000
Message-ID: <20250207143028.1865-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250207143028.1865-1-shiju.jose@huawei.com>
References: <20250207143028.1865-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Rasdaemon supports live memory repair for the CXL DRAM errors reported,
with 'maintenance needed' flag set. However the kernel CXL driver rejects
the request for the live memory repair in the following situations.
1. Memory is online and the repair is disruptive.
2. Memory is online and event record does not match.
In addition, live memory repair is not requested if the auto repair option
is switched off for the rasdaemon.

In the above unrepaired cases, repair-needed information for CXL DRAM
events must be stored in the CXL DRAM event record of the SQLite database.
This allows a boot-up script to read repair status and repair attributes
in the next boot. If the memory has not been repaired, the script will
issue the memory repair operation requested by the memory device in the
previous boot. The kernel CXL driver sends a repair command to the device
if the memory to be repaired is offline.

This change adds a field for storing the memory repair needed info in the
CXL DRAM event record of the SQLite database and ensures that the repair
needed status is stored.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 9 ++++++---
 ras-record.c      | 2 ++
 ras-record.h      | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index ae49740..25ef5c9 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -1609,10 +1609,13 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
 	if (trace_seq_printf(s, "CVME Count:%u ", ev.cvme_count) <= 0)
 		return -1;
 
-	cxl_dram_sparing(&ev);
+	if (cxl_dram_sparing(&ev) < 0)
+		ev.repair_needed = true;
 
-	if (!(ev.dpa_flags & CXL_DPA_NOT_REPAIRABLE))
-		cxl_ppr(&ev.hdr, ev.dpa, ev.nibble_mask);
+	if (!(ev.dpa_flags & CXL_DPA_NOT_REPAIRABLE)) {
+		if (cxl_ppr(&ev.hdr, ev.dpa, ev.nibble_mask) < 0)
+			ev.repair_needed = true;
+	}
 
 	/* Insert data into the SGBD */
 #ifdef HAVE_SQLITE3
diff --git a/ras-record.c b/ras-record.c
index eed7aca..ed745f9 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -993,6 +993,7 @@ static const struct db_fields cxl_dram_event_fields[] = {
 	{ .name = "sub_channel",	.type = "INTEGER" },
 	{ .name = "cme_threshold_ev_flags",	.type = "INTEGER" },
 	{ .name = "cvme_count",		.type = "INTEGER" },
+	{ .name = "repair_needed",	.type = "INTEGER" },
 };
 
 static const struct db_table_descriptor cxl_dram_event_tab = {
@@ -1043,6 +1044,7 @@ int ras_store_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *
 	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++,
 			 ev->cme_threshold_ev_flags);
 	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->cvme_count);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->repair_needed);
 
 	rc = sqlite3_step(priv->stmt_cxl_dram_event);
 	if (rc != SQLITE_OK && rc != SQLITE_DONE)
diff --git a/ras-record.h b/ras-record.h
index 5eab62c..35edae1 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -238,6 +238,7 @@ struct ras_cxl_dram_event {
 	uint8_t res_id[CXL_PLDM_RES_ID_LEN];
 	uint8_t cme_threshold_ev_flags;
 	uint32_t cvme_count;
+	bool repair_needed;
 };
 
 struct ras_cxl_memory_module_event {
-- 
2.43.0


