Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C214F8FAC
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2019 13:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbfKLMa3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Nov 2019 07:30:29 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbfKLMa3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Nov 2019 07:30:29 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C0A70B60CC0023154EA9;
        Tue, 12 Nov 2019 20:30:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 12 Nov 2019 20:30:18 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH 1/9] rasdaemon: fix the wrong declaring of 'sruct ras_events' in ras-record.h
Date:   Tue, 12 Nov 2019 20:27:06 +0800
Message-ID: <1573561634-225173-2-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1573561634-225173-1-git-send-email-tanxiaofei@huawei.com>
References: <1573561634-225173-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The following warning can be found by PC-Lint when do static code
analysis to the file non-standard-hisi_hip08.c.
Warning -- Declaration of symbol 'ras' hides symbol 'ras' (line 28, file ras-record.h)

This means that the local variable name 'ras' is same as an global
variable. In fact, there is no global variable named 'ras', but an
wrong declaring in ras-record.h.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 ras-record.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ras-record.h b/ras-record.h
index 5311c67..da72557 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -25,7 +25,7 @@
 
 extern long user_hz;
 
-struct ras_events *ras;
+struct ras_events;
 
 struct ras_mc_event {
 	char timestamp[64];
-- 
2.8.1

