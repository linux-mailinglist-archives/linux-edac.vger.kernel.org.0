Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6D739F61F
	for <lists+linux-edac@lfdr.de>; Tue,  8 Jun 2021 14:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhFHMO1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Jun 2021 08:14:27 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3472 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhFHMO0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 8 Jun 2021 08:14:26 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FzpvF40n7z6wLL;
        Tue,  8 Jun 2021 20:09:29 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 20:12:28 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 20:12:28 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <dinguyen@kernel.org>, <bp@alien8.de>, <mchehab@kernel.org>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <rric@kernel.org>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] EDAC/altera: Convert list_for_each to entry variant
Date:   Tue, 8 Jun 2021 20:31:04 +0800
Message-ID: <1623155464-61645-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggemi762-chm.china.huawei.com (10.1.198.148)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

convert list_for_each() to list_for_each_entry() where
applicable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/edac/altera_edac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 61c21bd..12cac99 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2040,14 +2040,11 @@ static int s10_edac_dberr_handler(struct notifier_block *this,
 		    &dberror);
 	regmap_write(edac->ecc_mgr_map, S10_SYSMGR_UE_VAL_OFST, dberror);
 	if (dberror & S10_DBE_IRQ_MASK) {
-		struct list_head *position;
 		struct altr_edac_device_dev *ed;
 		struct arm_smccc_res result;
 
 		/* Find the matching DBE in the list of devices */
-		list_for_each(position, &edac->a10_ecc_devices) {
-			ed = list_entry(position, struct altr_edac_device_dev,
-					next);
+		list_for_each_entry(ed, &edac->a10_ecc_devices, next) {
 			if (!(BIT(ed->db_irq) & dberror))
 				continue;
 
-- 
2.6.2

