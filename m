Return-Path: <linux-edac+bounces-2567-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3C59D3803
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 11:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3611B28BDF
	for <lists+linux-edac@lfdr.de>; Wed, 20 Nov 2024 10:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38CD1A00D6;
	Wed, 20 Nov 2024 10:00:26 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355B019D093;
	Wed, 20 Nov 2024 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096826; cv=none; b=V+gBQlGh7y9K/hdg29X4IK+22RuSJ1NXak2yO3BqZHxZDmWxD7H7ucpLNMhNA2b8iYChU4aqdxP3zCEkDYS4uc3/Kgi97frZ3LjVzlKP+cr1Idl73MBFDr0OtQcb4UlPhuHjNHDrDzRLrqRzg1C/7hzLvz13XgeXL6HxSHaor4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096826; c=relaxed/simple;
	bh=cancZSBNdg1EKba9CAg9GIjiqN5z5S/v/dGY3fvMpsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/KtG7RBKlbpeZG6salroVKsN8YvBmMaY1unO8C3325StGfuHQT8+A3gpEcz9C+TRcVajghodT1wKQhg/F+PNZcz2pymONO/MTbWcOJPfWrVs0DaLD2ReErMtcqUu7NX2SGya90yECs6q1VCWmRwHYLZvsl7SjMLsbtI91aGkic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XtcKq3zc9z6L76Y;
	Wed, 20 Nov 2024 17:59:59 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id BE814140F39;
	Wed, 20 Nov 2024 18:00:21 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.247.212) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 20 Nov 2024 11:00:20 +0100
From: <shiju.jose@huawei.com>
To: <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<mchehab@kernel.org>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<nifan.cxl@gmail.com>, <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dave@stgolabs.net>
CC: <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 03/13] rasdaemon: cxl: Add automatic indexing for storing CXL fields in SQLite database
Date: Wed, 20 Nov 2024 09:59:13 +0000
Message-ID: <20241120095923.1891-4-shiju.jose@huawei.com>
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

When the CXL specification adds new fields to the common header of
CXL event records, manual updates to the indexing are required to
store these CXL fields in the SQLite database. This update introduces
automatic indexing to facilitate the storage of CXL fields in the
SQLite database, eliminating the need for manual update to indexing.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-record.c | 134 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 74 insertions(+), 60 deletions(-)

diff --git a/ras-record.c b/ras-record.c
index b4a1abd..9e68158 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -780,23 +780,25 @@ int ras_store_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow
 
 static int ras_store_cxl_common_hdr(sqlite3_stmt *stmt, struct ras_cxl_event_common_hdr *hdr)
 {
+	int idx = 1;
+
 	if (!stmt || !hdr)
 		return 0;
 
-	sqlite3_bind_text(stmt, 1, hdr->timestamp, -1, NULL);
-	sqlite3_bind_text(stmt, 2, hdr->memdev, -1, NULL);
-	sqlite3_bind_text(stmt, 3, hdr->host, -1, NULL);
-	sqlite3_bind_int64(stmt, 4, hdr->serial);
-	sqlite3_bind_text(stmt, 5, hdr->log_type, -1, NULL);
-	sqlite3_bind_text(stmt, 6, hdr->hdr_uuid, -1, NULL);
-	sqlite3_bind_int(stmt, 7, hdr->hdr_flags);
-	sqlite3_bind_int(stmt, 8, hdr->hdr_handle);
-	sqlite3_bind_int(stmt, 9, hdr->hdr_related_handle);
-	sqlite3_bind_text(stmt, 10, hdr->hdr_timestamp, -1, NULL);
-	sqlite3_bind_int(stmt, 11, hdr->hdr_length);
-	sqlite3_bind_int(stmt, 12, hdr->hdr_maint_op_class);
-
-	return 0;
+	sqlite3_bind_text(stmt, idx++, hdr->timestamp, -1, NULL);
+	sqlite3_bind_text(stmt, idx++, hdr->memdev, -1, NULL);
+	sqlite3_bind_text(stmt, idx++, hdr->host, -1, NULL);
+	sqlite3_bind_int64(stmt, idx++, hdr->serial);
+	sqlite3_bind_text(stmt, idx++, hdr->log_type, -1, NULL);
+	sqlite3_bind_text(stmt, idx++, hdr->hdr_uuid, -1, NULL);
+	sqlite3_bind_int(stmt, idx++, hdr->hdr_flags);
+	sqlite3_bind_int(stmt, idx++, hdr->hdr_handle);
+	sqlite3_bind_int(stmt, idx++, hdr->hdr_related_handle);
+	sqlite3_bind_text(stmt, idx++, hdr->hdr_timestamp, -1, NULL);
+	sqlite3_bind_int(stmt, idx++, hdr->hdr_length);
+	sqlite3_bind_int(stmt, idx++, hdr->hdr_maint_op_class);
+
+	return idx;
 }
 
 /*
@@ -827,15 +829,18 @@ static const struct db_table_descriptor cxl_generic_event_tab = {
 
 int ras_store_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev)
 {
-	int rc;
+	int rc, idx;
 	struct sqlite3_priv *priv = ras->db_priv;
 
 	if (!priv || !priv->stmt_cxl_generic_event)
 		return 0;
 	log(TERM, LOG_INFO, "cxl_generic_event store: %p\n", priv->stmt_cxl_generic_event);
 
-	ras_store_cxl_common_hdr(priv->stmt_cxl_generic_event, &ev->hdr);
-	sqlite3_bind_blob(priv->stmt_cxl_generic_event, 13, ev->data,
+	idx = ras_store_cxl_common_hdr(priv->stmt_cxl_generic_event, &ev->hdr);
+	if (!idx)
+		return 0;
+
+	sqlite3_bind_blob(priv->stmt_cxl_generic_event, idx++, ev->data,
 			  CXL_EVENT_RECORD_DATA_LENGTH, NULL);
 
 	rc = sqlite3_step(priv->stmt_cxl_generic_event);
@@ -891,7 +896,7 @@ static const struct db_table_descriptor cxl_general_media_event_tab = {
 int ras_store_cxl_general_media_event(struct ras_events *ras,
 				      struct ras_cxl_general_media_event *ev)
 {
-	int rc;
+	int rc, idx;
 	struct sqlite3_priv *priv = ras->db_priv;
 
 	if (!priv || !priv->stmt_cxl_general_media_event)
@@ -899,20 +904,23 @@ int ras_store_cxl_general_media_event(struct ras_events *ras,
 	log(TERM, LOG_INFO, "cxl_general_media_event store: %p\n",
 	    priv->stmt_cxl_general_media_event);
 
-	ras_store_cxl_common_hdr(priv->stmt_cxl_general_media_event, &ev->hdr);
-	sqlite3_bind_int64(priv->stmt_cxl_general_media_event, 13, ev->dpa);
-	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 14, ev->dpa_flags);
-	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 15, ev->descriptor);
-	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 16, ev->type);
-	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 17, ev->transaction_type);
-	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 18, ev->channel);
-	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 19, ev->rank);
-	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 20, ev->device);
-	sqlite3_bind_blob(priv->stmt_cxl_general_media_event, 21, ev->comp_id,
+	idx = ras_store_cxl_common_hdr(priv->stmt_cxl_general_media_event, &ev->hdr);
+	if (!idx)
+		return 0;
+
+	sqlite3_bind_int64(priv->stmt_cxl_general_media_event, idx++, ev->dpa);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev->dpa_flags);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev->descriptor);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev->type);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev->transaction_type);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev->channel);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev->rank);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, idx++, ev->device);
+	sqlite3_bind_blob(priv->stmt_cxl_general_media_event, idx++, ev->comp_id,
 			  CXL_EVENT_GEN_MED_COMP_ID_SIZE, NULL);
-	sqlite3_bind_int64(priv->stmt_cxl_general_media_event, 22, ev->hpa);
-	sqlite3_bind_text(priv->stmt_cxl_general_media_event, 23, ev->region, -1, NULL);
-	sqlite3_bind_text(priv->stmt_cxl_general_media_event, 24, ev->region_uuid, -1, NULL);
+	sqlite3_bind_int64(priv->stmt_cxl_general_media_event, idx++, ev->hpa);
+	sqlite3_bind_text(priv->stmt_cxl_general_media_event, idx++, ev->region, -1, NULL);
+	sqlite3_bind_text(priv->stmt_cxl_general_media_event, idx++, ev->region_uuid, -1, NULL);
 
 	rc = sqlite3_step(priv->stmt_cxl_general_media_event);
 	if (rc != SQLITE_OK && rc != SQLITE_DONE)
@@ -970,7 +978,7 @@ static const struct db_table_descriptor cxl_dram_event_tab = {
 
 int ras_store_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *ev)
 {
-	int rc;
+	int rc, idx;
 	struct sqlite3_priv *priv = ras->db_priv;
 
 	if (!priv || !priv->stmt_cxl_dram_event)
@@ -978,24 +986,27 @@ int ras_store_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *
 	log(TERM, LOG_INFO, "cxl_dram_event store: %p\n",
 	    priv->stmt_cxl_dram_event);
 
-	ras_store_cxl_common_hdr(priv->stmt_cxl_dram_event, &ev->hdr);
-	sqlite3_bind_int64(priv->stmt_cxl_dram_event, 13, ev->dpa);
-	sqlite3_bind_int(priv->stmt_cxl_dram_event, 14, ev->dpa_flags);
-	sqlite3_bind_int(priv->stmt_cxl_dram_event, 15, ev->descriptor);
-	sqlite3_bind_int(priv->stmt_cxl_dram_event, 16, ev->type);
-	sqlite3_bind_int(priv->stmt_cxl_dram_event, 17, ev->transaction_type);
-	sqlite3_bind_int(priv->stmt_cxl_dram_event, 18, ev->channel);
-	sqlite3_bind_int(priv->stmt_cxl_dram_event, 19, ev->rank);
-	sqlite3_bind_int(priv->stmt_cxl_dram_event, 20, ev->nibble_mask);
-	sqlite3_bind_int(priv->stmt_cxl_dram_event, 21, ev->bank_group);
-	sqlite3_bind_int(priv->stmt_cxl_dram_event, 22, ev->bank);
-	sqlite3_bind_int(priv->stmt_cxl_dram_event, 23, ev->row);
-	sqlite3_bind_int(priv->stmt_cxl_dram_event, 24, ev->column);
-	sqlite3_bind_blob(priv->stmt_cxl_dram_event, 25, ev->cor_mask,
+	idx = ras_store_cxl_common_hdr(priv->stmt_cxl_dram_event, &ev->hdr);
+	if (!idx)
+		return 0;
+
+	sqlite3_bind_int64(priv->stmt_cxl_dram_event, idx++, ev->dpa);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->dpa_flags);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->descriptor);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->type);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->transaction_type);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->channel);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->rank);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->nibble_mask);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->bank_group);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->bank);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->row);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, idx++, ev->column);
+	sqlite3_bind_blob(priv->stmt_cxl_dram_event, idx++, ev->cor_mask,
 			  CXL_EVENT_DER_CORRECTION_MASK_SIZE, NULL);
-	sqlite3_bind_int64(priv->stmt_cxl_dram_event, 26, ev->hpa);
-	sqlite3_bind_text(priv->stmt_cxl_dram_event, 27, ev->region, -1, NULL);
-	sqlite3_bind_text(priv->stmt_cxl_dram_event, 28, ev->region_uuid, -1, NULL);
+	sqlite3_bind_int64(priv->stmt_cxl_dram_event, idx++, ev->hpa);
+	sqlite3_bind_text(priv->stmt_cxl_dram_event, idx++, ev->region, -1, NULL);
+	sqlite3_bind_text(priv->stmt_cxl_dram_event, idx++, ev->region_uuid, -1, NULL);
 
 	rc = sqlite3_step(priv->stmt_cxl_dram_event);
 	if (rc != SQLITE_OK && rc != SQLITE_DONE)
@@ -1047,7 +1058,7 @@ static const struct db_table_descriptor cxl_memory_module_event_tab = {
 int ras_store_cxl_memory_module_event(struct ras_events *ras,
 				      struct ras_cxl_memory_module_event *ev)
 {
-	int rc;
+	int rc, idx;
 	struct sqlite3_priv *priv = ras->db_priv;
 
 	if (!priv || !priv->stmt_cxl_memory_module_event)
@@ -1055,16 +1066,19 @@ int ras_store_cxl_memory_module_event(struct ras_events *ras,
 	log(TERM, LOG_INFO, "cxl_memory_module_event store: %p\n",
 	    priv->stmt_cxl_memory_module_event);
 
-	ras_store_cxl_common_hdr(priv->stmt_cxl_memory_module_event, &ev->hdr);
-	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 13, ev->event_type);
-	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 14, ev->health_status);
-	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 15, ev->media_status);
-	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 16, ev->life_used);
-	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 17, ev->dirty_shutdown_cnt);
-	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 18, ev->cor_vol_err_cnt);
-	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 19, ev->cor_per_err_cnt);
-	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 20, ev->device_temp);
-	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 21, ev->add_status);
+	idx = ras_store_cxl_common_hdr(priv->stmt_cxl_memory_module_event, &ev->hdr);
+	if (!idx)
+		return 0;
+
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev->event_type);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev->health_status);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev->media_status);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev->life_used);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev->dirty_shutdown_cnt);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev->cor_vol_err_cnt);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev->cor_per_err_cnt);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev->device_temp);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, idx++, ev->add_status);
 
 	rc = sqlite3_step(priv->stmt_cxl_memory_module_event);
 	if (rc != SQLITE_OK && rc != SQLITE_DONE)
-- 
2.43.0


