Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6A2D9783
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2019 18:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406043AbfJPQep (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Oct 2019 12:34:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404676AbfJPQeo (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 16 Oct 2019 12:34:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D210E2626E956920997E;
        Thu, 17 Oct 2019 00:34:36 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.55) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 17 Oct 2019 00:34:26 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 6/7] rasdaemon: add closure and cleanups for the database
Date:   Wed, 16 Oct 2019 17:34:00 +0100
Message-ID: <20191016163401.16980-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20191016163401.16980-1-shiju.jose@huawei.com>
References: <Shiju Jose>
 <20191016163401.16980-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.55]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch adds closure and cleanups for the sqlite3 database.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-events.c               |  14 +++++-
 ras-non-standard-handler.c |  16 ++++++
 ras-non-standard-handler.h |   6 ++-
 ras-record.c               | 120 +++++++++++++++++++++++++++++++++++++++++++++
 ras-record.h               |   3 ++
 5 files changed, 157 insertions(+), 2 deletions(-)

diff --git a/ras-events.c b/ras-events.c
index f912dae..d155caa 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -418,7 +418,7 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 			size = read(fds[i].fd, page, pdata[i].ras->page_size);
 			if (size < 0) {
 				log(TERM, LOG_WARNING, "read\n");
-				goto error;
+				goto cleanup;
 			} else if (size > 0) {
 				kbuffer_load_subbuffer(kbuf, page);
 
@@ -452,6 +452,13 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 	/* poll() is not supported. We need to fallback to the old way */
 	log(TERM, LOG_INFO,
 	    "Old kernel detected. Stop listening and fall back to pthread way.\n");
+
+cleanup:
+	if (pdata[0].ras->record_events) {
+		unregister_ns_dec_tab();
+		ras_mc_event_closedb(pdata[0].cpu, pdata[0].ras);
+	}
+
 error:
 	kbuffer_free(kbuf);
 	free(page);
@@ -540,6 +547,11 @@ static void *handle_ras_events_cpu(void *priv)
 
 	read_ras_event(fd, pdata, kbuf, page);
 
+	if (pdata->ras->record_events) {
+		unregister_ns_dec_tab();
+		ras_mc_event_closedb(pdata->cpu, pdata->ras);
+	}
+
 	close(fd);
 	kbuffer_free(kbuf);
 	free(page);
diff --git a/ras-non-standard-handler.c b/ras-non-standard-handler.c
index 1b5d67a..d92fd42 100644
--- a/ras-non-standard-handler.c
+++ b/ras-non-standard-handler.c
@@ -41,6 +41,22 @@ int register_ns_dec_tab(const p_ns_dec_tab tab)
 void unregister_ns_dec_tab(void)
 {
 	if (ns_dec_tab) {
+#ifdef HAVE_SQLITE3
+		p_ns_dec_tab dec_tab;
+		int i, count;
+
+		for (count = 0; count < dec_tab_count; count++) {
+			dec_tab = ns_dec_tab[count];
+			for (i = 0; dec_tab[i].decode; i++) {
+				if (dec_tab[i].stmt_dec_record) {
+					ras_mc_finalize_vendor_table(
+						dec_tab[i].stmt_dec_record);
+					dec_tab[i].stmt_dec_record = NULL;
+				}
+			}
+		}
+#endif
+
 		free(ns_dec_tab);
 		ns_dec_tab = NULL;
 		dec_tab_count = 0;
diff --git a/ras-non-standard-handler.h b/ras-non-standard-handler.h
index fd9dd92..2b9bf40 100644
--- a/ras-non-standard-handler.h
+++ b/ras-non-standard-handler.h
@@ -36,8 +36,12 @@ int ras_non_standard_event_handler(struct trace_seq *s,
 
 void print_le_hex(struct trace_seq *s, const uint8_t *buf, int index);
 
+#ifdef HAVE_NON_STANDARD
 int register_ns_dec_tab(const p_ns_dec_tab tab);
-
 void unregister_ns_dec_tab(void);
+#else
+static inline int register_ns_dec_tab(const p_ns_dec_tab tab) { return 0; };
+static inline void unregister_ns_dec_tab(void) { return; };
+#endif
 
 #endif
diff --git a/ras-record.c b/ras-record.c
index 8f1c550..c6cf61a 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -595,6 +595,18 @@ int ras_mc_add_vendor_table(struct ras_events *ras,
 	return rc;
 }
 
+int ras_mc_finalize_vendor_table(sqlite3_stmt *stmt)
+{
+	int rc;
+
+	rc = sqlite3_finalize(stmt);
+	if (rc != SQLITE_OK)
+		log(TERM, LOG_ERR,
+		    "Failed to finalize sqlite: error = %d\n", rc);
+
+	return rc;
+}
+
 int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 {
 	int rc;
@@ -692,3 +704,111 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 		ras->db_priv = priv;
 	return 0;
 }
+
+int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
+{
+	int rc;
+	sqlite3 *db;
+	struct sqlite3_priv *priv = ras->db_priv;
+
+	printf("Calling %s()\n", __func__);
+
+	if (!priv)
+		return -1;
+
+	db = priv->db;
+	if (!db)
+		return -1;
+
+	if (priv->stmt_mc_event) {
+		rc = sqlite3_finalize(priv->stmt_mc_event);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize mc_event sqlite: error = %d\n",
+			    cpu, rc);
+	}
+
+#ifdef HAVE_AER
+	if (priv->stmt_aer_event) {
+		rc = sqlite3_finalize(priv->stmt_aer_event);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize aer_event sqlite: error = %d\n",
+			    cpu, rc);
+	}
+#endif
+
+#ifdef HAVE_EXTLOG
+	if (priv->stmt_extlog_record) {
+		rc = sqlite3_finalize(priv->stmt_extlog_record);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize extlog_record sqlite: error = %d\n",
+			    cpu, rc);
+	}
+#endif
+
+
+#ifdef HAVE_MCE
+	if (priv->stmt_mce_record) {
+		rc = sqlite3_finalize(priv->stmt_mce_record);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize mce_record sqlite: error = %d\n",
+			    cpu, rc);
+	}
+#endif
+
+#ifdef HAVE_NON_STANDARD
+	if (priv->stmt_non_standard_record) {
+		rc = sqlite3_finalize(priv->stmt_non_standard_record);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize non_standard_record sqlite: error = %d\n",
+			    cpu, rc);
+	}
+#endif
+
+#ifdef HAVE_ARM
+	if (priv->stmt_arm_record) {
+		rc = sqlite3_finalize(priv->stmt_arm_record);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize arm_record sqlite: error = %d\n",
+			    cpu, rc);
+	}
+#endif
+
+#ifdef HAVE_DEVLINK
+	if (priv->stmt_devlink_event) {
+		rc = sqlite3_finalize(priv->stmt_devlink_event);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize devlink_event sqlite: error = %d\n",
+			    cpu, rc);
+	}
+#endif
+
+#ifdef HAVE_DISKERROR
+	if (priv->stmt_diskerror_event) {
+		rc = sqlite3_finalize(priv->stmt_diskerror_event);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize diskerror_event sqlite: error = %d\n",
+			    cpu, rc);
+	}
+#endif
+
+	rc = sqlite3_close_v2(db);
+	if (rc != SQLITE_OK)
+		log(TERM, LOG_ERR,
+		    "cpu %u: Failed to close sqlite: error = %d\n", cpu, rc);
+
+	rc = sqlite3_shutdown();
+	if (rc != SQLITE_OK)
+		log(TERM, LOG_ERR,
+		    "cpu %u: Failed to shutdown sqlite: error = %d\n", cpu, rc);
+	free(priv);
+
+	return 0;
+}
diff --git a/ras-record.h b/ras-record.h
index c9af5ae..a67b193 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -147,8 +147,10 @@ struct db_table_descriptor {
 };
 
 int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras);
+int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras);
 int ras_mc_add_vendor_table(struct ras_events *ras, sqlite3_stmt **stmt,
 			    const struct db_table_descriptor *db_tab);
+int ras_mc_finalize_vendor_table(sqlite3_stmt *stmt);
 int ras_store_mc_event(struct ras_events *ras, struct ras_mc_event *ev);
 int ras_store_aer_event(struct ras_events *ras, struct ras_aer_event *ev);
 int ras_store_mce_record(struct ras_events *ras, struct mce_event *ev);
@@ -160,6 +162,7 @@ int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev
 
 #else
 static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
+static inline int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras) { return 0; };
 static inline int ras_store_mc_event(struct ras_events *ras, struct ras_mc_event *ev) { return 0; };
 static inline int ras_store_aer_event(struct ras_events *ras, struct ras_aer_event *ev) { return 0; };
 static inline int ras_store_mce_record(struct ras_events *ras, struct mce_event *ev) { return 0; };
-- 
2.1.4


