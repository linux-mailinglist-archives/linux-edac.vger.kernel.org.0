Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B54E109DB3
	for <lists+linux-edac@lfdr.de>; Tue, 26 Nov 2019 13:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfKZMQK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Nov 2019 07:16:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6716 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727767AbfKZMQK (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 26 Nov 2019 07:16:10 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D3F485348E8B537C3E8E;
        Tue, 26 Nov 2019 20:16:00 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 26 Nov 2019 20:15:54 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v2 9/9] rasdaemon: add default branch for switch statement
Date:   Tue, 26 Nov 2019 20:12:36 +0800
Message-ID: <1574770356-129510-10-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1574770356-129510-1-git-send-email-tanxiaofei@huawei.com>
References: <1574770356-129510-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add default branch for the switch statements that default branch
was missed.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisi_hip08.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index f8f8e1d..4cfa107 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -205,6 +205,8 @@ static char *err_severity(uint8_t err_sev)
 	case HISI_ERR_SEVERITY_FE: return "fatal";
 	case HISI_ERR_SEVERITY_CE: return "corrected";
 	case HISI_ERR_SEVERITY_NONE: return "none";
+	default:
+		break;
 	}
 	return "unknown";
 }
@@ -451,6 +453,8 @@ static char *pcie_local_sub_module_name(uint8_t id)
 	case HISI_PCIE_SUB_MODULE_ID_MAC: return "MAC_Layer";
 	case HISI_PCIE_SUB_MODULE_ID_DL: return "DL_Layer";
 	case HISI_PCIE_SUB_MODULE_ID_SDI: return "SDI_Layer";
+	default:
+		break;
 	}
 	return "unknown";
 }
-- 
2.8.1

