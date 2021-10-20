Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86668434540
	for <lists+linux-edac@lfdr.de>; Wed, 20 Oct 2021 08:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhJTGkr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Oct 2021 02:40:47 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14833 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhJTGkq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Oct 2021 02:40:46 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HZ15p3v3Nz90Ct;
        Wed, 20 Oct 2021 14:33:34 +0800 (CST)
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
Subject: [PATCH 1/4] rasdaemon: Fix the issue of sprintf data type mismatch in uuid_le()
Date:   Wed, 20 Oct 2021 14:33:37 +0800
Message-ID: <20211020063340.26079-2-tanxiaofei@huawei.com>
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

The data type of sprintf called in the function uuid_le() is mismatch.
Arm64 compiler force it to unsigned char by default, and can work normally.
But if someone compile it with the option -fsigned-char, the function
can't work correctly.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 ras-extlog-handler.c       | 2 +-
 ras-non-standard-handler.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ras-extlog-handler.c b/ras-extlog-handler.c
index 5fd3580..1834687 100644
--- a/ras-extlog-handler.c
+++ b/ras-extlog-handler.c
@@ -152,7 +152,7 @@ static char *uuid_le(const char *uu)
 	static const unsigned char le[16] = {3,2,1,0,5,4,7,6,8,9,10,11,12,13,14,15};
 
 	for (i = 0; i < 16; i++) {
-		p += sprintf(p, "%.2x", uu[le[i]]);
+		p += sprintf(p, "%.2x", (unsigned char) uu[le[i]]);
 		switch (i) {
 		case 3:
 		case 5:
diff --git a/ras-non-standard-handler.c b/ras-non-standard-handler.c
index 6ccf5bc..6d5a6f8 100644
--- a/ras-non-standard-handler.c
+++ b/ras-non-standard-handler.c
@@ -36,7 +36,7 @@ static char *uuid_le(const char *uu)
 	static const unsigned char le[16] = {3,2,1,0,5,4,7,6,8,9,10,11,12,13,14,15};
 
 	for (i = 0; i < 16; i++) {
-		p += sprintf(p, "%.2x", uu[le[i]]);
+		p += sprintf(p, "%.2x", (unsigned char) uu[le[i]]);
 		switch (i) {
 		case 3:
 		case 5:
@@ -61,7 +61,7 @@ static int uuid_le_cmp(const char *sec_type, const char *uuid2)
 			3, 2, 1, 0, 5, 4, 7, 6, 8, 9, 10, 11, 12, 13, 14, 15};
 
 	for (i = 0; i < 16; i++)
-		p += sprintf(p, "%.2x", sec_type[le[i]]);
+		p += sprintf(p, "%.2x", (unsigned char) sec_type[le[i]]);
 	*p = 0;
 	return strncmp(uuid1, uuid2, 32);
 }
-- 
2.33.0

