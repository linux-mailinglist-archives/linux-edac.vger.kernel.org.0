Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685BD434541
	for <lists+linux-edac@lfdr.de>; Wed, 20 Oct 2021 08:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhJTGlD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Oct 2021 02:41:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25302 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhJTGk5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Oct 2021 02:40:57 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HZ16S6z9gzbhGc;
        Wed, 20 Oct 2021 14:34:08 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
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
Subject: [PATCH 4/4] rasdaemon: Add some modules supported by hisi common error section
Date:   Wed, 20 Oct 2021 14:33:40 +0800
Message-ID: <20211020063340.26079-5-tanxiaofei@huawei.com>
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

Add some modules supported by hisi common error section. Besides,
HHA is the module for some old platform, and it takes the same place
of MATA, so remove it.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisilicon.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/non-standard-hisilicon.c b/non-standard-hisilicon.c
index f9c7bd4..1432163 100644
--- a/non-standard-hisilicon.c
+++ b/non-standard-hisilicon.c
@@ -184,7 +184,11 @@ static const char* module_name[] = {
 	"SEC",
 	"RDE",
 	"MEE",
-	"HHA",
+	"L4D",
+	"Tsensor",
+	"ROH",
+	"BTC",
+	"HILINK"
 };
 
 static const char* get_soc_desc(uint8_t soc_id)
-- 
2.33.0

