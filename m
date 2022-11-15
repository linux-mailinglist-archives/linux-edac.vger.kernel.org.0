Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94F7629E6F
	for <lists+linux-edac@lfdr.de>; Tue, 15 Nov 2022 17:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiKOQEs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Nov 2022 11:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiKOQEn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Nov 2022 11:04:43 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB66275
        for <linux-edac@vger.kernel.org>; Tue, 15 Nov 2022 08:04:42 -0800 (PST)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBW8z5BsSz689lX;
        Wed, 16 Nov 2022 00:00:03 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Tue, 15 Nov 2022 17:04:40 +0100
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.156.200) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 16:04:39 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <luoshengwei@huawei.com>, <panjunchong@hisilicon.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 10/11] rasdaemon: Fix for a memory out-of-bounds issue and optimized code to remove duplicate function.
Date:   Tue, 15 Nov 2022 16:04:18 +0000
Message-ID: <20221115160419.355-11-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20221115160419.355-1-shiju.jose@huawei.com>
References: <20221115160419.355-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.156.200]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Fixed a memory out-of-bounds issue with string pointers and
optimized code structure to remove duplicate function.

Signed-off-by: Lei Feng <fenglei47@h-partners.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 non-standard-hisi_hip08.c  |  6 +++---
 non-standard-hisilicon.c   |  2 +-
 ras-non-standard-handler.c | 16 +---------------
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 9092183..4ef47ea 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -1014,15 +1014,15 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
 
 static struct ras_ns_ev_decoder hip08_ns_ev_decoder[] = {
 	{
-		.sec_type = "1f8161e155d641e6bd107afd1dc5f7c5",
+		.sec_type = "1f8161e1-55d6-41e6-bd10-7afd1dc5f7c5",
 		.decode = decode_hip08_oem_type1_error,
 	},
 	{
-		.sec_type = "45534ea6ce2341158535e07ab3aef91d",
+		.sec_type = "45534ea6-ce23-4115-8535-e07ab3aef91d",
 		.decode = decode_hip08_oem_type2_error,
 	},
 	{
-		.sec_type = "b2889fc9e7d74f9da867af42e98be772",
+		.sec_type = "b2889fc9-e7d7-4f9d-a867-af42e98be772",
 		.decode = decode_hip08_pcie_local_error,
 	},
 };
diff --git a/non-standard-hisilicon.c b/non-standard-hisilicon.c
index d1e1774..6ee9271 100644
--- a/non-standard-hisilicon.c
+++ b/non-standard-hisilicon.c
@@ -387,7 +387,7 @@ static int decode_hisi_common_section(struct ras_events *ras,
 
 static struct ras_ns_ev_decoder hisi_section_ns_ev_decoder[]  = {
 	{
-		.sec_type = "c8b328a899174af69a132e08ab2e7586",
+		.sec_type = "c8b328a8-9917-4af6-9a13-2e08ab2e7586",
 		.decode = decode_hisi_common_section,
 	},
 };
diff --git a/ras-non-standard-handler.c b/ras-non-standard-handler.c
index 6d5a6f8..6932e58 100644
--- a/ras-non-standard-handler.c
+++ b/ras-non-standard-handler.c
@@ -52,20 +52,6 @@ static char *uuid_le(const char *uu)
 	return uuid;
 }
 
-static int uuid_le_cmp(const char *sec_type, const char *uuid2)
-{
-	static char uuid1[32];
-	char *p = uuid1;
-	int i;
-	static const unsigned char le[16] = {
-			3, 2, 1, 0, 5, 4, 7, 6, 8, 9, 10, 11, 12, 13, 14, 15};
-
-	for (i = 0; i < 16; i++)
-		p += sprintf(p, "%.2x", (unsigned char) sec_type[le[i]]);
-	*p = 0;
-	return strncmp(uuid1, uuid2, 32);
-}
-
 int register_ns_ev_decoder(struct ras_ns_ev_decoder *ns_ev_decoder)
 {
 	struct ras_ns_ev_decoder *list;
@@ -96,7 +82,7 @@ static int find_ns_ev_decoder(const char *sec_type, struct ras_ns_ev_decoder **p
 
 	ns_ev_decoder = ras_ns_ev_dec_list;
 	while (ns_ev_decoder) {
-		if (uuid_le_cmp(sec_type, ns_ev_decoder->sec_type) == 0) {
+		if (strcmp(uuid_le(sec_type), ns_ev_decoder->sec_type) == 0) {
 			*p_ns_ev_dec = ns_ev_decoder;
 			match  = 1;
 			break;
-- 
2.25.1

