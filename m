Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8930748565
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2019 16:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfFQO3m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jun 2019 10:29:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50562 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726920AbfFQO3l (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Jun 2019 10:29:41 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1F36236C7E016B04080B;
        Mon, 17 Jun 2019 22:29:39 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.53) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Jun 2019 22:29:30 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linuxarm@huawei.com>
CC:     Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 3/6] rasdaemon: update iteration logic for the non-standard error decoding functions
Date:   Mon, 17 Jun 2019 15:28:49 +0100
Message-ID: <20190617142852.12140-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190617142852.12140-1-shiju.jose@huawei.com>
References: <Shiju Jose>
 <20190617142852.12140-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.53]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch updates the iteration logic for the non-standard
error decoding functions.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 non-standard-hisi_hip07.c  | 2 +-
 ras-non-standard-handler.c | 2 +-
 ras-non-standard-handler.h | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/non-standard-hisi_hip07.c b/non-standard-hisi_hip07.c
index 19a5c47..bb2576e 100644
--- a/non-standard-hisi_hip07.c
+++ b/non-standard-hisi_hip07.c
@@ -134,11 +134,11 @@ struct ras_ns_dec_tab hisi_ns_dec_tab[] = {
 		.sec_type = "fbc2d923ea7a453dab132949f5af9e53",
 		.decode = decode_hip07_hns_error,
 	},
+	{ /* sentinel */ }
 };
 
 __attribute__((constructor))
 static void hip07_init(void)
 {
-	hisi_ns_dec_tab[0].len = ARRAY_SIZE(hisi_ns_dec_tab);
 	register_ns_dec_tab(hisi_ns_dec_tab);
 }
diff --git a/ras-non-standard-handler.c b/ras-non-standard-handler.c
index d343a2a..392bb27 100644
--- a/ras-non-standard-handler.c
+++ b/ras-non-standard-handler.c
@@ -163,7 +163,7 @@ int ras_non_standard_event_handler(struct trace_seq *s,
 
 	for (count = 0; count < dec_tab_count && !dec_done; count++) {
 		dec_tab = ns_dec_tab[count];
-		for (i = 0; i < dec_tab[0].len; i++) {
+		for (i = 0; dec_tab[i].decode; i++) {
 			if (uuid_le_cmp(ev.sec_type,
 					dec_tab[i].sec_type) == 0) {
 				dec_tab[i].decode(s, ev.error);
diff --git a/ras-non-standard-handler.h b/ras-non-standard-handler.h
index b9e9fb1..b2c9743 100644
--- a/ras-non-standard-handler.h
+++ b/ras-non-standard-handler.h
@@ -23,7 +23,6 @@
 typedef struct ras_ns_dec_tab {
 	const char *sec_type;
 	int (*decode)(struct trace_seq *s, const void *err);
-	size_t len;
 } *p_ns_dec_tab;
 
 int ras_non_standard_event_handler(struct trace_seq *s,
-- 
1.9.1


