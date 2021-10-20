Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323BA43453F
	for <lists+linux-edac@lfdr.de>; Wed, 20 Oct 2021 08:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhJTGkr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Oct 2021 02:40:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25300 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJTGkq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Oct 2021 02:40:46 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HZ16F18t2zbhGY;
        Wed, 20 Oct 2021 14:33:57 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 14:38:30 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 20 Oct 2021 14:38:30 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <shiju.jose@huawei.com>, <linuxarm@openeuler.org>,
        <jonathan.cameron@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 2/4] rasdaemon: Fix the issue of command option -r for hip08
Date:   Wed, 20 Oct 2021 14:33:38 +0800
Message-ID: <20211020063340.26079-3-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211020063340.26079-1-tanxiaofei@huawei.com>
References: <20211020063340.26079-1-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

It will record event even the option -r is not provided for hip08.
It is not right, and fix it.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisi_hip08.c | 6 +++---
 non-standard-hisilicon.c  | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index ebf03e1..9092183 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -670,7 +670,7 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 	}
 
 #ifdef HAVE_SQLITE3
-	if (!ev_decoder->stmt_dec_record) {
+	if (ras->record_events && !ev_decoder->stmt_dec_record) {
 		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
 					    &hip08_oem_type1_event_tab)
 			!= SQLITE_OK) {
@@ -842,7 +842,7 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 	}
 
 #ifdef HAVE_SQLITE3
-	if (!ev_decoder->stmt_dec_record) {
+	if (ras->record_events && !ev_decoder->stmt_dec_record) {
 		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
 			&hip08_oem_type2_event_tab) != SQLITE_OK) {
 			trace_seq_printf(s,
@@ -992,7 +992,7 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
 	}
 
 #ifdef HAVE_SQLITE3
-	if (!ev_decoder->stmt_dec_record) {
+	if (ras->record_events && !ev_decoder->stmt_dec_record) {
 		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
 				&hip08_pcie_local_event_tab) != SQLITE_OK) {
 			trace_seq_printf(s,
diff --git a/non-standard-hisilicon.c b/non-standard-hisilicon.c
index a6f5e78..3fccff6 100644
--- a/non-standard-hisilicon.c
+++ b/non-standard-hisilicon.c
@@ -77,6 +77,9 @@ void record_vendor_data(struct ras_ns_ev_decoder *ev_decoder,
 			       enum hisi_oem_data_type data_type,
 			       int id, int64_t data, const char *text)
 {
+	if (ev_decoder->stmt_dec_record == NULL)
+		return;
+
 	switch (data_type) {
 	case HISI_OEM_DATA_TYPE_INT:
 		sqlite3_bind_int(ev_decoder->stmt_dec_record, id, data);
@@ -94,6 +97,9 @@ int step_vendor_data_tab(struct ras_ns_ev_decoder *ev_decoder, const char *name)
 {
 	int rc;
 
+	if (ev_decoder->stmt_dec_record == NULL)
+		return 0;
+
 	rc = sqlite3_step(ev_decoder->stmt_dec_record);
 	if (rc != SQLITE_OK && rc != SQLITE_DONE)
 		log(TERM, LOG_ERR,
-- 
2.33.0

