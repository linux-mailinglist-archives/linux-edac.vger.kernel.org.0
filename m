Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E731C2A1506
	for <lists+linux-edac@lfdr.de>; Sat, 31 Oct 2020 10:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgJaJ62 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 31 Oct 2020 05:58:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7125 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgJaJ62 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 31 Oct 2020 05:58:28 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CNZPX6jcczLrK2;
        Sat, 31 Oct 2020 17:58:24 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sat, 31 Oct 2020
 17:58:18 +0800
From:   lvying6 <lvying6@huawei.com>
To:     <mchehab+huawei@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <fanwentao@huawei.com>
Subject: [PATCH rasdaemon 2/2] ras-page-isolation: page which is PAGE_OFFLINE_FAILED can be offlined again
Date:   Sat, 31 Oct 2020 17:57:15 +0800
Message-ID: <1604138235-7142-3-git-send-email-lvying6@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604138235-7142-1-git-send-email-lvying6@huawei.com>
References: <1604138235-7142-1-git-send-email-lvying6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

OS may fail to offline page at the previous time. After some time,
this page's state changed, and the page can be offlined by OS.
At this time, Correctable errors on this page reached the threshold.
Rasdaemon should trigger to offline this page again.

Signed-off-by: lvying6 <lvying6@huawei.com>
---
 ras-page-isolation.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/ras-page-isolation.c b/ras-page-isolation.c
index dc07545..fd7bd70 100644
--- a/ras-page-isolation.c
+++ b/ras-page-isolation.c
@@ -237,12 +237,17 @@ static void page_offline(struct page_record *pr)
 	int ret;
 
 	/* Offlining page is not required */
-	if (offline <= OFFLINE_ACCOUNT)
+	if (offline <= OFFLINE_ACCOUNT) {
+		log(TERM, LOG_INFO, "PAGE_CE_ACTION=%s, ignore to offline page at %#llx\n",
+				offline_choice[offline].name, addr);
 		return;
+	}
 
 	/* Ignore offlined pages */
-	if (pr->offlined != PAGE_ONLINE)
+	if (pr->offlined == PAGE_OFFLINE) {
+		log(TERM, LOG_INFO, "page at %#llx is already offlined, ignore\n", addr);
 		return;
+	}
 
 	/* Time to silence this noisy page */
 	if (offline == OFFLINE_SOFT_THEN_HARD) {
-- 
1.8.3.1

