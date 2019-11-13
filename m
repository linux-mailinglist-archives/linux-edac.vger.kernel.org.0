Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63BE2FB51E
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2019 17:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfKMQbf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Nov 2019 11:31:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56082 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728388AbfKMQbf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 13 Nov 2019 11:31:35 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DF5997B2231CCC07FD88;
        Thu, 14 Nov 2019 00:31:32 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.55) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 14 Nov 2019 00:31:23 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH rasdaemon 1/2] rasdaemon: fix for the ras-record.c:ras_mc_prepare_stmt() failure when new fields added to the sql table
Date:   Wed, 13 Nov 2019 16:31:12 +0000
Message-ID: <20191113163113.3356-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20191113163113.3356-1-shiju.jose@huawei.com>
References: <Shiju Jose>
 <20191113163113.3356-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.55]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

rasdaemon fails in the ras_mc_prepare_stmt() function when new fields are
added to the table's db_fields on top of the existing sql table in the
system.

This patch adds solution for this issue.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-record.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 4 deletions(-)

diff --git a/ras-record.c b/ras-record.c
index c6cf61a..ca58b22 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -499,10 +499,9 @@ int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev
 /*
  * Generic code
  */
-
-static int ras_mc_prepare_stmt(struct sqlite3_priv *priv,
-			       sqlite3_stmt **stmt,
-			       const struct db_table_descriptor *db_tab)
+static int __ras_mc_prepare_stmt(struct sqlite3_priv *priv,
+				 sqlite3_stmt **stmt,
+				 const struct db_table_descriptor *db_tab)
 
 {
 	int i, rc;
@@ -578,6 +577,92 @@ static int ras_mc_create_table(struct sqlite3_priv *priv,
 	return rc;
 }
 
+static int ras_mc_alter_table(struct sqlite3_priv *priv,
+			      sqlite3_stmt **stmt,
+			      const struct db_table_descriptor *db_tab)
+{
+	char sql[1024], *p = sql, *end = sql + sizeof(sql);
+	const struct db_fields *field;
+	int col_count;
+	int i, j, rc, found;
+
+	snprintf(p, end - p, "SELECT * FROM %s", db_tab->name);
+	rc = sqlite3_prepare_v2(priv->db, sql, -1, stmt, NULL);
+	if (rc != SQLITE_OK) {
+		log(TERM, LOG_ERR,
+		    "Failed to query fields from the table %s on %s: error = %d\n",
+		    db_tab->name, SQLITE_RAS_DB, rc);
+		return rc;
+	}
+
+	col_count = sqlite3_column_count(*stmt);
+	for (i = 0; i < db_tab->num_fields; i++) {
+		field = &db_tab->fields[i];
+		found = 0;
+		for (j = 0; j < col_count; j++) {
+			if (!strcmp(field->name,
+			    sqlite3_column_name(*stmt, j))) {
+				found = 1;
+				break;
+			}
+		}
+
+		if (!found) {
+			/* add new field */
+			p += snprintf(p, end - p, "ALTER TABLE %s ADD ",
+				      db_tab->name);
+			p += snprintf(p, end - p,
+				      "%s %s", field->name, field->type);
+#ifdef DEBUG_SQL
+			log(TERM, LOG_INFO, "SQL: %s\n", sql);
+#endif
+			rc = sqlite3_exec(priv->db, sql, NULL, NULL, NULL);
+			if (rc != SQLITE_OK) {
+				log(TERM, LOG_ERR,
+				    "Failed to add new field %s to the table %s on %s: error = %d\n",
+				    field->name, db_tab->name,
+				    SQLITE_RAS_DB, rc);
+				return rc;
+			}
+			p = sql;
+			memset(sql, 0, sizeof(sql));
+		}
+	}
+
+	return rc;
+}
+
+static int ras_mc_prepare_stmt(struct sqlite3_priv *priv,
+			       sqlite3_stmt **stmt,
+			       const struct db_table_descriptor *db_tab)
+{
+	int rc;
+
+	rc = __ras_mc_prepare_stmt(priv, stmt, db_tab);
+	if (rc != SQLITE_OK) {
+		log(TERM, LOG_ERR,
+		    "Failed to prepare insert db at table %s (db %s): error = %s\n",
+		    db_tab->name, SQLITE_RAS_DB, sqlite3_errmsg(priv->db));
+
+		log(TERM, LOG_INFO, "Trying to alter db at table %s (db %s)\n",
+		    db_tab->name, SQLITE_RAS_DB);
+
+		rc = ras_mc_alter_table(priv, stmt, db_tab);
+		if (rc != SQLITE_OK && rc != SQLITE_DONE) {
+			log(TERM, LOG_ERR,
+			    "Failed to alter db at table %s (db %s): error = %s\n",
+			    db_tab->name, SQLITE_RAS_DB,
+			    sqlite3_errmsg(priv->db));
+			stmt = NULL;
+			return rc;
+		}
+
+		rc = __ras_mc_prepare_stmt(priv, stmt, db_tab);
+	}
+
+	return rc;
+}
+
 int ras_mc_add_vendor_table(struct ras_events *ras,
 			    sqlite3_stmt **stmt,
 			    const struct db_table_descriptor *db_tab)
-- 
1.9.1


