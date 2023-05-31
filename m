Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D07C718700
	for <lists+linux-edac@lfdr.de>; Wed, 31 May 2023 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjEaQGz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 31 May 2023 12:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEaQGz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 31 May 2023 12:06:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E501101
        for <linux-edac@vger.kernel.org>; Wed, 31 May 2023 09:06:51 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWYxP062Bz67jHC;
        Thu,  1 Jun 2023 00:04:40 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 17:06:49 +0100
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <tanxiaofei@huawei.com>, <lvying6@huawei.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH V2 3/3] rasdaemon: Add support for creating the vendor error tables at startup
Date:   Thu, 1 Jun 2023 00:06:26 +0800
Message-ID: <20230531160627.1506-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230531160627.1506-1-shiju.jose@huawei.com>
References: <20230531160627.1506-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

1. Support for create/open the vendor error tables at rasdaemon startup.
2. Make changes in the HiSilicon error handling code for the same.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 non-standard-hisi_hip08.c  | 76 ++++++++++++++++++++++----------------
 non-standard-hisilicon.c   | 28 +++++++++-----
 ras-events.c               | 17 ++++++++-
 ras-non-standard-handler.c | 35 +++++++++++++++++-
 ras-non-standard-handler.h |  3 ++
 5 files changed, 116 insertions(+), 43 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 61f12eb..0899812 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -654,6 +654,20 @@ static void decode_oem_type1_err_regs(struct ras_ns_ev_decoder *ev_decoder,
 	step_vendor_data_tab(ev_decoder, "hip08_oem_type1_event_tab");
 }
 
+static int add_hip08_oem_type1_table(struct ras_events *ras, struct ras_ns_ev_decoder *ev_decoder)
+{
+#ifdef HAVE_SQLITE3
+	if (ras->record_events && !ev_decoder->stmt_dec_record) {
+		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
+					    &hip08_oem_type1_event_tab) != SQLITE_OK) {
+			log(TERM, LOG_WARNING, "Failed to create sql hip08_oem_type1_event_tab\n");
+			return -1;
+		}
+	}
+#endif
+	return 0;
+}
+
 /* error data decoding functions */
 static int decode_hip08_oem_type1_error(struct ras_events *ras,
 					struct ras_ns_ev_decoder *ev_decoder,
@@ -669,17 +683,6 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 		return -1;
 	}
 
-#ifdef HAVE_SQLITE3
-	if (ras->record_events && !ev_decoder->stmt_dec_record) {
-		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
-					    &hip08_oem_type1_event_tab)
-			!= SQLITE_OK) {
-			trace_seq_printf(s,
-					"create sql hip08_oem_type1_event_tab fail\n");
-			return -1;
-		}
-	}
-#endif
 	record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 			   HIP08_OEM_TYPE1_FIELD_TIMESTAMP,
 			   0, event->timestamp);
@@ -827,6 +830,20 @@ static void decode_oem_type2_err_regs(struct ras_ns_ev_decoder *ev_decoder,
 	step_vendor_data_tab(ev_decoder, "hip08_oem_type2_event_tab");
 }
 
+static int add_hip08_oem_type2_table(struct ras_events *ras, struct ras_ns_ev_decoder *ev_decoder)
+{
+#ifdef HAVE_SQLITE3
+	if (ras->record_events && !ev_decoder->stmt_dec_record) {
+		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
+					    &hip08_oem_type2_event_tab) != SQLITE_OK) {
+			log(TERM, LOG_WARNING, "Failed to create sql hip08_oem_type2_event_tab\n");
+			return -1;
+		}
+	}
+#endif
+	return 0;
+}
+
 static int decode_hip08_oem_type2_error(struct ras_events *ras,
 					struct ras_ns_ev_decoder *ev_decoder,
 					struct trace_seq *s,
@@ -841,16 +858,6 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 		return -1;
 	}
 
-#ifdef HAVE_SQLITE3
-	if (ras->record_events && !ev_decoder->stmt_dec_record) {
-		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
-			&hip08_oem_type2_event_tab) != SQLITE_OK) {
-			trace_seq_printf(s,
-				"create sql hip08_oem_type2_event_tab fail\n");
-			return -1;
-		}
-	}
-#endif
 	record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 			   HIP08_OEM_TYPE2_FIELD_TIMESTAMP,
 			   0, event->timestamp);
@@ -977,6 +984,20 @@ static void decode_pcie_local_err_regs(struct ras_ns_ev_decoder *ev_decoder,
 	step_vendor_data_tab(ev_decoder, "hip08_pcie_local_event_tab");
 }
 
+static int add_hip08_pcie_local_table(struct ras_events *ras, struct ras_ns_ev_decoder *ev_decoder)
+{
+#ifdef HAVE_SQLITE3
+	if (ras->record_events && !ev_decoder->stmt_dec_record) {
+		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
+					    &hip08_pcie_local_event_tab) != SQLITE_OK) {
+			log(TERM, LOG_WARNING, "Failed to create sql hip08_pcie_local_event_tab\n");
+			return -1;
+		}
+	}
+#endif
+	return 0;
+}
+
 static int decode_hip08_pcie_local_error(struct ras_events *ras,
 					 struct ras_ns_ev_decoder *ev_decoder,
 					 struct trace_seq *s,
@@ -991,16 +1012,6 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
 		return -1;
 	}
 
-#ifdef HAVE_SQLITE3
-	if (ras->record_events && !ev_decoder->stmt_dec_record) {
-		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
-				&hip08_pcie_local_event_tab) != SQLITE_OK) {
-			trace_seq_printf(s,
-				"create sql hip08_pcie_local_event_tab fail\n");
-			return -1;
-		}
-	}
-#endif
 	record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 			   HIP08_PCIE_LOCAL_FIELD_TIMESTAMP,
 			   0, event->timestamp);
@@ -1015,14 +1026,17 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
 static struct ras_ns_ev_decoder hip08_ns_ev_decoder[] = {
 	{
 		.sec_type = "1f8161e1-55d6-41e6-bd10-7afd1dc5f7c5",
+		.add_table = add_hip08_oem_type1_table,
 		.decode = decode_hip08_oem_type1_error,
 	},
 	{
 		.sec_type = "45534ea6-ce23-4115-8535-e07ab3aef91d",
+		.add_table = add_hip08_oem_type2_table,
 		.decode = decode_hip08_oem_type2_error,
 	},
 	{
 		.sec_type = "b2889fc9-e7d7-4f9d-a867-af42e98be772",
+		.add_table = add_hip08_pcie_local_table,
 		.decode = decode_hip08_pcie_local_error,
 	},
 };
diff --git a/non-standard-hisilicon.c b/non-standard-hisilicon.c
index 721821e..7296d28 100644
--- a/non-standard-hisilicon.c
+++ b/non-standard-hisilicon.c
@@ -341,6 +341,23 @@ static void decode_hisi_common_section_hdr(struct ras_ns_ev_decoder *ev_decoder,
 	HISI_SNPRINTF(event->error_msg, "]");
 }
 
+static int add_hisi_common_table(struct ras_events *ras,
+				 struct ras_ns_ev_decoder *ev_decoder)
+{
+#ifdef HAVE_SQLITE3
+	if (ras->record_events &&
+	    !ev_decoder->stmt_dec_record) {
+		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
+					    &hisi_common_section_tab) != SQLITE_OK) {
+			log(TERM, LOG_WARNING, "Failed to create sql hisi_common_section_tab\n");
+			return -1;
+		}
+	}
+#endif
+
+	return 0;
+}
+
 static int decode_hisi_common_section(struct ras_events *ras,
 				      struct ras_ns_ev_decoder *ev_decoder,
 				      struct trace_seq *s,
@@ -350,16 +367,6 @@ static int decode_hisi_common_section(struct ras_events *ras,
 			(struct hisi_common_error_section *)event->error;
 	struct hisi_event hevent;
 
-#ifdef HAVE_SQLITE3
-	if (ras->record_events && !ev_decoder->stmt_dec_record) {
-		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
-				&hisi_common_section_tab) != SQLITE_OK) {
-			trace_seq_printf(s, "create sql hisi_common_section_tab fail\n");
-			return -1;
-		}
-	}
-#endif
-
 	memset(&hevent, 0, sizeof(struct hisi_event));
 	trace_seq_printf(s, "\nHisilicon Common Error Section:\n");
 	decode_hisi_common_section_hdr(ev_decoder, err, &hevent);
@@ -392,6 +399,7 @@ static int decode_hisi_common_section(struct ras_events *ras,
 static struct ras_ns_ev_decoder hisi_section_ns_ev_decoder[]  = {
 	{
 		.sec_type = "c8b328a8-9917-4af6-9a13-2e08ab2e7586",
+		.add_table = add_hisi_common_table,
 		.decode = decode_hisi_common_section,
 	},
 };
diff --git a/ras-events.c b/ras-events.c
index d041828..5420a9c 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -474,6 +474,10 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 	if (pdata[0].ras->record_events) {
 		if (ras_mc_event_opendb(pdata[0].cpu, pdata[0].ras))
 			goto error;
+#ifdef HAVE_NON_STANDARD
+		if (ras_ns_add_vendor_tables(pdata[0].ras))
+			log(TERM, LOG_ERR, "Can't add vendor table\n");
+#endif
 	}
 
 	do {
@@ -558,8 +562,12 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 	    "Old kernel detected. Stop listening and fall back to pthread way.\n");
 
 cleanup:
-	if (pdata[0].ras->record_events)
+	if (pdata[0].ras->record_events) {
+#ifdef HAVE_NON_STANDARD
+		ras_ns_finalize_vendor_tables();
+#endif
 		ras_mc_event_closedb(pdata[0].cpu, pdata[0].ras);
+	}
 
 error:
 	kbuffer_free(kbuf);
@@ -656,6 +664,10 @@ static void *handle_ras_events_cpu(void *priv)
 			free(page);
 			return 0;
 		}
+#ifdef HAVE_NON_STANDARD
+		if (ras_ns_add_vendor_tables(pdata->ras))
+			log(TERM, LOG_ERR, "Can't add vendor table\n");
+#endif
 		pthread_mutex_unlock(&pdata->ras->db_lock);
 	}
 
@@ -663,6 +675,9 @@ static void *handle_ras_events_cpu(void *priv)
 
 	if (pdata->ras->record_events) {
 		pthread_mutex_lock(&pdata->ras->db_lock);
+#ifdef HAVE_NON_STANDARD
+		ras_ns_finalize_vendor_tables();
+#endif
 		ras_mc_event_closedb(pdata->cpu, pdata->ras);
 		pthread_mutex_unlock(&pdata->ras->db_lock);
 	}
diff --git a/ras-non-standard-handler.c b/ras-non-standard-handler.c
index b7096da..cb2504e 100644
--- a/ras-non-standard-handler.c
+++ b/ras-non-standard-handler.c
@@ -75,6 +75,32 @@ int register_ns_ev_decoder(struct ras_ns_ev_decoder *ns_ev_decoder)
 	return 0;
 }
 
+int ras_ns_add_vendor_tables(struct ras_events *ras)
+{
+	struct ras_ns_ev_decoder *ns_ev_decoder;
+	int error = 0;
+
+#ifdef HAVE_SQLITE3
+	if (!ras)
+		return -1;
+
+	ns_ev_decoder = ras_ns_ev_dec_list;
+	while (ns_ev_decoder) {
+		if (ns_ev_decoder->add_table && !ns_ev_decoder->stmt_dec_record) {
+			error = ns_ev_decoder->add_table(ras, ns_ev_decoder);
+			if (error)
+				break;
+		}
+		ns_ev_decoder = ns_ev_decoder->next;
+	}
+
+	if (error)
+		return -1;
+#endif
+
+	return 0;
+}
+
 static int find_ns_ev_decoder(const char *sec_type, struct ras_ns_ev_decoder **p_ns_ev_dec)
 {
 	struct ras_ns_ev_decoder *ns_ev_decoder;
@@ -96,7 +122,7 @@ static int find_ns_ev_decoder(const char *sec_type, struct ras_ns_ev_decoder **p
 	return 0;
 }
 
-static void unregister_ns_ev_decoder(void)
+void ras_ns_finalize_vendor_tables(void)
 {
 #ifdef HAVE_SQLITE3
 	struct ras_ns_ev_decoder *ns_ev_decoder = ras_ns_ev_dec_list;
@@ -108,6 +134,13 @@ static void unregister_ns_ev_decoder(void)
 		}
 		ns_ev_decoder = ns_ev_decoder->next;
 	}
+#endif
+}
+
+static void unregister_ns_ev_decoder(void)
+{
+#ifdef HAVE_SQLITE3
+	ras_ns_finalize_vendor_tables();
 #endif
 	ras_ns_ev_dec_list = NULL;
 }
diff --git a/ras-non-standard-handler.h b/ras-non-standard-handler.h
index c360eaf..d19a564 100644
--- a/ras-non-standard-handler.h
+++ b/ras-non-standard-handler.h
@@ -20,6 +20,7 @@
 struct ras_ns_ev_decoder {
 	struct ras_ns_ev_decoder *next;
 	const char *sec_type;
+	int (*add_table)(struct ras_events *ras, struct ras_ns_ev_decoder *ev_decoder);
 	int (*decode)(struct ras_events *ras, struct ras_ns_ev_decoder *ev_decoder,
 		      struct trace_seq *s, struct ras_non_standard_event *event);
 #ifdef HAVE_SQLITE3
@@ -36,6 +37,8 @@ void print_le_hex(struct trace_seq *s, const uint8_t *buf, int index);
 
 #ifdef HAVE_NON_STANDARD
 int register_ns_ev_decoder(struct ras_ns_ev_decoder *ns_ev_decoder);
+int ras_ns_add_vendor_tables(struct ras_events *ras);
+void ras_ns_finalize_vendor_tables(void);
 #else
 static inline int register_ns_ev_decoder(struct ras_ns_ev_decoder *ns_ev_decoder) { return 0; };
 #endif
-- 
2.25.1

