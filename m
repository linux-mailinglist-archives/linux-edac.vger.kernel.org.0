Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7C7434543
	for <lists+linux-edac@lfdr.de>; Wed, 20 Oct 2021 08:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJTGlD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Oct 2021 02:41:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:25301 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJTGk5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Oct 2021 02:40:57 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HZ16S6mW8zbhGZ;
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
Subject: [PATCH 3/4] rasdaemon: Fix some print format issues for hisi common error section
Date:   Wed, 20 Oct 2021 14:33:39 +0800
Message-ID: <20211020063340.26079-4-tanxiaofei@huawei.com>
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

It is not right to use '%d' to print uint8_t and uint16_t, although
there is no function issue. Change to use '%hhu' and '%hu' separately.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisilicon.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/non-standard-hisilicon.c b/non-standard-hisilicon.c
index 3fccff6..f9c7bd4 100644
--- a/non-standard-hisilicon.c
+++ b/non-standard-hisilicon.c
@@ -198,7 +198,7 @@ static const char* get_soc_desc(uint8_t soc_id)
 static void decode_module(struct hisi_event *event, uint8_t module_id)
 {
 	if (module_id >= sizeof(module_name)/sizeof(char *))
-		HISI_SNPRINTF(event->error_msg, "module=unknown(id=%d) ", module_id);
+		HISI_SNPRINTF(event->error_msg, "module=unknown(id=%hhu) ", module_id);
 	else
 		HISI_SNPRINTF(event->error_msg, "module=%s ", module_name[module_id]);
 }
@@ -207,36 +207,36 @@ static void decode_hisi_common_section_hdr(struct ras_ns_ev_decoder *ev_decoder,
 					  const struct hisi_common_error_section *err,
 					  struct hisi_event *event)
 {
-	HISI_SNPRINTF(event->error_msg, "[ table_version=%d", err->version);
+	HISI_SNPRINTF(event->error_msg, "[ table_version=%hhu", err->version);
 	if (err->val_bits & BIT(HISI_COMMON_VALID_SOC_ID))
 		HISI_SNPRINTF(event->error_msg, "soc=%s", get_soc_desc(err->soc_id));
 
 	if (err->val_bits & BIT(HISI_COMMON_VALID_SOCKET_ID))
-		HISI_SNPRINTF(event->error_msg, "socket_id=%d", err->socket_id);
+		HISI_SNPRINTF(event->error_msg, "socket_id=%hhu", err->socket_id);
 
 	if (err->val_bits & BIT(HISI_COMMON_VALID_TOTEM_ID))
-		HISI_SNPRINTF(event->error_msg, "totem_id=%d", err->totem_id);
+		HISI_SNPRINTF(event->error_msg, "totem_id=%hhu", err->totem_id);
 
 	if (err->val_bits & BIT(HISI_COMMON_VALID_NIMBUS_ID))
-		HISI_SNPRINTF(event->error_msg, "nimbus_id=%d", err->nimbus_id);
+		HISI_SNPRINTF(event->error_msg, "nimbus_id=%hhu", err->nimbus_id);
 
 	if (err->val_bits & BIT(HISI_COMMON_VALID_SUBSYSTEM_ID))
-		HISI_SNPRINTF(event->error_msg, "subsystem_id=%d", err->subsystem_id);
+		HISI_SNPRINTF(event->error_msg, "subsystem_id=%hhu", err->subsystem_id);
 
 	if (err->val_bits & BIT(HISI_COMMON_VALID_MODULE_ID))
 		decode_module(event, err->module_id);
 
 	if (err->val_bits & BIT(HISI_COMMON_VALID_SUBMODULE_ID))
-		HISI_SNPRINTF(event->error_msg, "submodule_id=%d", err->submodule_id);
+		HISI_SNPRINTF(event->error_msg, "submodule_id=%hhu", err->submodule_id);
 
 	if (err->val_bits & BIT(HISI_COMMON_VALID_CORE_ID))
-		HISI_SNPRINTF(event->error_msg, "core_id=%d", err->core_id);
+		HISI_SNPRINTF(event->error_msg, "core_id=%hhu", err->core_id);
 
 	if (err->val_bits & BIT(HISI_COMMON_VALID_PORT_ID))
-		HISI_SNPRINTF(event->error_msg, "port_id=%d", err->port_id);
+		HISI_SNPRINTF(event->error_msg, "port_id=%hhu", err->port_id);
 
 	if (err->val_bits & BIT(HISI_COMMON_VALID_ERR_TYPE))
-		HISI_SNPRINTF(event->error_msg, "err_type=%d", err->err_type);
+		HISI_SNPRINTF(event->error_msg, "err_type=%hu", err->err_type);
 
 	if (err->val_bits & BIT(HISI_COMMON_VALID_PCIE_INFO))
 		HISI_SNPRINTF(event->error_msg, "pcie_device_id=%04x:%02x:%02x.%x",
-- 
2.33.0

