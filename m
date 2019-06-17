Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A968D4855F
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2019 16:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfFQO3i (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jun 2019 10:29:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18629 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726005AbfFQO3i (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Jun 2019 10:29:38 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0BC47967F754714FB6ED;
        Mon, 17 Jun 2019 22:29:34 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.53) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Jun 2019 22:29:26 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linuxarm@huawei.com>
CC:     Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 1/6] rasdaemon:print non-standard error data if not decoded
Date:   Mon, 17 Jun 2019 15:28:47 +0100
Message-ID: <20190617142852.12140-2-shiju.jose@huawei.com>
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

This patch change printing non-standard error data
only if not decoded.

Suggested-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-non-standard-handler.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/ras-non-standard-handler.c b/ras-non-standard-handler.c
index 21e6a76..d343a2a 100644
--- a/ras-non-standard-handler.c
+++ b/ras-non-standard-handler.c
@@ -160,20 +160,6 @@ int ras_non_standard_event_handler(struct trace_seq *s,
 	ev.error = pevent_get_field_raw(s, event, "buf", record, &len, 1);
 	if(!ev.error)
 		return -1;
-	len = ev.length;
-	i = 0;
-	line_count = 0;
-	trace_seq_printf(s, " error:\n  %08x: ", i);
-	while(len >= 4) {
-		print_le_hex(s, ev.error, i);
-		i+=4;
-		len-=4;
-		if(++line_count == 4) {
-			trace_seq_printf(s, "\n  %08x: ", i);
-			line_count = 0;
-		} else
-			trace_seq_printf(s, " ");
-	}
 
 	for (count = 0; count < dec_tab_count && !dec_done; count++) {
 		dec_tab = ns_dec_tab[count];
@@ -187,6 +173,23 @@ int ras_non_standard_event_handler(struct trace_seq *s,
 		}
 	}
 
+	if (!dec_done) {
+		len = ev.length;
+		i = 0;
+		line_count = 0;
+		trace_seq_printf(s, " error:\n  %08x: ", i);
+		while (len >= 4) {
+			print_le_hex(s, ev.error, i);
+			i += 4;
+			len -= 4;
+			if (++line_count == 4) {
+				trace_seq_printf(s, "\n  %08x: ", i);
+				line_count = 0;
+			} else
+				trace_seq_printf(s, " ");
+		}
+	}
+
 	/* Insert data into the SGBD */
 #ifdef HAVE_SQLITE3
 	ras_store_non_standard_record(ras, &ev);
-- 
1.9.1


