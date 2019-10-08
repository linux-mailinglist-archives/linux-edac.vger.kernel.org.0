Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF7CCFA2F
	for <lists+linux-edac@lfdr.de>; Tue,  8 Oct 2019 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbfJHMmH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Oct 2019 08:42:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3273 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730888AbfJHMmH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 8 Oct 2019 08:42:07 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5354BA25EE8FDDB1A11B;
        Tue,  8 Oct 2019 20:41:58 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 8 Oct 2019 20:41:52 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH 5/5] rasdaemon: support three more modules for OEM type1 error for hip08
Date:   Tue, 8 Oct 2019 20:38:58 +0800
Message-ID: <1570538338-230884-6-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1570538338-230884-1-git-send-email-tanxiaofei@huawei.com>
References: <1570538338-230884-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Support three more modules for OEM type1 error for hip08. They are
RDE, GIC and USB.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisi_hip08.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 61e19b7..1774ec7 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -26,8 +26,11 @@
 #define HISI_OEM_MODULE_ID_POE	5
 #define HISI_OEM_MODULE_ID_DISP	8
 #define HISI_OEM_MODULE_ID_LPC	9
+#define HISI_OEM_MODULE_ID_GIC	13
+#define HISI_OEM_MODULE_ID_RDE	14
 #define HISI_OEM_MODULE_ID_SAS	15
 #define HISI_OEM_MODULE_ID_SATA	16
+#define HISI_OEM_MODULE_ID_USB	17
 
 #define HISI_OEM_VALID_SOC_ID		BIT(0)
 #define HISI_OEM_VALID_SOCKET_ID	BIT(1)
@@ -202,8 +205,11 @@ static char *oem_type1_module_name(uint8_t module_id)
 	case HISI_OEM_MODULE_ID_POE: return "POE";
 	case HISI_OEM_MODULE_ID_DISP: return "DISP";
 	case HISI_OEM_MODULE_ID_LPC: return "LPC";
+	case HISI_OEM_MODULE_ID_GIC: return "GIC";
+	case HISI_OEM_MODULE_ID_RDE: return "RDE";
 	case HISI_OEM_MODULE_ID_SAS: return "SAS";
 	case HISI_OEM_MODULE_ID_SATA: return "SATA";
+	case HISI_OEM_MODULE_ID_USB: return "USB";
 	}
 	return "unknown";
 }
-- 
2.8.1

